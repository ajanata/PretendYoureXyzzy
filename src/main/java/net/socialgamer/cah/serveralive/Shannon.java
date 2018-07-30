package net.socialgamer.cah.serveralive;

/**
 * Implementation of the Shannon stream-cipher.
 * <p>
 * Based on original reference implementation in C.
 *
 * @author Felix Bruns <felixbruns@web.de>
 */
@SuppressWarnings("ALL")
public final class Shannon {
  /*
   * Fold is how many register cycles need to be performed after combining the
   * last byte of key and non-linear feedback, before every byte depends on every
   * byte of the key. This depends on the feedback and nonlinear functions, and
   * on where they are combined into the register. Making it same as the register
   * length is a safe and conservative choice.
   */
  private static final int N = 16;
  private static final int FOLD = N;          /* How many iterations of folding to do. */
  private static final int INITKONST = 0x6996c53a; /* Value of konst to use during key loading. */
  private static final int KEYP = 13;         /* Where to insert key/MAC/counter words. */

  private int[] R;     /* Working storage for the shift register. */
  private int[] CRC;   /* Working storage for CRC accumulation. */
  private int[] initR; /* Saved register contents. */
  private int konst; /* Key dependant semi-constant. */
  private int sbuf;  /* Encryption buffer. */
  private int mbuf;  /* Partial word MAC buffer. */
  private int nbuf;  /* Number of part-word stream bits buffered. */

  /**
   * Create a new instance of the Shannon stream-cipher.
   */
  public Shannon() {
    /* Registers with length N. */
    this.R = new int[N];
    this.CRC = new int[N];
    this.initR = new int[N];
  }

  /* Nonlinear transform (sbox) of a word. There are two slightly different combinations. */
  private int sbox(int i) {
    i ^= Integer.rotateLeft(i, 5) | Integer.rotateLeft(i, 7);
    i ^= Integer.rotateLeft(i, 19) | Integer.rotateLeft(i, 22);

    return i;
  }

  private int sbox2(int i) {
    i ^= Integer.rotateLeft(i, 7) | Integer.rotateLeft(i, 22);
    i ^= Integer.rotateLeft(i, 5) | Integer.rotateLeft(i, 19);

    return i;
  }

  /* Cycle the contents of the register and calculate output word in sbuf. */
  private void cycle() {
    /* Temporary variable. */
    int t;

    /* Nonlinear feedback function. */
    t = this.R[12] ^ this.R[13] ^ this.konst;
    t = this.sbox(t) ^ Integer.rotateLeft(this.R[0], 1);

    /* Shift register. */
    for (int i = 1; i < N; i++) {
      this.R[i - 1] = this.R[i];
    }

    this.R[N - 1] = t;

    t = sbox2(this.R[2] ^ this.R[15]);
    this.R[0] ^= t;
    this.sbuf = t ^ this.R[8] ^ this.R[12];
  }

  /*
   * The Shannon MAC function is modelled after the concepts of Phelix and SHA.
   * Basically, words to be accumulated in the MAC are incorporated in two
   * different ways:
   * 1. They are incorporated into the stream cipher register at a place
   *    where they will immediately have a nonlinear effect on the state.
   * 2. They are incorporated into bit-parallel CRC-16 registers; the
   *    contents of these registers will be used in MAC finalization.
   */

  /*
   * Accumulate a CRC of input words, later to be fed into MAC.
   * This is actually 32 parallel CRC-16s, using the IBM CRC-16
   * polynomian x^16 + x^15 + x^2 + 1
   */
  private void crcFunc(int i) {
    /* Temporary variable. */
    int t;

    /* Accumulate CRC of input. */
    t = this.CRC[0] ^ this.CRC[2] ^ this.CRC[15] ^ i;

    for (int j = 1; j < N; j++) {
      this.CRC[j - 1] = this.CRC[j];
    }

    this.CRC[N - 1] = t;
  }

  /* Normal MAC word processing: do both stream register and CRC. */
  private void macFunc(int i) {
    this.crcFunc(i);

    this.R[KEYP] ^= i;
  }

  /* Initialize to known state. */
  private void initState() {
    /* Register initialized to Fibonacci numbers. */
    this.R[0] = 1;
    this.R[1] = 1;

    for (int i = 2; i < N; i++) {
      this.R[i] = this.R[i - 1] + this.R[i - 2];
    }

    /* Initialization constant. */
    this.konst = INITKONST;
  }

  /* Save the current register state. */
  private void saveState() {
    for (int i = 0; i < N; i++) {
      this.initR[i] = this.R[i];
    }
  }

  /* Inisialize to previously saved register state. */
  private void reloadState() {
    for (int i = 0; i < N; i++) {
      this.R[i] = this.initR[i];
    }
  }

  /* Initialize 'konst'. */
  private void genKonst() {
    this.konst = this.R[0];
  }

  /* Load key material into the register. */
  private void addKey(int k) {
    this.R[KEYP] ^= k;
  }

  /* Extra nonlinear diffusion of register for key and MAC. */
  private void diffuse() {
    for (int i = 0; i < FOLD; i++) {
      this.cycle();
    }
  }

  /*
   * Common actions for loading key material.
   * Allow non-word-multiple key and nonce material.
   * Note: Also initializes the CRC register as a side effect.
   */
  private void loadKey(byte[] key) {
    byte[] extra = new byte[4];
    int i, j;
    int t;

    /* Start folding key. */
    for (i = 0; i < (key.length & ~0x03); i += 4) {
      /* Shift 4 bytes into one word. */
      t = ((key[i + 3] & 0xFF) << 24) |
              ((key[i + 2] & 0xFF) << 16) |
              ((key[i + 1] & 0xFF) << 8) |
              ((key[i] & 0xFF));

      /* Insert key word at index 13. */
      this.addKey(t);

      /* Cycle register. */
      this.cycle();
    }

    /* If there were any extra bytes, zero pad to a word. */
    if (i < key.length) {
      /* i remains unchanged at start of loop. */
      for (j = 0; i < key.length; i++) {
        extra[j++] = key[i];
      }

      /* j remains unchanged at start of loop. */
      for (; j < 4; j++) {
        extra[j] = 0;
      }

      /* Shift 4 extra bytes into one word. */
      t = ((extra[3] & 0xFF) << 24) |
              ((extra[2] & 0xFF) << 16) |
              ((extra[1] & 0xFF) << 8) |
              ((extra[0] & 0xFF));

      /* Insert key word at index 13. */
      this.addKey(t);

      /* Cycle register. */
      this.cycle();
    }

    /* Also fold in the length of the key. */
    this.addKey(key.length);

    /* Cycle register. */
    this.cycle();

    /* Save a copy of the register. */
    for (i = 0; i < N; i++) {
      this.CRC[i] = this.R[i];
    }

    /* Now diffuse. */
    this.diffuse();

    /* Now XOR the copy back -- makes key loading irreversible. */
    for (i = 0; i < N; i++) {
      this.R[i] ^= this.CRC[i];
    }
  }

  /* Set key */
  public void key(byte[] key) {
    /* Initializet known state. */
    this.initState();

    /* Load key material. */
    this.loadKey(key);

    /* In case we proceed to stream generation. */
    this.genKonst();

    /* Save register state. */
    this.saveState();

    /* Set 'nbuf' value to zero. */
    this.nbuf = 0;
  }

  /* Set IV */
  public void nonce(byte[] nonce) {
    /* Reload register state. */
    this.reloadState();

    /* Set initialization constant. */
    this.konst = INITKONST;

    /* Load "IV" material. */
    this.loadKey(nonce);

    /* Set 'konst'. */
    this.genKonst();

    /* Set 'nbuf' value to zero. */
    this.nbuf = 0;
  }

  /*
   * XOR pseudo-random bytes into buffer.
   * Note: doesn't play well with MAC functions.
   */
  public void stream(byte[] buffer) {
    int i = 0, j, n = buffer.length;

    /* Handle any previously buffered bytes. */
    while (this.nbuf != 0 && n != 0) {
      buffer[i++] ^= this.sbuf & 0xFF;

      this.sbuf >>= 8;
      this.nbuf -= 8;

      n--;
    }

    /* Handle whole words. */
    j = n & ~0x03;

    while (i < j) {
      /* Cycle register. */
      this.cycle();

      /* XOR word. */
      buffer[i + 3] ^= (this.sbuf >> 24) & 0xFF;
      buffer[i + 2] ^= (this.sbuf >> 16) & 0xFF;
      buffer[i + 1] ^= (this.sbuf >> 8) & 0xFF;
      buffer[i] ^= (this.sbuf) & 0xFF;

      i += 4;
    }

    /* Handle any trailing bytes. */
    n &= 0x03;

    if (n != 0) {
      /* Cycle register. */
      this.cycle();

      this.nbuf = 32;

      while (this.nbuf != 0 && n != 0) {
        buffer[i++] ^= this.sbuf & 0xFF;

        this.sbuf >>= 8;
        this.nbuf -= 8;

        n--;
      }
    }
  }

  /*
   * Accumulate words into MAC without encryption.
   * Note that plaintext is accumulated for MAC.
   */
  public void macOnly(byte[] buffer) {
    int i = 0, j, n = buffer.length;
    int t;

    /* Handle any previously buffered bytes. */
    if (this.nbuf != 0) {
      while (this.nbuf != 0 && n != 0) {
        this.mbuf ^= buffer[i++] << (32 - this.nbuf);
        this.nbuf -= 8;

        n--;
      }

      /* Not a whole word yet. */
      if (this.nbuf != 0) {
        return;
      }

      /* LFSR already cycled. */
      this.macFunc(this.mbuf);
    }

    /* Handle whole words. */
    j = n & ~0x03;

    while (i < j) {
      /* Cycle register. */
      this.cycle();

      /* Shift 4 bytes into one word. */
      t = ((buffer[i + 3] & 0xFF) << 24) |
              ((buffer[i + 2] & 0xFF) << 16) |
              ((buffer[i + 1] & 0xFF) << 8) |
              ((buffer[i] & 0xFF));

      this.macFunc(t);

      i += 4;
    }

    /* Handle any trailing bytes. */
    n &= 0x03;

    if (n != 0) {
      /* Cycle register. */
      this.cycle();

      this.mbuf = 0;
      this.nbuf = 32;

      while (this.nbuf != 0 && n != 0) {
        this.mbuf ^= buffer[i++] << (32 - this.nbuf);
        this.nbuf -= 8;

        n--;
      }
    }
  }

  /*
   * Combined MAC and encryption.
   * Note that plaintext is accumulated for MAC.
   */
  public void encrypt(byte[] buffer) {
    this.encrypt(buffer, buffer.length);
  }

  /*
   * Combined MAC and encryption.
   * Note that plaintext is accumulated for MAC.
   */
  public void encrypt(byte[] buffer, int n) {
    int i = 0, j;
    int t;

    /* Handle any previously buffered bytes. */
    if (this.nbuf != 0) {
      while (this.nbuf != 0 && n != 0) {
        this.mbuf ^= (buffer[i] & 0xFF) << (32 - this.nbuf);
        buffer[i] ^= (this.sbuf >> (32 - this.nbuf)) & 0xFF;

        i++;

        this.nbuf -= 8;

        n--;
      }

      /* Not a whole word yet. */
      if (this.nbuf != 0) {
        return;
      }

      /* LFSR already cycled. */
      this.macFunc(this.mbuf);
    }

    /* Handle whole words. */
    j = n & ~0x03;

    while (i < j) {
      /* Cycle register. */
      this.cycle();

      /* Shift 4 bytes into one word. */
      t = ((buffer[i + 3] & 0xFF) << 24) |
              ((buffer[i + 2] & 0xFF) << 16) |
              ((buffer[i + 1] & 0xFF) << 8) |
              ((buffer[i] & 0xFF));

      this.macFunc(t);

      t ^= this.sbuf;

      /* Put word into byte buffer. */
      buffer[i + 3] = (byte) ((t >> 24) & 0xFF);
      buffer[i + 2] = (byte) ((t >> 16) & 0xFF);
      buffer[i + 1] = (byte) ((t >> 8) & 0xFF);
      buffer[i] = (byte) ((t) & 0xFF);

      i += 4;
    }

    /* Handle any trailing bytes. */
    n &= 0x03;

    if (n != 0) {
      /* Cycle register. */
      this.cycle();

      this.mbuf = 0;
      this.nbuf = 32;

      while (this.nbuf != 0 && n != 0) {
        this.mbuf ^= (buffer[i] & 0xFF) << (32 - this.nbuf);
        buffer[i] ^= (this.sbuf >> (32 - this.nbuf)) & 0xFF;

        i++;

        this.nbuf -= 8;

        n--;
      }
    }
  }

  /*
   * Combined MAC and decryption.
   * Note that plaintext is accumulated for MAC.
   */
  public void decrypt(byte[] buffer) {
    this.decrypt(buffer, buffer.length);
  }

  /*
   * Combined MAC and decryption.
   * Note that plaintext is accumulated for MAC.
   */
  public void decrypt(byte[] buffer, int n) {
    int i = 0, j;
    int t;

    /* Handle any previously buffered bytes. */
    if (this.nbuf != 0) {
      while (this.nbuf != 0 && n != 0) {
        buffer[i] ^= (this.sbuf >> (32 - this.nbuf)) & 0xFF;
        this.mbuf ^= (buffer[i] & 0xFF) << (32 - this.nbuf);

        i++;

        this.nbuf -= 8;

        n--;
      }

      /* Not a whole word yet. */
      if (this.nbuf != 0) {
        return;
      }

      /* LFSR already cycled. */
      this.macFunc(this.mbuf);
    }

    /* Handle whole words. */
    j = n & ~0x03;

    while (i < j) {
      /* Cycle register. */
      this.cycle();

      /* Shift 4 bytes into one word. */
      t = ((buffer[i + 3] & 0xFF) << 24) |
              ((buffer[i + 2] & 0xFF) << 16) |
              ((buffer[i + 1] & 0xFF) << 8) |
              ((buffer[i] & 0xFF));

      t ^= this.sbuf;

      this.macFunc(t);

      /* Put word into byte buffer. */
      buffer[i + 3] = (byte) ((t >> 24) & 0xFF);
      buffer[i + 2] = (byte) ((t >> 16) & 0xFF);
      buffer[i + 1] = (byte) ((t >> 8) & 0xFF);
      buffer[i] = (byte) ((t) & 0xFF);

      i += 4;
    }

    /* Handle any trailing bytes. */
    n &= 0x03;

    if (n != 0) {
      /* Cycle register. */
      this.cycle();

      this.mbuf = 0;
      this.nbuf = 32;

      while (this.nbuf != 0 && n != 0) {
        buffer[i] ^= (this.sbuf >> (32 - this.nbuf)) & 0xFF;
        this.mbuf ^= (buffer[i] & 0xFF) << (32 - this.nbuf);

        i++;

        this.nbuf -= 8;

        n--;
      }
    }
  }

  /*
   * Having accumulated a MAC, finish processing and return it.
   * Note that any unprocessed bytes are treated as if they were
   * encrypted zero bytes, so plaintext (zero) is accumulated.
   */
  public void finish(byte[] buffer) {
    this.finish(buffer, buffer.length);
  }

  /*
   * Having accumulated a MAC, finish processing and return it.
   * Note that any unprocessed bytes are treated as if they were
   * encrypted zero bytes, so plaintext (zero) is accumulated.
   */
  public void finish(byte[] buffer, int n) {
    int i = 0, j;

    /* Handle any previously buffered bytes. */
    if (this.nbuf != 0) {
      /* LFSR already cycled. */
      this.macFunc(this.mbuf);
    }

    /*
     * Perturb the MAC to mark end of input.
     * Note that only the stream register is updated, not the CRC.
     * This is an action that can't be duplicated by passing in plaintext,
     * hence defeating any kind of extension attack.
     */
    this.cycle();
    this.addKey(INITKONST ^ (this.nbuf << 3));

    this.nbuf = 0;

    /* Now add the CRC to the stream register and diffuse it. */
    for (j = 0; j < N; j++) {
      this.R[j] ^= this.CRC[j];
    }

    this.diffuse();

    /* Produce output from the stream buffer. */
    while (n > 0) {
      this.cycle();

      if (n >= 4) {
        /* Put word into byte buffer. */
        buffer[i + 3] = (byte) ((this.sbuf >> 24) & 0xFF);
        buffer[i + 2] = (byte) ((this.sbuf >> 16) & 0xFF);
        buffer[i + 1] = (byte) ((this.sbuf >> 8) & 0xFF);
        buffer[i] = (byte) ((this.sbuf) & 0xFF);

        n -= 4;
        i += 4;
      } else {
        for (j = 0; j < n; j++) {
          buffer[i + j] = (byte) ((this.sbuf >> (i * 8)) & 0xFF);
        }

        break;
      }
    }
  }
}
