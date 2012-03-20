-- Pretend You're Xyzzy cards by Andy Janata is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
-- Based on a work at www.cardsagainsthumanity.com.
-- For more information, see http://creativecommons.org/licenses/by-nc-sa/3.0/

-- This file contains the Black Cards and White Cards for Cards Against Humanity, as a script for importing into PostgreSQL. There should be a user named cah.

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: cah; Type: DATABASE; Schema: -; Owner: cah
--

CREATE DATABASE cah WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';


ALTER DATABASE cah OWNER TO cah;

\connect cah

-- Dumped from database version 8.4.11
-- Dumped by pg_dump version 9.1.3
-- Started on 2012-03-20 15:45:15

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
-- Dependencies: 1786 1787 1789 1790 6
-- Name: black_cards; Type: TABLE; Schema: public; Owner: cah; Tablespace: 
--

CREATE TABLE black_cards (
    id integer NOT NULL,
    text character varying(255) NOT NULL,
    draw smallint DEFAULT 0,
    pick smallint DEFAULT 1,
    creator integer,
    in_v1 boolean DEFAULT true NOT NULL,
    in_v2 boolean DEFAULT false NOT NULL
);


ALTER TABLE public.black_cards OWNER TO cah;

--
-- TOC entry 1806 (class 0 OID 0)
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
-- TOC entry 1807 (class 0 OID 0)
-- Dependencies: 141
-- Name: black_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cah
--

ALTER SEQUENCE black_cards_id_seq OWNED BY black_cards.id;


--
-- TOC entry 1808 (class 0 OID 0)
-- Dependencies: 141
-- Name: black_cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cah
--

SELECT pg_catalog.setval('black_cards_id_seq', 98, true);


--
-- TOC entry 146 (class 1259 OID 16417)
-- Dependencies: 1792 1793 6
-- Name: white_cards; Type: TABLE; Schema: public; Owner: cah; Tablespace: 
--

CREATE TABLE white_cards (
    id integer NOT NULL,
    text character varying(255) NOT NULL,
    creator integer,
    in_v1 boolean DEFAULT false NOT NULL,
    in_v2 boolean DEFAULT true NOT NULL
);


ALTER TABLE public.white_cards OWNER TO cah;

--
-- TOC entry 1809 (class 0 OID 0)
-- Dependencies: 146
-- Name: COLUMN white_cards.creator; Type: COMMENT; Schema: public; Owner: cah
--

COMMENT ON COLUMN white_cards.creator IS 'NULL for default, non-NULL for user id';


--
-- TOC entry 147 (class 1259 OID 16420)
-- Dependencies: 6 146
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
-- TOC entry 1810 (class 0 OID 0)
-- Dependencies: 147
-- Name: white_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cah
--

ALTER SEQUENCE white_cards_id_seq OWNED BY white_cards.id;


--
-- TOC entry 1811 (class 0 OID 0)
-- Dependencies: 147
-- Name: white_cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cah
--

SELECT pg_catalog.setval('white_cards_id_seq', 508, true);


--
-- TOC entry 1788 (class 2604 OID 16422)
-- Dependencies: 141 140
-- Name: id; Type: DEFAULT; Schema: public; Owner: cah
--

ALTER TABLE ONLY black_cards ALTER COLUMN id SET DEFAULT nextval('black_cards_id_seq'::regclass);


--
-- TOC entry 1791 (class 2604 OID 16423)
-- Dependencies: 147 146
-- Name: id; Type: DEFAULT; Schema: public; Owner: cah
--

ALTER TABLE ONLY white_cards ALTER COLUMN id SET DEFAULT nextval('white_cards_id_seq'::regclass);


--
-- TOC entry 1802 (class 0 OID 16399)
-- Dependencies: 140
-- Data for Name: black_cards; Type: TABLE DATA; Schema: public; Owner: cah
--

COPY black_cards (id, text, draw, pick, creator, in_v1, in_v2) FROM stdin;
16  Who stole the cookies from the cookie jar?  0 1 \N  t f
23  I wish I hadn't lost the instruction manual for _____.  0 1 \N  t f
27  What's the next superhero?  0 1 \N  t f
37  When I'm in prison, I'll have _____ smuggled in.  0 1 \N  t f
54  After Hurricane Katrina, Sean Penn brought _____ to all the people of New Orleans.  0 1 \N  t f
55  Due to a PR fiasco, Walmart no longer offers _____. 0 1 \N  t f
69  Life was difficult for cavemen before _____.  0 1 \N  t f
1 Why can't I sleep at night? 0 1 \N  t t
4 What's that smell?  0 1 \N  t t
17  What's the next Happy Meal® toy?  0 1 \N  t t
18  Anthropologists have recently discovered a primitive tribe that worships _____. 0 1 \N  t t
19  It's a pity that kids these days are all getting involved with _____. 0 1 \N  t t
14  Alternative medicine is now embracing the curative powers of _____. 0 1 \N  t t
78  And the Academy Award for _____ goes to _____.  0 2 \N  t t
15  What's that sound?  0 1 \N  t t
9 What ended my last relationship?  0 1 \N  t t
10  MTV's new reality show features eight washed-up celebrities living with _____ 0 1 \N  t t
11  I drink to forget _____.  0 1 \N  t t
12  I'm sorry, Professor, but I couldn't complete my homework because of _____. 0 1 \N  t t
7 What is Batman's guilty pleasure? 0 1 \N  t t
6 This is the way the world ends / This is the way the world ends / This is the way the world ends / Not with a bang but with _____ 0 1 \N  t t
3 What's a girl's best friend?  0 1 \N  t t
8 TSA guidelines now prohibit _____ on airplanes. 0 1 \N  t t
20  _____. That's how I want to die.  0 1 \N  t t
79  For my next trick, I will pull _____ out of _____.  0 2 \N  t t
21  In the new Disney Channel Original Movie, Hannah Montana struggles with _____ for the first time. 0 1 \N  t t
80  _____ is a slippery slope that leads to _____.  0 2 \N  t t
22  What does Dick Cheney prefer? 0 1 \N  t t
24  Instead of coal, Santa now gives the bad children _____.  0 1 \N  t t
25  What's the most emo?  0 1 \N  t t
26  In 1,000 years, when paper money is but a distant memory, _____ will be our currency. 0 1 \N  t t
81  In M. Night Shyamalan's new movie, Bruce Willis discovers that _____ had really been _____ all along. 0 2 \N  t t
28  A romantic, candlelit dinner would be incomplete without _____. 0 1 \N  t t
30  _____. Betcha can't have just one!  0 1 \N  t t
82  In a world ravaged by _____, our only solace is _____.  0 2 \N  t t
34  War! What is it good for? 0 1 \N  t t
33  During sex, I like to think about _____.  0 1 \N  t t
39  What are my parents hiding from me? 0 1 \N  t t
36  What will always get you laid?  0 1 \N  t t
38  What did I bring back from Mexico?  0 1 \N  t t
48  What don't you want to find in your Chinese food? 0 1 \N  t t
49  What will I bring back in time to convince people that I am a powerful wizard?  0 1 \N  t t
50  How am I maintaining my relationship status?  0 1 \N  t t
51  _____. It's a trap! 0 1 \N  t t
52  Coming to Broadway this season, _____: The Musical. 0 1 \N  t t
84  Rumor has it that Vladimir Putin's favorite dish is _____ stuffed with _____. 0 2 \N  t t
57  But before I kill you, Mr. Bond, I must show you _____. 0 1 \N  t t
58  What gives me uncontrollable gas? 0 1 \N  t t
62  What do old people smell like?  0 1 \N  t t
61  The class field trip was completely ruined by _____.  0 1 \N  t t
60  When Pharaoh remained unmoved, Moses called down a plague of _____. 0 1 \N  t t
59  What's my secret power? 0 1 \N  t t
41  What's there a ton of in heaven?  0 1 \N  t t
42  What would grandma find disturbing, yet oddly charming? 0 1 \N  t t
85  I never truly understood _____ until I encountered _____. 0 2 \N  t t
43  What did the U.S. airdrop to the children of Afghanistan? 0 1 \N  t t
40  What helps Obama unwind?  0 1 \N  t t
73  What did Vin Diesel eat for dinner? 0 1 \N  t t
72  _____: Good to the last drop. 0 1 \N  t t
76  Why am I sticky?  0 1 \N  t t
75  What gets better with age?  0 1 \N  t t
74  _____: kid-tested, mother-approved. 0 1 \N  t t
71  What's the crustiest? 0 1 \N  t t
70  What's Teach for America using to inspire inner city students to succeed? 0 1 \N  t t
67  Studies show that lab rats navigate mazes 50% faster after being exposed to _____.  0 1 \N  t t
86  Make a haiku. 2 3 \N  t t
68  I do not know with which weapons World War III will be fought, but World War IV will be fought with _____.  0 1 \N  t t
66  Why do I hurt all over? 0 1 \N  t t
63  What am I giving up for Lent? 0 1 \N  t t
64  In Michael Jackson's final moments, he thought about _____. 0 1 \N  t t
65  In an attempt to reach a wider audience, the Smithsonian Museum of Natural History has opened an interactive exhibit on _____.  0 1 \N  t t
45  When I am the President of the United States, I will create the Department of _____.  0 1 \N  t t
87  Lifetime® presents _____, the story of _____. 0 2 \N  t t
47  When I am a billionare, I shall erect a 50-foot statue to commemorate _____.  0 1 \N  t t
88  When I was tripping on acid, _____ turned into _____. 0 2 \N  t t
89  That's right, I killed _____. How, you ask? _____.  0 2 \N  t t
77  What's my anti-drug?  0 1 \N  t t
90  _____ + _____ = _____.  2 3 \N  t t
56  What never fails to liven up the party? 0 1 \N  t t
44  What's the new fad diet?  0 1 \N  t t
46  Major League Baseball has banned _____ for giving players an unfair advantage.  0 1 \N  t t
31  White people like _____.  0 1 \N  t t
32  _____. High five, bro.  0 1 \N  t t
29  Next from J.K. Rowling: Harry Potter and the Chamber of _____.  0 1 \N  t t
35  BILLY MAYS HERE FOR _____.  0 1 \N  t t
83  In his new summer comedy, Rob Schneider is _____ trapped in the body of _____.  0 2 \N  t f
91  Maybe she's born with it. Maybe it's _____. 0 1 \N  f t
5 _____? There's an app for that  0 1 \N  t t
13  During Picasso's often-overlooked Brown Period, he produced hundreds of paintings of _____. 0 1 \N  t t
2 I got 99 problems but _____ ain't one.  0 1 \N  t t
92  Dear Abby, I'm having some trouble with _____ and would like your advice. 0 1 \N  f t
93  What's the next superhero/sidekick duo? 0 2 \N  f t
94  In L.A. County Jail, word is you can trade 200 cigarettes for _____.  0 1 \N  f t
53  While the United States raced the Soviet Union to the moon, the Mexican government funneled millions of pesos into research on _____. 0 1 \N  t t
95  After the earthquake, Sean Penn brought _____ to the people of Haiti. 0 1 \N  f t
96  Next on ESPN2, the World Series of _____. 0 1 \N  f t
97  Step 1: _____. Step 2: _____. Step 3: Profit. 0 2 \N  f t
98  Life for American Indians was forever changed when the White Man introduced them to _____.  0 1 \N  f t
\.


--
-- TOC entry 1803 (class 0 OID 16417)
-- Dependencies: 146
-- Data for Name: white_cards; Type: TABLE DATA; Schema: public; Owner: cah
--

COPY white_cards (id, text, creator, in_v1, in_v2) FROM stdin;
461 Flying sex snakes \N  f t
282 Michelle Obama's arms.  \N  t t
124 White people. \N  t t
462 MechaHitler.  \N  f t
393 An erection that lasts longer than four hours.  \N  t t
463 Getting naked and watching Nickelodeon. \N  f t
464 Charisma. \N  f t
141 Panda sex.  \N  t t
465 Morgan Freeman's voice. \N  f t
466 Breaking out into song and dance. \N  f t
467 Soup that is too hot. \N  f t
121 Stifling a giggle at the mention of Hutus and Tutsis. \N  t t
468 Chutzpah. \N  f t
469 Unfathomable stupidity. \N  f t
470 Horrifying laser hair removal accidents.  \N  f t
269 A middle-aged man on roller skates. \N  t t
1 Coat hanger abortions.  \N  t t
471 Boogers.  \N  f t
472 A Bop It™.  \N  f t
138 Scrubbing under the folds.  \N  t t
473 Expecting a burp and vomiting on the floor. \N  f t
275 Wearing underwear inside-out to avoid doing laundry.  \N  t t
474 A defective condom. \N  f t
475 Teenage pregnancy.  \N  f t
476 Hot cheese. \N  f t
477 A mopey zoo lion. \N  f t
167 The Tempur-Pedic® Swedish Sleep System™.  \N  t t
478 Shapeshifters.  \N  f t
479 The Care Bear Stare.  \N  f t
480 Erectile dysfunction. \N  f t
481 The chronic.  \N  f t
483 "Tweeting." \N  f t
484 Firing a rifle into the air while balls deep in a squealing hog.  \N  f t
485 Nicolas Cage. \N  f t
482 Home video of Oprah sobbing into a Lean Cuisine®. \N  f t
225 Dropping a chandelier on your enemies and riding the rope up. \N  t t
486 Euphoria™ by Calvin Klein.  \N  f t
487 Switching to Geico®.  \N  f t
488 A gentle caress of the inner thigh. \N  f t
489 Poor life choices.  \N  f t
490 Embryonic stem cells. \N  f t
297 Public ridicule.  \N  t t
265 A snapping turtle biting the tip of your penis. \N  t t
491 Customer service representatives. \N  f t
492 The Little Engine That Could. \N  f t
218 Vehicular manslaughter. \N  t t
493 Lady Gaga.  \N  f t
494 A death ray.  \N  f t
495 Vigilante justice.  \N  f t
496 Exactly what you'd expect.  \N  f t
497 Natural male enhancement. \N  f t
498 Passive-aggressive Post-it notes. \N  f t
499 Inappropriate yodeling. \N  f t
500 A homoerotic volleyball montage.  \N  f t
267 Domino's™ Oreo™ Dessert Pizza.  \N  t t
501 Actually taking candy from a baby.  \N  f t
160 The token minority. \N  t t
502 Jibber-jabber.  \N  f t
503 Crystal meth. \N  f t
504 My inner demons.  \N  f t
505 Pac-Man uncontrollably guzzling cum.  \N  f t
506 My vagina.  \N  f t
507 The Donald Trump Seal of Approval™. \N  f t
508 The true meaning of Christmas.  \N  f t
44  German dungeon porn.  \N  t t
40  Praying the gay away. \N  t t
63  Dying.  \N  t t
41  Same-sex ice dancing. \N  t t
70  Dying of dysentery. \N  t t
19  Roofies.  \N  t t
22  The Big Bang. \N  t t
23  Amputees. \N  t t
74  Men.  \N  t t
18  Concealing a boner. \N  t t
87  Agriculture.  \N  t t
51  Making a pouty face.  \N  t t
98  YOU MUST CONSTRUCT ADDITIONAL PYLONS. \N  t t
60  Hormone injections. \N  t t
55  Tom Cruise. \N  t t
56  Object permanence.  \N  t t
92  Consultants.  \N  t t
26  Being marginalized. \N  t t
54  The profoundly handicapped. \N  t t
96  Party poopers.  \N  t t
48  Nickelback. \N  t t
7 Doing the right thing.  \N  t t
65  The invisible hand. \N  t t
49  Heteronormativity.  \N  t t
29  Cuddling. \N  t t
84  Raptor attacks. \N  t t
38  Fear itself.  \N  t t
91  Sniffing glue.  \N  t t
58  An icepick lobotomy.  \N  t t
109 Being rich. \N  t t
79  The clitoris. \N  t t
71  Sexy pillow fights. \N  t t
105 Michael Jackson.  \N  t t
101 Sexting.  \N  t t
33  Horse meat. \N  t t
8 Hunting accidents.  \N  t f
9 A cartoon camel enjoying the smooth, refreshing taste of a cigarette. \N  t f
15  Abstinence. \N  t f
17  Mountain Dew Code Red.  \N  t f
21  Tweeting. \N  t f
43  Making sex at her.  \N  t f
64  Stunt doubles.  \N  t f
69  Flavored condoms. \N  t f
100 Heath Ledger. \N  t f
110 Muzzy.  \N  t f
97  Sunshine and rainbows.  \N  t t
68  Flash flooding. \N  t t
57  Goblins.  \N  t t
13  Spectacular abs.  \N  t t
72  The Three-Fifths compromise.  \N  t t
4 Vigorous jazz hands.  \N  t t
106 Skeletor. \N  t t
80  Vikings.  \N  t t
34  Genital piercings.  \N  t t
11  Viagra®.  \N  t t
67  A really cool hat.  \N  t t
102 An Oedipus complex. \N  t t
82  The Underground Railroad. \N  t t
77  Heartwarming orphans. \N  t t
47  Cheating in the Special Olympics. \N  t t
108 Sharing needles.  \N  t t
46  Ethnic cleansing. \N  t t
103 Eating all of the cookies before the AIDS bake-sale.  \N  t t
93  My humps. \N  t t
10  The violation of our most basic human rights. \N  t t
35  Fingering.  \N  t t
53  The placenta. \N  t t
5 Flightless birds. \N  t t
37  Stranger danger.  \N  t t
107 Chivalry. \N  t t
76  Sean Penn.  \N  t t
73  A sad handjob.  \N  t t
66  Jew-fros. \N  t t
12  Self-loathing.  \N  t t
61  A falcon with a cap on its head.  \N  t t
75  Historically black colleges.  \N  t t
30  Aaron Burr. \N  t t
25  Former President George W. Bush.  \N  t t
94  Geese.  \N  t t
99  Mutually-assured destruction. \N  t t
88  Bling.  \N  t t
27  Smegma. \N  t t
90  The South.  \N  t t
83  Pretending to care. \N  t t
59  Arnold Schwarzenegger.  \N  t t
20  Glenn Beck convulsively vomiting as a brood of crab spiders hatches in his brain and erupts from his tear ducts.  \N  t t
104 A sausage festival. \N  t t
62  Foreskin. \N  t t
95  Being a dick to children. \N  t t
52  Chainsaws for hands.  \N  t t
86  A Gypsy curse.  \N  t t
31  The Pope. \N  t t
16  A balanced breakfast. \N  t t
36  Elderly Japanese men. \N  t t
6 Pictures of boobs.  \N  t t
39  Science.  \N  t t
32  A bleached asshole. \N  t t
3 Autocannibalism.  \N  t t
50  William Shatner.  \N  t t
85  A micropenis. \N  t t
78  Waterboarding.  \N  t t
45  Bingeing and purging. \N  t t
89  A clandestine butt scratch. \N  t t
2 Man meat. \N  t t
28  Laying an egg.  \N  t t
14  An honest cop with nothing left to lose.  \N  t t
42  The terrorists. \N  t t
81  Friends who eat all the snacks. \N  t t
120 Cookie Monster devouring the Eucharist wafers.  \N  t f
123 Letting yourself go.  \N  t f
130 Twinkies®.  \N  t f
131 A LAN party.  \N  t f
133 A grande sugar-free iced soy caramel macchiato. \N  t f
143 Will Smith. \N  t f
156 Marky Mark and the Funky Bunch. \N  t f
158 Dave Matthews Band. \N  t f
164 Substitute teachers.  \N  t f
177 Garth Brooks. \N  t f
188 Keeping Christ in Christmas.  \N  t f
190 That one gay Teletubby. \N  t f
216 Passive-agression.  \N  t f
247 A neglected Tamagotchi™.  \N  t f
248 The People's Elbow. \N  t f
230 Guys who don't call.  \N  t t
152 AIDS. \N  t t
187 The Rapture.  \N  t t
244 Eugenics. \N  t t
181 Taking off your shirt.  \N  t t
139 A drive-by shooting.  \N  t t
217 Ronald Reagan.  \N  t t
195 Jewish fraternities.  \N  t t
198 All-you-can-eat shrimp for $4.99. \N  t t
233 Scalping. \N  t t
196 Edible underpants.  \N  t t
154 Figgy pudding.  \N  t t
240 Intelligent design. \N  t t
207 Nocturnal emissions.  \N  t t
119 Uppercuts.  \N  t t
180 The American Dream. \N  t t
226 Testicular torsion. \N  t t
201 The folly of man. \N  t t
153 The KKK.  \N  t t
241 The taint; the grundle; the fleshy fun-bridge.  \N  t t
237 Saxophone solos.  \N  t t
200 That thing that electrocutes your abs.  \N  t t
176 Oversized lollipops.  \N  t t
161 Friends with benefits.  \N  t t
137 Teaching a robot to love. \N  t t
205 Me time.  \N  t t
250 The heart of a child. \N  t t
252 Smallpox blankets.  \N  t t
127 Yeast.  \N  t t
214 Full frontal nudity.  \N  t t
175 Authentic Mexican cuisine.  \N  t t
253 Licking things to claim them as your own. \N  t t
174 Genghis Khan. \N  t t
209 The hardworking Mexican.  \N  t t
189 RoboCop.  \N  t t
112 Spontaneous human combustion. \N  t t
128 Natural selection.  \N  t t
245 A good sniff. \N  t t
212 Nipple blades.  \N  t t
126 Leaving an awkward voicemail. \N  t t
213 Assless chaps.  \N  t t
191 Sweet, sweet vengeance. \N  t t
243 Keg stands. \N  t t
232 Darth Vader.  \N  t t
114 Necrophilia.  \N  t t
144 Toni Morrison's vagina. \N  t t
159 Preteens. \N  t t
185 A cooler full of organs.  \N  t t
178 Keanu Reeves. \N  t t
166 A thermonuclear detonation. \N  t t
186 A moment of silence.  \N  t t
142 Catapults.  \N  t t
118 Emotions. \N  t t
151 Balls.  \N  t t
234 Homeless people.  \N  t t
173 Old-people smell. \N  t t
117 Farting and walking away. \N  t t
206 The inevitable heat death of the universe.  \N  t t
24  The Rev. Dr. Martin Luther King, Jr.  \N  t t
136 Sperm whales. \N  t t
204 A murder most foul. \N  t t
208 Daddy issues. \N  t t
199 Britney Spears at 55. \N  t t
210 Natalie Portman.  \N  t t
223 The Holy Bible. \N  t t
229 Hot Pockets®. \N  t t
220 Pulling out.  \N  t t
163 Pixelated bukkake.  \N  t t
168 Waiting 'til marriage.  \N  t t
235 The World of Warcraft.  \N  t t
116 Global warming. \N  t t
224 World peace.  \N  t t
170 A can of whoop-ass. \N  t t
148 A zesty breakfast burrito.  \N  t t
221 Picking up girls at the abortion clinic.  \N  t t
146 Land mines. \N  t t
113 College.  \N  t t
228 A time travel paradox.  \N  t t
155 Seppuku.  \N  t t
211 Waking up half-naked in a Denny's parking lot.  \N  t t
149 Christopher Walken. \N  t t
236 Gloryholes. \N  t t
169 A tiny horse. \N  t t
184 Child abuse.  \N  t t
219 Menstruation. \N  t t
135 A sassy black woman.  \N  t t
162 Re-gifting. \N  t t
122 Penis envy. \N  t t
179 Drinking alone. \N  t t
215 Hulk Hogan. \N  t t
145 Five-Dollar Footlongs™. \N  t t
140 Whipping it out.  \N  t t
171 Dental dams.  \N  t t
157 Gandhi. \N  t t
239 God.  \N  t t
150 Friction. \N  t t
147 A sea of troubles.  \N  t t
197 Poor people.  \N  t t
183 Flesh-eating bacteria.  \N  t t
125 Dick Cheney.  \N  t t
246 Lockjaw.  \N  t t
165 Take-backsies.  \N  t t
132 Opposable thumbs. \N  t t
222 The homosexual agenda.  \N  t t
202 Fiery poops.  \N  t t
203 Cards Against Humanity. \N  t t
192 Fancy Feast®. \N  t t
238 Sean Connery. \N  t t
227 The milk man. \N  t t
115 The Chinese gymnastics team.  \N  t t
231 Eating the last known bison.  \N  t t
134 Soiling oneself.  \N  t t
182 Giving 110%.  \N  t t
242 Friendly fire.  \N  t t
111 Count Chocula.  \N  t t
172 Feeding Rosie O'Donnell.  \N  t t
251 Seduction.  \N  t t
194 Being a motherfucking sorcerer. \N  t t
264 Eastern European Turbo-Folk music.  \N  t f
273 Douchebags on their iPhones.  \N  t f
281 The deformed. \N  t f
285 Donald Trump. \N  t f
288 This answer is postmodern.  \N  t f
301 African children. \N  t f
307 Have some more kugel. \N  t f
310 Crippling debt. \N  t f
313 Shorties and blunts.  \N  t f
328 (I am doing Kegels right now.)  \N  t f
331 Bestiality. \N  t f
333 Drum circles. \N  t f
338 Inappropriate yelling.  \N  t f
341 The Thong Song. \N  t f
342 A vajazzled vagina. \N  t f
350 Sobbing into a Hungry-Man® Frozen Dinner. \N  t f
353 Ring Pops™. \N  t f
363 Tiger Woods.  \N  t f
371 PCP.  \N  t f
383 Mr. Snuffleupagus.  \N  t f
394 A disappointing birthday party. \N  t t
319 Puppies!  \N  t t
308 A windmill full of corpses. \N  t t
340 Being on fire.  \N  t t
372 A lifetime of sadness.  \N  t t
258 Pterodactyl eggs. \N  t t
289 Crumpets with the Queen.  \N  t t
344 Exchanging pleasantries.  \N  t t
276 Republicans.  \N  t t
321 Kim Jong-il.  \N  t t
366 Glenn Beck being harried by a swarm of buzzards.  \N  t t
254 A salty surprise. \N  t t
330 The Jews. \N  t t
324 Incest. \N  t t
284 The Übermensch. \N  t t
391 Nazis.  \N  t t
292 Repression. \N  t t
287 Attitude. \N  t t
361 Passable transvestites. \N  t t
395 Puberty.  \N  t t
374 Swooping. \N  t t
311 Adderall™.  \N  t t
379 A look-see. \N  t t
348 Lactation.  \N  t t
266 Pabst Blue Ribbon.  \N  t t
357 The gays. \N  t t
278 A foul mouth. \N  t t
377 A hot mess. \N  t t
268 My collection of high-tech sex toys.  \N  t t
318 Bees? \N  t t
388 Getting drunk on mouthwash. \N  t t
277 The glass ceiling.  \N  t t
286 Sarah Palin.  \N  t t
291 Team-building exercises.  \N  t t
290 Frolicking. \N  t t
380 Not giving a shit about the Third World.  \N  t t
345 My relationship status. \N  t t
384 Barack Obama. \N  t t
302 Mouth herpes. \N  t t
386 Wiping her butt.  \N  t t
263 Pedophiles. \N  t t
373 Doin' it in the butt. \N  t t
347 Being fabulous. \N  t t
389 An M. Night Shyamalan plot twist. \N  t t
294 A bag of magic beans. \N  t t
296 Dead parents. \N  t t
257 My sex life.  \N  t t
343 Riding off into the sunset. \N  t t
364 Dick fingers. \N  t t
362 The Virginia Tech Massacre. \N  t t
387 Queefing. \N  t t
339 Tangled Slinkys.  \N  t t
337 Civilian casualties.  \N  t t
316 Leprosy.  \N  t t
325 Grave robbing.  \N  t t
376 Tentacle porn.  \N  t t
304 Bill Nye the Science Guy. \N  t t
370 New Age music.  \N  t t
261 72 virgins. \N  t t
322 Hope. \N  t t
314 Passing a kidney stone. \N  t t
299 A mime having a stroke. \N  t t
368 Classist undertones.  \N  t t
298 A mating display. \N  t t
382 The Kool-Aid Man. \N  t t
349 Not reciprocating oral sex. \N  t t
352 Date rape.  \N  t t
306 Italians. \N  t t
256 My soul.  \N  t t
354 GoGurt®.  \N  t t
312 A stray pube. \N  t t
279 Jerking off into a pool of children's tears.  \N  t t
280 Getting really high.  \N  t t
378 Too much hair gel.  \N  t t
303 Overcompensation. \N  t t
272 Free samples. \N  t t
346 Shaquille O'Neal's acting career. \N  t t
271 Half-assed foreplay.  \N  t t
283 Explosions. \N  t t
392 White privilege.  \N  t t
293 Road head.  \N  t t
255 Poorly-timed Holocaust jokes. \N  t t
323 8 oz. of sweet Mexican black-tar heroin.  \N  t t
355 Judge Judy. \N  t t
259 Altar boys. \N  t t
358 Scientology.  \N  t t
329 Justin Bieber.  \N  t t
327 Alcoholism. \N  t t
351 My genitals.  \N  t t
332 Winking at old people.  \N  t t
385 Golden showers. \N  t t
365 Racism. \N  t t
336 Auschwitz.  \N  t t
262 Raping and pillaging. \N  t t
334 Kids with ass cancer. \N  t t
274 Hurricane Katrina.  \N  t t
356 Lumberjack fantasies. \N  t t
381 American Gladiators.  \N  t t
295 An asymmetric boob job. \N  t t
326 Asians who aren't good at math. \N  t t
335 Loose lips. \N  t t
270 The Blood of Christ.  \N  t t
317 A brain tumor.  \N  t t
315 Prancing. \N  t t
375 The Hamburglar. \N  t t
360 Police brutality. \N  t t
260 Forgetting the Alamo. \N  t t
369 Booby-trapping the house to foil burglars.  \N  t t
359 Estrogen. \N  t t
390 A robust mongoloid. \N  t t
309 Her Royal Highness, Queen Elizabeth II. \N  t t
193 Pooping back and forth. Forever.  \N  t t
320 Cockfights. \N  t t
305 Bitches.  \N  t t
300 Stephen Hawking talking dirty.  \N  t t
403 Those times when you get sand in your vagina. \N  t f
424 Faith healing.  \N  t f
428 Impotence.  \N  t f
454 Bananas in Pajamas. \N  t f
399 Getting so angry that you pop a boner.  \N  t t
414 Tasteful sideboob.  \N  t t
396 Two midgets shitting into a bucket. \N  t t
406 Racially-biased SAT questions.  \N  t t
449 Glenn Beck catching his scrotum on a curtain hook.  \N  t t
398 The forbidden fruit.  \N  t t
459 Anal beads. \N  t t
367 Surprise sex! \N  t t
426 Dead babies.  \N  t t
129 Masturbation. \N  t t
452 The Hustle. \N  t t
404 A Super Soaker™ full of cat pee.  \N  t t
409 Obesity.  \N  t t
429 Child beauty pageants.  \N  t t
422 Goats eating coins. \N  t t
457 Kamikaze pilots.  \N  t t
443 Powerful thighs.  \N  t t
450 A big hoopla about nothing. \N  t t
433 Women's suffrage. \N  t t
442 John Wilkes Booth.  \N  t t
425 Parting the Red Sea.  \N  t t
435 Harry Potter erotica. \N  t t
416 Grandma.  \N  t t
407 Porn stars. \N  t t
423 A monkey smoking a cigar. \N  t t
439 Mathletes.  \N  t t
437 Lance Armstrong's missing testicle. \N  t t
434 Children on leashes.  \N  t t
445 Multiple stab wounds. \N  t t
411 Oompa-Loompas.  \N  t t
451 Peeing a little bit.  \N  t t
421 The miracle of childbirth.  \N  t t
448 Another goddamn vampire movie.  \N  t t
460 The Make-A-Wish® Foundation.  \N  t t
455 Active listening. \N  t t
402 A gassy antelope. \N  t t
412 BATMAN!!! \N  t t
413 Black people. \N  t t
447 Serfdom.  \N  t t
440 Lunchables™.  \N  t t
418 The Trail of Tears. \N  t t
453 Ghosts. \N  t t
436 The Dance of the Sugar Plum Fairy.  \N  t t
420 Finger painting.  \N  t t
249 Robert Downey, Jr.  \N  t t
405 Muhammed (Praise Be Unto Him).  \N  t t
419 Famine. \N  t t
431 AXE Body Spray. \N  t t
458 The Force.  \N  t t
446 Cybernetic enhancements.  \N  t t
444 Mr. Clean, right behind you.  \N  t t
401 Third base. \N  t t
438 Dwarf tossing.  \N  t t
408 A fetus.  \N  t t
441 Women in yogurt commercials.  \N  t t
417 Copping a feel. \N  t t
400 Sexual tension. \N  t t
456 Dry heaving.  \N  t t
430 Centaurs. \N  t t
397 Wifely duties.  \N  t t
415 Hot people. \N  t t
432 Kanye West. \N  t t
427 The Amish.  \N  t t
410 When you fart and a little bit comes out. \N  t t
\.


--
-- TOC entry 1795 (class 2606 OID 16425)
-- Dependencies: 140 140
-- Name: black_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY black_cards
    ADD CONSTRAINT black_cards_pkey PRIMARY KEY (id);


--
-- TOC entry 1797 (class 2606 OID 16427)
-- Dependencies: 140 140
-- Name: black_cards_text_key; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY black_cards
    ADD CONSTRAINT black_cards_text_key UNIQUE (text);


--
-- TOC entry 1799 (class 2606 OID 16431)
-- Dependencies: 146 146
-- Name: white_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY white_cards
    ADD CONSTRAINT white_cards_pkey PRIMARY KEY (id);


--
-- TOC entry 1801 (class 2606 OID 16433)
-- Dependencies: 146 146
-- Name: white_cards_text_key; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY white_cards
    ADD CONSTRAINT white_cards_text_key UNIQUE (text);


-- Completed on 2012-03-20 15:45:18

--
-- PostgreSQL database dump complete
--
