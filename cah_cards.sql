-- Pretend You're Xyzzy cards by Andy Janata is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
-- Based on a work at www.cardsagainsthumanity.com.
-- For more information, see http://creativecommons.org/licenses/by-nc-sa/3.0/

-- This file contains the Black Cards and White Cards for Cards Against Humanity, as a script for importing into PostgreSQL. There should be a user named cah.

--
-- PostgreSQL database dump
--

-- Dumped from database version 8.4.11
-- Dumped by pg_dump version 9.1.3
-- Started on 2012-07-07 14:54:57

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 140 (class 1259 OID 16399)
-- Dependencies: 1795 1796 1798 1799 6
-- Name: black_cards; Type: TABLE; Schema: public; Owner: cah; Tablespace: 
--

CREATE TABLE black_cards (
    id integer NOT NULL,
    text character varying(255) NOT NULL,
    draw smallint DEFAULT 0,
    pick smallint DEFAULT 1,
    creator integer,
    in_v1 boolean DEFAULT false NOT NULL,
    in_v2 boolean DEFAULT false NOT NULL,
    watermark character varying(5)
);


ALTER TABLE public.black_cards OWNER TO cah;

--
-- TOC entry 1828 (class 0 OID 0)
-- Dependencies: 140
-- Name: COLUMN black_cards.creator; Type: COMMENT; Schema: public; Owner: cah
--

COMMENT ON COLUMN black_cards.creator IS 'NULL for default card, non-NULL for user id';


--
-- TOC entry 141 (class 1259 OID 16404)
-- Dependencies: 6 140
-- Name: black_cards_id_seq; Type: SEQUENCE; Schema: public; Owner: cah
--

CREATE SEQUENCE black_cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.black_cards_id_seq OWNER TO cah;

--
-- TOC entry 1829 (class 0 OID 0)
-- Dependencies: 141
-- Name: black_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cah
--

ALTER SEQUENCE black_cards_id_seq OWNED BY black_cards.id;


--
-- TOC entry 1830 (class 0 OID 0)
-- Dependencies: 141
-- Name: black_cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cah
--

SELECT pg_catalog.setval('black_cards_id_seq', 98, true);


--
-- TOC entry 148 (class 1259 OID 16497)
-- Dependencies: 6
-- Name: card_set; Type: TABLE; Schema: public; Owner: cah; Tablespace: 
--

CREATE TABLE card_set (
    id integer NOT NULL,
    active boolean NOT NULL,
    name character varying(255),
    base_deck boolean NOT NULL
);


ALTER TABLE public.card_set OWNER TO cah;

--
-- TOC entry 149 (class 1259 OID 16502)
-- Dependencies: 6
-- Name: card_set_black_card; Type: TABLE; Schema: public; Owner: cah; Tablespace: 
--

CREATE TABLE card_set_black_card (
    card_set_id integer NOT NULL,
    black_card_id integer NOT NULL
);


ALTER TABLE public.card_set_black_card OWNER TO cah;

--
-- TOC entry 150 (class 1259 OID 16507)
-- Dependencies: 6
-- Name: card_set_white_card; Type: TABLE; Schema: public; Owner: cah; Tablespace: 
--

CREATE TABLE card_set_white_card (
    card_set_id integer NOT NULL,
    white_card_id integer NOT NULL
);


ALTER TABLE public.card_set_white_card OWNER TO cah;

--
-- TOC entry 146 (class 1259 OID 16417)
-- Dependencies: 1801 1802 6
-- Name: white_cards; Type: TABLE; Schema: public; Owner: cah; Tablespace: 
--

CREATE TABLE white_cards (
    id integer NOT NULL,
    text character varying(255) NOT NULL,
    creator integer,
    in_v1 boolean DEFAULT false NOT NULL,
    in_v2 boolean DEFAULT false NOT NULL,
    watermark character varying(5)
);


ALTER TABLE public.white_cards OWNER TO cah;

--
-- TOC entry 1831 (class 0 OID 0)
-- Dependencies: 146
-- Name: COLUMN white_cards.creator; Type: COMMENT; Schema: public; Owner: cah
--

COMMENT ON COLUMN white_cards.creator IS 'NULL for default, non-NULL for user id';


--
-- TOC entry 147 (class 1259 OID 16420)
-- Dependencies: 146 6
-- Name: white_cards_id_seq; Type: SEQUENCE; Schema: public; Owner: cah
--

CREATE SEQUENCE white_cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.white_cards_id_seq OWNER TO cah;

--
-- TOC entry 1832 (class 0 OID 0)
-- Dependencies: 147
-- Name: white_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cah
--

ALTER SEQUENCE white_cards_id_seq OWNED BY white_cards.id;


--
-- TOC entry 1833 (class 0 OID 0)
-- Dependencies: 147
-- Name: white_cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cah
--

SELECT pg_catalog.setval('white_cards_id_seq', 508, true);


--
-- TOC entry 1797 (class 2604 OID 16422)
-- Dependencies: 141 140
-- Name: id; Type: DEFAULT; Schema: public; Owner: cah
--

ALTER TABLE ONLY black_cards ALTER COLUMN id SET DEFAULT nextval('black_cards_id_seq'::regclass);


--
-- TOC entry 1800 (class 2604 OID 16423)
-- Dependencies: 147 146
-- Name: id; Type: DEFAULT; Schema: public; Owner: cah
--

ALTER TABLE ONLY white_cards ALTER COLUMN id SET DEFAULT nextval('white_cards_id_seq'::regclass);


--
-- TOC entry 1821 (class 0 OID 16399)
-- Dependencies: 140
-- Data for Name: black_cards; Type: TABLE DATA; Schema: public; Owner: cah
--

COPY black_cards (id, text, draw, pick, creator, in_v1, in_v2, watermark) FROM stdin;
16  Who stole the cookies from the cookie jar?  0 1 \N  t f \N
23  I wish I hadn't lost the instruction manual for _____.  0 1 \N  t f \N
27  What's the next superhero?  0 1 \N  t f \N
37  When I'm in prison, I'll have _____ smuggled in.  0 1 \N  t f \N
54  After Hurricane Katrina, Sean Penn brought _____ to all the people of New Orleans.  0 1 \N  t f \N
55  Due to a PR fiasco, Walmart no longer offers _____. 0 1 \N  t f \N
69  Life was difficult for cavemen before _____.  0 1 \N  t f \N
1 Why can't I sleep at night? 0 1 \N  t t \N
4 What's that smell?  0 1 \N  t t \N
17  What's the next Happy Meal® toy?  0 1 \N  t t \N
18  Anthropologists have recently discovered a primitive tribe that worships _____. 0 1 \N  t t \N
19  It's a pity that kids these days are all getting involved with _____. 0 1 \N  t t \N
14  Alternative medicine is now embracing the curative powers of _____. 0 1 \N  t t \N
78  And the Academy Award for _____ goes to _____.  0 2 \N  t t \N
15  What's that sound?  0 1 \N  t t \N
9 What ended my last relationship?  0 1 \N  t t \N
11  I drink to forget _____.  0 1 \N  t t \N
12  I'm sorry, Professor, but I couldn't complete my homework because of _____. 0 1 \N  t t \N
7 What is Batman's guilty pleasure? 0 1 \N  t t \N
6 This is the way the world ends / This is the way the world ends / This is the way the world ends / Not with a bang but with _____ 0 1 \N  t t \N
3 What's a girl's best friend?  0 1 \N  t t \N
8 TSA guidelines now prohibit _____ on airplanes. 0 1 \N  t t \N
20  _____. That's how I want to die.  0 1 \N  t t \N
79  For my next trick, I will pull _____ out of _____.  0 2 \N  t t \N
21  In the new Disney Channel Original Movie, Hannah Montana struggles with _____ for the first time. 0 1 \N  t t \N
80  _____ is a slippery slope that leads to _____.  0 2 \N  t t \N
22  What does Dick Cheney prefer? 0 1 \N  t t \N
24  Instead of coal, Santa now gives the bad children _____.  0 1 \N  t t \N
25  What's the most emo?  0 1 \N  t t \N
26  In 1,000 years, when paper money is but a distant memory, _____ will be our currency. 0 1 \N  t t \N
81  In M. Night Shyamalan's new movie, Bruce Willis discovers that _____ had really been _____ all along. 0 2 \N  t t \N
28  A romantic, candlelit dinner would be incomplete without _____. 0 1 \N  t t \N
30  _____. Betcha can't have just one!  0 1 \N  t t \N
82  In a world ravaged by _____, our only solace is _____.  0 2 \N  t t \N
34  War! What is it good for? 0 1 \N  t t \N
33  During sex, I like to think about _____.  0 1 \N  t t \N
39  What are my parents hiding from me? 0 1 \N  t t \N
36  What will always get you laid?  0 1 \N  t t \N
38  What did I bring back from Mexico?  0 1 \N  t t \N
48  What don't you want to find in your Chinese food? 0 1 \N  t t \N
49  What will I bring back in time to convince people that I am a powerful wizard?  0 1 \N  t t \N
50  How am I maintaining my relationship status?  0 1 \N  t t \N
51  _____. It's a trap! 0 1 \N  t t \N
52  Coming to Broadway this season, _____: The Musical. 0 1 \N  t t \N
84  Rumor has it that Vladimir Putin's favorite dish is _____ stuffed with _____. 0 2 \N  t t \N
57  But before I kill you, Mr. Bond, I must show you _____. 0 1 \N  t t \N
58  What gives me uncontrollable gas? 0 1 \N  t t \N
62  What do old people smell like?  0 1 \N  t t \N
61  The class field trip was completely ruined by _____.  0 1 \N  t t \N
60  When Pharaoh remained unmoved, Moses called down a plague of _____. 0 1 \N  t t \N
59  What's my secret power? 0 1 \N  t t \N
41  What's there a ton of in heaven?  0 1 \N  t t \N
42  What would grandma find disturbing, yet oddly charming? 0 1 \N  t t \N
85  I never truly understood _____ until I encountered _____. 0 2 \N  t t \N
43  What did the U.S. airdrop to the children of Afghanistan? 0 1 \N  t t \N
40  What helps Obama unwind?  0 1 \N  t t \N
73  What did Vin Diesel eat for dinner? 0 1 \N  t t \N
72  _____: Good to the last drop. 0 1 \N  t t \N
76  Why am I sticky?  0 1 \N  t t \N
75  What gets better with age?  0 1 \N  t t \N
74  _____: kid-tested, mother-approved. 0 1 \N  t t \N
71  What's the crustiest? 0 1 \N  t t \N
70  What's Teach for America using to inspire inner city students to succeed? 0 1 \N  t t \N
67  Studies show that lab rats navigate mazes 50% faster after being exposed to _____.  0 1 \N  t t \N
86  Make a haiku. 2 3 \N  t t \N
68  I do not know with which weapons World War III will be fought, but World War IV will be fought with _____.  0 1 \N  t t \N
66  Why do I hurt all over? 0 1 \N  t t \N
63  What am I giving up for Lent? 0 1 \N  t t \N
64  In Michael Jackson's final moments, he thought about _____. 0 1 \N  t t \N
65  In an attempt to reach a wider audience, the Smithsonian Museum of Natural History has opened an interactive exhibit on _____.  0 1 \N  t t \N
45  When I am the President of the United States, I will create the Department of _____.  0 1 \N  t t \N
87  Lifetime® presents _____, the story of _____. 0 2 \N  t t \N
47  When I am a billionare, I shall erect a 50-foot statue to commemorate _____.  0 1 \N  t t \N
88  When I was tripping on acid, _____ turned into _____. 0 2 \N  t t \N
89  That's right, I killed _____. How, you ask? _____.  0 2 \N  t t \N
77  What's my anti-drug?  0 1 \N  t t \N
90  _____ + _____ = _____.  2 3 \N  t t \N
56  What never fails to liven up the party? 0 1 \N  t t \N
44  What's the new fad diet?  0 1 \N  t t \N
46  Major League Baseball has banned _____ for giving players an unfair advantage.  0 1 \N  t t \N
31  White people like _____.  0 1 \N  t t \N
32  _____. High five, bro.  0 1 \N  t t \N
29  Next from J.K. Rowling: Harry Potter and the Chamber of _____.  0 1 \N  t t \N
35  BILLY MAYS HERE FOR _____.  0 1 \N  t t \N
10  MTV's new reality show features eight washed-up celebrities living with _____.  0 1 \N  t t \N
83  In his new summer comedy, Rob Schneider is _____ trapped in the body of _____.  0 2 \N  t f \N
5 _____? There's an app for that  0 1 \N  t t \N
13  During Picasso's often-overlooked Brown Period, he produced hundreds of paintings of _____. 0 1 \N  t t \N
2 I got 99 problems but _____ ain't one.  0 1 \N  t t \N
53  While the United States raced the Soviet Union to the moon, the Mexican government funneled millions of pesos into research on _____. 0 1 \N  t t \N
1001  test  0 1 \N  f f \N
1003  Starting Canadian Black Cards 0 1 \N  f f \N
1009  End Canadian Black Cards  0 1 \N  f f \N
1033  end bonus misprint bonus card 0 1 \N  f f \N
1044  begin First Expansion 0 1 \N  f f \N
1065  end first expansion 0 1 \N  f f \N
1004  O Canada, we stand on guard for ____. 0 1 \N  f f CAN
1005  Air Canada guidelines now prohibit ____ on airplanes. 0 1 \N  f f CAN
1006  In an attempt to reach a wider audience, the Royal Ontario Museum has opened an interactive exhibit on ____.  0 1 \N  f f CAN
1007  CTV presents ____, the story of ____. 0 2 \N  f f CAN
1008  What's the Canadian government using to inspire rural students to succeed?  0 1 \N  f f CAN
1045  He who controls ____ controls the world.  0 1 \N  f f X1
1046  The CIA now interrogates enemy agents by repeatedly subjecting them to ____.  0 1 \N  f f X1
1047  Dear Sir or Madam, We regret to inform you that the Office of ____ has denied your request for ____.  0 2 \N  f f X1
1048  In Rome, there are whisperings that the Vatican has a secret room devoted to ____.  0 1 \N  f f X1
1049  Science will never explain the origin of ____.  0 1 \N  f f X1
1050  When all else fails, I can always masturbate to ____. 0 1 \N  f f X1
1051  I learned the hard way that you can't cheer up a grieving friend with ____. 0 1 \N  f f X1
1052  In its new tourism campaign, Detroit proudly proclaims that it has finally eliminated ____. 0 1 \N  f f X1
1053  An international tribunal has found ____ guilty of ____.  0 2 \N  f f X1
1054  The socialist governments of Scandinavia have declared that access to ____ is a basic human right.  0 1 \N  f f X1
1055  In his new self-produced album, Kanye West raps over the sounds of ____.  0 1 \N  f f X1
1056  What's the gift that keeps on giving? 0 1 \N  f f X1
1057  This season on Man vs. Wild, Bear Grylls must survive in the depths of the Amazon with only ____ and his wits.  0 1 \N  f f X1
1058  When I pooped, what came out of my butt?  0 1 \N  f f X1
1059  In the distant future, historians will agree that ____ marked the beginning of America's decline. 0 1 \N  f f X1
1060  In a pinch, ____ can be a suitable substitute for ____. 0 2 \N  f f X1
1061  What has been making life difficult at the nudist colony? 0 1 \N  f f X1
1062  Michael Bay's new three-hour action epic pits ____ against ____.  0 2 \N  f f X1
91  Maybe she's born with it. Maybe it's _____. 0 1 \N  f t 1.2
92  Dear Abby, I'm having some trouble with _____ and would like your advice. 0 1 \N  f t 1.2
93  What's the next superhero/sidekick duo? 0 2 \N  f t 1.2
94  In L.A. County Jail, word is you can trade 200 cigarettes for _____.  0 1 \N  f t 1.2
95  After the earthquake, Sean Penn brought _____ to the people of Haiti. 0 1 \N  f t 1.2
96  Next on ESPN2, the World Series of _____. 0 1 \N  f t 1.2
97  Step 1: _____. Step 2: _____. Step 3: Profit. 0 2 \N  f t 1.2
98  Life for American Indians was forever changed when the White Man introduced them to _____.  0 1 \N  f t 1.2
1032  Daddy, why is Mommy crying? 0 1 \N  f f B
1063  And I would have gotten away with it, too, if it hadn't been for ____!  0 1 \N  f f X1
1064  What brought the orgy to a grinding halt? 0 1 \N  f f X1
\.


--
-- TOC entry 1823 (class 0 OID 16497)
-- Dependencies: 148
-- Data for Name: card_set; Type: TABLE DATA; Schema: public; Owner: cah
--

COPY card_set (id, active, name, base_deck) FROM stdin;
1153  t Canadian  f
1154  t Misprint Replacement Bonus Cards  f
1155  t The First Expansion f
1151  t First Version t
1152  t Second Version  t
\.


--
-- TOC entry 1824 (class 0 OID 16502)
-- Dependencies: 149
-- Data for Name: card_set_black_card; Type: TABLE DATA; Schema: public; Owner: cah
--

COPY card_set_black_card (card_set_id, black_card_id) FROM stdin;
1151  1
1151  2
1151  3
1151  4
1151  5
1151  6
1151  7
1151  8
1151  9
1151  10
1151  11
1151  12
1151  13
1151  14
1151  15
1151  17
1151  16
1151  19
1151  18
1151  21
1151  20
1151  23
1151  22
1151  25
1151  24
1151  27
1151  26
1151  29
1151  28
1151  31
1151  30
1151  34
1151  35
1151  32
1151  33
1151  38
1151  39
1151  36
1151  37
1151  42
1151  43
1151  40
1151  41
1151  46
1151  47
1151  44
1151  45
1151  51
1151  50
1151  49
1151  48
1151  55
1151  54
1151  53
1151  52
1151  59
1151  58
1151  57
1151  56
1151  63
1151  62
1151  61
1151  60
1151  68
1151  69
1151  70
1151  71
1151  64
1151  65
1151  66
1151  67
1151  76
1151  77
1151  78
1151  79
1151  72
1151  73
1151  74
1151  75
1151  85
1151  84
1151  87
1151  86
1151  81
1151  80
1151  83
1151  82
1151  89
1151  88
1151  90
1152  1
1152  2
1152  3
1152  4
1152  5
1152  6
1152  7
1152  8
1152  9
1152  10
1152  11
1152  12
1152  13
1152  14
1152  15
1152  17
1152  19
1152  18
1152  21
1152  20
1152  22
1152  25
1152  24
1152  26
1152  29
1152  28
1152  31
1152  30
1152  34
1152  35
1152  32
1152  33
1152  38
1152  39
1152  36
1152  42
1152  43
1152  40
1152  41
1152  46
1152  47
1152  44
1152  45
1152  51
1152  50
1152  49
1152  48
1152  53
1152  52
1152  59
1152  58
1152  57
1152  56
1152  63
1152  62
1152  61
1152  60
1152  68
1152  70
1152  71
1152  64
1152  65
1152  66
1152  67
1152  76
1152  77
1152  78
1152  79
1152  72
1152  73
1152  74
1152  75
1152  85
1152  84
1152  87
1152  86
1152  81
1152  80
1152  82
1152  93
1152  92
1152  95
1152  94
1152  89
1152  88
1152  91
1152  90
1152  98
1152  96
1152  97
1153  1005
1153  1004
1153  1007
1153  1006
1153  1008
1154  1032
1155  1064
1155  1058
1155  1059
1155  1056
1155  1057
1155  1062
1155  1063
1155  1060
1155  1061
1155  1049
1155  1048
1155  1051
1155  1050
1155  1053
1155  1052
1155  1055
1155  1054
1155  1045
1155  1047
1155  1046
\.


--
-- TOC entry 1825 (class 0 OID 16507)
-- Dependencies: 150
-- Data for Name: card_set_white_card; Type: TABLE DATA; Schema: public; Owner: cah
--

COPY card_set_white_card (card_set_id, white_card_id) FROM stdin;
1151  1
1151  2
1151  3
1151  4
1151  5
1151  6
1151  7
1151  8
1151  9
1151  10
1151  11
1151  12
1151  13
1151  14
1151  15
1151  17
1151  16
1151  19
1151  18
1151  21
1151  20
1151  23
1151  22
1151  25
1151  24
1151  27
1151  26
1151  29
1151  28
1151  31
1151  30
1151  34
1151  35
1151  32
1151  33
1151  38
1151  39
1151  36
1151  37
1151  42
1151  43
1151  40
1151  41
1151  46
1151  47
1151  44
1151  45
1151  51
1151  50
1151  49
1151  48
1151  55
1151  54
1151  53
1151  52
1151  59
1151  58
1151  57
1151  56
1151  63
1151  62
1151  61
1151  60
1151  68
1151  69
1151  70
1151  71
1151  64
1151  65
1151  66
1151  67
1151  76
1151  77
1151  78
1151  79
1151  72
1151  73
1151  74
1151  75
1151  85
1151  84
1151  87
1151  86
1151  81
1151  80
1151  83
1151  82
1151  93
1151  92
1151  95
1151  94
1151  89
1151  88
1151  91
1151  90
1151  102
1151  103
1151  100
1151  101
1151  98
1151  99
1151  96
1151  97
1151  110
1151  111
1151  108
1151  109
1151  106
1151  107
1151  104
1151  105
1151  119
1151  118
1151  117
1151  116
1151  115
1151  114
1151  113
1151  112
1151  127
1151  126
1151  125
1151  124
1151  123
1151  122
1151  121
1151  120
1151  137
1151  136
1151  139
1151  138
1151  141
1151  140
1151  143
1151  142
1151  129
1151  128
1151  131
1151  130
1151  133
1151  132
1151  135
1151  134
1151  152
1151  153
1151  154
1151  155
1151  156
1151  157
1151  158
1151  159
1151  144
1151  145
1151  146
1151  147
1151  148
1151  149
1151  150
1151  151
1151  171
1151  170
1151  169
1151  168
1151  175
1151  174
1151  173
1151  172
1151  163
1151  162
1151  161
1151  160
1151  167
1151  166
1151  165
1151  164
1151  186
1151  187
1151  184
1151  185
1151  190
1151  191
1151  188
1151  189
1151  178
1151  179
1151  176
1151  177
1151  182
1151  183
1151  180
1151  181
1151  205
1151  204
1151  207
1151  206
1151  201
1151  200
1151  203
1151  202
1151  197
1151  196
1151  199
1151  198
1151  193
1151  192
1151  195
1151  194
1151  220
1151  221
1151  222
1151  223
1151  216
1151  217
1151  218
1151  219
1151  212
1151  213
1151  214
1151  215
1151  208
1151  209
1151  210
1151  211
1151  239
1151  238
1151  237
1151  236
1151  235
1151  234
1151  233
1151  232
1151  231
1151  230
1151  229
1151  228
1151  227
1151  226
1151  225
1151  224
1151  254
1151  255
1151  252
1151  253
1151  250
1151  251
1151  248
1151  249
1151  246
1151  247
1151  244
1151  245
1151  242
1151  243
1151  240
1151  241
1151  275
1151  274
1151  273
1151  272
1151  279
1151  278
1151  277
1151  276
1151  283
1151  282
1151  281
1151  280
1151  287
1151  286
1151  285
1151  284
1151  258
1151  259
1151  256
1151  257
1151  262
1151  263
1151  260
1151  261
1151  266
1151  267
1151  264
1151  265
1151  270
1151  271
1151  268
1151  269
1151  305
1151  304
1151  307
1151  306
1151  309
1151  308
1151  311
1151  310
1151  313
1151  312
1151  315
1151  314
1151  317
1151  316
1151  319
1151  318
1151  288
1151  289
1151  290
1151  291
1151  292
1151  293
1151  294
1151  295
1151  296
1151  297
1151  298
1151  299
1151  300
1151  301
1151  302
1151  303
1151  343
1151  342
1151  341
1151  340
1151  339
1151  338
1151  337
1151  336
1151  351
1151  350
1151  349
1151  348
1151  347
1151  346
1151  345
1151  344
1151  326
1151  327
1151  324
1151  325
1151  322
1151  323
1151  320
1151  321
1151  334
1151  335
1151  332
1151  333
1151  330
1151  331
1151  328
1151  329
1151  373
1151  372
1151  375
1151  374
1151  369
1151  368
1151  371
1151  370
1151  381
1151  380
1151  383
1151  382
1151  377
1151  376
1151  379
1151  378
1151  356
1151  357
1151  358
1151  359
1151  352
1151  353
1151  354
1151  355
1151  364
1151  365
1151  366
1151  367
1151  360
1151  361
1151  362
1151  363
1151  410
1151  411
1151  408
1151  409
1151  414
1151  415
1151  412
1151  413
1151  402
1151  403
1151  400
1151  401
1151  406
1151  407
1151  404
1151  405
1151  395
1151  394
1151  393
1151  392
1151  399
1151  398
1151  397
1151  396
1151  387
1151  386
1151  385
1151  384
1151  391
1151  390
1151  389
1151  388
1151  440
1151  441
1151  442
1151  443
1151  444
1151  445
1151  446
1151  447
1151  432
1151  433
1151  434
1151  435
1151  436
1151  437
1151  438
1151  439
1151  425
1151  424
1151  427
1151  426
1151  429
1151  428
1151  431
1151  430
1151  417
1151  416
1151  419
1151  418
1151  421
1151  420
1151  423
1151  422
1151  460
1151  459
1151  458
1151  457
1151  456
1151  455
1151  454
1151  453
1151  452
1151  451
1151  450
1151  449
1151  448
1152  1
1152  2
1152  3
1152  4
1152  5
1152  6
1152  7
1152  10
1152  11
1152  12
1152  13
1152  14
1152  16
1152  19
1152  18
1152  20
1152  23
1152  22
1152  25
1152  24
1152  27
1152  26
1152  29
1152  28
1152  31
1152  30
1152  34
1152  35
1152  32
1152  33
1152  38
1152  39
1152  36
1152  37
1152  42
1152  40
1152  41
1152  46
1152  47
1152  44
1152  45
1152  51
1152  50
1152  49
1152  48
1152  55
1152  54
1152  53
1152  52
1152  59
1152  58
1152  57
1152  56
1152  63
1152  62
1152  61
1152  60
1152  68
1152  70
1152  71
1152  65
1152  66
1152  67
1152  76
1152  77
1152  78
1152  79
1152  72
1152  73
1152  74
1152  75
1152  85
1152  84
1152  87
1152  86
1152  81
1152  80
1152  83
1152  82
1152  93
1152  92
1152  95
1152  94
1152  89
1152  88
1152  91
1152  90
1152  102
1152  103
1152  101
1152  98
1152  99
1152  96
1152  97
1152  111
1152  108
1152  109
1152  106
1152  107
1152  104
1152  105
1152  119
1152  118
1152  117
1152  116
1152  115
1152  114
1152  113
1152  112
1152  127
1152  126
1152  125
1152  124
1152  122
1152  121
1152  137
1152  136
1152  139
1152  138
1152  141
1152  140
1152  142
1152  129
1152  128
1152  132
1152  135
1152  134
1152  152
1152  153
1152  154
1152  155
1152  157
1152  159
1152  144
1152  145
1152  146
1152  147
1152  148
1152  149
1152  150
1152  151
1152  171
1152  170
1152  169
1152  168
1152  175
1152  174
1152  173
1152  172
1152  163
1152  162
1152  161
1152  160
1152  167
1152  166
1152  165
1152  186
1152  187
1152  184
1152  185
1152  191
1152  189
1152  178
1152  179
1152  176
1152  182
1152  183
1152  180
1152  181
1152  205
1152  204
1152  207
1152  206
1152  201
1152  200
1152  203
1152  202
1152  197
1152  196
1152  199
1152  198
1152  193
1152  192
1152  195
1152  194
1152  220
1152  221
1152  222
1152  223
1152  217
1152  218
1152  219
1152  212
1152  213
1152  214
1152  215
1152  208
1152  209
1152  210
1152  211
1152  239
1152  238
1152  237
1152  236
1152  235
1152  234
1152  233
1152  232
1152  231
1152  230
1152  229
1152  228
1152  227
1152  226
1152  225
1152  224
1152  254
1152  255
1152  252
1152  253
1152  250
1152  251
1152  249
1152  246
1152  244
1152  245
1152  242
1152  243
1152  240
1152  241
1152  275
1152  274
1152  272
1152  279
1152  278
1152  277
1152  276
1152  283
1152  282
1152  280
1152  287
1152  286
1152  284
1152  258
1152  259
1152  256
1152  257
1152  262
1152  263
1152  260
1152  261
1152  266
1152  267
1152  265
1152  270
1152  271
1152  268
1152  269
1152  305
1152  304
1152  306
1152  309
1152  308
1152  311
1152  312
1152  315
1152  314
1152  317
1152  316
1152  319
1152  318
1152  289
1152  290
1152  291
1152  292
1152  293
1152  294
1152  295
1152  296
1152  297
1152  298
1152  299
1152  300
1152  302
1152  303
1152  343
1152  340
1152  339
1152  337
1152  336
1152  351
1152  349
1152  348
1152  347
1152  346
1152  345
1152  344
1152  326
1152  327
1152  324
1152  325
1152  322
1152  323
1152  320
1152  321
1152  334
1152  335
1152  332
1152  330
1152  329
1152  373
1152  372
1152  375
1152  374
1152  369
1152  368
1152  370
1152  381
1152  380
1152  382
1152  377
1152  376
1152  379
1152  378
1152  356
1152  357
1152  358
1152  359
1152  352
1152  354
1152  355
1152  364
1152  365
1152  366
1152  367
1152  360
1152  361
1152  362
1152  410
1152  411
1152  408
1152  409
1152  414
1152  415
1152  412
1152  413
1152  402
1152  400
1152  401
1152  406
1152  407
1152  404
1152  405
1152  395
1152  394
1152  393
1152  392
1152  399
1152  398
1152  397
1152  396
1152  387
1152  386
1152  385
1152  384
1152  391
1152  390
1152  389
1152  388
1152  440
1152  441
1152  442
1152  443
1152  444
1152  445
1152  446
1152  447
1152  432
1152  433
1152  434
1152  435
1152  436
1152  437
1152  438
1152  439
1152  425
1152  427
1152  426
1152  429
1152  431
1152  430
1152  417
1152  416
1152  419
1152  418
1152  421
1152  420
1152  423
1152  422
1152  478
1152  479
1152  476
1152  477
1152  474
1152  475
1152  472
1152  473
1152  470
1152  471
1152  468
1152  469
1152  466
1152  467
1152  464
1152  465
1152  463
1152  462
1152  461
1152  460
1152  459
1152  458
1152  457
1152  456
1152  455
1152  453
1152  452
1152  451
1152  450
1152  449
1152  448
1152  508
1152  504
1152  505
1152  506
1152  507
1152  500
1152  501
1152  502
1152  503
1152  496
1152  497
1152  498
1152  499
1152  493
1152  492
1152  495
1152  494
1152  489
1152  488
1152  491
1152  490
1152  485
1152  484
1152  487
1152  486
1152  481
1152  480
1152  483
1152  482
1153  1016
1153  1017
1153  1018
1153  1019
1153  1020
1153  1021
1153  1022
1153  1023
1153  1024
1153  1025
1153  1026
1153  1010
1153  1027
1153  1011
1153  1028
1153  1012
1153  1029
1153  1013
1153  1030
1153  1014
1153  1015
1154  1034
1154  1035
1154  1036
1154  1037
1154  1038
1154  1039
1154  1041
1154  1040
1154  1042
1155  1100
1155  1101
1155  1102
1155  1103
1155  1096
1155  1097
1155  1098
1155  1099
1155  1092
1155  1093
1155  1094
1155  1095
1155  1088
1155  1089
1155  1090
1155  1091
1155  1117
1155  1116
1155  1119
1155  1118
1155  1113
1155  1112
1155  1115
1155  1114
1155  1109
1155  1108
1155  1111
1155  1110
1155  1105
1155  1104
1155  1107
1155  1106
1155  1134
1155  1135
1155  1132
1155  1133
1155  1130
1155  1131
1155  1128
1155  1129
1155  1126
1155  1127
1155  1124
1155  1125
1155  1122
1155  1123
1155  1120
1155  1121
1155  1145
1155  1144
1155  1143
1155  1142
1155  1141
1155  1140
1155  1139
1155  1138
1155  1137
1155  1136
1155  1066
1155  1067
1155  1070
1155  1071
1155  1068
1155  1069
1155  1083
1155  1082
1155  1081
1155  1080
1155  1087
1155  1086
1155  1085
1155  1084
1155  1075
1155  1074
1155  1073
1155  1072
1155  1079
1155  1078
1155  1077
1155  1076
\.


--
-- TOC entry 1822 (class 0 OID 16417)
-- Dependencies: 146
-- Data for Name: white_cards; Type: TABLE DATA; Schema: public; Owner: cah
--

COPY white_cards (id, text, creator, in_v1, in_v2, watermark) FROM stdin;
282 Michelle Obama's arms.  \N  t t \N
124 White people. \N  t t \N
393 An erection that lasts longer than four hours.  \N  t t \N
141 Panda sex.  \N  t t \N
121 Stifling a giggle at the mention of Hutus and Tutsis. \N  t t \N
269 A middle-aged man on roller skates. \N  t t \N
1 Coat hanger abortions.  \N  t t \N
138 Scrubbing under the folds.  \N  t t \N
275 Wearing underwear inside-out to avoid doing laundry.  \N  t t \N
167 The Tempur-Pedic® Swedish Sleep System™.  \N  t t \N
1146  end First Expansion \N  f f \N
461 Flying sex snakes \N  f t 1.2
462 MechaHitler.  \N  f t 1.2
463 Getting naked and watching Nickelodeon. \N  f t 1.2
464 Charisma. \N  f t 1.2
465 Morgan Freeman's voice. \N  f t 1.2
466 Breaking out into song and dance. \N  f t 1.2
467 Soup that is too hot. \N  f t 1.2
468 Chutzpah. \N  f t 1.2
469 Unfathomable stupidity. \N  f t 1.2
470 Horrifying laser hair removal accidents.  \N  f t 1.2
471 Boogers.  \N  f t 1.2
472 A Bop It™.  \N  f t 1.2
473 Expecting a burp and vomiting on the floor. \N  f t 1.2
474 A defective condom. \N  f t 1.2
475 Teenage pregnancy.  \N  f t 1.2
476 Hot cheese. \N  f t 1.2
477 A mopey zoo lion. \N  f t 1.2
478 Shapeshifters.  \N  f t 1.2
479 The Care Bear Stare.  \N  f t 1.2
480 Erectile dysfunction. \N  f t 1.2
481 The chronic.  \N  f t 1.2
483 "Tweeting." \N  f t 1.2
484 Firing a rifle into the air while balls deep in a squealing hog.  \N  f t 1.2
485 Nicolas Cage. \N  f t 1.2
482 Home video of Oprah sobbing into a Lean Cuisine®. \N  f t 1.2
1110  Leveling up.  \N  f f X1
1111  Literally eating shit.  \N  f f X1
1112  Making the penises kiss.  \N  f f X1
1113  Media coverage. \N  f f X1
1114  Medieval Times® Dinner & Tournament.  \N  f f X1
1115  Moral ambiguity.  \N  f f X1
1116  My machete. \N  f f X1
1117  One thousand Slim Jims. \N  f f X1
1118  Ominous background music. \N  f f X1
1119  Overpowering your father. \N  f f X1
1120  Pistol-whipping a hostage.  \N  f f X1
1121  Quiche. \N  f f X1
1122  Quivering jowls.  \N  f f X1
1123  Revenge fucking.  \N  f f X1
1124  Ripping into a man's chest and pulling out his still-beating heart. \N  f f X1
1125  Ryan Gosling riding in on a white horse.  \N  f f X1
1126  Santa Claus.  \N  f f X1
1127  Scrotum tickling. \N  f f X1
1128  Sexual humiliation. \N  f f X1
1129  Sexy Siamese twins. \N  f f X1
1130  Slow motion.  \N  f f X1
1131  Space muffins.  \N  f f X1
1132  Statistically validated stereotypes.  \N  f f X1
1133  Sudden Poop Explosion Disease.  \N  f f X1
1134  The boners of the elderly.  \N  f f X1
1135  The economy.  \N  f f X1
225 Dropping a chandelier on your enemies and riding the rope up. \N  t t \N
297 Public ridicule.  \N  t t \N
265 A snapping turtle biting the tip of your penis. \N  t t \N
218 Vehicular manslaughter. \N  t t \N
267 Domino's™ Oreo™ Dessert Pizza.  \N  t t \N
160 The token minority. \N  t t \N
486 Euphoria™ by Calvin Klein.  \N  f t 1.2
487 Switching to Geico®.  \N  f t 1.2
488 A gentle caress of the inner thigh. \N  f t 1.2
489 Poor life choices.  \N  f t 1.2
490 Embryonic stem cells. \N  f t 1.2
491 Customer service representatives. \N  f t 1.2
492 The Little Engine That Could. \N  f t 1.2
493 Lady Gaga.  \N  f t 1.2
494 A death ray.  \N  f t 1.2
495 Vigilante justice.  \N  f t 1.2
496 Exactly what you'd expect.  \N  f t 1.2
497 Natural male enhancement. \N  f t 1.2
498 Passive-aggressive Post-it notes. \N  f t 1.2
499 Inappropriate yodeling. \N  f t 1.2
500 A homoerotic volleyball montage.  \N  f t 1.2
501 Actually taking candy from a baby.  \N  f t 1.2
502 Jibber-jabber.  \N  f t 1.2
503 Crystal meth. \N  f t 1.2
504 My inner demons.  \N  f t 1.2
505 Pac-Man uncontrollably guzzling cum.  \N  f t 1.2
506 My vagina.  \N  f t 1.2
507 The Donald Trump Seal of Approval™. \N  f t 1.2
508 The true meaning of Christmas.  \N  f t 1.2
1136  The Fanta® girls. \N  f f X1
1137  The Gulags. \N  f f X1
1138  The harsh light of day. \N  f f X1
1139  The hiccups.  \N  f f X1
1140  The shambling corpse of Larry King. \N  f f X1
1141  The four arms of Vishnu.  \N  f f X1
1142  Being a busy adult with many important things to do.  \N  f f X1
1143  Tripping balls. \N  f f X1
1144  Words, words, words.  \N  f f X1
1145  Zeus's sexual appetites.  \N  f f X1
1066  A big black dick. \N  f f X1
1067  A beached whale.  \N  f f X1
1068  A bloody pacifier.  \N  f f X1
1069  A crappy little hand. \N  f f X1
1070  A low standard of living. \N  f f X1
1071  A nuanced critique. \N  f f X1
1072  Panty raids.  \N  f f X1
1073  A passionate Latino lover.  \N  f f X1
1074  A rival dojo. \N  f f X1
1075  A web of lies.  \N  f f X1
1076  A woman scorned.  \N  f f X1
1077  Clams \N  f f X1
1078  Apologizing.  \N  f f X1
1079  Appreciative snapping.  \N  f f X1
1080  Neil Patrick Harris.  \N  f f X1
1081  Beating your wives. \N  f f X1
1082  Being a dinosaur. \N  f f X1
1083  Shaft.  \N  f f X1
1002  testtest  \N  f f \N
1031  End Canadian White Cards  \N  f f \N
1010  Mr. Dressup.  \N  f f CAN
1011  Being Canadian. \N  f f CAN
1012  The Famous Five.  \N  f f CAN
1013  Stephen Harper. \N  f f CAN
1014  The Royal Canadian Mounted Police.  \N  f f CAN
1015  An icy handjob from an Edmonton hooker. \N  f f CAN
1016  Poutine.  \N  f f CAN
1017  Newfies.  \N  f f CAN
1018  The Official Languages Act. La Loi sur les langues officielles. \N  f f CAN
1019  Terry Fox's prosthetic leg. \N  f f CAN
1020  The FLQ.  \N  f f CAN
1021  Canada: America's Hat.  \N  f f CAN
1022  Don Cherry's wardrobe.  \N  f f CAN
1023  Burning down the White House. \N  f f CAN
1024  Heritage minutes. \N  f f CAN
1025  Homo milk.  \N  f f CAN
1026  Naked News. \N  f f CAN
1027  Syrupy sex with a maple tree. \N  f f CAN
1028  Snotsicles. \N  f f CAN
1029  Schmirler the Curler. \N  f f CAN
1030  A Molson muscle.  \N  f f CAN
44  German dungeon porn.  \N  t t \N
40  Praying the gay away. \N  t t \N
63  Dying.  \N  t t \N
41  Same-sex ice dancing. \N  t t \N
70  Dying of dysentery. \N  t t \N
19  Roofies.  \N  t t \N
22  The Big Bang. \N  t t \N
23  Amputees. \N  t t \N
74  Men.  \N  t t \N
18  Concealing a boner. \N  t t \N
87  Agriculture.  \N  t t \N
51  Making a pouty face.  \N  t t \N
98  YOU MUST CONSTRUCT ADDITIONAL PYLONS. \N  t t \N
60  Hormone injections. \N  t t \N
55  Tom Cruise. \N  t t \N
56  Object permanence.  \N  t t \N
92  Consultants.  \N  t t \N
26  Being marginalized. \N  t t \N
54  The profoundly handicapped. \N  t t \N
96  Party poopers.  \N  t t \N
48  Nickelback. \N  t t \N
7 Doing the right thing.  \N  t t \N
65  The invisible hand. \N  t t \N
49  Heteronormativity.  \N  t t \N
29  Cuddling. \N  t t \N
84  Raptor attacks. \N  t t \N
38  Fear itself.  \N  t t \N
91  Sniffing glue.  \N  t t \N
58  An icepick lobotomy.  \N  t t \N
109 Being rich. \N  t t \N
79  The clitoris. \N  t t \N
71  Sexy pillow fights. \N  t t \N
105 Michael Jackson.  \N  t t \N
101 Sexting.  \N  t t \N
33  Horse meat. \N  t t \N
8 Hunting accidents.  \N  t f \N
9 A cartoon camel enjoying the smooth, refreshing taste of a cigarette. \N  t f \N
15  Abstinence. \N  t f \N
17  Mountain Dew Code Red.  \N  t f \N
21  Tweeting. \N  t f \N
43  Making sex at her.  \N  t f \N
64  Stunt doubles.  \N  t f \N
69  Flavored condoms. \N  t f \N
100 Heath Ledger. \N  t f \N
110 Muzzy.  \N  t f \N
97  Sunshine and rainbows.  \N  t t \N
68  Flash flooding. \N  t t \N
57  Goblins.  \N  t t \N
13  Spectacular abs.  \N  t t \N
72  The Three-Fifths compromise.  \N  t t \N
4 Vigorous jazz hands.  \N  t t \N
106 Skeletor. \N  t t \N
80  Vikings.  \N  t t \N
34  Genital piercings.  \N  t t \N
11  Viagra®.  \N  t t \N
67  A really cool hat.  \N  t t \N
102 An Oedipus complex. \N  t t \N
82  The Underground Railroad. \N  t t \N
77  Heartwarming orphans. \N  t t \N
47  Cheating in the Special Olympics. \N  t t \N
108 Sharing needles.  \N  t t \N
46  Ethnic cleansing. \N  t t \N
103 Eating all of the cookies before the AIDS bake-sale.  \N  t t \N
93  My humps. \N  t t \N
10  The violation of our most basic human rights. \N  t t \N
35  Fingering.  \N  t t \N
53  The placenta. \N  t t \N
5 Flightless birds. \N  t t \N
37  Stranger danger.  \N  t t \N
107 Chivalry. \N  t t \N
76  Sean Penn.  \N  t t \N
73  A sad handjob.  \N  t t \N
66  Jew-fros. \N  t t \N
12  Self-loathing.  \N  t t \N
61  A falcon with a cap on its head.  \N  t t \N
75  Historically black colleges.  \N  t t \N
30  Aaron Burr. \N  t t \N
25  Former President George W. Bush.  \N  t t \N
94  Geese.  \N  t t \N
99  Mutually-assured destruction. \N  t t \N
88  Bling.  \N  t t \N
27  Smegma. \N  t t \N
90  The South.  \N  t t \N
83  Pretending to care. \N  t t \N
59  Arnold Schwarzenegger.  \N  t t \N
20  Glenn Beck convulsively vomiting as a brood of crab spiders hatches in his brain and erupts from his tear ducts.  \N  t t \N
104 A sausage festival. \N  t t \N
62  Foreskin. \N  t t \N
95  Being a dick to children. \N  t t \N
52  Chainsaws for hands.  \N  t t \N
86  A Gypsy curse.  \N  t t \N
31  The Pope. \N  t t \N
16  A balanced breakfast. \N  t t \N
36  Elderly Japanese men. \N  t t \N
6 Pictures of boobs.  \N  t t \N
39  Science.  \N  t t \N
32  A bleached asshole. \N  t t \N
3 Autocannibalism.  \N  t t \N
50  William Shatner.  \N  t t \N
85  A micropenis. \N  t t \N
78  Waterboarding.  \N  t t \N
45  Bingeing and purging. \N  t t \N
89  A clandestine butt scratch. \N  t t \N
2 Man meat. \N  t t \N
28  Laying an egg.  \N  t t \N
14  An honest cop with nothing left to lose.  \N  t t \N
42  The terrorists. \N  t t \N
81  Friends who eat all the snacks. \N  t t \N
1043  end misprint bonus card \N  f f \N
1034  A bitch slap. \N  f f B
1035  One trillion dollars. \N  f f B
1036  Chunks of dead prostitute.  \N  f f B
1037  The entire Mormon Tabernacle Choir. \N  f f B
1038  The female orgasm.  \N  f f B
1039  Extremely tight pants.  \N  f f B
1040  Stormtroopers.  \N  f f B
1041  The Boy Scouts of America.  \N  f f B
1042  Throwing a virgin into a volcano. \N  f f B
120 Cookie Monster devouring the Eucharist wafers.  \N  t f \N
123 Letting yourself go.  \N  t f \N
130 Twinkies®.  \N  t f \N
131 A LAN party.  \N  t f \N
133 A grande sugar-free iced soy caramel macchiato. \N  t f \N
143 Will Smith. \N  t f \N
156 Marky Mark and the Funky Bunch. \N  t f \N
158 Dave Matthews Band. \N  t f \N
164 Substitute teachers.  \N  t f \N
177 Garth Brooks. \N  t f \N
188 Keeping Christ in Christmas.  \N  t f \N
190 That one gay Teletubby. \N  t f \N
216 Passive-agression.  \N  t f \N
247 A neglected Tamagotchi™.  \N  t f \N
248 The People's Elbow. \N  t f \N
230 Guys who don't call.  \N  t t \N
152 AIDS. \N  t t \N
187 The Rapture.  \N  t t \N
244 Eugenics. \N  t t \N
181 Taking off your shirt.  \N  t t \N
139 A drive-by shooting.  \N  t t \N
217 Ronald Reagan.  \N  t t \N
195 Jewish fraternities.  \N  t t \N
198 All-you-can-eat shrimp for $4.99. \N  t t \N
233 Scalping. \N  t t \N
196 Edible underpants.  \N  t t \N
154 Figgy pudding.  \N  t t \N
240 Intelligent design. \N  t t \N
207 Nocturnal emissions.  \N  t t \N
119 Uppercuts.  \N  t t \N
180 The American Dream. \N  t t \N
226 Testicular torsion. \N  t t \N
201 The folly of man. \N  t t \N
153 The KKK.  \N  t t \N
241 The taint; the grundle; the fleshy fun-bridge.  \N  t t \N
237 Saxophone solos.  \N  t t \N
200 That thing that electrocutes your abs.  \N  t t \N
176 Oversized lollipops.  \N  t t \N
161 Friends with benefits.  \N  t t \N
137 Teaching a robot to love. \N  t t \N
205 Me time.  \N  t t \N
250 The heart of a child. \N  t t \N
252 Smallpox blankets.  \N  t t \N
127 Yeast.  \N  t t \N
214 Full frontal nudity.  \N  t t \N
175 Authentic Mexican cuisine.  \N  t t \N
253 Licking things to claim them as your own. \N  t t \N
174 Genghis Khan. \N  t t \N
209 The hardworking Mexican.  \N  t t \N
189 RoboCop.  \N  t t \N
112 Spontaneous human combustion. \N  t t \N
128 Natural selection.  \N  t t \N
245 A good sniff. \N  t t \N
212 Nipple blades.  \N  t t \N
126 Leaving an awkward voicemail. \N  t t \N
213 Assless chaps.  \N  t t \N
191 Sweet, sweet vengeance. \N  t t \N
243 Keg stands. \N  t t \N
232 Darth Vader.  \N  t t \N
114 Necrophilia.  \N  t t \N
144 Toni Morrison's vagina. \N  t t \N
159 Preteens. \N  t t \N
185 A cooler full of organs.  \N  t t \N
178 Keanu Reeves. \N  t t \N
166 A thermonuclear detonation. \N  t t \N
186 A moment of silence.  \N  t t \N
142 Catapults.  \N  t t \N
118 Emotions. \N  t t \N
151 Balls.  \N  t t \N
234 Homeless people.  \N  t t \N
173 Old-people smell. \N  t t \N
117 Farting and walking away. \N  t t \N
206 The inevitable heat death of the universe.  \N  t t \N
24  The Rev. Dr. Martin Luther King, Jr.  \N  t t \N
136 Sperm whales. \N  t t \N
204 A murder most foul. \N  t t \N
208 Daddy issues. \N  t t \N
199 Britney Spears at 55. \N  t t \N
210 Natalie Portman.  \N  t t \N
223 The Holy Bible. \N  t t \N
229 Hot Pockets®. \N  t t \N
220 Pulling out.  \N  t t \N
163 Pixelated bukkake.  \N  t t \N
168 Waiting 'til marriage.  \N  t t \N
235 The World of Warcraft.  \N  t t \N
116 Global warming. \N  t t \N
224 World peace.  \N  t t \N
170 A can of whoop-ass. \N  t t \N
148 A zesty breakfast burrito.  \N  t t \N
221 Picking up girls at the abortion clinic.  \N  t t \N
146 Land mines. \N  t t \N
113 College.  \N  t t \N
228 A time travel paradox.  \N  t t \N
155 Seppuku.  \N  t t \N
211 Waking up half-naked in a Denny's parking lot.  \N  t t \N
149 Christopher Walken. \N  t t \N
236 Gloryholes. \N  t t \N
169 A tiny horse. \N  t t \N
184 Child abuse.  \N  t t \N
219 Menstruation. \N  t t \N
135 A sassy black woman.  \N  t t \N
162 Re-gifting. \N  t t \N
122 Penis envy. \N  t t \N
179 Drinking alone. \N  t t \N
215 Hulk Hogan. \N  t t \N
145 Five-Dollar Footlongs™. \N  t t \N
140 Whipping it out.  \N  t t \N
171 Dental dams.  \N  t t \N
157 Gandhi. \N  t t \N
239 God.  \N  t t \N
150 Friction. \N  t t \N
147 A sea of troubles.  \N  t t \N
197 Poor people.  \N  t t \N
183 Flesh-eating bacteria.  \N  t t \N
125 Dick Cheney.  \N  t t \N
246 Lockjaw.  \N  t t \N
165 Take-backsies.  \N  t t \N
132 Opposable thumbs. \N  t t \N
222 The homosexual agenda.  \N  t t \N
202 Fiery poops.  \N  t t \N
203 Cards Against Humanity. \N  t t \N
192 Fancy Feast®. \N  t t \N
238 Sean Connery. \N  t t \N
227 The milk man. \N  t t \N
115 The Chinese gymnastics team.  \N  t t \N
231 Eating the last known bison.  \N  t t \N
134 Soiling oneself.  \N  t t \N
182 Giving 110%.  \N  t t \N
242 Friendly fire.  \N  t t \N
111 Count Chocula.  \N  t t \N
172 Feeding Rosie O'Donnell.  \N  t t \N
251 Seduction.  \N  t t \N
194 Being a motherfucking sorcerer. \N  t t \N
264 Eastern European Turbo-Folk music.  \N  t f \N
273 Douchebags on their iPhones.  \N  t f \N
281 The deformed. \N  t f \N
285 Donald Trump. \N  t f \N
288 This answer is postmodern.  \N  t f \N
301 African children. \N  t f \N
307 Have some more kugel. \N  t f \N
310 Crippling debt. \N  t f \N
313 Shorties and blunts.  \N  t f \N
328 (I am doing Kegels right now.)  \N  t f \N
331 Bestiality. \N  t f \N
333 Drum circles. \N  t f \N
338 Inappropriate yelling.  \N  t f \N
341 The Thong Song. \N  t f \N
342 A vajazzled vagina. \N  t f \N
350 Sobbing into a Hungry-Man® Frozen Dinner. \N  t f \N
353 Ring Pops™. \N  t f \N
363 Tiger Woods.  \N  t f \N
371 PCP.  \N  t f \N
383 Mr. Snuffleupagus.  \N  t f \N
394 A disappointing birthday party. \N  t t \N
319 Puppies!  \N  t t \N
308 A windmill full of corpses. \N  t t \N
340 Being on fire.  \N  t t \N
372 A lifetime of sadness.  \N  t t \N
258 Pterodactyl eggs. \N  t t \N
289 Crumpets with the Queen.  \N  t t \N
344 Exchanging pleasantries.  \N  t t \N
276 Republicans.  \N  t t \N
321 Kim Jong-il.  \N  t t \N
366 Glenn Beck being harried by a swarm of buzzards.  \N  t t \N
254 A salty surprise. \N  t t \N
330 The Jews. \N  t t \N
324 Incest. \N  t t \N
284 The Übermensch. \N  t t \N
391 Nazis.  \N  t t \N
292 Repression. \N  t t \N
287 Attitude. \N  t t \N
361 Passable transvestites. \N  t t \N
395 Puberty.  \N  t t \N
374 Swooping. \N  t t \N
311 Adderall™.  \N  t t \N
379 A look-see. \N  t t \N
348 Lactation.  \N  t t \N
266 Pabst Blue Ribbon.  \N  t t \N
357 The gays. \N  t t \N
278 A foul mouth. \N  t t \N
377 A hot mess. \N  t t \N
268 My collection of high-tech sex toys.  \N  t t \N
318 Bees? \N  t t \N
388 Getting drunk on mouthwash. \N  t t \N
277 The glass ceiling.  \N  t t \N
286 Sarah Palin.  \N  t t \N
291 Team-building exercises.  \N  t t \N
290 Frolicking. \N  t t \N
380 Not giving a shit about the Third World.  \N  t t \N
345 My relationship status. \N  t t \N
384 Barack Obama. \N  t t \N
302 Mouth herpes. \N  t t \N
386 Wiping her butt.  \N  t t \N
263 Pedophiles. \N  t t \N
373 Doin' it in the butt. \N  t t \N
347 Being fabulous. \N  t t \N
389 An M. Night Shyamalan plot twist. \N  t t \N
294 A bag of magic beans. \N  t t \N
296 Dead parents. \N  t t \N
257 My sex life.  \N  t t \N
343 Riding off into the sunset. \N  t t \N
364 Dick fingers. \N  t t \N
362 The Virginia Tech Massacre. \N  t t \N
387 Queefing. \N  t t \N
339 Tangled Slinkys.  \N  t t \N
337 Civilian casualties.  \N  t t \N
316 Leprosy.  \N  t t \N
325 Grave robbing.  \N  t t \N
376 Tentacle porn.  \N  t t \N
304 Bill Nye the Science Guy. \N  t t \N
370 New Age music.  \N  t t \N
261 72 virgins. \N  t t \N
322 Hope. \N  t t \N
314 Passing a kidney stone. \N  t t \N
299 A mime having a stroke. \N  t t \N
368 Classist undertones.  \N  t t \N
298 A mating display. \N  t t \N
382 The Kool-Aid Man. \N  t t \N
349 Not reciprocating oral sex. \N  t t \N
352 Date rape.  \N  t t \N
306 Italians. \N  t t \N
256 My soul.  \N  t t \N
354 GoGurt®.  \N  t t \N
312 A stray pube. \N  t t \N
279 Jerking off into a pool of children's tears.  \N  t t \N
280 Getting really high.  \N  t t \N
378 Too much hair gel.  \N  t t \N
303 Overcompensation. \N  t t \N
272 Free samples. \N  t t \N
346 Shaquille O'Neal's acting career. \N  t t \N
271 Half-assed foreplay.  \N  t t \N
283 Explosions. \N  t t \N
392 White privilege.  \N  t t \N
293 Road head.  \N  t t \N
255 Poorly-timed Holocaust jokes. \N  t t \N
323 8 oz. of sweet Mexican black-tar heroin.  \N  t t \N
355 Judge Judy. \N  t t \N
259 Altar boys. \N  t t \N
358 Scientology.  \N  t t \N
329 Justin Bieber.  \N  t t \N
327 Alcoholism. \N  t t \N
351 My genitals.  \N  t t \N
332 Winking at old people.  \N  t t \N
385 Golden showers. \N  t t \N
365 Racism. \N  t t \N
336 Auschwitz.  \N  t t \N
262 Raping and pillaging. \N  t t \N
334 Kids with ass cancer. \N  t t \N
274 Hurricane Katrina.  \N  t t \N
356 Lumberjack fantasies. \N  t t \N
381 American Gladiators.  \N  t t \N
295 An asymmetric boob job. \N  t t \N
326 Asians who aren't good at math. \N  t t \N
335 Loose lips. \N  t t \N
270 The Blood of Christ.  \N  t t \N
317 A brain tumor.  \N  t t \N
315 Prancing. \N  t t \N
375 The Hamburglar. \N  t t \N
360 Police brutality. \N  t t \N
260 Forgetting the Alamo. \N  t t \N
369 Booby-trapping the house to foil burglars.  \N  t t \N
359 Estrogen. \N  t t \N
390 A robust mongoloid. \N  t t \N
309 Her Royal Highness, Queen Elizabeth II. \N  t t \N
193 Pooping back and forth. Forever.  \N  t t \N
320 Cockfights. \N  t t \N
305 Bitches.  \N  t t \N
300 Stephen Hawking talking dirty.  \N  t t \N
403 Those times when you get sand in your vagina. \N  t f \N
424 Faith healing.  \N  t f \N
428 Impotence.  \N  t f \N
454 Bananas in Pajamas. \N  t f \N
399 Getting so angry that you pop a boner.  \N  t t \N
414 Tasteful sideboob.  \N  t t \N
396 Two midgets shitting into a bucket. \N  t t \N
406 Racially-biased SAT questions.  \N  t t \N
449 Glenn Beck catching his scrotum on a curtain hook.  \N  t t \N
398 The forbidden fruit.  \N  t t \N
459 Anal beads. \N  t t \N
367 Surprise sex! \N  t t \N
426 Dead babies.  \N  t t \N
129 Masturbation. \N  t t \N
452 The Hustle. \N  t t \N
404 A Super Soaker™ full of cat pee.  \N  t t \N
409 Obesity.  \N  t t \N
429 Child beauty pageants.  \N  t t \N
422 Goats eating coins. \N  t t \N
457 Kamikaze pilots.  \N  t t \N
443 Powerful thighs.  \N  t t \N
450 A big hoopla about nothing. \N  t t \N
433 Women's suffrage. \N  t t \N
442 John Wilkes Booth.  \N  t t \N
425 Parting the Red Sea.  \N  t t \N
435 Harry Potter erotica. \N  t t \N
416 Grandma.  \N  t t \N
407 Porn stars. \N  t t \N
423 A monkey smoking a cigar. \N  t t \N
439 Mathletes.  \N  t t \N
437 Lance Armstrong's missing testicle. \N  t t \N
434 Children on leashes.  \N  t t \N
445 Multiple stab wounds. \N  t t \N
411 Oompa-Loompas.  \N  t t \N
451 Peeing a little bit.  \N  t t \N
421 The miracle of childbirth.  \N  t t \N
448 Another goddamn vampire movie.  \N  t t \N
460 The Make-A-Wish® Foundation.  \N  t t \N
455 Active listening. \N  t t \N
402 A gassy antelope. \N  t t \N
412 BATMAN!!! \N  t t \N
413 Black people. \N  t t \N
447 Serfdom.  \N  t t \N
440 Lunchables™.  \N  t t \N
418 The Trail of Tears. \N  t t \N
453 Ghosts. \N  t t \N
436 The Dance of the Sugar Plum Fairy.  \N  t t \N
420 Finger painting.  \N  t t \N
249 Robert Downey, Jr.  \N  t t \N
405 Muhammed (Praise Be Unto Him).  \N  t t \N
419 Famine. \N  t t \N
431 AXE Body Spray. \N  t t \N
458 The Force.  \N  t t \N
446 Cybernetic enhancements.  \N  t t \N
444 Mr. Clean, right behind you.  \N  t t \N
401 Third base. \N  t t \N
438 Dwarf tossing.  \N  t t \N
408 A fetus.  \N  t t \N
441 Women in yogurt commercials.  \N  t t \N
417 Copping a feel. \N  t t \N
400 Sexual tension. \N  t t \N
456 Dry heaving.  \N  t t \N
430 Centaurs. \N  t t \N
397 Wifely duties.  \N  t t \N
415 Hot people. \N  t t \N
432 Kanye West. \N  t t \N
427 The Amish.  \N  t t \N
410 When you fart and a little bit comes out. \N  t t \N
1084  Bosnian chicken farmers.  \N  f f X1
1085  Nubile slave boys.  \N  f f X1
1086  Carnies.  \N  f f X1
1087  Coughing into a vagina. \N  f f X1
1088  Suicidal thoughts.  \N  f f X1
1089  Dancing with a broom. \N  f f X1
1090  Deflowering the princess. \N  f f X1
1091  Dorito breath.  \N  f f X1
1092  Eating an albino. \N  f f X1
1093  Enormous Scandinavian women.  \N  f f X1
1094  Fabricating statistics. \N  f f X1
1095  Finding a skeleton. \N  f f X1
1096  Gandalf.  \N  f f X1
1097  Genetically engineered super-soldiers.  \N  f f X1
1098  George Clooney's musk.  \N  f f X1
1099  Getting abducted by Peter Pan.  \N  f f X1
1100  Getting in her pants, politely. \N  f f X1
1101  Gladiatorial combat.  \N  f f X1
1102  Good grammar. \N  f f X1
1103  Hipsters. \N  f f X1
1104  Historical revisionism. \N  f f X1
1105  Insatiable bloodlust. \N  f f X1
1106  Jafar.  \N  f f X1
1107  Jean-Claude Van Damme.  \N  f f X1
1108  Just the tip. \N  f f X1
1109  Mad hacky-sack skills.  \N  f f X1
\.


--
-- TOC entry 1804 (class 2606 OID 16425)
-- Dependencies: 140 140
-- Name: black_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY black_cards
    ADD CONSTRAINT black_cards_pkey PRIMARY KEY (id);


--
-- TOC entry 1806 (class 2606 OID 16427)
-- Dependencies: 140 140
-- Name: black_cards_text_key; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY black_cards
    ADD CONSTRAINT black_cards_text_key UNIQUE (text);


--
-- TOC entry 1814 (class 2606 OID 16506)
-- Dependencies: 149 149 149
-- Name: card_set_black_card_pkey; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY card_set_black_card
    ADD CONSTRAINT card_set_black_card_pkey PRIMARY KEY (card_set_id, black_card_id);


--
-- TOC entry 1812 (class 2606 OID 16501)
-- Dependencies: 148 148
-- Name: card_set_pkey; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY card_set
    ADD CONSTRAINT card_set_pkey PRIMARY KEY (id);


--
-- TOC entry 1816 (class 2606 OID 16511)
-- Dependencies: 150 150 150
-- Name: card_set_white_card_pkey; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY card_set_white_card
    ADD CONSTRAINT card_set_white_card_pkey PRIMARY KEY (card_set_id, white_card_id);


--
-- TOC entry 1808 (class 2606 OID 16431)
-- Dependencies: 146 146
-- Name: white_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY white_cards
    ADD CONSTRAINT white_cards_pkey PRIMARY KEY (id);


--
-- TOC entry 1810 (class 2606 OID 16433)
-- Dependencies: 146 146
-- Name: white_cards_text_key; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY white_cards
    ADD CONSTRAINT white_cards_text_key UNIQUE (text);


--
-- TOC entry 1818 (class 2606 OID 16517)
-- Dependencies: 1803 149 140
-- Name: fk513da45c997611f9; Type: FK CONSTRAINT; Schema: public; Owner: cah
--

ALTER TABLE ONLY card_set_black_card
    ADD CONSTRAINT fk513da45c997611f9 FOREIGN KEY (black_card_id) REFERENCES black_cards(id);


--
-- TOC entry 1817 (class 2606 OID 16512)
-- Dependencies: 148 149 1811
-- Name: fk513da45cb2505f39; Type: FK CONSTRAINT; Schema: public; Owner: cah
--

ALTER TABLE ONLY card_set_black_card
    ADD CONSTRAINT fk513da45cb2505f39 FOREIGN KEY (card_set_id) REFERENCES card_set(id);


--
-- TOC entry 1819 (class 2606 OID 16522)
-- Dependencies: 148 1811 150
-- Name: fkc2487272b2505f39; Type: FK CONSTRAINT; Schema: public; Owner: cah
--

ALTER TABLE ONLY card_set_white_card
    ADD CONSTRAINT fkc2487272b2505f39 FOREIGN KEY (card_set_id) REFERENCES card_set(id);


--
-- TOC entry 1820 (class 2606 OID 16527)
-- Dependencies: 150 1807 146
-- Name: fkc2487272bfd29b4d; Type: FK CONSTRAINT; Schema: public; Owner: cah
--

ALTER TABLE ONLY card_set_white_card
    ADD CONSTRAINT fkc2487272bfd29b4d FOREIGN KEY (white_card_id) REFERENCES white_cards(id);


-- Completed on 2012-07-07 14:55:01

--
-- PostgreSQL database dump complete
--

