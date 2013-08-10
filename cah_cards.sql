-- Pretend You're Xyzzy cards by Andy Janata is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
-- Based on a work at www.cardsagainsthumanity.com.
-- For more information, see http://creativecommons.org/licenses/by-nc-sa/3.0/

-- This file contains the Black Cards and White Cards for Cards Against Humanity, as a script for importing into PostgreSQL. There should be a user named cah.
-- Includes the First, Second, and Third Expansions, as well as the Canadian version cards, 2012 Holiday Pack, and PAX East 2013 packs.
-- Also includes a lot of custom card sets.

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.9
-- Dumped by pg_dump version 9.2.2
-- Started on 2013-08-10 16:48:55

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 169 (class 3079 OID 11677)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 1943 (class 0 OID 0)
-- Dependencies: 169
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 161 (class 1259 OID 16386)
-- Name: black_cards; Type: TABLE; Schema: public; Owner: cah; Tablespace: 
--

CREATE TABLE black_cards (
    id integer NOT NULL,
    text character varying(255) NOT NULL,
    draw smallint DEFAULT 0,
    pick smallint DEFAULT 1,
    watermark character varying(5)
);


ALTER TABLE public.black_cards OWNER TO cah;

--
-- TOC entry 162 (class 1259 OID 16393)
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
-- TOC entry 1944 (class 0 OID 0)
-- Dependencies: 162
-- Name: black_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cah
--

ALTER SEQUENCE black_cards_id_seq OWNED BY black_cards.id;


--
-- TOC entry 163 (class 1259 OID 16395)
-- Name: card_set; Type: TABLE; Schema: public; Owner: cah; Tablespace: 
--

CREATE TABLE card_set (
    id integer NOT NULL,
    active boolean NOT NULL,
    name character varying(255),
    base_deck boolean NOT NULL,
    description character varying(255),
    weight integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.card_set OWNER TO cah;

--
-- TOC entry 164 (class 1259 OID 16398)
-- Name: card_set_black_card; Type: TABLE; Schema: public; Owner: cah; Tablespace: 
--

CREATE TABLE card_set_black_card (
    card_set_id integer NOT NULL,
    black_card_id integer NOT NULL
);


ALTER TABLE public.card_set_black_card OWNER TO cah;

--
-- TOC entry 165 (class 1259 OID 16401)
-- Name: card_set_white_card; Type: TABLE; Schema: public; Owner: cah; Tablespace: 
--

CREATE TABLE card_set_white_card (
    card_set_id integer NOT NULL,
    white_card_id integer NOT NULL
);


ALTER TABLE public.card_set_white_card OWNER TO cah;

--
-- TOC entry 168 (class 1259 OID 24580)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: cah
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO cah;

--
-- TOC entry 166 (class 1259 OID 16404)
-- Name: white_cards; Type: TABLE; Schema: public; Owner: cah; Tablespace: 
--

CREATE TABLE white_cards (
    id integer NOT NULL,
    text character varying(255) NOT NULL,
    watermark character varying(5)
);


ALTER TABLE public.white_cards OWNER TO cah;

--
-- TOC entry 167 (class 1259 OID 16409)
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
-- TOC entry 1945 (class 0 OID 0)
-- Dependencies: 167
-- Name: white_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cah
--

ALTER SEQUENCE white_cards_id_seq OWNED BY white_cards.id;


--
-- TOC entry 1907 (class 2604 OID 16411)
-- Name: id; Type: DEFAULT; Schema: public; Owner: cah
--

ALTER TABLE ONLY black_cards ALTER COLUMN id SET DEFAULT nextval('black_cards_id_seq'::regclass);


--
-- TOC entry 1909 (class 2604 OID 16412)
-- Name: id; Type: DEFAULT; Schema: public; Owner: cah
--

ALTER TABLE ONLY white_cards ALTER COLUMN id SET DEFAULT nextval('white_cards_id_seq'::regclass);


--
-- TOC entry 1928 (class 0 OID 16386)
-- Dependencies: 161
-- Data for Name: black_cards; Type: TABLE DATA; Schema: public; Owner: cah
--

COPY black_cards (id, text, draw, pick, watermark) FROM stdin;
16	Who stole the cookies from the cookie jar?	0	1	\N
504	What is the next great Kickstarter project?	0	1	RS
27	What's the next superhero?	0	1	\N
505	____ 2012.	0	1	RS
100230	____.	0	1	TGWTG
5097	Personals ad: Seeking a female who doesn't mind ____, might also be willing to try a male if they're ____.	0	2	Furry
5099	I tell everyone I'm not a furry, but I've drawn a lot of ____.	0	1	Furry
1	Why can't I sleep at night?	0	1	\N
4	What's that smell?	0	1	\N
15	What's that sound?	0	1	\N
9	What ended my last relationship?	0	1	\N
7	What is Batman's guilty pleasure?	0	1	\N
3	What's a girl's best friend?	0	1	\N
22	What does Dick Cheney prefer?	0	1	\N
25	What's the most emo?	0	1	\N
39	What are my parents hiding from me?	0	1	\N
36	What will always get you laid?	0	1	\N
38	What did I bring back from Mexico?	0	1	\N
48	What don't you want to find in your Chinese food?	0	1	\N
49	What will I bring back in time to convince people that I am a powerful wizard?	0	1	\N
50	How am I maintaining my relationship status?	0	1	\N
58	What gives me uncontrollable gas?	0	1	\N
62	What do old people smell like? 	0	1	\N
59	What's my secret power?	0	1	\N
41	What's there a ton of in heaven?	0	1	\N
42	What would grandma find disturbing, yet oddly charming?	0	1	\N
43	What did the U.S. airdrop to the children of Afghanistan?	0	1	\N
40	What helps Obama unwind?	0	1	\N
73	What did Vin Diesel eat for dinner?	0	1	\N
76	Why am I sticky?	0	1	\N
75	What gets better with age?	0	1	\N
71	What's the crustiest?	0	1	\N
70	What's Teach for America using to inspire inner city students to succeed?	0	1	\N
86	Make a haiku.	2	3	\N
66	Why do I hurt all over?	0	1	\N
63	What am I giving up for Lent?	0	1	\N
77	What's my anti-drug?	0	1	\N
56	What never fails to liven up the party?	0	1	\N
44	What's the new fad diet?	0	1	\N
1273	And that's how Equestria was made!	0	1	MLP
2	I got 99 problems but ____ ain't one.	0	1	\N
8	TSA guidelines now prohibit ____ on airplanes.	0	1	\N
10	MTV's new reality show features eight washed-up celebrities living with ____.	0	1	\N
11	I drink to forget ____.	0	1	\N
12	I'm sorry, Professor, but I couldn't complete my homework because of ____.	0	1	\N
13	During Picasso's often-overlooked Brown Period, he produced hundreds of paintings of ____.	0	1	\N
14	Alternative medicine is now embracing the curative powers of ____.	0	1	\N
18	Anthropologists have recently discovered a primitive tribe that worships ____.	0	1	\N
19	It's a pity that kids these days are all getting involved with ____.	0	1	\N
20	____. That's how I want to die.	0	1	\N
21	In the new Disney Channel Original Movie, Hannah Montana struggles with ____ for the first time.	0	1	\N
23	I wish I hadn't lost the instruction manual for ____.	0	1	\N
24	Instead of coal, Santa now gives the bad children ____.	0	1	\N
26	In 1,000 years, when paper money is but a distant memory, ____ will be our currency.	0	1	\N
28	A romantic, candlelit dinner would be incomplete without ____.	0	1	\N
29	Next from J.K. Rowling: Harry Potter and the Chamber of ____.	0	1	\N
30	____. Betcha can't have just one!	0	1	\N
31	White people like ____.	0	1	\N
32	____. High five, bro.	0	1	\N
33	During sex, I like to think about ____.	0	1	\N
35	BILLY MAYS HERE FOR ____.	0	1	\N
37	When I'm in prison, I'll have ____ smuggled in.	0	1	\N
45	When I am the President of the United States, I will create the Department of ____.	0	1	\N
46	Major League Baseball has banned ____ for giving players an unfair advantage.	0	1	\N
47	When I am a billionare, I shall erect a 50-foot statue to commemorate ____.	0	1	\N
51	____. It's a trap!	0	1	\N
52	Coming to Broadway this season, ____: The Musical.	0	1	\N
54	After Hurricane Katrina, Sean Penn brought ____ to all the people of New Orleans.	0	1	\N
55	Due to a PR fiasco, Walmart no longer offers ____.	0	1	\N
57	But before I kill you, Mr. Bond, I must show you ____.	0	1	\N
60	When Pharaoh remained unmoved, Moses called down a plague of ____.	0	1	\N
61	The class field trip was completely ruined by ____.	0	1	\N
64	In Michael Jackson's final moments, he thought about ____.	0	1	\N
65	In an attempt to reach a wider audience, the Smithsonian Museum of Natural History has opened an interactive exhibit on ____.	0	1	\N
67	Studies show that lab rats navigate mazes 50% faster after being exposed to ____.	0	1	\N
68	I do not know with which weapons World War III will be fought, but World War IV will be fought with ____.	0	1	\N
69	Life was difficult for cavemen before ____.	0	1	\N
72	____: Good to the last drop.	0	1	\N
74	____: kid-tested, mother-approved.	0	1	\N
78	And the Academy Award for ____ goes to ____.	0	2	\N
79	For my next trick, I will pull ____ out of ____.	0	2	\N
80	____ is a slippery slope that leads to ____.	0	2	\N
81	In M. Night Shyamalan's new movie, Bruce Willis discovers that ____ had really been ____ all along.	0	2	\N
82	In a world ravaged by ____, our only solace is ____.	0	2	\N
83	In his new summer comedy, Rob Schneider is ____ trapped in the body of ____.	0	2	\N
85	I never truly understood ____ until I encountered ____.	0	2	\N
88	When I was tripping on acid, ____ turned into ____.	0	2	\N
89	That's right, I killed ____. How, you ask? ____.	0	2	\N
90	____ + ____ = ____.	2	3	\N
506	What is Curious George so curious about?	0	1	RS
1001	test	0	1	\N
1003	Starting Canadian Black Cards	0	1	\N
1009	End Canadian Black Cards	0	1	\N
1033	end bonus misprint bonus card	0	1	\N
1044	begin First Expansion	0	1	\N
1065	end first expansion	0	1	\N
1004	O Canada, we stand on guard for ____.	0	1	CAN
1005	Air Canada guidelines now prohibit ____ on airplanes.	0	1	CAN
1006	In an attempt to reach a wider audience, the Royal Ontario Museum has opened an interactive exhibit on ____.	0	1	CAN
1007	CTV presents ____, the story of ____.	0	2	CAN
1008	What's the Canadian government using to inspire rural students to succeed?	0	1	CAN
1045	He who controls ____ controls the world.	0	1	X1
1046	The CIA now interrogates enemy agents by repeatedly subjecting them to ____.	0	1	X1
1047	Dear Sir or Madam, We regret to inform you that the Office of ____ has denied your request for ____.	0	2	X1
1048	In Rome, there are whisperings that the Vatican has a secret room devoted to ____.	0	1	X1
1049	Science will never explain the origin of ____.	0	1	X1
1050	When all else fails, I can always masturbate to ____.	0	1	X1
1051	I learned the hard way that you can't cheer up a grieving friend with ____.	0	1	X1
1052	In its new tourism campaign, Detroit proudly proclaims that it has finally eliminated ____.	0	1	X1
1053	An international tribunal has found ____ guilty of ____.	0	2	X1
1054	The socialist governments of Scandinavia have declared that access to ____ is a basic human right.	0	1	X1
1055	In his new self-produced album, Kanye West raps over the sounds of ____.	0	1	X1
1056	What's the gift that keeps on giving?	0	1	X1
1057	This season on Man vs. Wild, Bear Grylls must survive in the depths of the Amazon with only ____ and his wits.	0	1	X1
1058	When I pooped, what came out of my butt?	0	1	X1
1059	In the distant future, historians will agree that ____ marked the beginning of America's decline.	0	1	X1
1060	In a pinch, ____ can be a suitable substitute for ____.	0	2	X1
1061	What has been making life difficult at the nudist colony?	0	1	X1
1062	Michael Bay's new three-hour action epic pits ____ against ____.	0	2	X1
507	What is the next big sideshow attraction?	0	1	RS
508	Praise ____!	0	1	RS
93	What's the next superhero/sidekick duo?	0	2	1.2
509	Keith Richards enjoys ____ on his food.	0	1	RS
1032	Daddy, why is Mommy crying?	0	1	B
1063	And I would have gotten away with it, too, if it hadn't been for ____!	0	1	X1
1064	What brought the orgy to a grinding halt?	0	1	X1
1156	During his midlife crisis, my dad got really into ____.	0	1	X2
1157	____ would be woefully incomplete without ____.	0	2	X2
1158	My new favorite porn star is Joey "____" McGee.	0	1	X2
1159	Before I run for president, I must destroy all evidence of my involvement with ____.	0	1	X2
1160	This is your captain speaking. Fasten your seatbelts and prepare for ____.	0	1	X2
1161	In his newest and most difficult stunt, David Blaine must escape from ____.	0	1	X2
1162	The Five Stages of Grief: denial, anger, bargaining, ____, acceptance.	0	1	X2
1163	My mom freaked out when she looked at my browser history and found ____.com/____.	0	2	X2
1164	I went from ____ to ____, all thanks to ____.	2	3	X2
1165	Members of New York's social elite are paying thousands of dollars just to experience ____.	0	1	X2
1166	This month's Cosmo: "Spice up your sex life by bringing ____ into the bedroom."	0	1	X2
1167	Little Miss Muffet Sat on a tuffet, Eating her curds and ____.	0	1	X2
1168	If God didn't want us to enjoy ____, he wouldn't have given us ____.	0	2	X2
1169	My country, 'tis of thee, sweet land of ____.	0	1	X2
1170	After months of debate, the Occupy Wall Street General Assembly could only agree on "More ____!"	0	1	X2
1171	I spent my whole life working toward ____, only to have it ruined by ____.	0	2	X2
1172	Next time on Dr. Phil: How to talk to your child about ____.	0	1	X2
1173	Only two things in life are certain: death and ____.	0	1	X2
1174	Everyone down on the ground! We don't want to hurt anyone. We're just here for ____.	0	1	X2
1175	The healing process began when I joined a support group for victims of ____.	0	1	X2
1176	The votes are in, and the new high school mascot is ____.	0	1	X2
1177	Charades was ruined for me forever when my mom had to act out ____.	0	1	X2
1178	Before ____, all we had was ____.	0	2	X2
1179	Tonight on 20/20: What you don't know about ____ could kill you.	0	1	X2
1180	You haven't truly lived until you've experienced ____ and ____ at the same time.	0	2	X2
1275	Big Mac sleeps soundly whenever ____ is with him.	0	1	MLP
1257	____ has won the national Equestrian award for ____.	0	2	MLP
1260	____ is best pony.	0	1	MLP
1262	____ should ____ ____.	2	3	MLP
1264	____? That's future Spike's problem.	0	1	MLP
1265	After a wild night of crusading, Applebloom learned that ____ was her super special talent.	0	1	MLP
1267	After a wild night of partying, Fluttershy awakens to find ____ in her bed.	0	1	MLP
1268	After living for thousands of years Celestia can only find pleasure in ____.	0	1	MLP
1270	Aloe and Lotus have been experimenting with a radical treatment that utilizes the therapeutic properties of ____.	0	1	MLP
5	____? There's an app for that.	0	1	\N
91	Maybe she's born with it. Maybe it's ____.	0	1	1.2
94	In L.A. County Jail, word is you can trade 200 cigarettes for ____.	0	1	1.2
95	After the earthquake, Sean Penn brought ____ to the people of Haiti.	0	1	1.2
96	Next on ESPN2, the World Series of ____.	0	1	1.2
97	Step 1: ____. Step 2: ____. Step 3: Profit.	0	2	1.2
98	Life for American Indians was forever changed when the White Man introduced them to ____.	0	1	1.2
1277	BUY SOME ____!	0	1	MLP
1279	CUTIE MARK CRUSADERS; ____! YAY!	0	1	MLP
1281	Daring Do and the quest for ____.	0	1	MLP
1283	Dear Princess Celestia, Today I learned about ____. 	0	1	MLP
1285	Despite everypony's expectations, Sweetie Belle's cutie mark ended up being ____.	0	1	MLP
1287	Equestrian researchers have discovered that ____ is The 7th Element of Harmony.	0	1	MLP
1289	Every Morning, Princess Celestia Rises ____.	0	1	MLP
1303	In a stroke of unparalleled evil, Discord turned ____ into ____.	0	2	MLP
1305	In a world without humans, saddles are actually made for ____.	0	1	MLP
1306	Inexplicably, the only thing the parasprites wouldn't eat was ____.	0	1	MLP
1309	It turns out Hitler's favorite pony was ____.	0	1	MLP
1311	It's not a boulder! It's ____!	0	1	MLP
1313	Lauren Faust was shocked to find ____ in her mailbox.	0	1	MLP
1315	Luna didn't help in the fight against Chrysalis because she was too busy with ____.	0	1	MLP
1317	My cutie mark would be ____.	0	1	MLP
1319	Not many people know that Tara Strong is also the voice of ____.	0	1	MLP
1321	Nothing makes Pinkie smile more than ____.	0	1	MLP
1458	This holiday season, Tim Allen must overcome his fear of ____ to save Christmas.	0	1	❄
1459	Jesus is ____.	0	1	❄
1462	On the third day of Christmas, my true love gave to me: three French hens, two turtle doves, and ____.	0	1	❄
1463	Wake up, America. Christmas is under attack by secular liberals and their ____.	0	1	❄
1291	Everypony was shocked to discover that Scootaloo's cutie mark was ____.	0	1	MLP
1292	Giggle at ____!	0	1	MLP
1295	I never knew what ____ could be, until you all shared its ____ with me.	0	2	MLP
1297	I'd like to be ____.	0	1	MLP
1301	In a fit of rage, Princess Celestia sent ____ to the ____ for ____.	2	3	MLP
1323	Once upon a time, the land of Equestria was ruled by ____ and ____.	0	2	MLP
1325	Ponyville is widely known for ____.	0	1	MLP
1327	Ponyville was shocked to discover ____ in Fluttershy's shed.	0	1	MLP
1329	Prince Blueblood's cutie mark represents ____.	0	1	MLP
1330	Rainbow Dash has always wanted ____.	0	1	MLP
1345	Rainbow Dash is the only pony in all of Equestria who can ____.	0	1	MLP
1347	Rainbow Dash received a concussion after flying into ____.	0	1	MLP
1350	Rarity has a long forgotten line of clothing inspired by ____.	0	1	MLP
1352	Rarity was supposed to have a song about ____, but it was cut.	0	1	MLP
1353	Rarity's latest dress design was inspired by ____.	0	1	MLP
1354	Should the Elements of Harmony fail, ____ is to be used as a last resort.	0	1	MLP
1355	Super Speedy ____ Squeezy 5000.	0	1	MLP
1356	Surprisingly, Canterlot has a museum of ____.	0	1	MLP
1359	____. That is my fetish.	0	1	MLP
1361	The Elements of Harmony were originally the Elements of ____.	0	1	MLP
1363	The Everfree forest is full of ____.	0	1	MLP
1365	The national anthem of Equestria is ____.	0	1	MLP
1366	The only way to get Opal in the bath is with ____.	0	1	MLP
1369	The worst mishap caused by Princess Cadance was when she made ____ and ____ fall in love.	0	2	MLP
1370	To much controversy, Princess Celestia made ____ illegal.	0	1	MLP
1371	Today, Mayor Mare announced her official campaign position on ____ and ____. No pony was the least bit surprised.	0	2	MLP
1372	Twilight got bored with the magic of friendship, and now studies the magic of ____.	0	1	MLP
1373	Twilight Sparkle owns far more books on ____ than she'd like to admit.	0	1	MLP
1374	When Luna got to the moon, she was greeted with ____.	0	1	MLP
1375	When Spike is asleep, Twilight likes to read books about ____.	0	1	MLP
1376	Without any warning, Pinkie Pie burst into a song about ____.	0	1	MLP
1377	You're a human transported to Equestria! The first thing you'd look for is ____.	0	1	MLP
1378	Zecora is a well known supplier of ____ and ____.	0	2	MLP
1460	Every Christmas, my uncle gets drunk and tells the story about ____.	0	1	❄
1461	What keeps me warm during the cold, cold winter?	0	1	❄
1457	After blacking out during New Year's Eve, I was awoken by ____.	0	1	❄
99	____ Jesus is the Jesus of ____.	0	2	VS
100	____ ALL THE ____.	0	2	VS
101	There were ALOT of ____ doing ____.	0	2	VS
102	Dogimo would give up ____ to type a six sentence paragraph in a thread.	0	1	VS
103	Simple dog ate and vomited ____.	0	1	VS
104	When I was 25, I won an award for ____.	0	1	VS
105	I'm more awesome than a T-rex because of ____.	0	1	VS
106	____ in my pants.	0	1	VS
107	We need to talk about your whole gallon of ____.	0	1	VS
108	Clean ALL the ____.	0	1	VS
109	The first rule of Jade Club is ____.	0	1	VS
110	The forum nearly broke when ____ posted ____ in The Dead Thread.	0	2	VS
111	A mod war about ____ occurred during ____.	0	2	VS
112	No one likes me after I posted ____ in the TMI thread.	0	1	VS
113	____ was banned from tinychat because of ____.	0	2	VS
114	____ for president!	0	1	VS
115	I did ____, like a fucking adult.	0	1	VS
116	Domo travelled across ____ to win the prize of ____.	0	2	VS
117	Roses and her hammer collection defeated an entire squadron of ____.	0	1	VS
118	After Blue posted ____ in chat, I never trusted his links again.	0	1	VS
119	Fuck you, I'm a ____.	0	1	VS
120	Cunnilungus and psychiatry brought us to ____.	0	1	VS
121	I CAN ____ ACROSS THE ____.	0	2	VS
122	____ is the only thing that matters.	0	1	VS
123	I'm an expert on ____.	0	1	VS
510	What can you always find in between the couch cushions?	0	1	RS
125	I want ____ in my mouflon RIGHT MEOW.	0	1	VS
126	Don't get mad, get ____.	0	1	VS
127	Have fun, don't be ____.	0	1	VS
128	It's the end of ____ as we know it.	0	1	VS
129	____ is my worst habit.	0	1	VS
130	Everything's better with ____.	0	1	VS
131	Yaar's mother is ____.	0	1	VS
132	What would you taste like?	0	1	VS
133	What have you accomplished today?	0	1	VS
134	What made you happy today?	0	1	VS
135	Why are you frothing with rage?	0	1	VS
136	What mildy annoyed you today?	0	1	VS
137	We'll always have ____.	0	1	VS
138	____ uses ____. It is SUPER EFFECTIVE!	0	2	VS
139	Let's all rock out to the sounds of ____.	0	1	VS
140	Take ____, it will last longer.	0	1	VS
141	You have my bow. AND MY ____.	0	1	VS
142	VS: Where the ____ happens!	0	1	VS
143	____? FRY. EYES.	0	1	VS
144	A wild ____ appeared! It used ____!	0	2	VS
145	I thought being a ____ was the best thing ever, until I became a ____.	0	2	VS
146	Live long and ____.	0	1	VS
511	The victim was found with ____.	0	1	RS
148	I'm under the ____.	0	1	VS
149	If life gives you ____, make ____.	0	2	VS
150	Who needs a bidet when you have ____?	0	1	VS
151	Kill it with ____!	0	1	VS
152	My ____ is too big!	0	1	VS
153	Best drink ever: One part ____, three parts ____, and a splash of ____.	2	3	VS
154	____ makes me uncomfortable.	0	1	VS
155	Stop, drop, and ____.	0	1	VS
156	Think before you ____.	0	1	VS
157	The hills are alive with ____ of ____.	0	2	VS
512	What is love without ____?	0	1	RS
100004	test<sup>&reg;</sup><br><i>italic</i>&trade;<br><span class="card_number"><b>&uarr;</b></span>	0	1	test
100006	____ is the name of my ____ cover band.	0	2	SG
100016	Alcoholic games of Clue&reg; lead to ____.	0	1	SG
100027	I have an idea even better than Kickstarter, and it's called ____starter.	0	1	PAX A
100028	You have been waylaid by ____ and must defend yourself.	0	1	PAX A
100037	Action stations! Action stations! Set condition one throughout the fleet and brace for ____!	0	1	PAX B
100038	In the final round of this year's Omegathon, Omeganauts must face off in a game of ____.	0	1	PAX B
100047	Press <span class="card_number">&darr;</span><span class="card_number">&darr;</span><span class="card_number">&larr;</span><span class="card_number">&rarr;</span><span class="card_number">B</span> to unleash ____.	0	1	PAX C
100048	I don't know exactly how I got the PAX plague, but I suspect it had something to do with ____.	0	1	PAX C
100054	____: Hours of fun. Easy to use. Perfect for ____!	0	2	X3
100058	Turns out that ____-Man was neither the hero we needed nor wanted.	0	1	X3
100059	What left this stain on my couch?	0	1	X3
100065	Call the law offices of Goldstein &amp; Goldstein, because no one should have to tolerate ____ in the workplace.	0	1	X3
100066	A successful job interview begins with a firm handshake and ends with ____.	0	1	X3
100070	Lovin' you is easy 'cause you're ____.	0	1	X3
100074	Money can't buy me love, but it can buy me ____.	0	1	X3
100078	Listen, son. If you want to get involved with ____, I won't stop you. Just steer clear of ____.	0	2	X3
100085	During high school, I never really fit in until I found ____ club.	0	1	X3
100089	Hey baby, come back to my place and I'll show you ____.	0	1	X3
100093	To prepare for his upcoming role, Daniel Day-Lewis immersed himself in the world of ____.	0	1	X3
100094	Finally! A service that delivers ____ right to your door.	0	1	X3
100095	My gym teacher got fired for adding ____ to the obstacle course.	0	1	X3
100096	When you get right down to it, ____ is just ____.	0	2	X3
100097	As part of his daily regimen, Anderson Cooper sets aside 15 minutes for ____.	0	1	X3
100098	In the seventh circle of Hell, sinners must endure ____ for all eternity.	0	1	X3
100100	After months of practice with ____, I think I'm finally ready for ____.	0	2	X3
100103	The blind date was going horribly until we discovered our shared interest in ____.	0	1	X3
100104	____. Awesome in theory, kind of a mess in practice.	0	1	X3
100105	With enough time and pressure, ____ will turn into ____.	0	2	X3
100106	I'm not like the rest of you. I'm too rich and busy for ____.	0	1	X3
100108	And what did <i>you</i> bring for show and tell?	0	1	X3
100110	Having problems with ____? Try ____!	0	2	X3
100113	As part of his contract, Prince won't perform without ____ in his dressing room.	0	1	X3
100155	____.tumblr.com	0	1	SG
17	What's the next Happy Meal&reg; toy?	0	1	\N
100092	My life is ruled by a vicious cycle of ____ and ____.	0	2	X3
124	After I saw ____, I needed ____.	0	2	VS
100007	____ with ____ in ____.	2	3	SG
147	There's ____ in my soup.	0	1	VS
158	____ caused Northernlion to take stupid damage.	0	1	NL
159	____ Is the best item in The Binding of Isaac.	0	1	NL
160	____ is the worst item in The Binding of Isaac.	0	1	NL
161	____ is/are Northernlion's worst nightmare.	0	1	NL
162	____ sounds like a great alternative rock band.	0	1	NL
163	____: The Northernlion Story.	0	1	NL
164	____? Well, I won't look a gift horse in the mouth on that one.	0	1	NL
165	____. Everything else is uncivilized.	0	1	NL
166	"Hey everybody and welcome to Let's Look At ____!"	0	1	NL
167	As always, I will ____ you next time!	0	1	NL
168	Best game of 2013? ____, of course.	0	1	NL
169	But that ____ has sailed.	0	1	NL
87	Lifetime&reg; presents ____, the story of ____.	0	2	\N
92	Dear Abby,<br><br>I'm having some trouble with ____ and would like your advice.	0	1	1.2
170	Even ____ is/are better at video games than Northernlion.	0	1	NL
171	Everything's coming up ____.	0	1	NL
172	Finding something like ____ would turn this run around.	0	1	NL
173	Fuck the haters, this is ____.	0	1	NL
174	Get in my ____ zone.	0	1	NL
175	How do you get your dog to stop humping your leg?	0	1	NL
176	I can do ____ and die immediately afterward.	0	1	NL
177	I don't even see ____ anymore; all I see are blondes, brunettes, redheads...	0	1	NL
178	I'm in the permanent ____ state.	0	1	NL
179	If sloth ____ are wrong I don’t want to be right.	0	1	NL
180	Invaded the world of ____.	0	1	NL
181	It's ____, ya dangus!	0	1	NL
182	JSmithOTI: Total ____.	0	1	NL
183	Legend has it, the Thug of Porn was arrested for ____.	0	1	NL
184	Let's Look At: ____.	0	1	NL
185	Northernlion's latest novelty Twitter account is @____.	0	1	NL
186	More like the Duke of ____, right?	0	1	NL
187	No one man should have all that ____.	0	1	NL
188	Northernlion has been facing ridicule for calling ____ a rogue-like.	0	1	NL
189	Northernlion always forgets the name of ____.	0	1	NL
190	Northernlion's refusal to Let's Play ____ was probably a good call.	0	1	NL
191	Of all the things that Ryan and Josh have in common, they bond together through their mutual love of ____.	0	1	NL
192	Oh god, I can't believe we ate ____ at PAX.	0	1	NL
193	One thing Northernlion was right about was ____.	0	1	NL
194	Only in Korea can you see ____.	0	1	NL
195	Praise the ____!	0	1	NL
196	Recently, Northernlion has felt woefully insecure due to ____.	0	1	NL
197	Roguelike? How about ___-like.	0	1	NL
198	Sometimes, a man's just gotta ____.	0	1	NL
199	The hero of the stream was ____.	0	1	NL
200	The stream was going well until ____.	0	1	NL
201	The Youtube chat proved ineffective, so instead we had to communicate via ____.	0	1	NL
202	____? It's a DLC item.	0	1	NL
203	This new game is an interesting ____-like-like.	0	1	NL
204	We're rolling in ____!	0	1	NL
205	Whenever I ___, take a drink.	0	1	NL
206	Today's trivia topic is ____.	0	1	NL
207	What do you give to the CEO of Youtube as a gift?	0	1	NL
208	The only way NL is ever going to make it to Hell in Spelunky is by using ____.	0	1	NL
209	That ____ has sailed.	0	1	NL
210	Welcome back to The Binding of Isaac. Today's challenge run will be based on  ____.	0	1	NL
211	Well there's nothing wrong with ____ by any stretch of the imagination.	0	1	NL
212	I'd sacrifice ____ at the Altar.	0	1	NL
213	Fox would still be here if not for ____.	0	1	NL
214	The Holy Trinity: ____, ____, and ____!	2	3	NL
215	I wasn't even that drunk! I just had some ____, ____, and ____.	2	3	NL
216	____ was indicted on account of ____.	0	2	NL
217	____: The ____ Story.	0	2	NL
8710	What does Alucard have nightmares about?	0	1	ANX1
219	Hello everybody, welcome to a new episode of ____ plays ____.	0	2	NL
220	I beat Blue Baby with only ____ and ____!	0	2	NL
221	Northernlion has alienated fans of ____ by calling them ____.	0	2	NL
222	Northernlion was fired from his teaching job and had to flee South Korea after an incident involving  ____ and ____.	0	2	NL
8711	I've always wanted to become a voice actor, so I could play the role of ____.	0	1	ANX1
5100	My original species combines ____ and ____. It's called ____.	2	3	Furry
5101	____. And now I'm bleeding.	0	1	Furry
100159	Don't slow down in East Cleveland or ____.	0	1	SG
53	While the United States raced the Soviet Union to the moon, the Mexican government funneled millions of pesos into research on ____.	0	1	\N
226	My life for ____!	0	1	RS
513	Who let the dogs out?	0	1	RS
514	In his next movie, Will Smith saves the world from ____.	0	1	RS
515	Lady Gaga has revealed her new dress will be made of ____.	0	1	RS
516	Justin Beiber's new song is all about ____.	0	1	RS
517	The new fad diet is all about making people do ____ and eat ____.	0	2	RS
518	Grand Theft Auto&trade;: ____.	0	1	RS
519	I whip my ____ back and forth.	0	1	RS
520	When North Korea gets ____, it will be the end of the world.	0	1	RS
521	Plan a three course meal.	2	3	RS
522	Tastes like ____.	0	1	RS
523	What is literally worse than Hitler?	0	1	RS
524	____ ruined many people's childhood.	0	1	RS
525	____ and ____ are the new hot couple.	0	2	RS
526	Who needs college when you have ____.	0	1	RS
527	When short on money, you can always ____.	0	1	RS
528	What will Xyzzy take over the world with?	0	1	RS
529	The next pokemon will combine ____ and ____.	0	2	RS
530	Who is GLaDOS's next test subject?	0	1	RS
531	Instead of playing Cards Against Humanity, you could be ____.	0	1	RS
532	The next Assassin's Creed game will take place in ____.	0	1	RS
533	I wouldn't fuck ____ with ____'s dick.	0	2	RS
534	One does not simply walk into ____.	0	1	RS
535	In the next Punch Out!!, ____ will be the secret final boss.	0	1	RS
536	Welcome to my secret lair on ____.	0	1	RS
537	Dustin Browder demands more ____ in StarCraft&reg;.	0	1	RS
538	What is the answer to life's question?	0	1	RS
539	I've got the whole world in my ____.	0	1	RS
540	I never thought ____ would be so enjoyable.	0	1	RS
541	In his second term, Obama will rid America of ____.	0	1	RS
542	What is Japan's national pastime?	0	1	RS
5102	Suck my ____.	0	1	Furry
543	In the future, ____ will fuel our cars.	0	1	RS
544	The lion, the witch, and ____.	0	1	RS
545	In the next episode, SpongeBob gets introduced to ____. 	0	1	RS
546	____ Game of the Year Edition.	0	1	RS
547	What was going through Osama Bin Laden's head before he died?	0	1	RS
548	In a news conference, Obama pulled out ____, to everyone's surprise.	0	1	RS
549	Nights filled with ____.	0	1	RS
738	To top One More Day, future comic writers will use ____ to break up a relationship.	0	1	TGWTG
739	The real reason MAGFest was ruined was ____.	0	1	TGWTG
740	The reason Linkara doesn't like milk in his cereal is ____.	0	1	TGWTG
741	The secret of Linkara's magic gun is ____.	0	1	TGWTG
8712	If the anime industry is dying, what will be the final nail in it's coffin?	0	1	ANX1
743	For the next Anniversary event, the TGWTG producers must battle ____ to get ____.	0	2	TGWTG
744	If a dog and a dolphin can get along, why not ____ and ____?	0	2	TGWTG
745	If I wanted to see ____, I'll stick with ____, thank you very much.	0	2	TGWTG
746	I asked Linkara to retweet ____, but instead, he retweeted ____.	0	2	TGWTG
747	I write slash fanfiction pairing ____ with ____.	0	2	TGWTG
8713	Ladies and gentlemen, I give you ____... COVERED IN BEES!!!	0	1	ANX1
749	Next time on Obscurus Lupa Presents: " ____ IV: The Return of ____".	0	2	TGWTG
8714	Don't stand behind him, if you value your ____.	0	1	ANX1
751	Todd in the Shadows broke the Not a Rhyme button when the singer tried to rhyme ____ with ____.	0	2	TGWTG
752	Welshy is to ____ as Sad Panda is to ____.	0	2	TGWTG
753	Linkara's next story arc will involve him defeating ____ with the power of  ____.	0	2	TGWTG
754	Rock and Roll is nothing but ____ and the rage of ____!	0	2	TGWTG
8715	What the hell is "Juvijuvibro"?!	0	1	ANX1
756	Being fed up with reviewing lamps, what obscure topic did Linkara review next?	0	1	TGWTG
225	When I was a kid, all we had in Lunchables were three ____ and ____.	0	2	NL
224	On its last dying breath, ____ sent out a cry for help. A bunch of ____ heard the cry.	0	2	NL
5103	I also take ____ as payment for commissions.	0	1	Furry
5015	____ looks pretty in all the art, but have you seen one in real life?	0	1	Furry
100203	At the last PAX, Paul and Storm had ____ thrown at them during "Opening Band".	0	1	SG
100206	How did I lose my virginity?	0	1	1.3
100207	Here is the church<br>Here is the steeple<br>Open the doors<br>And there is ____.	0	1	1.3
100208	During his childhood, Salvador Dal&iacute; produced hundreds of paintings of ____.	0	1	1.3
6	This is the way the world ends \\ This is the way the world ends \\ Not with a bang but with ____.	0	1	\N
100209	In 1,000 years, when paper money is a distant memory, how will we pay for goods and services?	0	1	1.3
34	War!<br><br>What is it good for?	0	1	\N
100210	What don't you want to find in your Kung Pao chicken?	0	1	1.3
84	Rumor has it that Vladimir Putin's favorite delicacy is ____ stuffed with ____.	0	2	\N
100217	The Smithsonian Museum of Natural History has just opened an exhibit on ____.	0	1	1.3
100218	What did the commenters bitch about next to Doug?	0	1	TGWTG
5016	At first I couldn't understand ____, but now it's my biggest kink.	0	1	Furry
5017	Long story short, I ended up with ____ in my ass.	0	1	Furry
5018	Don't knock ____ until you've tried it.	0	1	Furry
5019	Who knew I'd be able to make a living off of ____?	0	1	Furry
5020	It's difficult to explain to friends and family why I know so much about ____.	0	1	Furry
5021	Once I started roleplaying ____, it was all downhill from there.	0	1	Furry
5022	____ are so goddamn cool.	0	1	Furry
5023	____, by Bad Dragon™.	0	1	Furry
5024	No, look, you don't understand. I REALLY like ____.	0	1	Furry
5025	I don't think my parents will ever accept that the real me is ____.	0	1	Furry
5026	I can't believe I spent most of my paycheck on ____.	0	1	Furry
5027	You can try to justify ____ all you want, but you don't have to be ____ to realize it's just plain wrong.	0	2	Furry
5028	I've been waiting all year for ____.	0	1	Furry
5029	I can't wait to meet up with my internet friends for ____.	0	1	Furry
771	The next crossover will have ____ and ____ review ____.	2	3	TGWTG
772	We all made a mistake when we ate ____ at MAGFest.	0	1	TGWTG
773	Kyle's next student film will focus on ____.	0	1	TGWTG
774	The RDA chat knew Nash was trolling them when he played ____.	0	1	TGWTG
775	Why does Linkara have all of those Cybermats?	0	1	TGWTG
776	____ will be the subject of the next TGWTG panel at MAGFest.	0	1	TGWTG
777	At his next con appearance, Linkara will cosplay as ____.	0	1	TGWTG
778	WAIT!  I have an idea!  It involves using ____!	0	1	TGWTG
779	What does Linkara eat with his chicken strips?	0	1	TGWTG
780	If you value your life, never mention ____ around Oancitizen.	0	1	TGWTG
781	Arlo P. Arlo's newest weapon combines ____ and ____!	0	2	TGWTG
782	____ and ____ are in the worst comic Linkara ever read.	0	2	TGWTG
783	____ is only on the site because of ____.	0	2	TGWTG
784	The newest fanfic trend is turning ____ into ____.	0	2	TGWTG
785	Every weekend, Golby likes to ____ then ____ before finally ____.	2	3	GFC
786	Every weekend, Golby enjoys drinking ____ before getting into a fight with ____ and having sex with ____.	2	3	GFC
787	Connie the Condor often doesn't talk on skype because of ____.	0	1	GFC
788	Jorgi the Corgi most definitely enjoys ____.	0	1	GFC
789	Tom is good, but he's not ____ good.	0	1	GFC
790	It's DJ Manny in the hizouse, playing ____ all night long!	0	1	GFC
791	BENCH ALL THE ____.	0	1	GFC
792	Hey guys, check out my ____ montage!	0	1	GFC
793	____ + ____ = Golby.	0	2	GFC
653	____ is the reason Linkara doesn't like to swear.	0	1	TGWTG
654	____ was completely avoidable!	0	1	TGWTG
655	____ will live!	0	1	TGWTG
656	____ is something else Diamanda Hagan has to live with every day.	0	1	TGWTG
657	____ should be on TGWTG.	0	1	TGWTG
658	____ was the first thing to go when Hagan took over the world.	0	1	TGWTG
659	____! What are you doing here?	0	1	TGWTG
660	____! You know, for kids.	0	1	TGWTG
661	I love ____. It's so bad.	0	1	TGWTG
8716	As part of a recent promotion, Japanese KFCs are now dressing their Colonel Sanders statues up as ____.	0	1	ANX1
663	____. With onions.	0	1	TGWTG
664	____ is the theme of this year's anniversary crossover.	0	1	TGWTG
665	A ____ Credit Card!?	0	1	TGWTG
8717	Fighting ____ by moonlight! Winning ____ by daylight! Never running from a real fight! She is the one named ____!	2	3	ANX1
8718	It's no secret.  Deep down, everybody wants to fuck ____.	0	1	ANX1
8719	Behold! My trap card, ____!	0	1	ANX1
669	Blip checks are way smaller in January so I'll spend the month riffing on ____ to gain more views.	0	1	TGWTG
670	Brad Tries ____.	0	1	TGWTG
671	Doug still regrets the day he decided to do a Let's Play video for "Bart Simpson's ____ Adventure".	0	1	TGWTG
672	Enemies of Diamanda Hagan have been known to receive strange packages filled with  ____.	0	1	TGWTG
673	High and away on a wing and a prayer, who could it be? Believe it or not, it's just ____.	0	1	TGWTG
674	What broke Nash this week?	0	1	TGWTG
675	I ____ so you don't have to.	0	1	TGWTG
676	I AM THE VOICELESS. THE NEVER SHOULD. I AM ____.	0	1	TGWTG
677	I prefer for MY exploitation films to have ____, thank you very much.	0	1	TGWTG
678	I watch movies just to see if I can find a Big Lipped ____ Moment.	0	1	TGWTG
679	I'm looking forward to Jesuotaku's playthrough of Fire Emblem: ____.	0	1	TGWTG
8720	After eating a Devil Fruit, I now have the power of ____.	0	1	ANX1
681	In his latest review, Phelous was killed by ____.	0	1	TGWTG
682	It was all going well until they found ____.	0	1	TGWTG
683	JW confirms, you can play ____,	0	1	TGWTG
684	Next January, the Nostalgia Critic is doing ____ Month.	0	1	TGWTG
685	No one wants to see your ____.	0	1	TGWTG
686	Of Course! Don't you know anything about ____?	0	1	TGWTG
687	OH MY GOD THIS IS THE GREATEST ____ I'VE EVER SEEN IN MY LIFE!	0	1	TGWTG
688	On the other side of the Plot Hole, the Nostalgia Critic found ____.	0	1	TGWTG
689	Reactions were mixed when ____ joined TGWTG.	0	1	TGWTG
690	Sage has presented JO with the new ecchi series ____.	0	1	TGWTG
691	Sean got his head stuck in ____.	0	1	TGWTG
692	STOP OR I WILL ____.	0	1	TGWTG
693	The invasion of Molassia was tragically thwarted by ____.	0	1	TGWTG
694	The newest reviewer addition to the site specializes in ____.	0	1	TGWTG
695	The next person to leave Channel Awesome will announce their departure via ____.	0	1	TGWTG
696	The next Renegade Cut is about ____ in a beloved children's movie.	0	1	TGWTG
697	The Nostalgia Critic will NEVER review ____.	0	1	TGWTG
698	The only thing Linkara would sell his soul for is ____.	0	1	TGWTG
699	What is the real reason Demo Reel failed?	0	1	TGWTG
8721	By far, the most mind-bogglingly awesome thing I've ever seen in anime is ____.	0	1	ANX1
8722	My Little Sister Can't Be ____!	0	1	ANX1
702	This weekend, the nation of Haganistan will once again commence its annual celebration of ____.  	0	1	TGWTG
703	To troll the RDA chat this time, Todd requested a song by ____.	0	1	TGWTG
704	Todd knew he didn't have a chance after trying to seduce Lupa with ____.	0	1	TGWTG
705	Turns out, that wasn't tea in MikeJ's cup, it was ____.	0	1	TGWTG
706	Viewers were shocked when Paw declared ____ the best song of the movie.	0	1	TGWTG
707	WE WERE FIGHTING LIKE ____.	0	1	TGWTG
708	Well, I've read enough fanfic about ____ and Lupa to last a lifetime.	0	1	TGWTG
709	What does Nash like to sing about?	0	1	TGWTG
710	What does Todd look like under his mask?	0	1	TGWTG
711	What doesn't go there?	0	1	TGWTG
712	What doesn't work that way?	0	1	TGWTG
713	What else does Diamanda Hagan have to live with every day?	0	1	TGWTG
714	What is in Sci Fi Guy's vest?	0	1	TGWTG
715	What the fuck is wrong with you?	0	1	TGWTG
716	What will Tara name her next hippo?	0	1	TGWTG
717	What's holding up the site redesign?	0	1	TGWTG
718	What's really inside the Plot Hole?	0	1	TGWTG
719	What's the real reason nobody has ever played the TGWTG Panel Drinking Game?	0	1	TGWTG
720	What's up next on WTFIWWY?	0	1	TGWTG
721	When the JesuOtaku stream got to the "awful part of the night," the GreatSG video featured ____.	0	1	TGWTG
722	Why can't Film Brain stop extending his final vowels?	0	1	TGWTG
723	Why was Radio Dead Air shut down this time?	0	1	TGWTG
724	90's Kid's favorite comic is ____.	0	1	TGWTG
725	Because poor literacy is ____.	0	1	TGWTG
726	He is a glitch. He is missing. He is ____.	0	1	TGWTG
727	In a surprise twist, the villain of Linkara's next story arc turned out to be ____.	0	1	TGWTG
728	Linkara now prefers to say ____ in lieu of "fuck".	0	1	TGWTG
729	Of course!  Don't you know anything about ___?	0	1	TGWTG
730	Snowflame feels no ____.	0	1	TGWTG
731	Snowflame found a new love besides cocaine. What is it?	0	1	TGWTG
732	So let's dig into ____ #1.	0	1	TGWTG
734	Where'd he purchase that?	0	1	TGWTG
735	When is the next History of Power Rangers coming out?	0	1	TGWTG
736	What is as low as the standards of the 90's Kid?	0	1	TGWTG
737	What delayed the next History of Power Rangers?	0	1	TGWTG
100163	____ has the "mount" keyword.	0	1	SG
794	On a night out, Golby will traditionally get into a fight with a ____ then have sex with a ____ before complaining about a hangover from too much ____.	2	3	GFC
795	You're so _____ I'll have to delete you.	0	1	GFC
796	Cindi suddenly turned into Steven after ____.	0	1	GFC
797	When Barta isn't talking he's ____.	0	1	GFC
798	I got a new tattoo, it looks a bit like ____.	0	1	GFC
799	What strange Korean delicacy will Mark enjoy today?	0	1	GFC
800	____ is camping my lane.	0	1	GFC
801	The OGN was fun, but there was far too much ____ cosplay.	0	1	GFC
802	"What are you thinking?" "You know, ____ and stuff."	0	1	GFC
100223	Drunken games of Pretend You're Xyzzy lead to ____ and ____.	0	2	SG
803	Vegeta, what does the scouter say?	0	1	AN
804	____. BELIEVE IT!	0	1	AN
805	Make a contract with me, and become ____!	0	1	AN
806	You guys are so wrong. Obviously, ____ is best waifu.	0	1	AN
807	In the latest chapter of Toriko, our hero hunts down, kills, and eats a creature made entirely of ____.	0	1	AN
808	THIS ____ HAS BEEN PASSED DOWN THE ARMSTRONG FAMILY LINE FOR GENERATIONS!!!	0	1	AN
809	My favorite episode of ____ is the one with ____.	0	2	AN
810	Make a yaoi shipping.	0	2	AN
811	This doujinshi I just bought has ____ and ____ getting it on, hardcore.	0	2	AN
812	On the next episode of Dragon Ball Z, ____ is forced to do the fusion dance with ____.	0	2	AN
813	You are already ____.	0	1	AN
814	Who the hell do you think I am?!	0	1	AN
815	On the next episode of Dragon Ball Z, Goku has a fierce battle with ____.	0	1	AN
816	____. YOU SHOULD BE WATCHING.	0	1	AN
5096	Most cats are ____.	0	1	Furry
818	Fresh from Japan: The new smash hit single by ____ titled ____.	0	2	AN
819	____ vs. ____. BEST. FIGHT. EVER.	0	2	AN
820	So wait, ____ was actually ____? Wow, I didn't see that one coming!	0	2	AN
821	Real men watch ____.	0	1	AN
822	When it comes to hentai, nothing gets me hotter than ____.	0	1	AN
823	Whenever I'm splashed with cold water, I turn into ____.	0	1	AN
824	No matter how you look at it, ultimately ____ is responsible for ____.	0	2	AN
825	S-Shut up!! I-It's not like I'm ____ or anything.	0	1	AN
826	The English dub of ____ sucks worse than ____.	0	2	AN
827	What is mo&eacute;?	0	1	AN
828	Hayao Miyazaki's latest family film is about a young boy befriending ____.	0	1	AN
829	Congratulations, ____.	0	1	AN
830	By far the best panel at any anime convention is the one for ____.	0	1	AN
831	One thing you almost never see in anime is ____.	0	1	AN
832	The rarest Pok&eacute;mon in my collection is ____.	0	1	AN
833	What do I hate most about anime?	0	1	AN
834	Mamoru Oshii's latest film is a slow-paced, two hour-long cerebral piece about the horrors of ____.	0	1	AN
835	What do I love most about anime?	0	1	AN
836	This morning, hundreds of Japanese otaku lined up outside their favorite store to buy the limited collector's edition of ____.	0	1	AN
837	Every now and then, I like to participate in the time-honored Japanese tradition of ____.	0	1	AN
838	There are guilty pleasures. And then there's ____.	0	1	AN
839	Watch it! Or I'll take your ____.	0	1	AN
840	New from Studio GAINAX: ____ the Animation.	0	1	AN
841	Using my power of Geass, I command you to do... THIS!	0	1	AN
842	Chicks. Dig. ____. <i>Nice.</i>	0	1	AN
843	When it comes to Japanese cuisine, there's simply nothing better than ____.	0	1	AN
844	The next big Tokusatsu show: "Super Sentai ____ Ranger!"	0	1	AN
845	In the name of the moon, I will punish ____!	0	1	AN
846	Just announced: The brand new anime adaptation of ____, starring ____ as the voice of ____.	2	3	AN
847	Don't worry, he's okay! He survived thanks to ____.	0	1	AN
848	____. Goddammit, Japan.	0	1	AN
849	In the latest chapter of Golgo 13, he kills his target with ____.	0	1	AN
850	Welcome home, Master! Is there anything your servant girl can bring you today?	0	1	AN
851	In the latest episode of Case Closed, Conan deduces that it was ____ who killed ____ because of ____.	2	3	AN
852	I have never in my life laughed harder than the first time I watched ____.	0	1	AN
853	Take this! My love, my anger, and all of my ____!	0	1	AN
854	Karaoke night! I'm totally gonna sing my favorite song, ____.	0	1	AN
855	Digimon! Digivolve to: ____-mon!	0	1	AN
856	Now! Face my ultimate attack!	0	1	AN
857	Behold the name of my Zanpakuto, ____!	0	1	AN
858	From the twisted mind of Nabeshin: An anime about ____, ____, and ____.	2	3	AN
859	____. Only on Toonami	0	1	AN
860	I am in despair! ____ has left me in despair!	0	1	AN
861	The new manga from ____ is about a highschool girl discovering ____.	0	2	AN
862	To save the world, you must collect all 7 ____.	0	1	AN
863	Sasuke has ____ implants.	0	1	AN
864	In truth, the EVA units are actually powered by the souls of ____.	0	1	AN
865	Dreaming! Don't give it up ____! Dreaming! Don't give it up ____! Dreaming! Don't give it up ____!	2	3	AN
817	Lupin the III's latest caper involves him trying to steal ____.	0	1	AN
666	A piece of ____ is missing.	0	1	TGWTG
667	What do Brad and Floyd like to do after a long day?	0	1	TGWTG
668	At least he didn't fuck ____.	0	1	TGWTG
742	Hello, and welcome to Atop ____, where ____ burns.	0	2	TGWTG
8723	No matter how I look at it, it's your fault I'm not ____!	0	1	ANX1
662	Hello, I'm the Nostalgia Critic. I remember ____ so you don't have to!	0	1	TGWTG
5098	Taking pride in one's collection of ____.	0	1	Furry
755	If you are able to deflect ____ with ____, we refer to it as "Frying ____".	2	3	TGWTG
8724	They are the prey, and we are the ____.	0	1	ANX1
5030	Did you hear about the guy that smuggled ____ into the hotel?	0	1	Furry
867	The new Gurren Lagann blurays from Aniplex will literally cost you ____.	0	1	AN
868	The most overused anime cliche is ____.	0	1	AN
869	The inspiration behind the latest hit show is ____.	0	1	AN
870	While writing Dragon Ball, Akira Toriyama would occasionally take a break from working to enjoy ____.	0	1	AN
871	The show was great, until ____ showed up.	0	1	AN
872	Nothing ruins a good anime faster than ____.	0	1	AN
873	People die when they are ____.	0	1	AN
874	I want to be the very best, like no one ever was! ____ is my real test, ____ is my cause!	0	2	AN
875	Okay, I'll admit it. I would totally go gay for ____.	0	1	AN
876	Who are you callin' ____ so short he can't see over his own ____?!?!	0	2	AN
877	If you ask me, there need to be more shows about ____.	0	1	AN
878	____. That is the kind of man I was.	0	1	AN
879	I'm sorry! I'm sorry! I didn't mean to accidentally walk in on you while you were ____!	0	1	AN
880	After a long, arduous battle, ____ finally met their end by ____.	0	2	AN
881	This is our final battle. Mark my words, I will defeat you, ____!	0	1	AN
882	You used ____. It's super effective!	0	1	AN
883	The best English dub I've ever heard is the one for ____.	0	1	AN
884	I know of opinions and all that, but I just don't understand how anyone could actually enjoy ____.	0	1	AN
885	____. HE DEDD.	0	1	AN
886	She'll thaw out if you try ____.	0	1	AN
887	You see, I'm simply ____.	0	1	AN
888	Yoko Kanno's latest musical score features a song sung entirely by ____.	0	1	AN
889	Truly and without question, ____ is the manliest of all men.	0	1	AN
890	WANTED: $50,000,000,000 reward for the apprehension of____.	0	1	AN
891	This year, I totally lucked out and found ____ in the dealer's room.	0	1	AN
892	How did I avoid your attack? Simple. By ____.	0	1	AN
893	If I was a magical girl, my cute mascot sidekick would be ____.	0	1	AN
894	From the creators of Tiger &amp; Bunny: ____ &amp; ____!!	0	2	AN
895	In the future of 199X, the barrier between our world and the demon world is broken, and thousands of monsters invade our realm to feed upon ____.	0	1	AN
896	Animation studio ____ is perhaps best known for ____.	0	2	AN
897	____. So kawaii!! &lt;3 &lt;3	0	1	AN
898	The most annoying kind of anime fans are ____.	0	1	AN
899	Cooking is so fun! Cooking is so fun! Now it's time to take a break and see what we have done! ____. YAY! IT'S READY!!	0	1	AN
900	My favorite hentai is the one where ____ is held down and violated by ____.	0	2	AN
901	The government of Japan recently passed a law that effectively forbids all forms of ____.	0	1	AN
902	Mom, I swear! Despite it's name, ____ is NOT a porno!	0	1	AN
903	This year, I'm totally gonna cosplay as ____.	0	1	AN
904	Coming to Neon Alley: ____, completely UNCUT &amp; UNCENSORED.	0	1	AN
905	No matter how many times I see it, ____ always brings a tear to my eye.	0	1	AN
906	Of my entire collection, my most prized possession is ____.	0	1	AN
907	Who placed first in the most recent Shonen Jump popularity poll?	0	1	AN
908	Someday when I have kids, I want to share with them the joys of ____.	0	1	AN
909	So, what have you learned from all of this?	0	1	AN
910	In this episode of Master Keaton, Keaton builds ____ out of ____ and ____.	2	3	AN
911	The World Line was changed when I sent a D-mail to myself about ____.	0	1	AN
912	My ____ is the ____ that will pierce the heavens!!  <i>*same white card used for both blanks*</i>	0	1	AN
913	After years of searching, the crew of the Thousand Sunny finally found out that the One Piece is actually ____.	0	1	AN
914	When I found all 7 Dragon Balls, Shenron granted me my wish for ____.	0	1	AN
915	The best part of my ____ costume is ____.	0	2	AN
916	Cards Against Anime: It's more fun than ____!	0	1	AN
917	On the mean streets of Tokyo, everyone knows that ____ is the leader of the ________ Gang.	0	2	AN
918	He might just save the universe, if he only had some ____!	0	1	AN
920	Make a harem.	3	5	AN
921	Make a dub cast. ____ as ____, ____ as ____, &amp; ____ as ____.	4	6	AN
922	So just who is this Henry Goto fellow, anyway?	0	1	AN
923	When Henry Goto is alone and thinks that no one's looking, he secretly enjoys ____.	0	1	AN
924	Dr. Black Jack, please hurry! The patient is suffering from a terminal case of ____!	0	1	AN
925	I'M-A FIRIN' MAH ____!	0	1	AN
926	Make a love triangle.	2	3	AN
919	This ____ of mine glows with an awesome power! Its ____ tells me to defeat you!	0	2	AN
866	Yo-Ho-Ho! He took a bite of ____.	0	1	AN
927	Scientists have reverse engineered alien technology that unlocks the secrets of ____.	0	1	MrMan
928	It is often argued that our ancestors would have never evolved without the aid of ____.	0	1	MrMan
929	The sad truth is, that at the edge of the universe, there is nothing but ____.	0	1	MrMan
930	The 1930's is often regarded as the golden age of ____.	0	1	MrMan
931	____ a day keeps ____ away.	0	2	MrMan
932	There is a time for peace, a time for war, and a time for ____.	0	1	MrMan
933	If a pot of gold is at one end of the rainbow, what is at the other?	0	1	MrMan
934	A fortune teller told me I will live a life filled with ____.	0	1	MrMan
935	The Himalayas are filled with many perils, such as ____.	0	1	MrMan
936	The road to success is paved with ____.	0	1	MrMan
937	I work out so I can look good when I'm ____.	0	1	MrMan
938	What's the time? ____ time!	0	2	MrMan
939	And on his farm he had ____, E-I-E-I-O!	0	1	MrMan
940	Genius is 10% inspiration and 90% ____.	0	1	MrMan
941	I will not eat them Sam-I-Am. I will not eat ____.	0	1	MrMan
942	____ is the root of all evil.	0	1	MrMan
943	The primitive villagers were both shocked and amazed when I showed them ____.	0	1	MrMan
944	And it is said his ghost still wanders these halls, forever searching for his lost ____.	0	1	MrMan
945	Disney presents ____, on ice!	0	1	MrMan
946	The best part of waking up is ____ in your cup.	0	1	MrMan
947	Though Thomas Edison invented the lightbulb, he is also known for giving us ____.	0	1	MrMan
948	Little Miss. Muffet sat on her tuffet, eating her ____ and ____.	0	2	MrMan
949	What do I keep hidden in the crawlspace?	0	1	MrMan
950	Go-Go-Gadget, ____!	0	1	MrMan
951	I qualify for this job because I have several years experience in the field of ____.	0	1	MrMan
952	We just adopted ____ from the pound.	0	1	MrMan
953	It was the happiest day of my life when I became the proud parent of ____.	0	1	MrMan
954	I finally realized I hit rock bottom when I started digging through dumpsters for ____.	0	1	MrMan
955	With a million times the destructive force of all our nuclear weapons combined, no one was able to survive ____.	0	1	MrMan
956	You have been found guilty of 5 counts of ____, and 13 counts of ____.	0	2	MrMan
957	And the award for the filthiest scene in an adult film goes to "5 women and ____."	0	1	MrMan
958	The seldom mentioned 4th little pig build his house out of ____.	0	1	MrMan
959	"Why Grandma", said Little Red Riding Hood, "What big ____ you have!"	0	1	MrMan
960	Pay no attention to ____ behind the curtain!	0	1	MrMan
961	Who would have guessed that the alien invasion would be easily thwarted by ____.	0	1	MrMan
962	With Democrats and Republicans in a dead heat, the election was snatched by ____ party.	0	1	MrMan
963	Mama always said life was like ____.	0	1	MrMan
100226	Who could have guessed that the alien invasion would be easily thwarted by ____.	0	1	MrMan
100227	With the Democrats and Republicans in a dead heat, the election was snatched by the ____ party.	0	1	MrMan
5001	The panel I'm looking forward to most at AC this year is...	0	1	Furry
5002	My Original Character's name is ____.	0	1	Furry
5003	My secret tumblr account where I post nothing but ____.	0	1	Furry
5004	Only my internet friends know that I fantasize about ____.	0	1	Furry
5005	Everyone really just goes to the cons for ____.	0	1	Furry
5006	It all started with ____.	0	1	Furry
5007	I'll roleplay ____, you can be ____.	0	2	Furry
5008	I'm no longer allowed near ____ after the incident with ____.	0	2	Furry
5009	I've been into ____ since before I hit puberty, I just didn't know what it meant.	0	1	Furry
5010	Realizing, too late, the implications of your interest in ____ as a child.	0	1	Furry
5011	Whoa, I might fantasize about ____, but I'd never actually go that far in real life.	0	1	Furry
5012	I realized they were a furry when they mentioned ____.	0	1	Furry
5013	Everyone on this site has such strong opinions about ____.	0	1	Furry
5014	My landlord had a lot of uncomfortable questions for me when when he found ____ in my bedroom while I was at work.	0	1	Furry
5031	I'm not even aroused by normal porn anymore, I can only get off to ____ or ____.	0	2	Furry
5032	____? Oh, yeah, I could get my mouth around that.	0	1	Furry
5033	What wouldn't I fuck?	0	1	Furry
5034	When I thought I couldn't go any lower, I realized I would probably fuck ____.	0	1	Furry
5035	I knew my boyfriend was a keeper when he said he'd try ____, just for me.	0	1	Furry
5036	Fuck ____, get ____.	0	2	Furry
5038	I would bend over for ____.	0	1	Furry
5039	I think having horns would make ____ complicated.	0	1	Furry
5040	In my past life, I was ____.	0	1	Furry
5041	____ is my spirit animal.	0	1	Furry
5042	____. This is what my life has come to.	0	1	Furry
5043	I'm not even sad that I devote at least six hours of each day to ____.	0	1	Furry
5044	I never felt more accomplished than when I realized I could fit ____ into my ass.	0	1	Furry
5045	Yeah, I know I have a lot of ____ in my favorites, but I'm just here for the art.	0	1	Furry
5046	I'm not a "furry," I prefer to be called ____.	0	1	Furry
5047	Okay, ____? Pretty much the cutest thing ever.	0	1	Furry
5048	____. Yeah, that's a pretty interesting way to die.	0	1	Furry
5049	I didn't believe the rumors about ____, until I saw the videos.	0	1	Furry
5050	I knew I needed to leave the fandom when I realized I was ____.	0	1	Furry
5051	After being a furry for so long, I can never see ____ without getting a little aroused.	0	1	Furry
5052	It's really hard not to laugh at ____.	0	1	Furry
5053	If my parents ever found ____, I'd probably be disowned.	0	1	Furry
5054	____ ruined the fandom.	0	1	Furry
5055	The most recent item in my search history.	0	1	Furry
5056	Is it weird that I want to rub my face on ____?	0	1	Furry
680	In her newest review, Diamanda Hagan finds herself in the body of ____.	0	1	TGWTG
8725	My love for you is like ____.  BERSERKER!	0	1	ANX1
748	Last time I took bath salts, I ended up ____ in ____.	0	2	TGWTG
750	Tara taught me that if you're going to engage in ____, then ____ isn't a good idea.	0	2	TGWTG
700	The website was almost called "thatguywith____.com".	0	1	TGWTG
701	They even took ____! Who does that?!	0	1	TGWTG
733	You may be a robot, but I AM ____!	0	1	TGWTG
223	Northernlion's doctor diagnosed him today with ____, an unfortunate condition that would lead to ____.	0	2	NL
218	And now we're going to be fighting ____ on ____.	0	2	NL
8681	The comment section was nothing but ____ arguing about ____.	0	2	DAH
8726	IT'S ____ TIME!	0	1	ANX1
8727	It has been said... That there are entire forests of ____, made from the sweetest ____.	0	2	ANX1
8728	Attention, duelists: My hair is ____.	0	1	ANX1
8729	What do otaku smell like?	0	1	ANX1
8730	Madoka Kyouno's nickname for Muginami's older brother is ____.	0	1	ANX1
8731	"____."<br>"What the hell, man?!"<br>"____."<br>"Oh, okay."	0	2	ANX1
8732	And from Kyoto Animation, a show about cute girls doing ____.	0	1	ANX1
8733	Anime has taught me that classic literature can always be improved by adding ____.	0	1	ANX1
8734	The mo&eacute; debate was surprisingly civil until someone mentioned ____.	0	1	ANX1
8735	That's not a squid!  It's ____!	0	1	ANX1
8736	The Chocolate Underground stopped the Good For You Party by capturing their ____ and exposing their leader as ____.	0	2	ANX1
8737	Who cares about the printing press, did that medieval peasant girl just invent ____?!	0	1	ANX1
8747	Eating ____ gave me ____.	2	2	AI
8748	The reason I go to church is to learn about ____.	0	1	AI
8749	Show me on ____, where he ____.	0	2	AI
8750	I wouldn't ____ you with ____.	0	2	AI
8751	All attempts at ____, have met with failure and crippling economic sanctions.	0	1	AI
8752	Despite our Administration's best efforts, we are still incapable of ____.	0	1	AI
8753	Technology improves every day. One day soon, surfing the web will be replaced by ____.	0	1	AI
8754	Choosy Moms Choose ____.	0	1	AI
8755	At camp, we'd scare each other by telling stories about ____ around the fire.	0	1	AI
5037	____? Oh murr.	0	1	Furry
5106	Why are you making chocolate pudding at 4 in the morning?	0	1	Vidya
5107	The newest feature of the Xbox One is ____.	0	1	Vidya
5108	PS3: It only does  ____.	0	1	Vidya
5109	The new TF2 promo items are based on ____.	0	1	Vidya
5110	If Gordon Freeman spoke, what would he talk about?	0	1	Vidya
5111	&gt;tfw when ____.	0	1	Vidya
5112	All you had to do was follow the damn ____, CJ!	0	1	Vidya
5113	Liquid! How can you still be alive?	0	1	Vidya
5114	What can change the nature of a man?	0	1	Vidya
5115	 Microsoft revealed that the Xbox One's demos had actually been running on ____ 	0	1	Vidya
5116	What if ____ was a girl?	0	1	Vidya
5117	What did I preorder at gamestop?	0	1	Vidya
5118	____ confirmed for Super Smash Bros!	0	1	Vidya
5119	Based ____.	0	1	Vidya
5120	The newest IP from Nintendo, Super ____ Bros. 	0	1	Vidya
5121	____ only, no items, Final Destination. 	0	1	Vidya
5122	Enjoy ____ while you play your Xbox one!	0	1	Vidya
5123	The future of gaming lies with the ____.	0	1	Vidya
5124	The best way to be comfy when playing video games is with ____.	0	1	Vidya
5125	____ has no games.	0	1	Vidya
5126	PC gamers have made a petition to get ____ on their platform.	0	1	Vidya
5127	The new Nintendo ____ is a big gimmick. 	0	1	Vidya
5128	&gt;implying you aren't ____	0	1	Vidya
5129	WHAT IS A MAN?	0	1	Vidya
5130	What is a ___ but a ____?	0	2	Vidya
5131	WE WILL DRAG THIS ___ INTO THE 21ST CENTURY.	0	1	Vidya
5132	Wake up, Mr. Freeman. Wake up and ____.	0	1	Vidya
5133	All your ____ are belong to us	0	1	Vidya
5134	I'm in ur base, ____	0	1	Vidya
5135	Pop Quiz: Beatles Song- ___ terday.	0	1	Vidya
5136	 ___ would like to play.	0	1	Vidya
5137	A mod of doom was made that was based off of ____.	0	1	Vidya
5138	I really didn't like what they did with the ____ Movie adaption.	0	1	Vidya
5139	"HEY, GOLLEN PALACE? HOW U SAY ____ IN CHINESE?"	0	1	Vidya
5140	Pumpkin doesn't want this.	0	1	Vidya
5141	NEXT TIME ON GAME GRUMPS: ____.	0	1	Vidya
5142	I used to be an adventurer like you, until ____.	0	1	Vidya
5143	Yeah, well, my dad works for ____.	0	1	Vidya
5144	Kotaku addresses sexism in ____ in their latest article.	0	1	Vidya
5145	Get double XP for Halo 3 with purchase of ____.	0	1	Vidya
5146	Sorry Mario, but ____ is in another castle.	0	1	Vidya
5147	LoL stole their new character design off of ____.	0	1	Vidya
5148	____ is the cancer killing video games.	0	1	Vidya
5149	Suffer, like ____ did.	0	1	Vidya
5150	The ____ is a lie.	0	1	Vidya
5151	It's like ____ with guns!	0	1	Vidya
5152	Is a man not entitiled to ____?	0	1	Vidya
5153	____ has changed.	0	1	Vidya
5154	But you can call me ____ the ____. Has a nice ring to it dontcha think?	0	1	Vidya
5155	Objective: ____	0	1	Vidya
5156	EA Sports! It's ____.	0	1	Vidya
5157	____ is waiting for your challenge!	0	1	Vidya
5158	____ sappin' my sentry. 	0	1	Vidya
5159	I'm here to ____ and chew bubble gum, and I'm all out of gum.	0	1	Vidya
5160	I've covered ____, you know.	0	1	Vidya
5161	It's dangerous to go alone! Take this:	0	1	Vidya
5162	You were almost a ____ sandwich!	0	1	Vidya
5163	That's the second biggest ____ I've ever seen!	0	1	Vidya
5164	____. ____ never changes.	0	1	Vidya
5165	____ has changed. 	0	1	Vidya
5166	You have been banned. Reason: ____.	0	1	Vidya
5167	The newest trope against women in video games: ____.	0	1	Vidya
5168	Fans started a kickstarter for a new ____ game. 	0	1	Vidya
5169	Huh? What was that noise?	0	1	Vidya
5170	Viral marketers are trying to push the new ____.	0	1	Vidya
5171	I wouldn't call it a Battlestation, more like a ____.	0	1	Vidya
5172	____: Gotta go fast!	0	1	Vidya
5173	The best final fantasy game was ____.	0	1	Vidya
5174	I love the ____, it's so bad	0	1	Vidya
5175	Valve is going to make ____ 2 before they release HL3.	0	1	Vidya
5176	____ is a pretty cool guy	0	1	Vidya
5177	Ah! Your rival! What was his name again?	0	1	Vidya
5178	What's in the box, /v/?	0	1	Vidya
5179	Why is the ____ fandom the worst?	0	1	Vidya
5180	Achievement Unlocked: ____ !	0	1	Vidya
5181	I'm ____ under the table right now!	0	1	Vidya
5182	brb guys, ____ break	0	1	Vidya
5183	OH MY GOD JC, A ____	0	1	Vidya
5184	wooooooow, it took all 3 of you to ____	0	1	Vidya
5185	Rev up those ____, because I am sure hungry for one- HELP! HELP!	0	1	Vidya
5186	____ is 2deep and edgy for you.	0	1	Vidya
5187	Only casuals like ____.	0	1	Vidya
5188	The princess is in another ____	0	1	Vidya
5189	I have the bigger ____.	0	1	Vidya
5190	____ TEAM RULES!!	0	1	Vidya
5191	When you see it... you don't see ____.	0	1	Vidya
5192	HEY, GOLLEN PALACE? HOW U SAY ____ IN CHINESE?	0	1	Vidya
5193	WHAT THE FUCK DID YOU SAY ABOUT ME YOU ____?	0	1	Vidya
5194	This will be the 6th time we've posted ____; we've become increasingly efficient at it.	0	1	Vidya
5195	appealing to a larger audience	0	1	Vidya
5196	we must embrace ____ and burn it as fuel for out journey.	0	1	Vidya
5197	In Kingdom Hearts, Donald Duck will be replaced with ____ .	0	1	Vidya
5198	&gt;walk into gamestop<br>&gt;see ____<br>&gt;walk out	0	1	Vidya
5199	Because of the lastest school shooting, ____ is being blamed for making kids too violent.	0	1	Vidya
5200	Here lies ____: peperony and chease	0	1	Vidya
5201	Throwaway round: Get rid of those shit cards you don't want. Thanks for all the suggestions, /v/	0	1	Vidya
5202	The president has been kidnapped by ____. Are you a bad enough dude to rescue the president?	0	1	Vidya
5203	We ____ now.	0	1	Vidya
5204	What is the new mustard paste?	0	1	Vidya
5205	&gt;____<br>&gt;____<br>&gt;2011<br>&gt;ISHYGDDT	0	2	Vidya
5206	All you had to do was ____ the damn ____!	0	2	Vidya
5207	The new ititeration in the Call of Duty franchise has players fighting off ____ deep in the jungles of ____ 	0	2	Vidya
5208	Check your privilege, you ____ ____.	0	2	Vidya
5209	Jill, here's a ____. It might come in handy if you, the master of ____, take it with you. 	0	2	Vidya
5210	____ is a pretty cool guy, eh ____ and doesn't afraid of anything.	0	2	Vidya
5211	Ironic ____ is still ____.	0	2	Vidya
5212	It's like ____with ____!	0	2	Vidya
5057	I never thought I'd be comfortable with ____, but now it's pretty much the only thing I masturbate to.	0	1	Furry
5058	My next fursuit will have ____.	0	1	Furry
5059	I'm writing a porn comic about ____ and ____. 	0	2	Furry
5060	I tell everyone that I make my money off "illustration," when really, I just draw ____.	0	1	Furry
5061	Oh, you're an artist? Could you draw ____ for me?	0	1	Furry
5062	Everyone thinks they're so great, but the only thing they're good at drawing is ____.	0	1	Furry
5063	They're just going to spend all that money on ____.	0	1	Furry
5064	While everyone else seems to have a deep, instinctual fear of ____, it just turns me on.	0	1	Furry
5065	Lying about having ____ to get donations, which you spend on ____.	0	2	Furry
5066	It's not bestiality, it's ____.	0	1	Furry
5067	Everyone thinks that because I'm a furry, I'm into ____. Unfortunately, they're right.	0	1	Furry
5068	I'm only gay for ____.	0	1	Furry
5069	Excuse you, I'm a were-____.	0	1	Furry
5070	If you like it, then you should put ____ on it.	0	1	Furry
5071	My girlfriend won't let me do ____.	0	1	Furry
5072	The most pleasant surprise I've had this year.	0	1	Furry
5073	I knew I had a problem when I had to sell ____ to pay for ____.	0	2	Furry
5074	I'm about 50% ____.	0	1	Furry
5075	____: Horrible tragedy, or sexual opportunity?	0	1	Furry
5076	It's a little worrying that I have to compare the size of ____ to beverage containers.	0	1	Furry
5077	Hey, you guys wanna come back to my place? I've got ____ and ____.	0	2	Furry
5078	Jizzing all over ____.	0	1	Furry
5079	It's just that much creepier when 40-year-old men are into ____.	0	1	Furry
5080	____ is no substitute for social skills, but it's a start.	0	1	Furry
5081	The real reason I got into the fandom? ____.	0	1	Furry
5082	____ are definitely the new huskies.	0	1	Furry
5083	I remember when ____ was just getting started.	0	1	Furry
5084	When no one else is around, sometimes I consider doing things with ____.	0	1	Furry
5085	Actually coming inside ____.	0	1	Furry
5086	I don't know how we got on the subject of dragon cocks, but it probably started with ____.	0	1	Furry
5087	____ is a shining example of what those with autism can really do.	0	1	Furry
5088	It is my dream to be covered with ____.	0	1	Furry
5089	____ fucking ____. Now that's hot.	0	2	Furry
5090	Would you rather suck ____, or get dicked by ____?	0	2	Furry
5091	It never fails to liven up the workplace when you ask your coworkers if they'd rather have sex with ____ or ____.	0	2	Furry
5092	HELLO FURRIEND, HOWL ARE YOU DOING?	0	1	Furry
5093	What are the two worst cards in your hand right now?	0	2	Furry
5094	Nobody believes me when I tell that one story about walking in on ____.	0	1	Furry
5095	You don't know who ____ is? They're the one that draws ____.	0	2	Furry
5104	You sometimes wish you'd encounter ____ while all alone, in the woods. With a bottle of lube.	0	1	Furry
5105	I used to avoid talking about ____, but now it's just a part of normal conversation with my friends.	0	1	Furry
8377	____ didn't make it onto the first AT4W DVD.	0	1	TGWTG
8378	____ is part of the WTFIWWY wheelhouse.	0	1	TGWTG
8379	____ is the subject of the Critic's newest review.	0	1	TGWTG
8380	____ is the subject of the missing short from The Uncanny Valley.	0	1	TGWTG
8381	____ needs more gay.	0	1	TGWTG
8382	____ will be Linkara's next cosplay.	0	1	TGWTG
8383	____ wound up in this week's top WTFIWWY story.	0	1	TGWTG
8384	After getting snowed in at MAGfest, the reviewers were stuck with ____.	0	1	TGWTG
8385	ALL OF ____.	0	1	TGWTG
8386	An intervention was staged for Linkara after ____ was discovered in his hat.	0	1	TGWTG
8387	As a way of apologizing for a poorly received episode, E Rod promised to review ____.	0	1	TGWTG
8388	Being done with My Little Pony, 8-Bit Mickey has moved onto ____.	0	1	TGWTG
8389	Birdemic 3: ____	0	1	TGWTG
8390	E Rod has a new dance move called ____.	0	1	TGWTG
8391	Even Kyle thinks ____ is pretentious.	0	1	TGWTG
8392	Florida's new crazy is about ____.	0	1	TGWTG
8393	Hello, I'm a ____.	0	1	TGWTG
8394	Here There Be ____.	0	1	TGWTG
8395	Hey kids, I'm Nash, and I couldn't make ____ up if I tried.	0	1	TGWTG
8396	Hey Nash, whatcha playin'?	0	1	TGWTG
8397	How is Bennett going to creep out Ask That Guy this time? 	0	1	TGWTG
8398	In his most recent Avatar vlog, Doug's favorite thing about the episode was ____.	0	1	TGWTG
8399	In the newest Cheap Damage, CR looks at the trading card game version of ____.	0	1	TGWTG
8400	IT'S NOT ____!	0	1	TGWTG
8401	It's not nudity if there's ____.	0	1	TGWTG
8402	Leon Thomas almost named his show Renegade ____.	0	1	TGWTG
8403	Linkara was shocked when he found out Insano was secretly ____.	0	1	TGWTG
8404	Linkara's Yu-Gi-Oh deck is built up with nothing but ____.	0	1	TGWTG
8405	Luke Mochrie proved he was still part of the site by____.	0	1	TGWTG
8406	MikeJ's next sexual conquest is ____.	0	1	TGWTG
8407	Nash had a long day at work, so tonight he'll stream ____.	0	1	TGWTG
8408	Nash rejected yet another RDA request for ____.	0	1	TGWTG
8409	Nash's recent rant about Microsoft led to ____.	0	1	TGWTG
8410	Nash's Reviewer Spotlight featured ____.	0	1	TGWTG
8411	New rule in the RDA Drinking Game:  Every time ____ happens, take a shot!	0	1	TGWTG
8412	On the next WTFIWWY, Nash will give us a brief history of ____.	0	1	TGWTG
8413	The best Bad Movie Beatdown sketch is where Film Brain ropes Lordhebe into ____.	0	1	TGWTG
8414	The controversy over ad-blocking could be easily solved by ____.	0	1	TGWTG
8415	The easiest way to counteract a DMCA takedown notice is with ____.	0	1	TGWTG
8416	The last time Welshy and Film Brain were in a room together, they ended up ____.	0	1	TGWTG
8417	The new site that will overtake TGWTG is ____.	0	1	TGWTG
8418	The newest Rap Libs makes extensive use of the phrase "____."	0	1	TGWTG
8419	The theme of this week's WTFIWWY is ____.	0	1	TGWTG
8420	This week, Nash's beer is made with ____.	0	1	TGWTG
8421	What did Doug bring to the set of To Boldly Flee?	0	1	TGWTG
8422	What does Ven have to do now?	0	1	TGWTG
8423	What hot, trendy new dance will feature in Paw's next Dance Spectacular?	0	1	TGWTG
8424	What is hidden in Linkara's hat?	0	1	TGWTG
8425	What is literally the only thing tastier than a dragon's soul?	0	1	TGWTG
8426	What is Snowflame's only known weakness?	0	1	TGWTG
8427	What is the name of the next new Channel Awesome contributor?	0	1	TGWTG
8428	What killed Harvey Finevoice's son?	0	1	TGWTG
8429	What made Dodger ban someone from the RDA chat this week?	0	1	TGWTG
8430	What new upgrade did Nash give Laura?	0	1	TGWTG
8431	What was the first sign that Linkara was turning evil?	0	1	TGWTG
8432	What will Nash try to kill next with his hammer?	0	1	TGWTG
8433	When Arlo The Orc turns into a werewolf, he likes to snack on ____.	0	1	TGWTG
8434	When interviewing Linkara, be sure to ask him about ____!	0	1	TGWTG
8435	When not reviewing or ruling Haganistan with an iron fist, Hagan's hobby is ____.	0	1	TGWTG
8436	Who REALLY called Oancitizen to help him snap out of his ennui?	0	1	TGWTG
8437	Whose ass did Zodann kick this time?	0	1	TGWTG
8438	Why did Nash go to Chicago?	0	1	TGWTG
8439	Why doesn't Doug ever attend MAGFest?	0	1	TGWTG
8440	Why doesn't Film Brain have an actual reviewer costume?	0	1	TGWTG
8441	The MAGFest Nerf War took a dark turn when ____ was waylaid by ____.	0	2	TGWTG
8442	For a late night snack, Nash made a sandwich of ____ and ____.	0	2	TGWTG
8443	The next TGWTG porn spoof?  ____ with ____!	0	2	TGWTG
8444	Putting ____ in ____? That doesn't go there!	0	2	TGWTG
8445	In trying to ban ____, Florida accidentally banned ____.	0	2	TGWTG
8446	If ____ got to direct an Uncanny Valley short, it would have featured ____.	0	2	TGWTG
8447	At ConBravo, ____ will be hosting a panel on ____.	0	2	TGWTG
8448	At MAGFest, ____ will host a panel focusing on ____.	0	2	TGWTG
8449	"Greetings, dear listeners.  Won't you join ____ for ____?"	0	2	TGWTG
8450	Sad Panda is actually ____ and  ____.	0	2	TGWTG
8451	I'm going to die watching ____ review ____.	0	2	TGWTG
8452	In a new latest announcement video, ____ has announced an appearance at ____.	0	2	TGWTG
8453	After ____, Phelous regenerated into ____. 	0	2	TGWTG
8454	____ and ____ would make awesome siblings.	0	2	TGWTG
8455	Some fangirls lay awake all night thinking of ____ and ____ together.	0	2	TGWTG
8456	In my new show, I review ____ while dressed like ____.	0	2	TGWTG
8457	Luke's newest character is ____, the Inner ____.	0	2	TGWTG
8458	Good evening! I am ____ of  ____.	0	2	TGWTG
8459	____ is the reason that ____ picked "AIDS."	0	2	TGWTG
8460	Nash's newest made-up curse word is ____-____-____! 	2	3	TGWTG
8461	Using alchemy, combine ____ and ____ to make ____! 	2	3	TGWTG
8462	Write Linkara's next storyline as a haiku.	2	3	TGWTG
8463	Nash will build his next contraption with just ____, ____, and ____.	2	3	TGWTG
8464	 ____  did ____ to avoid ____.	2	3	TGWTG
8465	Make a WTFIWWY story.	2	3	TGWTG
8466	Dang it, ____!	0	1	NL
8467	____ was full of leeches.	0	1	NL
8468	Pimp your ___!	0	1	NL
8469	My apologies to the ____ estate.	0	1	NL
8470	What interrupted the #NLSS?	0	1	NL
8471	Travel by ____.	0	1	NL
8472	The stream broke when Ryuka stepped on the ____ key.	0	1	NL
8473	Say that to my face one more time and I'll start ____.	0	1	NL
8474	Oh my god, he's using ____ magic!	0	1	NL
8475	Krazy Mike lost to ____!	0	1	NL
8476	What would you do if Ohm really did just die?	0	1	NL
8477	____ has invaded!	0	1	NL
8478	We're having technical difficulties due to ____.	0	1	NL
8479	JSmithOTI is referred to as a Scumlord, but his friends call him ____.	0	1	NL
8480	Ohmwrecker is known for his MLG online play. What people don't know is that he's also MLG at ____.	0	1	NL
8481	Follow MichaelALFox on Twitter and you can see pictures of ____.	0	1	NL
8482	After Mars, ____ is the next furthest planet from the sun.	0	1	NL
8483	What would Ohm do?	0	1	NL
8484	The next movie reading will be of ____.	0	1	NL
8485	How did Northernlion unite Scotland?	0	1	NL
8486	Green loves the new Paranautical Activity item ____, but keeps comparing it to the crossbow.	0	1	NL
8487	____ is really essential to completing the game.	0	1	NL
8488	My channel is youtube.com/____.	0	1	NL
8489	Northernlion's cat Ryuka is known for ____ while he records.	0	1	NL
8490	What gave Ohmwrecker his gaming powers?	0	1	NL
8491	Hello anybody, I am ____Patrol.	0	1	NL
8492	I have ____, can you ____ me?	0	2	NL
8493	____! Get off the ____!	0	2	NL
8494	My name is ____ and today we'll be checking out ____.	0	2	NL
8495	It's true that Green9090 is ____, but we must all admit that Ohm is better at ____	0	2	NL
8496	That's the way ____ did it, that's the way ____ does it, and it''s worked out pretty well so far.	0	2	NL
8497	Today on Crusader Kings 2, NL plays King ____ the ____.	0	2	NL
8498	After winning yet another race, Josh made ____ tweet about ____.	0	2	NL
8499	This time on ____ vs. ____, we're playing ____.	2	3	NL
8500	Welcome back to ____.	0	1	GG
8501	Welcome to Sonic Team! We make ____, I think!	0	1	GG
8502	What am I willing to put up with today?	0	1	GG
8503	What can be found in Arin's chins?	0	1	GG
8504	What do Mumbo's magic words mean?	0	1	GG
8505	What is the boopinest shit?	0	1	GG
8506	WHAT THE FUCK IS A ____?!	0	1	GG
8507	What's better than Skyward Sword?	0	1	GG
8508	What's the real reason Jon left?	0	1	GG
8509	When I look in the mirror I see ____.	0	1	GG
8510	Who replaced Jon when he left GameGrumps?	0	1	GG
8511	Who's an asshole?	0	1	GG
8512	Why is Steam Train so controversial?	0	1	GG
8513	WOOP WOOP WOOP I'M A ____!	0	1	GG
8514	You know what fan mail makes me the happiest every time I see it? It's the ones where people are like, "____." 	0	1	GG
8515	You're ruining my integrity! ____ won't hire me now!	0	1	GG
8516	I've been ____ again!	0	1	GG
8517	Rolling around at the speed of ____!	0	1	GG
8518	This time on Guest Grumps, we have ____.	0	1	GG
8519	Top five games, go! 1? Mega Man X. 2-5? ____.	0	1	GG
8520	Use your ____!	0	1	GG
8521	Look at this guy, he's like ____.	0	1	GG
8522	Look, it's ____!	0	1	GG
8523	Next time on Game Grumps, ____!	0	1	GG
8524	Nightshade: The Claws of ____.	0	1	GG
8525	Number one! With a bullet! Zoom in on the ____!	0	1	GG
8526	Oh, it's ____!	0	1	GG
8527	One slice of ____ please.	0	1	GG
8528	Pikachu, use your ____ attack!	0	1	GG
8529	Put a hole in that ____!	0	1	GG
8530	Real talk? ____.	0	1	GG
8531	Jon's mom called him to tell him about ____.	0	1	GG
8532	Kirby has two iconic abilities: suck and ____.	0	1	GG
8533	Listen to the ____ on this shit.	0	1	GG
8534	Jon believes that the most important part of any video game is ____.	0	1	GG
8535	Jon can't get enough of ____.	0	1	GG
8536	Jon can't survive air travel without ____.	0	1	GG
8537	Jon just wants to touch ____.	0	1	GG
8538	Is there anything to gain from this?	0	1	GG
8539	It's no use! Take ____!	0	1	GG
8540	Jon and Arin suck at ____.	0	1	GG
8541	Jon and Arin win! They realize ____ is more important.	0	1	GG
8542	If the ____ wasn't there, I would do. But it's there, so it's not.	0	1	GG
8543	How many ____ does Mega Man get?	0	1	GG
8544	How many nose hairs does ____ have?	0	1	GG
8545	I certainly can't do it without you, and I know you can't do it without ____!	0	1	GG
8546	I tell you once, I tell you twice! ____ is good for economy!	0	1	GG
8547	I wanna put my ____ in her!	0	1	GG
8548	I'm not even SELLING ____!	0	1	GG
8549	Do you remember the episode where Ash caught a ____?	0	1	GG
8550	Don't throw ____! It's expensive to somebody!	0	1	GG
8551	Dude, real talk? ____.	0	1	GG
8552	Eat your ____, son.	0	1	GG
8553	Egoraptor's fiancee is actually a ____.	0	1	GG
8554	Everybody wants to know about me, but they don't know about my ____.	0	1	GG
8555	Fool me once, I'm mad. Fool me twice? How could you. Fool me three times, you're officially ____.	0	1	GG
8556	For my first attack, I will juggle ____ to impress you.	0	1	GG
8557	Fuck, I found a ____.	0	1	GG
8558	Game Grumps: sponsored by ____.	0	1	GG
8559	Give ____ a chance! He'll grow on you!	0	1	GG
8560	____? Ten-outta-ten!	0	1	GG
8561	____. I AAAAAAIN’T HAVIN’ THAT SHIT!	0	1	GG
8562	____. It's no use!	0	1	GG
8563	____. MILLIONS ARE DEAD!!!	0	1	GG
8564	____. Put that in, Barry.	0	1	GG
8565	____. This is like one of my Japanese animes!	0	1	GG
8566	...What the bloody hell are you two talking about?!	0	1	GG
8567	"These new ____ t-shirts are gonna change some lives, Arin."	0	1	GG
8568	"You want cheese pizza?" "No. ____."	0	1	GG
8569	And then, as a fuckin' goof, I'd put a hole in ____.	0	1	GG
8570	And there it was...Kirby had finally met the ____ of the lost city.	0	1	GG
8571	Arin believes that the most important part of any video game is ____.	0	1	GG
8572	Arin has an adverse reaction to ____.	0	1	GG
8573	Barry entertains himself by watching old episodes of ____.	0	1	GG
8574	Barry, add ____ into the video!	0	1	GG
8575	Barry, we need a replay on ____.	0	1	GG
8576	BARRY! SHOW ____ AGAIN!	0	1	GG
8577	Barry's sheer skill at ____ is unmatched.	0	1	GG
8578	I don't like the ____ flavor.	0	1	GG
8579	____ don't even cost this less!	0	1	GG
8580	____ Grumps!	0	1	GG
8581	____ has aged really well.	0	1	GG
8582	____ is GREAT GREAT GREAT!	0	1	GG
8583	____ is Jon's favorite video game of all time.	0	1	GG
8584	____ is not Jon's strong suit.	0	1	GG
8585	____ Train!	0	1	GG
8586	____ WINS!	0	1	GG
8587	____: Better than deer shit!	0	1	GG
8588	Welcome back to ____ ____!	0	2	GG
8589	Real talk? Is that ____ ____?	0	2	GG
8590	Look at that ____-ass ____!	0	2	GG
8591	JON'S ____, SHOW US YOUR ____.	0	2	GG
8592	The Grumps' latest silly player names are ____ and ____.	0	2	GG
8593	If you don't know what ____ is, you can't go to ____.	0	2	GG
8594	In this corner, ____; in the other corner, ____; it's Game Grumps VS!	0	2	GG
8595	IF I CAN'T BE ____, I SURE AS HELL CAN BE ____!!	0	2	GG
8596	COME ON AND ____, AND WELCOME TO THE ____!	0	2	GG
8597	If ____ evolved from ____, why the fuck is there still ____, dude?!	2	3	GG
8598	____? Pretty smart. ____? Pretty fuckin' smart. ____? FUCKING GENIUS!!!!	2	3	GG
8599	____ is probably a Venusaur kind of guy.	0	1	RT
8600	____ is the greatest Canadian.	0	1	RT
8601	____ is the worst on the Podcast.	0	1	RT
8602	____. That's top.	0	1	RT
8603	After getting wasted at PAX, Burnie announced that "I am ____!"	0	1	RT
8604	Barbara sucks ____.	0	1	RT
8605	Close up of my ____.	0	1	RT
8606	Come to Fort ____!	0	1	RT
8607	Describe yourself in one word/phrase.	0	1	RT
8608	Detective ____ is down!	0	1	RT
8609	Does our house say "We love ____?"	0	1	RT
8610	Dude, I got sixteen ____!	0	1	RT
8611	Fight, fight, fight, ____?	0	1	RT
8612	Fuck it, I mean ____, right?	0	1	RT
8613	I'ma smother you in my ____!	0	1	RT
8614	If Jack was frog and you kissed him, what would he turn into?	0	1	RT
8615	If you could fuck anyone in the world, who would you choose?	0	1	RT
8616	If you could have any superpower, what would it be?	0	1	RT
8617	If you were allowed to do one illegal thing, what would it be? 	0	1	RT
8618	It's a ____ out there.	0	1	RT
8619	It's not my fault. Somebody put ____ in my way.	0	1	RT
8620	Joel plays ____.	0	1	RT
8621	Let's do ____ again! This is fun!	0	1	RT
8622	Lindsay could fuck up ____.	0	1	RT
8623	LLLLLLLLLLLLLET'S ____!	0	1	RT
8624	My ____ is trying to die.	0	1	RT
8625	On tonight's Let's Play, the AH crew plays ____.	0	1	RT
8626	People like ____.	0	1	RT
8627	RT Recap, featuring ____!	0	1	RT
8628	Shout out to ____!	0	1	RT
8629	Shout out to my mom. Called my Teddy Bear ____.	0	1	RT
8630	So, I was just walking along, until suddenly ____ came along and attacked me.	0	1	RT
8631	Thanks to ____ for this week's theme song.	0	1	RT
8632	The next RvB cameo will be voiced by ____.	0	1	RT
8633	They questioned Ryan's sanity after finding ____ in his house.	0	1	RT
8634	This week on AHWU, ____.	0	1	RT
8635	This week on Immersion, we are going to test ____.	0	1	RT
8636	What are fire hydrants called in England?	0	1	RT
8637	What does Ryan's kid listen to?	0	1	RT
8638	What is Game Night?	0	1	RT
8639	What is the meaning of life?	0	1	RT
8640	What is the saddest thing you've ever seen?	0	1	RT
8641	What is the worst thing anyone could say in front of the police?	0	1	RT
8642	What is your biggest feature?	0	1	RT
8643	What is your favorite book?	0	1	RT
8644	What is your mating call?	0	1	RT
8645	What makes Caboose angry?	0	1	RT
8646	What makes Michael the angriest?	0	1	RT
8647	What mysteries lie beyond Jack's beard? 	0	1	RT
8648	What would be your chosen catchphrase?	0	1	RT
8649	What's in Gavin's desk?	0	1	RT
8650	Where are we going for lunch?	0	1	RT
8651	Where does Ray belong?	0	1	RT
8652	Who has a fake Internet girlfriend?	0	1	RT
8654	Why are we here?	0	1	RT
8655	Why is Geoff cool?	0	1	RT
8656	Why was Michael screaming at Gavin?	0	1	RT
8657	Would you guys still like me if my name was ____?	0	1	RT
8658	You threw it against the wall like a ____!	0	1	RT
8659	____ is ____ as dicks.	0	2	RT
8660	____ is the best ____ ever. Of all time.	0	2	RT
8661	____ wins! ____ is a horse!	0	2	RT
8662	If you got $1,000,000 per week, would you ____, but in the next day, you'd have to ____?	0	2	RT
8663	My name is ____, and I hate ____!	0	2	RT
8664	No one in the office expected the bromance between ____ and ____.	0	2	RT
8665	Select two cards to create your team name.	0	2	RT
8666	This week on VS, ____ challenges ____ to a game of ____.	2	3	RT
8667	The war's over. We're holding a parade in ____'s honor. ____ drives the float, and ____ is in charge of confetti.	2	3	RT
8668	What's a paladin?	0	1	DAH
8669	One of these days i'm just gonna shit my ____.	0	1	DAH
8670	You need to ____ your asshole, it's vital to this operation.	0	1	DAH
8671	I'm sorry Timmy, but I must ____ you.	0	1	DAH
8672	It took hours to edit ____ into the video.	0	1	DAH
8673	In this week's gauntlet, Tehsmarty challenges ChilledChaos to ____.	0	1	DAH
8674	In this week's gauntlet, ChilledChaos challenges Tehsmarty to ____.	0	1	DAH
8675	I AM THE ____ CZAR!!!	0	1	DAH
8676	ZeRoyalViking's up and coming game company, "ZEA" accredits their success to ____.	0	1	DAH
8677	Tehsmarty loves the smell of ____ in the morning.	0	1	DAH
8678	The Creatures' next member is ____.	0	1	DAH
8679	Come on and slam, and welcome to the ____.	0	1	DAH
8680	____, the one you want to get DDoS'd	0	1	DAH
8653	Why are there six ____ when there are only four ____?	0	2	RT
8682	GaLmHD is so pro at almost every game he plays yet he can`t play____!	0	1	DAH
8683	Smarty's darkest fear is ____.	0	1	DAH
8684	Pewdiepie's going to play ____!?	0	1	DAH
8685	And here we have ____. Strike it's weakness for MASSIVE damage!	0	1	DAH
8686	But Beardman! Why do you think that ____?	0	1	DAH
8687	In the next episode of Press Heart to Continue: Dodger talks about ____.	0	1	DAH
8688	What did Criken do this time to break ARMA III? 	0	1	DAH
8689	What was the big prize this time around at the Thrown Controllers panel?	0	1	DAH
8690	What did Mitch or Bajan Canadian find in the fridge today?	0	1	DAH
8691	In ____ We Trust.	0	1	DAH
8692	When Sp00n finally removed his horsemask on the livestream, we saw ____.	0	1	DAH
8693	I give this game a rating of ____.	0	1	DAH
8694	What did Pewdiepie overreact to on his channel today?	0	1	DAH
8695	This time on Brutalmoose's Top 10, his guest was ____.	0	1	DAH
8696	Only Totalbiscuit would spend an hour long video discussing ____.	0	1	DAH
8697	Last Thursday, Riorach was identified in public and she proceeded to ____.	0	1	DAH
8698	On this episode of PKA Woody and Wings talk about ____.	0	1	DAH
8699	Bro's Angels. We ____ hard.	0	1	DAH
8700	TotalBiscuit's top hat is actually ____. 	0	1	DAH
8701	GTA shenanigans would not be GTA shenanigans without Seananners dropping ____ on ____.	0	2	DAH
8702	Knowing Chilled's knowledge with Minecraft, he'll probably use ____ on ____ in his next video.	0	2	DAH
8703	The Xbox One's DRM policy isn't half as bad as ____.	0	2	DAH
8704	In today's Driftor in-depth episode we shall look at ____.	0	2	DAH
8705	What will YouTube add in its next unneeded update?	0	2	DAH
8706	Two Best Friends Play ____.	0	2	DAH
8707	Oh great, ____ is doing another ____ game LP.	0	2	DAH
8708	In his new Co-op work SSoHPKC will be playing ____ with ____.	0	2	DAH
8709	My name is-a ____ and i likea da ____.	0	2	DAH
\.


--
-- TOC entry 1946 (class 0 OID 0)
-- Dependencies: 162
-- Name: black_cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cah
--

SELECT pg_catalog.setval('black_cards_id_seq', 8755, true);


--
-- TOC entry 1930 (class 0 OID 16395)
-- Dependencies: 163
-- Data for Name: card_set; Type: TABLE DATA; Schema: public; Owner: cah
--

COPY card_set (id, active, name, base_deck, description, weight) FROM stdin;
1151	t	First Version	t	The original version of the Cards Against Humanity base game.	1
1152	t	Second Version	t	The updated version of the Cards Against Humanity base game.	2
100211	t	Third Version	t	Another updated version of the Cards Against Humanity base game.	3
1155	t	The First Expansion	f	The official First Expansion.	10
1256	t	The Second Expansion	f	The official Second Expansion.	11
1153	t	Canadian	f	Cards included in Canadian orders.	20
1154	t	Misprint Replacement Bonus Cards	f	Bonus cards included with replacements for misprinted cards.	21
1488	t	2012 Holiday Pack	f	The 2012 Holiday Pack.	22
100154	t	The Third Expansion	f	The official Third Expansion.	12
100051	t	PAX East 2013 Pack &quot;C&quot;	f	PAX East 2013 Pack &quot;C&quot;.	32
100049	t	PAX East 2013 Pack &quot;A&quot;	f	PAX East 2013 Pack &quot;A&quot;.	30
100050	t	PAX East 2013 Pack &quot;B&quot;	f	PAX East 2013 Pack &quot;B&quot;.	31
100001	t	[CUSTOM] r/MLPLounge	f	http://www.reddit.com/r/mlplounge/	500
100002	t	[CUSTOM] Very Serious	f	http://forum.verysrs.com/	501
100157	t	[CUSTOM] Northernlion	f	http://www.youtube.com/user/Northernlion	502
100161	t	[CUSTOM] That Guy With The Glasses	t	http://thatguywiththeglasses.com/	503
100160	t	[CUSTOM] Ridiculously Stupid	f		504
100003	t	[CUSTOM] Admin's Picks	f	Custom cards that I think are particularly fitting.	100
100017	t	[CUSTOM] SocialGamer	f	Custom cards from the SocialGamer.net community.	101
100219	t	[CUSTOM] Golby Fan Club	f		505
100224	t	[CUSTOM] Anime	t	http://www.desudesbrigade.com/	506
100233	t	[CUSTOM] Derps Against Humanity	f		520
100232	t	[CUSTOM] Rooster Teeth	f		519
100231	t	[CUSTOM] Game Grumps	f		518
100229	t	[CUSTOM] Vidya	f	by Sl0nderman	517
100228	t	[CUSTOM] Sodomy Dog's Furry Pack	f		516
100225	t	[CUSTOM] Mr. Man Collection	f		515
100234	f	[CUSTOM] Anime Expansion #1	f	http://www.desudesbrigade.com/	507
100236	f	[CUSTOM] Antisocial Injustice	f		521
\.


--
-- TOC entry 1931 (class 0 OID 16398)
-- Dependencies: 164
-- Data for Name: card_set_black_card; Type: TABLE DATA; Schema: public; Owner: cah
--

COPY card_set_black_card (card_set_id, black_card_id) FROM stdin;
1151	1
1151	2
1151	3
1151	4
1151	5
1151	6
1151	7
1151	8
1151	9
1151	10
1151	11
1151	12
1151	13
1151	14
1151	15
1151	17
1151	16
1151	19
1151	18
1151	21
1151	20
1151	23
1151	22
1151	25
1151	24
1151	27
1151	26
1151	29
1151	28
1151	31
1151	30
1151	34
1151	35
1151	32
1151	33
1151	38
1151	39
1151	36
1151	37
1151	42
1151	43
1151	40
1151	41
1151	46
1151	47
1151	44
1151	45
1151	51
1151	50
1151	49
1151	48
1151	55
1151	54
1151	53
1151	52
1151	59
1151	58
1151	57
1151	56
1151	63
1151	62
1151	61
1151	60
1151	68
1151	69
1151	70
1151	71
1151	64
1151	65
1151	66
1151	67
1151	76
1151	77
1151	78
1151	79
1151	72
1151	73
1151	74
1151	75
1151	85
1151	84
1151	87
1151	86
1151	81
1151	80
1151	83
1151	82
1151	89
1151	88
1151	90
1152	1
1152	2
1152	3
1152	4
1152	5
1152	6
1152	7
1152	8
1152	9
1152	10
1152	11
1152	12
1152	13
1152	14
1152	15
1152	17
1152	19
1152	18
1152	21
1152	20
1152	22
1152	25
1152	24
1152	26
1152	29
1152	28
1152	31
1152	30
1152	34
1152	35
1152	32
1152	33
1152	38
1152	39
1152	36
1152	42
1152	43
1152	40
1152	41
1152	46
1152	47
1152	44
1152	45
1152	51
1152	50
1152	49
1152	48
1152	53
1152	52
1152	59
1152	58
1152	57
1152	56
1152	63
1152	62
1152	61
1152	60
1152	68
1152	70
1152	71
1152	64
1152	65
1152	66
1152	67
1152	76
1152	77
1152	78
1152	79
1152	72
1152	73
1152	74
1152	75
1152	85
1152	84
1152	87
1152	86
1152	81
1152	80
1152	82
1152	93
1152	92
1152	95
1152	94
1152	89
1152	88
1152	91
1152	90
1152	98
1152	96
1152	97
1153	1005
1153	1004
1153	1007
1153	1006
1153	1008
1154	1032
1155	1064
1155	1058
1155	1059
1155	1056
1155	1057
1155	1062
1155	1063
1155	1060
1155	1061
1155	1049
1155	1048
1155	1051
1155	1050
1155	1053
1155	1052
1155	1055
1155	1054
1155	1045
1155	1047
1155	1046
1256	1157
1256	1156
1256	1159
1256	1158
1256	1161
1256	1160
1256	1163
1256	1162
1256	1165
1256	1164
1256	1167
1256	1166
1256	1168
1256	1169
1256	1170
1256	1171
1256	1172
1256	1173
1256	1174
1256	1175
1256	1176
1256	1177
1256	1178
1256	1179
1256	1180
1488	1457
1488	1458
1488	1459
1488	1460
1488	1461
1488	1462
1488	1463
100001	1375
100001	1374
100001	1373
100001	1372
100001	1371
100001	1370
100001	1369
100001	1366
100001	1365
100001	1363
100001	1361
100001	1359
100001	1356
100001	1354
100001	1355
100001	1352
100001	1353
100001	1350
100001	1347
100001	1345
100001	1262
100001	1260
100001	1257
100001	1270
100001	1268
100001	1267
100001	1264
100001	1265
100001	1279
100001	1277
100001	1376
100001	1377
100001	1275
100001	1378
100001	1273
100001	1306
100001	1305
100001	1311
100001	1309
100001	1297
100001	1303
100001	1301
100001	1291
100001	1289
100001	1295
100001	1292
100001	1283
100001	1281
100001	1287
100001	1285
100001	1329
100001	1330
100001	1321
100001	1323
100001	1325
100001	1327
100001	1313
100001	1315
100001	1317
100001	1319
100002	137
100002	136
100002	139
100002	138
100002	141
100002	140
100002	143
100002	142
100002	129
100002	128
100002	131
100002	130
100002	133
100002	132
100002	135
100002	134
100002	152
100002	153
100002	154
100002	155
100002	156
100002	157
100002	144
100002	145
100002	146
100002	147
100002	148
100002	149
100002	150
100002	151
100002	102
100002	103
100002	100
100002	101
100002	99
100002	110
100002	111
100002	108
100002	109
100002	106
100002	107
100002	104
100002	105
100002	119
100002	118
100002	117
100002	116
100002	115
100002	114
100002	113
100002	112
100002	127
100002	126
100002	125
100002	124
100002	123
100002	122
100002	121
100002	120
100003	137
100003	136
100003	139
100003	138
100003	140
100003	129
100003	128
100003	130
100003	133
100003	132
100003	135
100003	134
100003	152
100003	153
100003	1359
100003	154
100003	155
100003	156
100003	157
100003	144
100003	147
100003	149
100003	150
100003	151
100003	114
100003	127
100003	126
100003	124
100003	123
100003	122
100003	120
100017	100006
100017	100007
100017	100016
100049	100028
100049	100027
100050	100037
100050	100038
100051	100047
100051	100048
100154	100089
100154	100095
100154	100094
100154	100093
100154	100092
100154	100085
100154	100074
100154	100078
100154	100066
100154	100065
100154	100070
100154	100103
100154	100059
100154	100058
100154	100100
100154	100098
100154	100097
100154	100096
100154	100110
100154	100108
100154	100106
100154	100105
100154	100054
100154	100104
100154	100113
100017	100155
100003	100016
100003	100155
100003	100006
100157	158
100157	159
100157	171
100157	170
100157	169
100157	168
100157	175
100157	174
100157	173
100157	172
100157	163
100157	162
100157	161
100157	160
100157	167
100157	166
100157	165
100157	164
100157	186
100157	187
100157	184
100157	185
100157	190
100157	191
100157	188
100157	189
100157	178
100157	179
100157	176
100157	177
100157	182
100157	183
100157	180
100157	181
100157	205
100157	204
100157	207
100157	206
100157	201
100157	200
100157	203
100157	202
100157	197
100157	196
100157	199
100157	198
100157	193
100157	192
100157	195
100157	194
100157	220
100157	221
100157	222
100157	223
100157	216
100157	217
100157	218
100157	219
100157	212
100157	213
100157	214
100157	215
100157	208
100157	210
100157	211
100157	225
100157	224
100003	202
100003	192
100003	162
100003	165
100017	100159
100003	100159
100160	548
100160	549
100160	546
100160	547
100160	544
100160	545
100160	508
100160	516
100160	509
100160	517
100160	510
100160	518
100160	511
100160	519
100160	512
100160	504
100160	513
100160	505
100160	514
100160	506
100160	515
100160	507
100160	524
100160	525
100160	526
100160	527
100160	520
100160	226
100160	521
100160	522
100160	523
100160	533
100160	532
100160	535
100160	534
100160	529
100160	528
100160	531
100160	530
100160	541
100160	540
100160	543
100160	542
100160	537
100160	536
100160	539
100160	538
100003	168
100003	175
100003	513
100003	514
100003	525
100003	520
100003	521
100003	522
100003	528
100003	537
100003	536
100003	198
100003	194
100003	214
100003	510
100003	504
100003	226
100003	225
100003	224
100161	687
100161	686
100161	685
100161	684
100161	683
100161	682
100161	681
100161	680
100161	679
100161	678
100161	677
100161	676
100161	675
100161	674
100161	673
100161	672
100161	702
100161	703
100161	700
100161	701
100161	698
100161	699
100161	696
100161	697
100161	694
100161	695
100161	692
100161	693
100161	690
100161	691
100161	688
100161	689
100161	653
100161	655
100161	654
100161	668
100161	669
100161	670
100161	671
100161	664
100161	665
100161	666
100161	667
100161	660
100161	661
100161	662
100161	663
100161	656
100161	657
100161	658
100161	659
100161	747
100161	746
100161	745
100161	744
100161	751
100161	750
100161	749
100161	748
100161	739
100161	738
100161	737
100161	736
100161	743
100161	742
100161	741
100161	740
100161	754
100161	755
100161	752
100161	753
100161	713
100161	712
100161	715
100161	714
100161	717
100161	716
100161	719
100161	718
100161	705
100161	704
100161	707
100161	706
100161	709
100161	708
100161	711
100161	710
100161	728
100161	729
100161	730
100161	731
100161	732
100161	733
100161	734
100161	735
100161	720
100161	721
100161	722
100161	723
100161	724
100161	725
100161	726
100161	727
100003	687
100003	685
100003	678
100003	692
100003	660
100003	747
100003	712
100003	715
100161	756
100017	100163
100003	508
100017	100203
100211	100208
100211	100209
100211	100210
100211	100207
100211	100206
100211	1
100211	2
100211	3
100211	4
100211	6
100211	7
100211	8
100211	9
100211	78
100211	10
100211	79
100211	11
100211	12
100211	14
100211	15
100211	17
100211	19
100211	81
100211	21
100211	80
100211	20
100211	82
100211	22
100211	93
100211	25
100211	92
100211	24
100211	29
100211	28
100211	91
100211	31
100211	30
100211	34
100211	35
100211	32
100211	33
100211	38
100211	39
100211	36
100211	42
100211	43
100211	40
100211	41
100211	46
100211	47
100211	44
100211	45
100211	51
100211	50
100211	49
100211	53
100211	52
100211	59
100211	58
100211	57
100211	56
100211	63
100211	62
100211	61
100211	60
100211	1032
100211	68
100211	70
100211	64
100211	66
100211	67
100211	76
100211	77
100211	72
100211	73
100211	74
100211	75
100211	85
100211	84
100211	87
100211	86
100211	95
100211	94
100211	89
100211	88
100211	90
100211	98
100211	96
100211	97
100211	100217
100161	100218
100161	784
100161	774
100161	775
100161	772
100161	773
100161	771
100161	782
100161	783
100161	780
100161	781
100161	778
100161	779
100161	776
100161	777
100219	791
100219	790
100219	789
100219	788
100219	787
100219	786
100219	785
100219	799
100219	798
100219	797
100219	796
100219	795
100219	794
100219	793
100219	792
100219	800
100219	801
100219	802
100003	800
100003	792
100017	100223
100224	821
100224	820
100224	823
100224	822
100224	817
100224	816
100224	819
100224	818
100224	829
100224	828
100224	831
100224	830
100224	825
100224	824
100224	827
100224	826
100224	804
100224	805
100224	806
100224	807
100224	803
100224	812
100224	813
100224	814
100224	815
100224	808
100224	809
100224	810
100224	811
100224	881
100224	880
100224	883
100224	882
100224	885
100224	884
100224	887
100224	886
100224	889
100224	888
100224	891
100224	890
100224	893
100224	892
100224	895
100224	894
100224	864
100224	865
100224	866
100224	867
100224	868
100224	869
100224	870
100224	871
100224	872
100224	873
100224	874
100224	875
100224	876
100224	877
100224	878
100224	879
100224	851
100224	850
100224	849
100224	848
100224	855
100224	854
100224	853
100224	852
100224	859
100224	858
100224	857
100224	856
100224	863
100224	862
100224	861
100224	860
100224	834
100224	835
100224	832
100224	833
100224	838
100224	839
100224	836
100224	837
100224	842
100224	843
100224	840
100224	841
100224	846
100224	847
100224	844
100224	845
100224	926
100224	924
100224	925
100224	922
100224	923
100224	920
100224	921
100224	918
100224	919
100224	916
100224	917
100224	914
100224	915
100224	912
100224	913
100224	911
100224	910
100224	909
100224	908
100224	907
100224	906
100224	905
100224	904
100224	903
100224	902
100224	901
100224	900
100224	899
100224	898
100224	897
100224	896
100225	956
100225	957
100225	958
100225	959
100225	952
100225	953
100225	954
100225	955
100225	948
100225	949
100225	950
100225	951
100225	944
100225	945
100225	946
100225	947
100225	941
100225	940
100225	943
100225	942
100225	937
100225	936
100225	939
100225	938
100225	933
100225	932
100225	935
100225	934
100225	929
100225	928
100225	931
100225	930
100225	927
100225	963
100225	960
100225	100226
100225	100227
100003	821
100003	820
100003	823
100003	824
100003	803
100003	814
100003	815
100003	889
100003	890
100003	873
100003	875
100003	848
100003	855
100003	852
100003	838
100003	843
100003	846
100003	957
100003	958
100003	959
100003	954
100003	949
100003	950
100003	944
100003	946
100003	943
100003	942
100003	936
100003	939
100003	935
100003	929
100003	925
100003	906
100003	902
100003	901
100003	962
100003	961
100228	5023
100228	5022
100228	5021
100228	5020
100228	5019
100228	5018
100228	5017
100228	5016
100228	5015
100228	5014
100228	5013
100228	5012
100228	5011
100228	5010
100228	5009
100228	5008
100228	5006
100228	5007
100228	5004
100228	5005
100228	5002
100228	5003
100228	5001
100228	5053
100228	5052
100228	5055
100228	5054
100228	5049
100228	5048
100228	5051
100228	5050
100228	5045
100228	5044
100228	5047
100228	5046
100228	5041
100228	5040
100228	5043
100228	5042
100228	5036
100228	5037
100228	5038
100228	5039
100228	5032
100228	5033
100228	5034
100228	5035
100228	5028
100228	5029
100228	5030
100228	5031
100228	5024
100228	5025
100228	5026
100228	5027
100228	5083
100228	5082
100228	5081
100228	5080
100228	5087
100228	5086
100228	5085
100228	5084
100228	5075
100228	5074
100228	5073
100228	5072
100228	5079
100228	5078
100228	5077
100228	5076
100228	5066
100228	5067
100228	5064
100228	5065
100228	5070
100228	5071
100228	5068
100228	5069
100228	5058
100228	5059
100228	5056
100228	5057
100228	5062
100228	5063
100228	5060
100228	5061
100228	5105
100228	5104
100228	5096
100228	5097
100228	5098
100228	5099
100228	5100
100228	5101
100228	5102
100228	5103
100228	5088
100228	5089
100228	5090
100228	5091
100228	5092
100228	5093
100228	5094
100228	5095
100229	5197
100229	5196
100229	5199
100229	5198
100229	5193
100229	5192
100229	5195
100229	5194
100229	5189
100229	5188
100229	5191
100229	5190
100229	5185
100229	5184
100229	5187
100229	5186
100229	5212
100229	5208
100229	5209
100229	5210
100229	5211
100229	5204
100229	5205
100229	5206
100229	5207
100229	5200
100229	5201
100229	5202
100229	5203
100229	5163
100229	5162
100229	5161
100229	5160
100229	5167
100229	5166
100229	5165
100229	5164
100229	5155
100229	5154
100229	5153
100229	5152
100229	5159
100229	5158
100229	5157
100229	5156
100229	5178
100229	5179
100229	5176
100229	5177
100229	5182
100229	5183
100229	5180
100229	5181
100229	5170
100229	5171
100229	5168
100229	5169
100229	5174
100229	5175
100229	5172
100229	5173
100229	5129
100229	5128
100229	5131
100229	5130
100229	5133
100229	5132
100229	5135
100229	5134
100229	5121
100229	5120
100229	5123
100229	5122
100229	5125
100229	5124
100229	5127
100229	5126
100229	5144
100229	5145
100229	5146
100229	5147
100229	5148
100229	5149
100229	5150
100229	5151
100229	5136
100229	5137
100229	5138
100229	5139
100229	5140
100229	5141
100229	5142
100229	5143
100229	5113
100229	5112
100229	5115
100229	5114
100229	5117
100229	5116
100229	5119
100229	5118
100229	5107
100229	5106
100229	5109
100229	5108
100229	5111
100229	5110
100161	8399
100161	8398
100161	8397
100161	8396
100161	8395
100161	8394
100161	8393
100161	8392
100161	8391
100161	8390
100161	8389
100161	8388
100161	8387
100161	8386
100161	8385
100161	8384
100161	8414
100161	8415
100161	8412
100161	8413
100161	8410
100161	8411
100161	8408
100161	8409
100161	8406
100161	8407
100161	8404
100161	8405
100161	8402
100161	8403
100161	8400
100161	8401
100161	8429
100161	8428
100161	8431
100161	8430
100161	8425
100161	8424
100161	8427
100161	8426
100161	8421
100161	8420
100161	8423
100161	8422
100161	8417
100161	8416
100161	8419
100161	8418
100161	8444
100161	8445
100161	8446
100161	8447
100161	8440
100161	8441
100161	8442
100161	8443
100161	8436
100161	8437
100161	8438
100161	8439
100161	8432
100161	8433
100161	8434
100161	8435
100161	8377
100161	8378
100161	8379
100161	8380
100161	8381
100161	8382
100161	8383
100161	8465
100161	8464
100161	8448
100161	8449
100161	8450
100161	8451
100161	8452
100161	8453
100161	8454
100161	8455
100161	8456
100161	8457
100161	8458
100161	8459
100161	8460
100161	8461
100161	8462
100161	8463
100157	8467
100157	8466
100157	8469
100157	8468
100157	8471
100157	8470
100157	8473
100157	8472
100157	8475
100157	8474
100157	8477
100157	8476
100157	8479
100157	8478
100157	8499
100157	8498
100157	8497
100157	8496
100157	8482
100157	8483
100157	8480
100157	8481
100157	8486
100157	8487
100157	8484
100157	8485
100157	8490
100157	8491
100157	8488
100157	8489
100157	8494
100157	8495
100157	8492
100157	8493
100231	8533
100231	8532
100231	8535
100231	8534
100231	8529
100231	8528
100231	8531
100231	8530
100231	8541
100231	8540
100231	8543
100231	8542
100231	8537
100231	8536
100231	8539
100231	8538
100231	8516
100231	8517
100231	8518
100231	8519
100231	8512
100231	8513
100231	8514
100231	8515
100231	8524
100231	8525
100231	8526
100231	8527
100231	8520
100231	8521
100231	8522
100231	8523
100231	8567
100231	8566
100231	8565
100231	8564
100231	8563
100231	8562
100231	8561
100231	8560
100231	8575
100231	8574
100231	8573
100231	8572
100231	8571
100231	8570
100231	8569
100231	8568
100231	8550
100231	8551
100231	8548
100231	8549
100231	8546
100231	8547
100231	8544
100231	8545
100231	8558
100231	8559
100231	8556
100231	8557
100231	8554
100231	8555
100231	8552
100231	8553
100231	8503
100231	8502
100231	8501
100231	8500
100231	8507
100231	8506
100231	8505
100231	8504
100231	8511
100231	8510
100231	8509
100231	8508
100231	8592
100231	8593
100231	8594
100231	8595
100231	8596
100231	8597
100231	8598
100231	8585
100231	8584
100231	8587
100231	8586
100231	8589
100231	8588
100231	8591
100231	8590
100231	8577
100231	8576
100231	8579
100231	8578
100231	8581
100231	8580
100231	8583
100231	8582
100232	8664
100232	8665
100232	8666
100232	8667
100232	8660
100232	8661
100232	8662
100232	8663
100232	8656
100232	8657
100232	8658
100232	8659
100232	8653
100232	8652
100232	8655
100232	8654
100232	8649
100232	8648
100232	8651
100232	8650
100232	8645
100232	8644
100232	8647
100232	8646
100232	8641
100232	8640
100232	8643
100232	8642
100232	8600
100232	8601
100232	8602
100232	8603
100232	8604
100232	8605
100232	8606
100232	8607
100232	8599
100232	8634
100232	8635
100232	8632
100232	8633
100232	8638
100232	8639
100232	8636
100232	8637
100232	8626
100232	8627
100232	8624
100232	8625
100232	8630
100232	8631
100232	8628
100232	8629
100232	8619
100232	8618
100232	8617
100232	8616
100232	8623
100232	8622
100232	8621
100232	8620
100232	8611
100232	8610
100232	8609
100232	8608
100232	8615
100232	8614
100232	8613
100232	8612
100233	8668
100233	8669
100233	8670
100233	8671
100233	8702
100233	8703
100233	8708
100233	8700
100233	8709
100233	8701
100233	8706
100233	8698
100233	8707
100233	8699
100233	8704
100233	8696
100233	8705
100233	8697
100233	8694
100233	8695
100233	8692
100233	8693
100233	8690
100233	8691
100233	8688
100233	8689
100233	8687
100233	8686
100233	8685
100233	8684
100233	8683
100233	8682
100233	8681
100233	8680
100233	8679
100233	8678
100233	8677
100233	8676
100233	8675
100233	8674
100233	8673
100233	8672
100003	5133
100003	5132
100003	5146
100003	5150
100003	5020
100003	5019
100003	5017
100003	5016
100003	8644
100003	8641
100003	8640
100003	8643
100003	8703
100003	8680
100003	8675
100003	5026
100003	8600
100003	8639
100234	8736
100234	8737
100234	8710
100234	8711
100234	8718
100234	8719
100234	8716
100234	8717
100234	8714
100234	8715
100234	8712
100234	8713
100234	8727
100234	8726
100234	8725
100234	8724
100234	8723
100234	8722
100234	8721
100234	8720
100234	8735
100234	8734
100234	8733
100234	8732
100234	8731
100234	8730
100234	8729
100234	8728
100236	8753
100236	8752
100236	8755
100236	8754
100236	8748
100236	8749
100236	8750
100236	8751
100236	8747
\.


--
-- TOC entry 1932 (class 0 OID 16401)
-- Dependencies: 165
-- Data for Name: card_set_white_card; Type: TABLE DATA; Schema: public; Owner: cah
--

COPY card_set_white_card (card_set_id, white_card_id) FROM stdin;
1151	1
1151	2
1151	3
1151	4
1151	5
1151	6
1151	7
1151	8
1151	9
1151	10
1151	11
1151	12
1151	13
1151	14
1151	15
1151	17
1151	16
1151	19
1151	18
1151	21
1151	20
1151	23
1151	22
1151	25
1151	24
1151	27
1151	26
1151	29
1151	28
1151	31
1151	30
1151	34
1151	35
1151	32
1151	33
1151	38
1151	39
1151	36
1151	37
1151	42
1151	43
1151	40
1151	41
1151	46
1151	47
1151	44
1151	45
1151	51
1151	50
1151	49
1151	48
1151	55
1151	54
1151	53
1151	52
1151	59
1151	58
1151	57
1151	56
1151	63
1151	62
1151	61
1151	60
1151	68
1151	69
1151	70
1151	71
1151	64
1151	65
1151	66
1151	67
1151	76
1151	77
1151	78
1151	79
1151	72
1151	73
1151	74
1151	75
1151	85
1151	84
1151	87
1151	86
1151	81
1151	80
1151	83
1151	82
1151	93
1151	92
1151	95
1151	94
1151	89
1151	88
1151	91
1151	90
1151	102
1151	103
1151	100
1151	101
1151	98
1151	99
1151	96
1151	97
1151	110
1151	111
1151	108
1151	109
1151	106
1151	107
1151	104
1151	105
1151	119
1151	118
1151	117
1151	116
1151	115
1151	114
1151	113
1151	112
1151	127
1151	126
1151	125
1151	124
1151	123
1151	122
1151	121
1151	120
1151	137
1151	136
1151	139
1151	138
1151	141
1151	140
1151	143
1151	142
1151	129
1151	128
1151	131
1151	130
1151	133
1151	132
1151	135
1151	134
1151	152
1151	153
1151	154
1151	155
1151	156
1151	157
1151	158
1151	159
1151	144
1151	145
1151	146
1151	147
1151	148
1151	149
1151	150
1151	151
1151	171
1151	170
1151	169
1151	168
1151	175
1151	174
1151	173
1151	172
1151	163
1151	162
1151	161
1151	160
1151	167
1151	166
1151	165
1151	164
1151	186
1151	187
1151	184
1151	185
1151	190
1151	191
1151	188
1151	189
1151	178
1151	179
1151	176
1151	177
1151	182
1151	183
1151	180
1151	181
1151	205
1151	204
1151	207
1151	206
1151	201
1151	200
1151	203
1151	202
1151	197
1151	196
1151	199
1151	198
1151	193
1151	192
1151	195
1151	194
1151	220
1151	221
1151	222
1151	223
1151	216
1151	217
1151	218
1151	219
1151	212
1151	213
1151	214
1151	215
1151	208
1151	209
1151	210
1151	211
1151	239
1151	238
1151	237
1151	236
1151	235
1151	234
1151	233
1151	232
1151	231
1151	230
1151	229
1151	228
1151	227
1151	226
1151	225
1151	224
1151	254
1151	255
1151	252
1151	253
1151	250
1151	251
1151	248
1151	249
1151	246
1151	247
1151	244
1151	245
1151	242
1151	243
1151	240
1151	241
1151	275
1151	274
1151	273
1151	272
1151	279
1151	278
1151	277
1151	276
1151	283
1151	282
1151	281
1151	280
1151	287
1151	286
1151	285
1151	284
1151	258
1151	259
1151	256
1151	257
1151	262
1151	263
1151	260
1151	261
1151	266
1151	267
1151	264
1151	265
1151	270
1151	271
1151	268
1151	269
1151	305
1151	304
1151	307
1151	306
1151	309
1151	308
1151	311
1151	310
1151	313
1151	312
1151	315
1151	314
1151	317
1151	316
1151	319
1151	318
1151	288
1151	289
1151	290
1151	291
1151	292
1151	293
1151	294
1151	295
1151	296
1151	297
1151	298
1151	299
1151	300
1151	301
1151	302
1151	303
1151	343
1151	342
1151	341
1151	340
1151	339
1151	338
1151	337
1151	336
1151	351
1151	350
1151	349
1151	348
1151	347
1151	346
1151	345
1151	344
1151	326
1151	327
1151	324
1151	325
1151	322
1151	323
1151	320
1151	321
1151	334
1151	335
1151	332
1151	333
1151	330
1151	331
1151	328
1151	329
1151	373
1151	372
1151	375
1151	374
1151	369
1151	368
1151	371
1151	370
1151	381
1151	380
1151	383
1151	382
1151	377
1151	376
1151	379
1151	378
1151	356
1151	357
1151	358
1151	359
1151	352
1151	353
1151	354
1151	355
1151	364
1151	365
1151	366
1151	367
1151	360
1151	361
1151	362
1151	363
1151	410
1151	411
1151	408
1151	409
1151	414
1151	415
1151	412
1151	413
1151	402
1151	403
1151	400
1151	401
1151	406
1151	407
1151	404
1151	405
1151	395
1151	394
1151	393
1151	392
1151	399
1151	398
1151	397
1151	396
1151	387
1151	386
1151	385
1151	384
1151	391
1151	390
1151	389
1151	388
1151	440
1151	441
1151	442
1151	443
1151	444
1151	445
1151	446
1151	447
1151	432
1151	433
1151	434
1151	435
1151	436
1151	437
1151	438
1151	439
1151	425
1151	424
1151	427
1151	426
1151	429
1151	428
1151	431
1151	430
1151	417
1151	416
1151	419
1151	418
1151	421
1151	420
1151	423
1151	422
1151	460
1151	459
1151	458
1151	457
1151	456
1151	455
1151	454
1151	453
1151	452
1151	451
1151	450
1151	449
1151	448
1152	1
1152	2
1152	3
1152	4
1152	5
1152	6
1152	7
1152	10
1152	11
1152	12
1152	13
1152	14
1152	16
1152	19
1152	18
1152	20
1152	23
1152	22
1152	25
1152	24
1152	27
1152	26
1152	29
1152	28
1152	31
1152	30
1152	34
1152	35
1152	32
1152	33
1152	38
1152	39
1152	36
1152	37
1152	42
1152	40
1152	41
1152	46
1152	47
1152	44
1152	45
1152	51
1152	50
1152	49
1152	48
1152	55
1152	54
1152	53
1152	52
1152	59
1152	58
1152	57
1152	56
1152	63
1152	62
1152	61
1152	60
1152	68
1152	70
1152	71
1152	65
1152	66
1152	67
1152	76
1152	77
1152	78
1152	79
1152	72
1152	73
1152	74
1152	75
1152	85
1152	84
1152	87
1152	86
1152	81
1152	80
1152	83
1152	82
1152	93
1152	92
1152	95
1152	94
1152	89
1152	88
1152	91
1152	90
1152	102
1152	103
1152	101
1152	98
1152	99
1152	96
1152	97
1152	111
1152	108
1152	109
1152	106
1152	107
1152	104
1152	105
1152	119
1152	118
1152	117
1152	116
1152	115
1152	114
1152	113
1152	112
1152	127
1152	126
1152	125
1152	124
1152	122
1152	121
1152	137
1152	136
1152	139
1152	138
1152	141
1152	140
1152	142
1152	129
1152	128
1152	132
1152	135
1152	134
1152	152
1152	153
1152	154
1152	155
1152	157
1152	159
1152	144
1152	145
1152	146
1152	147
1152	148
1152	149
1152	150
1152	151
1152	171
1152	170
1152	169
1152	168
1152	175
1152	174
1152	173
1152	172
1152	163
1152	162
1152	161
1152	160
1152	167
1152	166
1152	165
1152	186
1152	187
1152	184
1152	185
1152	191
1152	189
1152	178
1152	179
1152	176
1152	182
1152	183
1152	180
1152	181
1152	205
1152	204
1152	207
1152	206
1152	201
1152	200
1152	203
1152	202
1152	197
1152	196
1152	199
1152	198
1152	193
1152	192
1152	195
1152	194
1152	220
1152	221
1152	222
1152	223
1152	217
1152	218
1152	219
1152	212
1152	213
1152	214
1152	215
1152	208
1152	209
1152	210
1152	211
1152	239
1152	238
1152	237
1152	236
1152	235
1152	234
1152	233
1152	232
1152	231
1152	230
1152	229
1152	228
1152	227
1152	226
1152	225
1152	224
1152	254
1152	255
1152	252
1152	253
1152	250
1152	251
1152	249
1152	246
1152	244
1152	245
1152	242
1152	243
1152	240
1152	241
1152	275
1152	274
1152	272
1152	279
1152	278
1152	277
1152	276
1152	283
1152	282
1152	280
1152	287
1152	286
1152	284
1152	258
1152	259
1152	256
1152	257
1152	262
1152	263
1152	260
1152	261
1152	266
1152	267
1152	265
1152	270
1152	271
1152	268
1152	269
1152	305
1152	304
1152	306
1152	309
1152	308
1152	311
1152	312
1152	315
1152	314
1152	317
1152	316
1152	319
1152	318
1152	289
1152	290
1152	291
1152	292
1152	293
1152	294
1152	295
1152	296
1152	297
1152	298
1152	299
1152	300
1152	302
1152	303
1152	343
1152	340
1152	339
1152	337
1152	336
1152	351
1152	349
1152	348
1152	347
1152	346
1152	345
1152	344
1152	326
1152	327
1152	324
1152	325
1152	322
1152	323
1152	320
1152	321
1152	334
1152	335
1152	332
1152	330
1152	329
1152	373
1152	372
1152	375
1152	374
1152	369
1152	368
1152	370
1152	381
1152	380
1152	382
1152	377
1152	376
1152	379
1152	378
1152	356
1152	357
1152	358
1152	359
1152	352
1152	354
1152	355
1152	364
1152	365
1152	366
1152	367
1152	360
1152	361
1152	362
1152	410
1152	411
1152	408
1152	409
1152	414
1152	415
1152	412
1152	413
1152	402
1152	400
1152	401
1152	406
1152	407
1152	404
1152	405
1152	395
1152	394
1152	393
1152	392
1152	399
1152	398
1152	397
1152	396
1152	387
1152	386
1152	385
1152	384
1152	391
1152	390
1152	389
1152	388
1152	440
1152	441
1152	442
1152	443
1152	444
1152	445
1152	446
1152	447
1152	432
1152	433
1152	434
1152	435
1152	436
1152	437
1152	438
1152	439
1152	425
1152	427
1152	426
1152	429
1152	431
1152	430
1152	417
1152	416
1152	419
1152	418
1152	421
1152	420
1152	423
1152	422
1152	478
1152	479
1152	476
1152	477
1152	474
1152	475
1152	472
1152	473
1152	470
1152	471
1152	468
1152	469
1152	466
1152	467
1152	464
1152	465
1152	463
1152	462
1152	461
1152	460
1152	459
1152	458
1152	457
1152	456
1152	455
1152	453
1152	452
1152	451
1152	450
1152	449
1152	448
1152	508
1152	504
1152	505
1152	506
1152	507
1152	500
1152	501
1152	502
1152	503
1152	496
1152	497
1152	498
1152	499
1152	493
1152	492
1152	495
1152	494
1152	489
1152	488
1152	491
1152	490
1152	485
1152	484
1152	487
1152	486
1152	481
1152	480
1152	483
1152	482
1153	1016
1153	1017
1153	1018
1153	1019
1153	1020
1153	1021
1153	1022
1153	1023
1153	1024
1153	1025
1153	1026
1153	1010
1153	1027
1153	1011
1153	1028
1153	1012
1153	1029
1153	1013
1153	1030
1153	1014
1153	1015
1154	1034
1154	1035
1154	1036
1154	1037
1154	1038
1154	1039
1154	1041
1154	1040
1154	1042
1155	1100
1155	1101
1155	1102
1155	1103
1155	1096
1155	1097
1155	1098
1155	1099
1155	1092
1155	1093
1155	1094
1155	1095
1155	1088
1155	1089
1155	1090
1155	1091
1155	1117
1155	1116
1155	1119
1155	1118
1155	1113
1155	1112
1155	1115
1155	1114
1155	1109
1155	1108
1155	1111
1155	1110
1155	1105
1155	1104
1155	1107
1155	1106
1155	1134
1155	1135
1155	1132
1155	1133
1155	1130
1155	1131
1155	1128
1155	1129
1155	1126
1155	1127
1155	1124
1155	1125
1155	1122
1155	1123
1155	1120
1155	1121
1155	1145
1155	1144
1155	1143
1155	1142
1155	1141
1155	1140
1155	1139
1155	1138
1155	1137
1155	1136
1155	1066
1155	1067
1155	1070
1155	1071
1155	1068
1155	1069
1155	1083
1155	1082
1155	1081
1155	1080
1155	1087
1155	1086
1155	1085
1155	1084
1155	1075
1155	1074
1155	1073
1155	1072
1155	1079
1155	1078
1155	1077
1155	1076
1256	1221
1256	1220
1256	1223
1256	1222
1256	1217
1256	1216
1256	1219
1256	1218
1256	1229
1256	1228
1256	1231
1256	1230
1256	1225
1256	1224
1256	1227
1256	1226
1256	1236
1256	1237
1256	1238
1256	1239
1256	1232
1256	1233
1256	1234
1256	1235
1256	1244
1256	1245
1256	1246
1256	1247
1256	1240
1256	1241
1256	1242
1256	1243
1256	1255
1256	1254
1256	1253
1256	1252
1256	1251
1256	1250
1256	1249
1256	1248
1256	1181
1256	1182
1256	1183
1256	1187
1256	1186
1256	1185
1256	1184
1256	1191
1256	1190
1256	1189
1256	1188
1256	1195
1256	1194
1256	1193
1256	1192
1256	1199
1256	1198
1256	1197
1256	1196
1256	1202
1256	1203
1256	1200
1256	1201
1256	1206
1256	1207
1256	1204
1256	1205
1256	1210
1256	1211
1256	1208
1256	1209
1256	1214
1256	1215
1256	1212
1256	1213
1488	1464
1488	1465
1488	1466
1488	1467
1488	1468
1488	1469
1488	1470
1488	1471
1488	1479
1488	1478
1488	1477
1488	1476
1488	1475
1488	1474
1488	1473
1488	1487
1488	1486
1488	1485
1488	1484
1488	1483
1488	1482
1488	1481
1488	1480
100001	1368
100001	1367
100001	1364
100001	1362
100001	1360
100001	1358
100001	1357
100001	1351
100001	1348
100001	1349
100001	1346
100001	1344
100001	1405
100001	1404
100001	1407
100001	1406
100001	1401
100001	1400
100001	1403
100001	1402
100001	1397
100001	1396
100001	1399
100001	1398
100001	1393
100001	1392
100001	1395
100001	1394
100001	1388
100001	1389
100001	1390
100001	1391
100001	1384
100001	1385
100001	1386
100001	1387
100001	1380
100001	1381
100001	1382
100001	1383
100001	1379
100001	1307
100001	1304
100001	1310
100001	1308
100001	1299
100001	1298
100001	1296
100001	1302
100001	1300
100001	1290
100001	1288
100001	1294
100001	1293
100001	1282
100001	1280
100001	1286
100001	1284
100001	1337
100001	1336
100001	1339
100001	1338
100001	1341
100001	1340
100001	1343
100001	1342
100001	1328
100001	1331
100001	1333
100001	1332
100001	1335
100001	1334
100001	1320
100001	1322
100001	1324
100001	1326
100001	1312
100001	1314
100001	1316
100001	1318
100001	1263
100001	1261
100001	1259
100001	1258
100001	1271
100001	1269
100001	1266
100001	1278
100001	1276
100001	1274
100001	1272
100001	1426
100001	1427
100001	1424
100001	1425
100001	1430
100001	1431
100001	1428
100001	1429
100001	1435
100001	1432
100001	1433
100001	1438
100001	1439
100001	1436
100001	1437
100001	1411
100001	1410
100001	1409
100001	1408
100001	1415
100001	1414
100001	1413
100001	1412
100001	1419
100001	1418
100001	1417
100001	1416
100001	1423
100001	1422
100001	1421
100001	1420
100001	1441
100001	1440
100001	1443
100001	1442
100001	1445
100001	1444
100001	1447
100001	1446
100001	1449
100001	1448
100001	1451
100001	1450
100001	1453
100001	1452
100001	1455
100001	1454
100002	550
100002	551
100002	548
100002	549
100002	546
100002	547
100002	544
100002	545
100002	558
100002	559
100002	556
100002	557
100002	554
100002	555
100002	552
100002	553
100002	567
100002	566
100002	565
100002	564
100002	563
100002	562
100002	561
100002	560
100002	575
100002	574
100002	573
100002	572
100002	571
100002	570
100002	569
100002	568
100002	516
100002	517
100002	518
100002	519
100002	512
100002	513
100002	514
100002	515
100002	524
100002	525
100002	526
100002	527
100002	520
100002	521
100002	522
100002	523
100002	533
100002	532
100002	535
100002	534
100002	529
100002	528
100002	531
100002	530
100002	541
100002	540
100002	543
100002	542
100002	537
100002	536
100002	539
100002	538
100002	610
100002	611
100002	608
100002	609
100002	614
100002	615
100002	612
100002	613
100002	618
100002	619
100002	616
100002	617
100002	620
100002	621
100002	576
100002	577
100002	578
100002	579
100002	580
100002	581
100002	582
100002	583
100002	584
100002	585
100002	586
100002	587
100002	588
100002	589
100002	590
100002	591
100002	593
100002	592
100002	595
100002	594
100002	597
100002	596
100002	599
100002	598
100002	601
100002	600
100002	603
100002	602
100002	605
100002	604
100002	607
100002	606
100002	509
100002	510
100002	511
100003	610
100003	550
100003	551
100003	608
100003	549
100003	544
100003	545
100003	556
100003	554
100003	553
100003	1288
100003	564
100003	572
100003	568
100003	576
100003	516
100003	509
100003	578
100003	518
100003	510
100003	579
100003	512
100003	581
100003	513
100003	582
100003	514
100003	1263
100003	588
100003	520
100003	589
100003	541
100003	540
100003	1383
100003	605
100003	1274
100003	604
100003	539
100003	606
100017	100014
100017	100015
100017	100012
100017	100013
100017	100011
100017	100008
100017	100009
100017	100018
100049	100026
100049	100025
100049	100024
100049	100023
100049	100022
100049	100021
100049	100020
100049	100019
100050	100031
100050	100030
100050	100029
100050	100032
100050	100033
100050	100034
100050	100035
100050	100036
100051	100040
100051	100041
100051	100042
100051	100043
100051	100044
100051	100045
100051	100046
100051	100039
100017	100052
100017	100057
100154	100091
100154	100090
100154	100088
100154	100083
100154	100082
100154	100081
100154	100080
100154	100087
100154	100086
100154	100084
100154	100075
100154	100072
100154	100073
100154	100079
100154	100076
100154	100077
100154	100067
100154	100064
100154	100071
100154	100068
100154	100069
100154	100056
100154	100061
100154	100060
100154	100063
100154	100062
100154	100053
100154	100055
100154	100133
100154	100132
100154	100135
100154	100134
100154	100129
100154	100128
100154	100131
100154	100130
100154	100141
100154	100140
100154	100143
100154	100142
100154	100137
100154	100136
100154	100139
100154	100138
100154	100148
100154	100149
100154	100150
100154	100151
100154	100144
100154	100145
100154	100146
100154	100147
100154	100152
100154	100153
100154	100102
100154	100101
100154	100099
100154	100111
100154	100109
100154	100107
100154	100118
100154	100119
100154	100116
100154	100117
100154	100114
100154	100115
100154	100112
100154	100126
100154	100127
100154	100124
100154	100125
100154	100122
100154	100123
100154	100120
100154	100121
100003	100011
100003	100008
100003	100057
100017	100156
100157	3004
100157	3005
100157	3006
100157	3007
100157	3001
100157	3002
100157	3003
100157	3049
100157	3048
100157	3051
100157	3050
100157	3053
100157	3052
100157	3055
100157	3054
100157	3041
100157	3040
100157	3043
100157	3042
100157	3045
100157	3044
100157	3047
100157	3046
100157	3064
100157	3065
100157	3066
100157	3067
100157	3068
100157	3069
100157	3070
100157	3071
100157	3056
100157	3057
100157	3058
100157	3059
100157	3060
100157	3061
100157	3062
100157	3063
100157	3019
100157	3018
100157	3017
100157	3016
100157	3023
100157	3022
100157	3021
100157	3020
100157	3011
100157	3010
100157	3009
100157	3008
100157	3015
100157	3014
100157	3013
100157	3012
100157	3034
100157	3035
100157	3032
100157	3033
100157	3038
100157	3039
100157	3036
100157	3037
100157	3026
100157	3027
100157	3024
100157	3025
100157	3030
100157	3031
100157	3028
100157	3029
100157	3097
100157	3096
100157	3099
100157	3098
100157	3101
100157	3100
100157	3103
100157	3102
100157	3089
100157	3088
100157	3091
100157	3090
100157	3093
100157	3092
100157	3095
100157	3094
100157	3080
100157	3081
100157	3082
100157	3083
100157	3084
100157	3085
100157	3086
100157	3087
100157	3072
100157	3073
100157	3074
100157	3075
100157	3076
100157	3077
100157	3078
100157	3079
100157	3131
100157	3130
100157	3129
100157	3128
100157	3123
100157	3122
100157	3121
100157	3120
100157	3127
100157	3126
100157	3125
100157	3124
100157	3114
100157	3115
100157	3112
100157	3113
100157	3118
100157	3119
100157	3116
100157	3117
100157	3106
100157	3107
100157	3104
100157	3105
100157	3110
100157	3111
100157	3108
100157	3109
100157	100158
100003	3006
100003	3007
100003	3054
100003	3094
100003	3065
100003	3085
100003	3070
100003	3117
100160	3776
100160	3766
100160	3767
100160	3764
100160	3765
100160	3762
100160	3763
100160	3760
100160	3761
100160	3774
100160	3775
100160	3772
100160	3773
100160	3770
100160	3771
100160	3768
100160	3769
100160	3751
100160	3750
100160	3749
100160	3748
100160	3747
100160	3746
100160	3745
100160	3744
100160	3759
100160	3758
100160	3757
100160	3756
100160	3755
100160	3754
100160	3753
100160	3752
100160	3732
100160	3733
100160	3734
100160	3735
100160	3728
100160	3729
100160	3730
100160	3731
100160	3740
100160	3741
100160	3742
100160	3743
100160	3736
100160	3737
100160	3738
100160	3739
100160	3717
100160	3716
100160	3719
100160	3718
100160	3713
100160	3712
100160	3715
100160	3714
100160	3725
100160	3724
100160	3727
100160	3726
100160	3721
100160	3720
100160	3723
100160	3722
100160	3707
100160	3706
100160	3705
100160	3704
100160	3711
100160	3710
100160	3709
100160	3708
100160	3699
100160	3698
100160	3697
100160	3696
100160	3703
100160	3702
100160	3701
100160	3700
100160	3690
100160	3691
100160	3688
100160	3689
100160	3694
100160	3695
100160	3692
100160	3693
100160	3682
100160	3683
100160	3680
100160	3681
100160	3686
100160	3687
100160	3684
100160	3685
100160	3673
100160	3672
100160	3675
100160	3674
100160	3677
100160	3676
100160	3679
100160	3678
100160	3665
100160	3664
100160	3667
100160	3666
100160	3669
100160	3668
100160	3671
100160	3670
100160	3662
100160	3663
100003	3709
100003	3708
100003	3688
100003	3687
100003	3684
100003	3676
100003	3667
100003	3666
100003	3671
100003	3670
100003	3663
100003	3762
100003	3763
100003	3100
100003	3761
100003	3773
100003	3770
100003	3084
100003	3744
100003	3059
100003	3754
100003	3740
100003	3011
100003	3742
100003	3121
100003	3009
100003	3736
100003	3014
100003	3719
100003	3104
100003	3723
100161	4131
100161	4065
100161	4130
100161	4064
100161	4129
100161	4067
100161	4128
100161	4066
100161	4135
100161	4069
100161	4134
100161	4068
100161	4133
100161	4071
100161	4132
100161	4070
100161	4073
100161	4139
100161	4138
100161	4072
100161	4075
100161	4137
100161	4074
100161	4136
100161	4077
100161	4143
100161	4076
100161	4142
100161	4079
100161	4141
100161	4078
100161	4140
100161	4080
100161	4146
100161	4081
100161	4147
100161	4082
100161	4144
100161	4083
100161	4145
100161	4084
100161	4150
100161	4085
100161	4151
100161	4086
100161	4148
100161	4087
100161	4149
100161	4088
100161	4154
100161	4089
100161	4155
100161	4090
100161	4152
100161	4091
100161	4153
100161	4092
100161	4158
100161	4093
100161	4159
100161	4094
100161	4156
100161	4095
100161	4157
100161	4097
100161	4035
100161	4096
100161	4034
100161	4099
100161	4033
100161	4098
100161	4032
100161	4101
100161	4039
100161	4100
100161	4038
100161	4103
100161	4037
100161	4102
100161	4036
100161	4105
100161	4043
100161	4104
100161	4042
100161	4107
100161	4041
100161	4106
100161	4040
100161	4109
100161	4047
100161	4108
100161	4046
100161	4111
100161	4045
100161	4110
100161	4044
100161	4112
100161	4050
100161	4113
100161	4051
100161	4114
100161	4048
100161	4115
100161	4049
100161	4116
100161	4054
100161	4117
100161	4055
100161	4118
100161	4052
100161	4119
100161	4053
100161	4120
100161	4058
100161	4121
100161	4059
100161	4122
100161	4056
100161	4123
100161	4057
100161	4124
100161	4062
100161	4125
100161	4063
100161	4126
100161	4060
100161	4127
100161	4061
100161	4199
100161	4005
100161	4004
100161	4197
100161	4007
100161	4196
100161	4006
100161	4195
100161	4001
100161	4194
100161	4000
100161	4193
100161	4003
100161	4192
100161	4002
100161	4207
100161	4013
100161	4206
100161	4012
100161	4205
100161	4015
100161	4204
100161	4014
100161	4203
100161	4009
100161	4202
100161	4008
100161	4201
100161	4011
100161	4200
100161	4010
100161	4214
100161	4020
100161	4215
100161	4021
100161	4212
100161	4022
100161	4213
100161	4023
100161	4210
100161	4016
100161	4211
100161	4017
100161	4018
100161	4209
100161	4019
100161	4222
100161	4028
100161	4223
100161	4029
100161	4220
100161	4030
100161	4221
100161	4031
100161	4218
100161	4024
100161	4219
100161	4025
100161	4216
100161	4026
100161	4217
100161	4027
100161	4165
100161	4164
100161	4167
100161	4166
100161	4161
100161	4163
100161	4162
100161	4173
100161	4172
100161	4175
100161	4174
100161	4169
100161	4168
100161	4171
100161	4170
100161	4180
100161	4181
100161	4182
100161	4183
100161	4176
100161	4177
100161	4178
100161	4179
100161	4188
100161	3998
100161	4189
100161	3999
100161	4190
100161	3996
100161	4191
100161	3997
100161	4184
100161	3994
100161	4185
100161	3995
100161	4186
100161	4187
100161	3993
100161	4224
100161	4225
100161	4226
100161	4227
100161	4228
100003	4084
100003	4085
100003	4148
100003	4088
100003	4089
100003	4090
100003	4096
100003	4044
100003	4053
100003	4120
100003	4121
100003	4207
100003	4201
100003	4011
100003	4021
100003	4023
100003	4029
100003	4030
100003	4031
100003	4161
100003	4175
100003	4170
100003	4180
100003	4183
100003	3998
100003	3996
100003	4191
100003	3994
100003	4045
100157	4229
100017	100162
100003	100162
100211	100193
100211	100192
100211	100195
100211	100194
100211	100197
100211	100196
100211	100199
100211	100198
100211	100201
100211	100200
100211	100202
100211	100205
100211	100204
100211	100167
100211	100166
100211	100165
100211	100164
100211	100170
100211	100168
100211	100175
100211	100174
100211	100173
100211	100172
100211	100178
100211	100179
100211	100176
100211	100177
100211	100182
100211	100183
100211	100180
100211	100181
100211	100186
100211	100187
100211	100184
100211	100185
100211	100190
100211	100191
100211	100188
100211	100189
100211	19
100211	441
100211	308
100211	173
100211	340
100211	85
100211	101
100211	368
100211	380
100211	357
100211	365
100211	272
100211	400
100211	154
100211	100212
100211	145
100211	384
100211	34
100211	169
100211	36
100211	312
100211	167
100211	45
100211	294
100211	295
100211	419
100211	301
100211	77
100211	471
100211	74
100211	456
100211	93
100211	209
100211	102
100211	232
100211	106
100211	358
100211	359
100211	122
100211	6
100211	263
100211	266
100211	31
100211	315
100211	292
100211	303
100211	347
100211	345
100211	103
100211	125
100211	437
100211	427
100211	193
100211	462
100211	451
100211	235
100211	226
100211	488
100211	283
100211	286
100211	23
100211	26
100211	270
100211	305
100211	306
100211	296
100211	70
100211	71
100211	337
100211	1038
100211	336
100211	87
100211	1041
100211	1042
100211	330
100211	355
100211	367
100211	362
100211	138
100211	389
100211	444
100211	446
100211	172
100211	418
100211	420
100211	479
100211	195
100211	222
100211	461
100211	210
100211	448
100211	229
100211	249
100211	245
100211	256
100211	35
100211	33
100211	310
100211	40
100211	44
100211	49
100211	63
100211	1035
100211	65
100211	67
100211	329
100211	98
100211	104
100211	105
100211	360
100211	137
100211	142
100211	394
100211	151
100211	171
100211	443
100211	447
100211	434
100211	161
100211	189
100211	417
100211	478
100211	475
100211	198
100211	463
100211	223
100211	457
100211	504
100211	503
100211	244
100211	481
100211	2
100211	10
100211	27
100211	32
100211	37
100211	42
100211	41
100211	51
100211	56
100211	72
100211	97
100211	118
100211	114
100211	141
100211	140
100211	160
100211	200
100211	202
100211	221
100211	218
100211	246
100211	287
100211	265
100211	297
100211	300
100211	339
100211	325
100211	354
100211	361
100211	405
100211	399
100211	445
100211	436
100211	423
100211	469
100211	484
100211	12
100211	94
100211	166
100211	180
100211	239
100211	274
100211	317
100211	348
100211	334
100211	370
100211	356
100211	395
100211	432
100211	435
100211	426
100211	508
100211	48
100211	90
100211	132
100211	159
100211	146
100211	175
100211	191
100211	205
100211	237
100211	230
100211	241
100211	332
100211	411
100211	425
100211	453
100211	492
100211	495
100211	480
100211	38
100211	50
100211	61
100211	1036
100211	80
100211	117
100211	115
100211	127
100211	126
100211	124
100211	136
100211	135
100211	150
100211	170
100211	204
100211	206
100211	194
100211	208
100211	236
100211	228
100211	255
100211	253
100211	276
100211	298
100211	299
100211	326
100211	327
100211	382
100211	376
100211	440
100211	431
100211	476
100211	477
100211	474
100211	501
100211	496
100211	499
100211	493
100211	485
100211	22
100211	30
100211	47
100211	62
100211	60
100211	73
100211	88
100211	111
100211	147
100211	149
100211	168
100211	185
100211	182
100211	220
100211	213
100211	225
100211	275
100211	277
100211	311
100211	319
100211	349
100211	373
100211	372
100211	375
100211	409
100211	414
100211	415
100211	407
100211	396
100211	391
100211	388
100211	442
100211	421
100211	467
100211	452
100211	500
100211	497
100211	487
100211	24
100211	46
100211	1039
100211	82
100211	128
100211	181
100211	211
100211	252
100211	280
100211	257
100211	322
100211	402
100211	401
100211	404
100211	392
100211	387
100211	385
100211	466
100211	482
100211	3
100211	100213
100211	28
100211	52
100211	59
100211	58
100211	57
100211	83
100211	1040
100211	109
100211	155
100211	144
100211	163
100211	201
100211	199
100211	217
100211	234
100211	231
100211	224
100211	254
100211	261
100211	314
100211	316
100211	343
100211	351
100211	346
100211	364
100211	408
100211	412
100211	406
100211	430
100211	416
100211	472
100211	470
100211	460
100211	494
100211	490
100211	54
100211	53
100211	79
100211	91
100211	112
100211	153
100211	183
100211	197
100211	284
100211	259
100211	413
100211	455
100211	505
100211	506
100211	489
100211	1
100211	11
100211	13
100211	16
100211	100214
100211	100215
100211	25
100211	29
100211	39
100211	55
100211	1037
100211	76
100211	75
100211	108
100211	129
100211	152
100211	157
100211	148
100211	174
100211	165
100211	178
100211	179
100211	203
100211	196
100211	192
100211	216
100211	215
100211	238
100211	233
100211	227
100211	250
100211	242
100211	279
100211	267
100211	271
100211	268
100211	269
100211	304
100211	318
100211	323
100211	377
100211	393
100211	397
100211	386
100211	433
100211	429
100211	473
100211	465
100211	459
100211	458
100211	100216
100211	4
100211	5
100211	7
100211	18
100211	1034
100211	84
100211	95
100211	99
100211	212
100211	214
100211	278
100211	282
100211	290
100211	302
100211	324
100211	374
100211	410
100211	390
100211	187
100211	293
100211	498
100161	4266
100161	4267
100161	4264
100161	4265
100161	4270
100161	4271
100161	4268
100161	4269
100161	4258
100161	4259
100161	4256
100161	4257
100161	4262
100161	4263
100161	4260
100161	4261
100161	4273
100161	4272
100161	4232
100161	4233
100161	4234
100161	4235
100161	4236
100161	4237
100161	4238
100161	4239
100161	4230
100161	4231
100161	4249
100161	4248
100161	4251
100161	4250
100161	4253
100161	4252
100161	4255
100161	4254
100161	4241
100161	4240
100161	4243
100161	4242
100161	4245
100161	4244
100161	4247
100161	4246
100157	4275
100157	4274
100157	4277
100157	4276
100219	4400
100219	4401
100219	4402
100219	4403
100219	4404
100219	4405
100219	4406
100219	4407
100219	4408
100219	4409
100219	4410
100219	4411
100219	4412
100219	4413
100219	4414
100219	4415
100219	4385
100219	4384
100219	4387
100219	4386
100219	4389
100219	4388
100219	4391
100219	4390
100219	4393
100219	4392
100219	4395
100219	4394
100219	4397
100219	4396
100219	4399
100219	4398
100219	4370
100219	4371
100219	4368
100219	4369
100219	4374
100219	4375
100219	4372
100219	4373
100219	4378
100219	4379
100219	4376
100219	4377
100219	4382
100219	4383
100219	4380
100219	4381
100219	4359
100219	4358
100219	4363
100219	4362
100219	4361
100219	4360
100219	4367
100219	4366
100219	4365
100219	4364
100219	4453
100219	4452
100219	4455
100219	4454
100219	4449
100219	4448
100219	4451
100219	4450
100219	4457
100219	4456
100219	4458
100219	4438
100219	4439
100219	4436
100219	4437
100219	4434
100219	4435
100219	4432
100219	4433
100219	4446
100219	4447
100219	4444
100219	4445
100219	4442
100219	4443
100219	4440
100219	4441
100219	4423
100219	4422
100219	4421
100219	4420
100219	4419
100219	4418
100219	4417
100219	4416
100219	4431
100219	4430
100219	4429
100219	4428
100219	4427
100219	4426
100219	4425
100219	4424
100003	4400
100003	4401
100003	4404
100003	4405
100003	4407
100003	4396
100003	4364
100003	4454
100003	4458
100017	100220
100017	100221
100017	100222
100224	4468
100224	4469
100224	4470
100224	4471
100224	4464
100224	4465
100224	4466
100224	4467
100224	4476
100224	4477
100224	4478
100224	4479
100224	4472
100224	4473
100224	4474
100224	4475
100224	4461
100224	4460
100224	4463
100224	4462
100224	4459
100224	4537
100224	4536
100224	4539
100224	4538
100224	4541
100224	4540
100224	4543
100224	4542
100224	4529
100224	4528
100224	4531
100224	4530
100224	4533
100224	4532
100224	4535
100224	4534
100224	4520
100224	4521
100224	4522
100224	4523
100224	4524
100224	4525
100224	4526
100224	4527
100224	4512
100224	4513
100224	4514
100224	4515
100224	4516
100224	4517
100224	4518
100224	4519
100224	4507
100224	4506
100224	4505
100224	4504
100224	4511
100224	4510
100224	4509
100224	4508
100224	4499
100224	4498
100224	4497
100224	4496
100224	4503
100224	4502
100224	4501
100224	4500
100224	4490
100224	4491
100224	4488
100224	4489
100224	4494
100224	4495
100224	4492
100224	4493
100224	4482
100224	4483
100224	4480
100224	4481
100224	4486
100224	4487
100224	4484
100224	4485
100224	4605
100224	4604
100224	4607
100224	4606
100224	4601
100224	4600
100224	4603
100224	4602
100224	4597
100224	4596
100224	4599
100224	4598
100224	4593
100224	4592
100224	4595
100224	4594
100224	4588
100224	4589
100224	4590
100224	4591
100224	4584
100224	4585
100224	4586
100224	4587
100224	4580
100224	4581
100224	4582
100224	4583
100224	4576
100224	4577
100224	4578
100224	4579
100224	4575
100224	4574
100224	4573
100224	4572
100224	4571
100224	4570
100224	4569
100224	4568
100224	4567
100224	4566
100224	4565
100224	4564
100224	4563
100224	4562
100224	4561
100224	4560
100224	4558
100224	4559
100224	4556
100224	4557
100224	4554
100224	4555
100224	4552
100224	4553
100224	4550
100224	4551
100224	4548
100224	4549
100224	4546
100224	4547
100224	4544
100224	4545
100224	4613
100224	4612
100224	4615
100224	4614
100224	4609
100224	4608
100224	4611
100224	4610
100224	4621
100224	4620
100224	4623
100224	4622
100224	4617
100224	4616
100224	4619
100224	4618
100224	4628
100224	4629
100224	4630
100224	4631
100224	4624
100224	4625
100224	4626
100224	4627
100224	4636
100224	4637
100224	4638
100224	4639
100224	4632
100224	4633
100224	4634
100224	4635
100224	4647
100224	4646
100224	4645
100224	4644
100224	4643
100224	4642
100224	4641
100224	4640
100224	4655
100224	4654
100224	4653
100224	4652
100224	4651
100224	4650
100224	4649
100224	4648
100224	4662
100224	4663
100224	4660
100224	4661
100224	4658
100224	4659
100224	4656
100224	4657
100224	4670
100224	4671
100224	4668
100224	4669
100224	4666
100224	4667
100224	4664
100224	4665
100224	4673
100224	4672
100224	4675
100224	4674
100224	4677
100224	4676
100224	4679
100224	4678
100224	4681
100224	4680
100224	4683
100224	4682
100224	4685
100224	4684
100224	4687
100224	4686
100224	4688
100224	4689
100224	4690
100224	4691
100224	4692
100224	4693
100224	4694
100224	4695
100224	4696
100224	4697
100224	4698
100224	4699
100224	4700
100224	4701
100224	4702
100224	4703
100224	4707
100224	4706
100224	4705
100224	4704
100224	4711
100224	4710
100224	4709
100224	4708
100224	4715
100224	4714
100224	4713
100224	4712
100224	4719
100224	4718
100224	4717
100224	4716
100224	4722
100224	4723
100224	4720
100224	4721
100224	4726
100224	4727
100224	4724
100224	4725
100224	4730
100224	4731
100224	4728
100224	4729
100224	4734
100224	4735
100224	4732
100224	4733
100224	4748
100224	4749
100224	4750
100224	4751
100224	4744
100224	4745
100224	4746
100224	4747
100224	4740
100224	4741
100224	4742
100224	4743
100224	4736
100224	4737
100224	4738
100224	4739
100224	4765
100224	4764
100224	4767
100224	4766
100224	4761
100224	4760
100224	4763
100224	4762
100224	4757
100224	4756
100224	4759
100224	4758
100224	4753
100224	4752
100224	4755
100224	4754
100224	4782
100224	4783
100224	4780
100224	4781
100224	4778
100224	4779
100224	4776
100224	4777
100224	4774
100224	4775
100224	4772
100224	4773
100224	4770
100224	4771
100224	4768
100224	4769
100224	4799
100224	4798
100224	4797
100224	4796
100224	4795
100224	4794
100224	4793
100224	4792
100224	4791
100224	4790
100224	4789
100224	4788
100224	4787
100224	4786
100224	4785
100224	4784
100224	4808
100224	4809
100224	4810
100224	4811
100224	4812
100224	4813
100224	4814
100224	4815
100224	4800
100224	4801
100224	4802
100224	4803
100224	4804
100224	4805
100224	4806
100224	4807
100224	4825
100224	4824
100224	4827
100224	4826
100224	4829
100224	4828
100224	4831
100224	4830
100224	4817
100224	4816
100224	4819
100224	4818
100224	4821
100224	4820
100224	4823
100224	4822
100224	4842
100224	4843
100224	4840
100224	4841
100224	4846
100224	4847
100224	4844
100224	4845
100224	4834
100224	4835
100224	4832
100224	4833
100224	4838
100224	4839
100224	4836
100224	4837
100224	4850
100224	4849
100224	4848
100225	4886
100225	4887
100225	4884
100225	4885
100225	4882
100225	4883
100225	4880
100225	4881
100225	4894
100225	4895
100225	4892
100225	4893
100225	4890
100225	4891
100225	4888
100225	4889
100225	4871
100225	4870
100225	4869
100225	4868
100225	4867
100225	4866
100225	4865
100225	4864
100225	4879
100225	4878
100225	4877
100225	4876
100225	4875
100225	4874
100225	4873
100225	4872
100225	4916
100225	4917
100225	4918
100225	4919
100225	4912
100225	4913
100225	4914
100225	4915
100225	4924
100225	4925
100225	4926
100225	4927
100225	4920
100225	4921
100225	4922
100225	4923
100225	4901
100225	4900
100225	4903
100225	4902
100225	4897
100225	4896
100225	4899
100225	4898
100225	4909
100225	4908
100225	4911
100225	4910
100225	4905
100225	4904
100225	4907
100225	4906
100225	4946
100225	4947
100225	4944
100225	4945
100225	4948
100225	4949
100225	4931
100225	4930
100225	4929
100225	4928
100225	4935
100225	4934
100225	4933
100225	4932
100225	4939
100225	4938
100225	4937
100225	4936
100225	4943
100225	4942
100225	4941
100225	4940
100225	4859
100225	4858
100225	4857
100225	4856
100225	4863
100225	4862
100225	4861
100225	4860
100225	4851
100225	4855
100225	4854
100225	4853
100225	4852
100003	4886
100003	4880
100003	4894
100003	4893
100003	4888
100003	4618
100003	4869
100003	4877
100003	4876
100003	4644
100003	4914
100003	4926
100003	4923
100003	4901
100003	4900
100003	4903
100003	4897
100003	4658
100003	4659
100003	4905
100003	4947
100003	4944
100003	4471
100003	4948
100003	4466
100003	4477
100003	4682
100003	4687
100003	4930
100003	4929
100003	4690
100003	4461
100003	4462
100003	4942
100003	4941
100003	4707
100003	4727
100003	4738
100003	4535
100003	4739
100003	4534
100003	4764
100003	4522
100003	4523
100003	4524
100003	4517
100003	4506
100003	4510
100003	4489
100003	4494
100003	4493
100003	4482
100003	4480
100003	4808
100003	4602
100003	4803
100003	4805
100003	4584
100003	4577
100003	4859
100003	4858
100003	4863
100003	4862
100003	4861
100003	4552
100003	4851
100003	4548
100003	4854
100003	4853
100003	4852
100228	10047
100228	10046
100228	10045
100228	10044
100228	10043
100228	10042
100228	10041
100228	10040
100228	10039
100228	10038
100228	10037
100228	10036
100228	10035
100228	10034
100228	10033
100228	10032
100228	10030
100228	10031
100228	10028
100228	10029
100228	10026
100228	10027
100228	10024
100228	10025
100228	10022
100228	10023
100228	10020
100228	10021
100228	10018
100228	10019
100228	10016
100228	10017
100228	10013
100228	10012
100228	10015
100228	10014
100228	10009
100228	10008
100228	10011
100228	10010
100228	10005
100228	10004
100228	10007
100228	10006
100228	10001
100228	10003
100228	10002
100228	10107
100228	10106
100228	10105
100228	10104
100228	10111
100228	10110
100228	10109
100228	10108
100228	10099
100228	10098
100228	10097
100228	10096
100228	10103
100228	10102
100228	10101
100228	10100
100228	10090
100228	10091
100228	10088
100228	10089
100228	10094
100228	10095
100228	10092
100228	10093
100228	10082
100228	10083
100228	10080
100228	10081
100228	10086
100228	10087
100228	10084
100228	10085
100228	10073
100228	10072
100228	10075
100228	10074
100228	10077
100228	10076
100228	10079
100228	10078
100228	10065
100228	10064
100228	10067
100228	10066
100228	10069
100228	10068
100228	10071
100228	10070
100228	10056
100228	10057
100228	10058
100228	10059
100228	10060
100228	10061
100228	10062
100228	10063
100228	10048
100228	10049
100228	10050
100228	10051
100228	10052
100228	10053
100228	10054
100228	10055
100228	10166
100228	10167
100228	10164
100228	10165
100228	10162
100228	10163
100228	10160
100228	10161
100228	10174
100228	10175
100228	10172
100228	10173
100228	10170
100228	10171
100228	10168
100228	10169
100228	10151
100228	10150
100228	10149
100228	10148
100228	10147
100228	10146
100228	10145
100228	10144
100228	10159
100228	10158
100228	10157
100228	10156
100228	10155
100228	10154
100228	10153
100228	10152
100228	10132
100228	10133
100228	10134
100228	10135
100228	10128
100228	10129
100228	10130
100228	10131
100228	10140
100228	10141
100228	10142
100228	10143
100228	10136
100228	10137
100228	10138
100228	10139
100228	10117
100228	10116
100228	10119
100228	10118
100228	10113
100228	10112
100228	10115
100228	10114
100228	10125
100228	10124
100228	10127
100228	10126
100228	10121
100228	10120
100228	10123
100228	10122
100228	10177
100228	10176
100228	10178
100229	10701
100229	10700
100229	10703
100229	10702
100229	10697
100229	10696
100229	10699
100229	10698
100229	10693
100229	10692
100229	10695
100229	10694
100229	10689
100229	10688
100229	10691
100229	10690
100229	10716
100229	10717
100229	10718
100229	10719
100229	10712
100229	10713
100229	10714
100229	10715
100229	10708
100229	10709
100229	10710
100229	10711
100229	10704
100229	10705
100229	10706
100229	10707
100229	10723
100229	10722
100229	10721
100229	10720
100229	10633
100229	10632
100229	10635
100229	10634
100229	10637
100229	10636
100229	10639
100229	10638
100229	10625
100229	10624
100229	10627
100229	10626
100229	10629
100229	10628
100229	10631
100229	10630
100229	10648
100229	10649
100229	10650
100229	10651
100229	10652
100229	10653
100229	10654
100229	10655
100229	10640
100229	10641
100229	10642
100229	10643
100229	10644
100229	10645
100229	10646
100229	10647
100229	10667
100229	10666
100229	10665
100229	10664
100229	10671
100229	10670
100229	10669
100229	10668
100229	10659
100229	10658
100229	10657
100229	10656
100229	10663
100229	10662
100229	10661
100229	10660
100229	10682
100229	10683
100229	10680
100229	10681
100229	10686
100229	10687
100229	10684
100229	10685
100229	10674
100229	10675
100229	10672
100229	10673
100229	10678
100229	10679
100229	10676
100229	10677
100229	10564
100229	10565
100229	10566
100229	10567
100229	10560
100229	10561
100229	10562
100229	10563
100229	10572
100229	10573
100229	10574
100229	10575
100229	10568
100229	10569
100229	10570
100229	10571
100229	10581
100229	10580
100229	10583
100229	10582
100229	10577
100229	10576
100229	10579
100229	10578
100229	10589
100229	10588
100229	10591
100229	10590
100229	10585
100229	10584
100229	10587
100229	10586
100229	10598
100229	10599
100229	10596
100229	10597
100229	10594
100229	10595
100229	10592
100229	10593
100229	10606
100229	10607
100229	10604
100229	10605
100229	10602
100229	10603
100229	10600
100229	10601
100229	10615
100229	10614
100229	10613
100229	10612
100229	10611
100229	10610
100229	10609
100229	10608
100229	10623
100229	10622
100229	10621
100229	10620
100229	10619
100229	10618
100229	10617
100229	10616
100229	10509
100229	10510
100229	10511
100229	10513
100229	10512
100229	10515
100229	10514
100229	10517
100229	10516
100229	10519
100229	10518
100229	10521
100229	10520
100229	10523
100229	10522
100229	10525
100229	10524
100229	10527
100229	10526
100229	10530
100229	10531
100229	10528
100229	10529
100229	10534
100229	10535
100229	10532
100229	10533
100229	10538
100229	10539
100229	10536
100229	10537
100229	10542
100229	10543
100229	10540
100229	10541
100229	10547
100229	10546
100229	10545
100229	10544
100229	10551
100229	10550
100229	10549
100229	10548
100229	10555
100229	10554
100229	10553
100229	10552
100229	10559
100229	10558
100229	10557
100229	10556
100161	14930
100161	14931
100161	14928
100161	14929
100161	14934
100161	14935
100161	14932
100161	14933
100161	14938
100161	14939
100161	14936
100161	14937
100161	14942
100161	14943
100161	14940
100161	14941
100161	14915
100161	14914
100161	14913
100161	14912
100161	14919
100161	14918
100161	14917
100161	14916
100161	14923
100161	14922
100161	14921
100161	14920
100161	14927
100161	14926
100161	14925
100161	14924
100161	14960
100161	14961
100161	14962
100161	14963
100161	14964
100161	14945
100161	14944
100161	14947
100161	14946
100161	14949
100161	14948
100161	14951
100161	14950
100161	14953
100161	14952
100161	14955
100161	14954
100161	14957
100161	14956
100161	14959
100161	14958
100161	14870
100161	14871
100161	14868
100161	14869
100161	14866
100161	14867
100161	14864
100161	14865
100161	14878
100161	14879
100161	14876
100161	14877
100161	14874
100161	14875
100161	14872
100161	14873
100161	14855
100161	14854
100161	14853
100161	14852
100161	14851
100161	14850
100161	14849
100161	14848
100161	14863
100161	14862
100161	14861
100161	14860
100161	14859
100161	14858
100161	14857
100161	14856
100161	14900
100161	14901
100161	14902
100161	14903
100161	14896
100161	14897
100161	14898
100161	14899
100161	14908
100161	14909
100161	14910
100161	14911
100161	14904
100161	14905
100161	14906
100161	14907
100161	14885
100161	14884
100161	14887
100161	14886
100161	14881
100161	14880
100161	14883
100161	14882
100161	14893
100161	14892
100161	14895
100161	14894
100161	14889
100161	14888
100161	14891
100161	14890
100161	14830
100161	14831
100161	14828
100161	14829
100161	14826
100161	14827
100161	14824
100161	14825
100161	14822
100161	14823
100161	14820
100161	14821
100161	14818
100161	14819
100161	14847
100161	14846
100161	14845
100161	14844
100161	14843
100161	14842
100161	14841
100161	14840
100161	14839
100161	14838
100161	14837
100161	14836
100161	14835
100161	14834
100161	14833
100161	14832
100157	14998
100157	14997
100157	14996
100157	14995
100157	14994
100157	14993
100157	14992
100157	14990
100157	14991
100157	14988
100157	14989
100157	14986
100157	14987
100157	14984
100157	14985
100157	14982
100157	14983
100157	14980
100157	14981
100157	14978
100157	14979
100157	14976
100157	14977
100157	14965
100157	14966
100157	14967
100157	14968
100157	14969
100157	14970
100157	14971
100157	14972
100157	14973
100157	14974
100157	14975
100231	15067
100231	15066
100231	15065
100231	15064
100231	15071
100231	15070
100231	15069
100231	15068
100231	15059
100231	15058
100231	15057
100231	15056
100231	15063
100231	15062
100231	15061
100231	15060
100231	15050
100231	15051
100231	10028
100231	15048
100231	15049
100231	15054
100231	15055
100231	15052
100231	15053
100231	15042
100231	15043
100231	15040
100231	15041
100231	15046
100231	15047
100231	15044
100231	15045
100231	15097
100231	15096
100231	15099
100231	15098
100231	15101
100231	15100
100231	15103
100231	15102
100231	15089
100231	15088
100231	15091
100231	15090
100231	15093
100231	15092
100231	15095
100231	15094
100231	15080
100231	15081
100231	15082
100231	15083
100231	15084
100231	15085
100231	15086
100231	15087
100231	15072
100231	15073
100231	15074
100231	15075
100231	15076
100231	15077
100231	15078
100231	15079
100231	15007
100231	15006
100231	15005
100231	15004
100231	15003
100231	15002
100231	15001
100231	15000
100231	14999
100231	15037
100231	15036
100231	15039
100231	15038
100231	15033
100231	15032
100231	15035
100231	15034
100231	15029
100231	15028
100231	15031
100231	15030
100231	15025
100231	15024
100231	15027
100231	15026
100231	15020
100231	15021
100231	15022
100231	15023
100231	15016
100231	15017
100231	15018
100231	15019
100231	15012
100231	15013
100231	15014
100231	15015
100231	15008
100231	15009
100231	15010
100231	15011
100231	15169
100231	15168
100231	15171
100231	15170
100231	15173
100231	15172
100231	15175
100231	15174
100231	15109
100231	15108
100231	15111
100231	15110
100231	15105
100231	15104
100231	15107
100231	15106
100231	15117
100231	15116
100231	15119
100231	15118
100231	15113
100231	15112
100231	15115
100231	15114
100231	15124
100231	15125
100231	15126
100231	15127
100231	15120
100231	15121
100231	15122
100231	15123
100231	15132
100231	15133
100231	15134
100231	15135
100231	15128
100231	15129
100231	15130
100231	15131
100231	15143
100231	15142
100231	15141
100231	15140
100231	15139
100231	15138
100231	15137
100231	15136
100231	15151
100231	15150
100231	15149
100231	15148
100231	15147
100231	15146
100231	15145
100231	15144
100231	15158
100231	15159
100231	15156
100231	15157
100231	15154
100231	15155
100231	15152
100231	15153
100231	15166
100231	15167
100231	15164
100231	15165
100231	15162
100231	15163
100231	15160
100231	15161
100232	15304
100232	15305
100232	15306
100232	15307
100232	15308
100232	15309
100232	15310
100232	15311
100232	15296
100232	15297
100232	15298
100232	15299
100232	15300
100232	15301
100232	15302
100232	15303
100232	15321
100232	15320
100232	15323
100232	15322
100232	15325
100232	15324
100232	15327
100232	15326
100232	15313
100232	15312
100232	15315
100232	15314
100232	15317
100232	15316
100232	15319
100232	15318
100232	15330
100232	15328
100232	15329
100232	15244
100232	15245
100232	15246
100232	15247
100232	15240
100232	15241
100232	15242
100232	15243
100232	15236
100232	15237
100232	15238
100232	15239
100232	15232
100232	15233
100232	15234
100232	15235
100232	15261
100232	15260
100232	15263
100232	15262
100232	15257
100232	15256
100232	15259
100232	15258
100232	15253
100232	15252
100232	15255
100232	15254
100232	15249
100232	15248
100232	15251
100232	15250
100232	15278
100232	15279
100232	15276
100232	15277
100232	15274
100232	15275
100232	15272
100232	15273
100232	15270
100232	15271
100232	15268
100232	15269
100232	15266
100232	15267
100232	15264
100232	15265
100232	15295
100232	15294
100232	15293
100232	15292
100232	15291
100232	15290
100232	15289
100232	15288
100232	15287
100232	15286
100232	15285
100232	15284
100232	15283
100232	15282
100232	15281
100232	15280
100232	15177
100232	15176
100232	15179
100232	15178
100232	15181
100232	15180
100232	15183
100232	15182
100232	15184
100232	15185
100232	15186
100232	15187
100232	15188
100232	15189
100232	15190
100232	15191
100232	15192
100232	15193
100232	15194
100232	15195
100232	15196
100232	15197
100232	15198
100232	15199
100232	15203
100232	15202
100232	15201
100232	15200
100232	15207
100232	15206
100232	15205
100232	15204
100232	15211
100232	15210
100232	15209
100232	15208
100232	15215
100232	15214
100232	15213
100232	15212
100232	15218
100232	15219
100232	15216
100232	15217
100232	15222
100232	15223
100232	15220
100232	15221
100232	15226
100232	15227
100232	15224
100232	15225
100232	15230
100232	15231
100232	15228
100232	15229
100233	15338
100233	15339
100233	15336
100233	15337
100233	15342
100233	15343
100233	15340
100233	15341
100233	15331
100233	15334
100233	15335
100233	15332
100233	15333
100233	15355
100233	15354
100233	15353
100233	15352
100233	15359
100233	15358
100233	15357
100233	15356
100233	15363
100233	15347
100233	15362
100233	15346
100233	15361
100233	15345
100233	15360
100233	15344
100233	15367
100233	15351
100233	15366
100233	15350
100233	15365
100233	15349
100233	15364
100233	15348
100161	14817
100003	15303
100003	15333
100003	15210
100003	15131
100003	10036
100003	10028
100003	10027
100003	10025
100003	10013
100003	10014
100003	15102
100003	10560
100003	14942
100003	14940
100003	10581
100003	14971
100003	10120
100003	10510
100003	10525
100003	10524
100003	10527
100003	10526
100003	10528
100003	10529
100003	10543
100234	15490
100234	15491
100234	15488
100234	15489
100234	15494
100234	15495
100234	15492
100234	15493
100234	15416
100234	15417
100234	15418
100234	15419
100234	15420
100234	15421
100234	15422
100234	15423
100234	15408
100234	15409
100234	15410
100234	15411
100234	15412
100234	15413
100234	15414
100234	15415
100234	15401
100234	15400
100234	15403
100234	15402
100234	15405
100234	15404
100234	15407
100234	15406
100234	15393
100234	15392
100234	15395
100234	15394
100234	15397
100234	15396
100234	15399
100234	15398
100234	15386
100234	15387
100234	15384
100234	15385
100234	15390
100234	15391
100234	15388
100234	15389
100234	15378
100234	15379
100234	15376
100234	15377
100234	15382
100234	15383
100234	15380
100234	15381
100234	15371
100234	15370
100234	15369
100234	15368
100234	15375
100234	15374
100234	15373
100234	15372
100234	15484
100234	15485
100234	15486
100234	15487
100234	15480
100234	15481
100234	15482
100234	15483
100234	15476
100234	15477
100234	15478
100234	15479
100234	15472
100234	15473
100234	15474
100234	15475
100234	15469
100234	15468
100234	15471
100234	15470
100234	15465
100234	15464
100234	15467
100234	15466
100234	15461
100234	15460
100234	15463
100234	15462
100234	15457
100234	15456
100234	15459
100234	15458
100234	15454
100234	15455
100234	15452
100234	15453
100234	15450
100234	15451
100234	15448
100234	15449
100234	15446
100234	15447
100234	15444
100234	15445
100234	15442
100234	15443
100234	15440
100234	15441
100234	15439
100234	15438
100234	15437
100234	15436
100234	15435
100234	15434
100234	15433
100234	15432
100234	15431
100234	15430
100234	15429
100234	15428
100234	15427
100234	15426
100234	15425
100234	15424
100236	15537
100236	15536
100236	15539
100236	15538
100236	15541
100236	15540
100236	15543
100236	15542
100236	15545
100236	15544
100236	15547
100236	15546
100236	15548
100236	15522
100236	15523
100236	15524
100236	15525
100236	15526
100236	15527
100236	15528
100236	15529
100236	15530
100236	15531
100236	15532
100236	15533
100236	15534
100236	15535
\.


--
-- TOC entry 1947 (class 0 OID 0)
-- Dependencies: 168
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: cah
--

SELECT pg_catalog.setval('hibernate_sequence', 100236, true);


--
-- TOC entry 1933 (class 0 OID 16404)
-- Dependencies: 166
-- Data for Name: white_cards; Type: TABLE DATA; Schema: public; Owner: cah
--

COPY white_cards (id, text, watermark) FROM stdin;
282	Michelle Obama's arms.	\N
124	White people.	\N
393	An erection that lasts longer than four hours.	\N
141	Panda sex.	\N
121	Stifling a giggle at the mention of Hutus and Tutsis.	\N
269	A middle-aged man on roller skates.	\N
1	Coat hanger abortions.	\N
138	Scrubbing under the folds.	\N
275	Wearing underwear inside-out to avoid doing laundry.	\N
3662	Canadian Kindness.	RS
1146	end First Expansion	\N
3663	The world's tallest midget.	RS
462	MechaHitler.	1.2
463	Getting naked and watching Nickelodeon.	1.2
464	Charisma.	1.2
465	Morgan Freeman's voice.	1.2
466	Breaking out into song and dance.	1.2
467	Soup that is too hot.	1.2
468	Chutzpah.	1.2
469	Unfathomable stupidity.	1.2
470	Horrifying laser hair removal accidents.	1.2
471	Boogers.	1.2
3664	The shitty remains of Taco Bell&reg;.	RS
473	Expecting a burp and vomiting on the floor.	1.2
474	A defective condom.	1.2
475	Teenage pregnancy.	1.2
476	Hot cheese.	1.2
477	A mopey zoo lion.	1.2
478	Shapeshifters.	1.2
479	The Care Bear Stare.	1.2
480	Erectile dysfunction.	1.2
481	The chronic.	1.2
483	"Tweeting."	1.2
484	Firing a rifle into the air while balls deep in a squealing hog.	1.2
485	Nicolas Cage.	1.2
3665	Master Chief.	RS
1110	Leveling up.	X1
1111	Literally eating shit.	X1
1112	Making the penises kiss.	X1
1113	Media coverage.	X1
3666	Four Loko.	RS
1115	Moral ambiguity.	X1
1116	My machete.	X1
1117	One thousand Slim Jims.	X1
1118	Ominous background music.	X1
1119	Overpowering your father.	X1
1120	Pistol-whipping a hostage.	X1
1121	Quiche.	X1
1122	Quivering jowls.	X1
1123	Revenge fucking.	X1
1124	Ripping into a man's chest and pulling out his still-beating heart.	X1
1125	Ryan Gosling riding in on a white horse.	X1
1126	Santa Claus.	X1
1127	Scrotum tickling.	X1
1128	Sexual humiliation.	X1
1129	Sexy Siamese twins.	X1
1130	Slow motion.	X1
1131	Space muffins.	X1
1132	Statistically validated stereotypes.	X1
1133	Sudden Poop Explosion Disease.	X1
1134	The boners of the elderly.	X1
1135	The economy.	X1
225	Dropping a chandelier on your enemies and riding the rope up.	\N
297	Public ridicule.	\N
265	A snapping turtle biting the tip of your penis.	\N
218	Vehicular manslaughter.	\N
3667	Xyzzy playing around with gender roles.	RS
160	The token minority.	\N
3668	Walt Disney's frozen head.	RS
3669	Sponge baths.	RS
488	A gentle caress of the inner thigh.	1.2
489	Poor life choices.	1.2
490	Embryonic stem cells.	1.2
491	Customer service representatives.	1.2
492	The Little Engine That Could.	1.2
493	Lady Gaga.	1.2
494	A death ray.	1.2
495	Vigilante justice.	1.2
496	Exactly what you'd expect.	1.2
497	Natural male enhancement.	1.2
498	Passive-aggressive Post-it notes.	1.2
499	Inappropriate yodeling.	1.2
500	A homoerotic volleyball montage.	1.2
501	Actually taking candy from a baby.	1.2
502	Jibber-jabber.	1.2
503	Crystal meth.	1.2
504	My inner demons.	1.2
505	Pac-Man uncontrollably guzzling cum.	1.2
506	My vagina.	1.2
3670	Sonic brutally murdering Mario.	RS
508	The true meaning of Christmas.	1.2
3671	Mario brutally murdering Sonic.	RS
1137	The Gulags.	X1
1138	The harsh light of day.	X1
1139	The hiccups.	X1
1140	The shambling corpse of Larry King.	X1
1141	The four arms of Vishnu.	X1
1142	Being a busy adult with many important things to do.	X1
1143	Tripping balls.	X1
1144	Words, words, words.	X1
1145	Zeus's sexual appetites.	X1
1066	A big black dick.	X1
1067	A beached whale.	X1
1068	A bloody pacifier.	X1
1069	A crappy little hand.	X1
1070	A low standard of living.	X1
1071	A nuanced critique.	X1
1072	Panty raids.	X1
1073	A passionate Latino lover.	X1
1074	A rival dojo.	X1
1075	A web of lies.	X1
1076	A woman scorned.	X1
1078	Apologizing.	X1
1079	Appreciative snapping.	X1
1080	Neil Patrick Harris.	X1
1081	Beating your wives.	X1
1082	Being a dinosaur.	X1
1083	Shaft.	X1
1217	A soulful rendition of "Ol' Man River."	X2
1218	Intimacy problems.	X2
1219	A sweaty, panting leather daddy.	X2
1220	Spring break!	X2
1221	Being awesome at sex.	X2
1222	Dining with cardboard cutouts of the cast of "Friends."	X2
461	Flying sex snakes.	1.2
1077	Clams.	X1
1223	Another shot of morphine.	X2
1226	Bullshit.	X2
1227	The Google.	X2
3672	Getting high on bath salts.	RS
1229	The new Radiohead album.	X2
1230	An army of skeletons.	X2
1231	A man in yoga pants with a ponytail and feather earrings.	X2
1232	Mild autism.	X2
1233	Nunchuck moves.	X2
1234	Whipping a disobedient slave.	X2
1235	An ether-soaked rag.	X2
1236	A sweet spaceship.	X2
1237	A 55-gallon drum of lube.	X2
1238	Special musical guest, Cher.	X2
1239	The human body.	X2
1240	Boris the Soviet Love Hammer.	X2
1241	The grey nutrient broth that sustains Mitt Romney.	X2
1242	Tiny nipples.	X2
1243	Power.	X2
1244	Oncoming traffic.	X2
1245	A dollop of sour cream.	X2
1246	A slightly shittier parallel universe.	X2
1247	My first kill.	X2
1248	Graphic violence, adult language, and some sexual content.	X2
1249	Fetal alcohol syndrome.	X2
1250	The day the birds attacked.	X2
1251	One Ring to rule them all.	X2
1252	Grandpa's ashes.	X2
1253	Basic human decency.	X2
1254	A Burmese tiger pit.	X2
1255	Death by Steven Seagal.	X2
1002	testtest	\N
1031	End Canadian White Cards	\N
1010	Mr. Dressup.	CAN
1011	Being Canadian.	CAN
1012	The Famous Five.	CAN
1013	Stephen Harper.	CAN
1014	The Royal Canadian Mounted Police.	CAN
1015	An icy handjob from an Edmonton hooker.	CAN
1016	Poutine.	CAN
1017	Newfies.	CAN
1018	The Official Languages Act. La Loi sur les langues officielles.	CAN
1019	Terry Fox's prosthetic leg.	CAN
1020	The FLQ.	CAN
1021	Canada: America's Hat.	CAN
1022	Don Cherry's wardrobe.	CAN
1023	Burning down the White House.	CAN
1024	Heritage minutes.	CAN
1025	Homo milk.	CAN
1026	Naked News.	CAN
1027	Syrupy sex with a maple tree.	CAN
1028	Snotsicles.	CAN
1029	Schmirler the Curler.	CAN
1030	A Molson muscle.	CAN
1181	A bigger, blacker dick.	X2
3673	Snorting Pixie Stix.	RS
1183	A sad fat dragon with no friends.	X2
1184	Catastrophic urethral trauma.	X2
1185	Hillary Clinton's death stare.	X2
1186	Existing.	X2
3674	Poorly written Star Wars&reg; fan fiction.	RS
1188	Mooing.	X2
1189	Swiftly achieving orgasm.	X2
1190	Daddy's belt.	X2
1191	Double penetration.	X2
1192	Weapons-grade plutonium.	X2
1193	Some really fucked-up shit.	X2
1194	Subduing a grizzly bear and making her your wife.	X2
1195	Rising from the grave.	X2
1196	The mixing of the races.	X2
1197	Taking a man's eyes and balls out and putting his eyes where his balls go and then his balls in the eye holes.	X2
1198	Scrotal frostbite.	X2
1199	All of this blood.	X2
1200	Loki, the trickster god.	X2
1201	Whining like a little bitch.	X2
1202	Pumping out a baby every nine months.	X2
1203	Tongue.	X2
1204	Finding Waldo.	X2
1205	Upgrading homeless people to mobile hotspots.	X2
1206	Wearing an octopus for a hat.	X2
1207	An unhinged ferris wheel rolling toward the sea.	X2
1208	Living in a trashcan.	X2
1209	The corporations.	X2
1210	A magic hippie love cloud.	X2
1211	Fuck Mountain.	X2
1212	Survivor's guilt.	X2
1213	Me.	X2
1214	Getting hilariously gang-banged by the Blue Man Group.	X2
1215	Jeff Goldblum.	X2
1216	Making a friend.	X2
44	German dungeon porn.	\N
40	Praying the gay away.	\N
63	Dying.	\N
41	Same-sex ice dancing.	\N
70	Dying of dysentery.	\N
19	Roofies.	\N
22	The Big Bang.	\N
23	Amputees.	\N
74	Men.	\N
18	Concealing a boner.	\N
87	Agriculture.	\N
51	Making a pouty face.	\N
98	YOU MUST CONSTRUCT ADDITIONAL PYLONS.	\N
60	Hormone injections.	\N
55	Tom Cruise.	\N
56	Object permanence.	\N
92	Consultants.	\N
26	Being marginalized.	\N
54	The profoundly handicapped.	\N
96	Party poopers.	\N
48	Nickelback.	\N
7	Doing the right thing.	\N
65	The invisible hand.	\N
49	Heteronormativity.	\N
29	Cuddling.	\N
84	Raptor attacks.	\N
38	Fear itself.	\N
91	Sniffing glue.	\N
58	An icepick lobotomy.	\N
109	Being rich.	\N
79	The clitoris.	\N
71	Sexy pillow fights.	\N
105	Michael Jackson.	\N
101	Sexting.	\N
33	Horse meat.	\N
8	Hunting accidents.	\N
9	A cartoon camel enjoying the smooth, refreshing taste of a cigarette.	\N
15	Abstinence.	\N
17	Mountain Dew Code Red.	\N
21	Tweeting.	\N
43	Making sex at her.	\N
64	Stunt doubles.	\N
69	Flavored condoms.	\N
100	Heath Ledger.	\N
110	Muzzy.	\N
97	Sunshine and rainbows.	\N
68	Flash flooding.	\N
57	Goblins.	\N
13	Spectacular abs.	\N
72	The Three-Fifths compromise.	\N
4	Vigorous jazz hands.	\N
106	Skeletor.	\N
80	Vikings.	\N
34	Genital piercings.	\N
3675	The final circle of Hell.	RS
67	A really cool hat.	\N
102	An Oedipus complex.	\N
82	The Underground Railroad.	\N
77	Heartwarming orphans.	\N
47	Cheating in the Special Olympics.	\N
108	Sharing needles.	\N
46	Ethnic cleansing.	\N
103	Eating all of the cookies before the AIDS bake-sale.	\N
93	My humps.	\N
10	The violation of our most basic human rights.	\N
35	Fingering.	\N
53	The placenta.	\N
5	Flightless birds.	\N
37	Stranger danger.	\N
107	Chivalry.	\N
76	Sean Penn.	\N
73	A sad handjob.	\N
66	Jew-fros.	\N
12	Self-loathing.	\N
61	A falcon with a cap on its head.	\N
75	Historically black colleges.	\N
30	Aaron Burr.	\N
25	Former President George W. Bush.	\N
94	Geese.	\N
99	Mutually-assured destruction.	\N
88	Bling.	\N
27	Smegma.	\N
90	The South.	\N
83	Pretending to care.	\N
59	Arnold Schwarzenegger.	\N
20	Glenn Beck convulsively vomiting as a brood of crab spiders hatches in his brain and erupts from his tear ducts.	\N
104	A sausage festival.	\N
62	Foreskin.	\N
95	Being a dick to children.	\N
52	Chainsaws for hands.	\N
86	A Gypsy curse.	\N
31	The Pope.	\N
16	A balanced breakfast.	\N
36	Elderly Japanese men.	\N
6	Pictures of boobs.	\N
39	Science.	\N
32	A bleached asshole.	\N
3	Autocannibalism.	\N
50	William Shatner.	\N
85	A micropenis.	\N
78	Waterboarding.	\N
45	Bingeing and purging.	\N
89	A clandestine butt scratch.	\N
2	Man meat.	\N
28	Laying an egg.	\N
14	An honest cop with nothing left to lose.	\N
42	The terrorists.	\N
81	Friends who eat all the snacks.	\N
1043	end misprint bonus card	\N
1034	A bitch slap.	B
1035	One trillion dollars.	B
1036	Chunks of dead prostitute.	B
1037	The entire Mormon Tabernacle Choir.	B
1038	The female orgasm.	B
1039	Extremely tight pants.	B
1040	Stormtroopers.	B
1041	The Boy Scouts of America.	B
1042	Throwing a virgin into a volcano.	B
120	Cookie Monster devouring the Eucharist wafers.	\N
123	Letting yourself go.	\N
3676	The Bible.	RS
131	A LAN party.	\N
133	A grande sugar-free iced soy caramel macchiato.	\N
143	Will Smith.	\N
156	Marky Mark and the Funky Bunch.	\N
158	Dave Matthews Band.	\N
164	Substitute teachers.	\N
177	Garth Brooks.	\N
188	Keeping Christ in Christmas.	\N
190	That one gay Teletubby.	\N
216	Passive-agression.	\N
3677	Borat's one piece.	RS
248	The People's Elbow.	\N
230	Guys who don't call.	\N
152	AIDS.	\N
187	The Rapture.	\N
244	Eugenics.	\N
181	Taking off your shirt.	\N
139	A drive-by shooting.	\N
217	Ronald Reagan.	\N
195	Jewish fraternities.	\N
198	All-you-can-eat shrimp for $4.99.	\N
233	Scalping.	\N
196	Edible underpants.	\N
154	Figgy pudding.	\N
240	Intelligent design.	\N
207	Nocturnal emissions.	\N
119	Uppercuts.	\N
180	The American Dream.	\N
226	Testicular torsion.	\N
201	The folly of man.	\N
153	The KKK.	\N
241	The taint; the grundle; the fleshy fun-bridge.	\N
237	Saxophone solos.	\N
200	That thing that electrocutes your abs.	\N
176	Oversized lollipops.	\N
161	Friends with benefits.	\N
137	Teaching a robot to love.	\N
205	Me time.	\N
250	The heart of a child.	\N
252	Smallpox blankets.	\N
127	Yeast.	\N
214	Full frontal nudity.	\N
175	Authentic Mexican cuisine.	\N
253	Licking things to claim them as your own.	\N
174	Genghis Khan.	\N
209	The hardworking Mexican.	\N
189	RoboCop.	\N
112	Spontaneous human combustion.	\N
128	Natural selection.	\N
245	A good sniff.	\N
212	Nipple blades.	\N
126	Leaving an awkward voicemail.	\N
213	Assless chaps.	\N
191	Sweet, sweet vengeance.	\N
243	Keg stands.	\N
232	Darth Vader.	\N
114	Necrophilia.	\N
144	Toni Morrison's vagina.	\N
159	Preteens.	\N
185	A cooler full of organs.	\N
178	Keanu Reeves.	\N
166	A thermonuclear detonation.	\N
186	A moment of silence.	\N
142	Catapults.	\N
118	Emotions.	\N
151	Balls.	\N
234	Homeless people.	\N
173	Old-people smell.	\N
117	Farting and walking away.	\N
206	The inevitable heat death of the universe.	\N
24	The Rev. Dr. Martin Luther King, Jr.	\N
136	Sperm whales.	\N
204	A murder most foul.	\N
208	Daddy issues.	\N
199	Britney Spears at 55.	\N
210	Natalie Portman.	\N
223	The Holy Bible.	\N
3678	LOOK AT THIS PHOTOGRAPH!	RS
220	Pulling out.	\N
163	Pixelated bukkake.	\N
168	Waiting 'til marriage.	\N
235	The World of Warcraft.	\N
116	Global warming.	\N
224	World peace.	\N
170	A can of whoop-ass.	\N
148	A zesty breakfast burrito.	\N
221	Picking up girls at the abortion clinic.	\N
146	Land mines.	\N
113	College.	\N
228	A time travel paradox.	\N
155	Seppuku.	\N
211	Waking up half-naked in a Denny's parking lot.	\N
149	Christopher Walken.	\N
236	Gloryholes.	\N
169	A tiny horse.	\N
184	Child abuse.	\N
219	Menstruation.	\N
135	A sassy black woman.	\N
162	Re-gifting.	\N
122	Penis envy.	\N
179	Drinking alone.	\N
215	Hulk Hogan.	\N
3679	A 1971 Ford Pinto.	RS
140	Whipping it out.	\N
171	Dental dams.	\N
157	Gandhi.	\N
239	God.	\N
150	Friction.	\N
147	A sea of troubles.	\N
197	Poor people.	\N
183	Flesh-eating bacteria.	\N
125	Dick Cheney.	\N
246	Lockjaw.	\N
165	Take-backsies.	\N
132	Opposable thumbs.	\N
222	The homosexual agenda.	\N
202	Fiery poops.	\N
203	Cards Against Humanity.	\N
3680	Shitting on the White House lawn.	RS
238	Sean Connery.	\N
227	The milk man.	\N
115	The Chinese gymnastics team.	\N
231	Eating the last known bison.	\N
134	Soiling oneself.	\N
182	Giving 110%.	\N
242	Friendly fire.	\N
111	Count Chocula.	\N
172	Feeding Rosie O'Donnell.	\N
251	Seduction.	\N
194	Being a motherfucking sorcerer.	\N
264	Eastern European Turbo-Folk music.	\N
273	Douchebags on their iPhones.	\N
281	The deformed.	\N
285	Donald Trump.	\N
288	This answer is postmodern.	\N
301	African children.	\N
307	Have some more kugel.	\N
310	Crippling debt.	\N
313	Shorties and blunts.	\N
328	(I am doing Kegels right now.)	\N
331	Bestiality.	\N
333	Drum circles.	\N
338	Inappropriate yelling.	\N
341	The Thong Song.	\N
342	A vajazzled vagina.	\N
3681	Mountain Dew&reg; Baja Blast.	RS
3682	Nessie.	RS
363	Tiger Woods.	\N
371	PCP.	\N
383	Mr. Snuffleupagus.	\N
394	A disappointing birthday party.	\N
319	Puppies!	\N
308	A windmill full of corpses.	\N
340	Being on fire.	\N
372	A lifetime of sadness.	\N
258	Pterodactyl eggs.	\N
289	Crumpets with the Queen.	\N
344	Exchanging pleasantries.	\N
276	Republicans.	\N
321	Kim Jong-il.	\N
366	Glenn Beck being harried by a swarm of buzzards.	\N
254	A salty surprise.	\N
330	The Jews.	\N
324	Incest.	\N
3683	Princess Peach's Cake.	RS
391	Nazis.	\N
292	Repression.	\N
287	Attitude.	\N
361	Passable transvestites.	\N
395	Puberty.	\N
374	Swooping.	\N
4221	Rob Liefeld.	TGWTG
379	A look-see.	\N
348	Lactation.	\N
266	Pabst Blue Ribbon.	\N
357	The gays.	\N
278	A foul mouth.	\N
377	A hot mess.	\N
268	My collection of high-tech sex toys.	\N
318	Bees?	\N
388	Getting drunk on mouthwash.	\N
277	The glass ceiling.	\N
286	Sarah Palin.	\N
291	Team-building exercises.	\N
290	Frolicking.	\N
380	Not giving a shit about the Third World.	\N
345	My relationship status.	\N
384	Barack Obama.	\N
302	Mouth herpes.	\N
386	Wiping her butt.	\N
263	Pedophiles.	\N
373	Doin' it in the butt.	\N
347	Being fabulous.	\N
389	An M. Night Shyamalan plot twist.	\N
294	A bag of magic beans.	\N
296	Dead parents.	\N
257	My sex life.	\N
343	Riding off into the sunset.	\N
364	Dick fingers.	\N
362	The Virginia Tech Massacre.	\N
387	Queefing.	\N
339	Tangled Slinkys.	\N
337	Civilian casualties.	\N
316	Leprosy.	\N
325	Grave robbing.	\N
376	Tentacle porn.	\N
304	Bill Nye the Science Guy.	\N
370	New Age music.	\N
261	72 virgins.	\N
322	Hope.	\N
314	Passing a kidney stone.	\N
299	A mime having a stroke.	\N
368	Classist undertones.	\N
298	A mating display.	\N
382	The Kool-Aid Man.	\N
349	Not reciprocating oral sex.	\N
352	Date rape.	\N
306	Italians.	\N
256	My soul.	\N
3684	Two midgets stacked up pretending to be one person.	RS
312	A stray pube.	\N
279	Jerking off into a pool of children's tears.	\N
280	Getting really high.	\N
378	Too much hair gel.	\N
303	Overcompensation.	\N
272	Free samples.	\N
346	Shaquille O'Neal's acting career.	\N
271	Half-assed foreplay.	\N
283	Explosions.	\N
392	White privilege.	\N
293	Road head.	\N
255	Poorly-timed Holocaust jokes.	\N
323	8 oz. of sweet Mexican black-tar heroin.	\N
355	Judge Judy.	\N
259	Altar boys.	\N
358	Scientology.	\N
329	Justin Bieber.	\N
327	Alcoholism.	\N
351	My genitals.	\N
332	Winking at old people.	\N
385	Golden showers.	\N
365	Racism.	\N
336	Auschwitz.	\N
262	Raping and pillaging.	\N
334	Kids with ass cancer.	\N
274	Hurricane Katrina.	\N
356	Lumberjack fantasies.	\N
381	American Gladiators.	\N
295	An asymmetric boob job.	\N
326	Asians who aren't good at math.	\N
335	Loose lips.	\N
270	The Blood of Christ.	\N
317	A brain tumor.	\N
315	Prancing.	\N
375	The Hamburglar.	\N
360	Police brutality.	\N
260	Forgetting the Alamo.	\N
369	Booby-trapping the house to foil burglars.	\N
359	Estrogen.	\N
390	A robust mongoloid.	\N
309	Her Royal Highness, Queen Elizabeth II.	\N
193	Pooping back and forth. Forever.	\N
320	Cockfights.	\N
305	Bitches.	\N
300	Stephen Hawking talking dirty.	\N
403	Those times when you get sand in your vagina.	\N
424	Faith healing.	\N
428	Impotence.	\N
454	Bananas in Pajamas.	\N
399	Getting so angry that you pop a boner.	\N
414	Tasteful sideboob.	\N
396	Two midgets shitting into a bucket.	\N
406	Racially-biased SAT questions.	\N
449	Glenn Beck catching his scrotum on a curtain hook.	\N
398	The forbidden fruit.	\N
459	Anal beads.	\N
367	Surprise sex!	\N
426	Dead babies.	\N
129	Masturbation.	\N
452	The Hustle.	\N
3685	Apples to Apples&reg;.	RS
409	Obesity.	\N
429	Child beauty pageants.	\N
422	Goats eating coins.	\N
457	Kamikaze pilots.	\N
443	Powerful thighs.	\N
450	A big hoopla about nothing.	\N
433	Women's suffrage.	\N
442	John Wilkes Booth.	\N
425	Parting the Red Sea.	\N
435	Harry Potter erotica.	\N
416	Grandma.	\N
407	Porn stars.	\N
423	A monkey smoking a cigar.	\N
439	Mathletes.	\N
437	Lance Armstrong's missing testicle.	\N
434	Children on leashes.	\N
445	Multiple stab wounds.	\N
411	Oompa-Loompas.	\N
451	Peeing a little bit.	\N
421	The miracle of childbirth.	\N
448	Another goddamn vampire movie.	\N
3686	The tears of a college student.	RS
455	Active listening.	\N
402	A gassy antelope.	\N
412	BATMAN!!!	\N
413	Black people.	\N
447	Serfdom.	\N
418	The Trail of Tears.	\N
453	Ghosts.	\N
436	The Dance of the Sugar Plum Fairy.	\N
420	Finger painting.	\N
249	Robert Downey, Jr.	\N
405	Muhammed (Praise Be Unto Him).	\N
419	Famine.	\N
431	AXE Body Spray.	\N
458	The Force.	\N
446	Cybernetic enhancements.	\N
444	Mr. Clean, right behind you.	\N
401	Third base.	\N
438	Dwarf tossing.	\N
408	A fetus.	\N
441	Women in yogurt commercials.	\N
417	Copping a feel.	\N
400	Sexual tension.	\N
456	Dry heaving.	\N
430	Centaurs.	\N
397	Wifely duties.	\N
415	Hot people.	\N
432	Kanye West.	\N
427	The Amish.	\N
410	When you fart and a little bit comes out.	\N
1084	Bosnian chicken farmers.	X1
1085	Nubile slave boys.	X1
1086	Carnies.	X1
1087	Coughing into a vagina.	X1
1088	Suicidal thoughts.	X1
1089	Dancing with a broom.	X1
1090	Deflowering the princess.	X1
1091	Dorito breath.	X1
1092	Eating an albino.	X1
1093	Enormous Scandinavian women.	X1
1094	Fabricating statistics.	X1
1095	Finding a skeleton.	X1
1096	Gandalf.	X1
1097	Genetically engineered super-soldiers.	X1
1098	George Clooney's musk.	X1
1099	Getting abducted by Peter Pan.	X1
1100	Getting in her pants, politely.	X1
1101	Gladiatorial combat.	X1
1102	Good grammar.	X1
1103	Hipsters.	X1
1104	Historical revisionism.	X1
1105	Insatiable bloodlust.	X1
1106	Jafar.	X1
1107	Jean-Claude Van Damme.	X1
1108	Just the tip.	X1
1109	Mad hacky-sack skills.	X1
1224	Beefin' over turf.	X2
1225	A squadron of moles wearing aviator goggles.	X2
1258	A cutie mark.	MLP
1259	A daisy sandwich.	MLP
1261	A decorative toaster cozy.	MLP
1263	A giant horse cock.	MLP
1266	A hoof in the ass.	MLP
1269	A horny stallion.	MLP
1271	A human fetish.	MLP
1272	A juice box fetish.	MLP
1274	A juice box.	MLP
1276	A mare in heat.	MLP
1278	A racially pure Cloudsdale.	MLP
1280	A sexy saddle.	MLP
1282	A sock fetish.	MLP
1284	A Sonic Raingasm.	MLP
1286	A tactical sonic rainnuke.	MLP
1288	A tree.	MLP
1290	Actually cumming inside Rainbow Dash.	MLP
1293	An epic pony war in the distant future.	MLP
1294	An extremely horny Granny Smith.	MLP
1296	Another doughnut! With extra sprinkles!	MLP
1298	Applebucking.	MLP
1299	Applejack.	MLP
1300	Avasting Fluttershy's Ass.	MLP
1302	Baked Bads.	MLP
1304	Banned From Equestria (Daily).	MLP
1307	Being trapped on the Moon for 1000 years.	MLP
1308	Best Pony.	MLP
1310	Big Macintosh.	MLP
1312	BonBon.	MLP
1314	Books.	MLP
1316	Celestia's Hoof.	MLP
1318	Celestia's massive harem of foals.	MLP
1320	Cider.	MLP
1322	Clopfics.	MLP
1324	Clopping.	MLP
1326	Crippled foals.	MLP
1328	Cupcakes.	MLP
1331	Da Magicks.	MLP
1332	Daring Do fanfiction.	MLP
1333	Dark Magicks.	MLP
1334	Derpy Hooves.	MLP
1335	Diamond Dog roleplay.	MLP
1336	Discord.	MLP
1337	Equestria.	MLP
1338	Facehoofing.	MLP
1339	Fillidelphia.	MLP
1340	Filly fiddling.	MLP
1341	Fluffy Pony.	MLP
1342	Fluttershy.	MLP
1343	Fluttershy's secret stash.	MLP
1344	Fluttershy's Shed.	MLP
1346	Fluttertree.	MLP
1348	Foal abuse.	MLP
1349	Foodmanes.	MLP
1351	Friendship.	MLP
1357	Futaloo.	MLP
1358	Gabby Gums.	MLP
1360	Gently stroking the horn.	MLP
1362	Getting 20% cooler!	MLP
1364	Gypsies.	MLP
1367	Having hot pony sex with Bloomberg.	MLP
1368	Horn Necrosis.	MLP
1379	Hugging a pony non-sexually.	MLP
1380	Jappleack.	MLP
1381	Joe's Donut Hole.	MLP
1382	John Joseco.	MLP
1383	Lesbians.	MLP
1384	Zecora's meth lab.	MLP
1385	Lyra Heartstrings.	MLP
1386	Worst pony.	MLP
1387	Magic.	MLP
1388	Wolfieshy.	MLP
1389	Winter Wrap Up.	MLP
1390	Making Magic.	MLP
1391	Wincest.	MLP
1392	Whipping the Earth Pony slaves.	MLP
1393	Vinyl Scratch / DJ Pon-3.	MLP
1394	Unicorn Privilege.	MLP
1395	Man Spike.	MLP
1396	Two fillies shitting into a bucket.	MLP
1397	Manehatten.	MLP
1398	Twist.	MLP
1399	Mare Supremacy.	MLP
1400	Twilight's secret clop stash.	MLP
1401	Molestia's sex dungeon.	MLP
1402	Twilight Sparkle.	MLP
1403	THE ROYAL CANTERLOT VOICE.	MLP
1404	My OC.	MLP
1405	The Rainbow Factory.	MLP
1406	Nightmare Moon.	MLP
1407	The Pegasus Master Race.	MLP
1408	Octavia.	MLP
1409	The Moon.	MLP
1410	Orphaned foals.	MLP
1411	Pants.	MLP
1412	The Great and Powerful Trixie Lulamoon.	MLP
1413	The Grand Galloping Gala.	MLP
1414	Pegasus wing deformities.	MLP
1415	The Friendship Express.	MLP
1416	Pinkamena Diane Pie.	MLP
1417	The Chocolate Mousse Moose.	MLP
1418	The Cakes.	MLP
1419	Pinkamena's hacksaw.	MLP
1420	That squee noise.	MLP
1421	That Lyra plushie.	MLP
1422	Sweetie Bot.	MLP
1423	Sweetie Belle's virgin marshmallow pussy.	MLP
1424	Sweetie Belle.	MLP
1425	Pinkie Pie in full latex.	MLP
1426	Surprise.	MLP
1427	Stretching those glutes.	MLP
1428	Pinkie Pie.	MLP
1429	Steven Magnets.	MLP
1430	Plot.	MLP
1431	Spike's understanding of biology.	MLP
1432	Speaking Fancy.	MLP
1433	Poison Joke.	MLP
1434	Socks.	MLP
1435	Ponies wearing clothes.	MLP
1436	Sloppy clop.	MLP
1437	Shipping.	MLP
1438	Ponies with fucking lasers on their heads.	MLP
1439	Shaking Dat Plot.	MLP
1440	Secretly being a changeling all along.	MLP
1441	Ponies.	MLP
1442	Scootabuse.	MLP
1443	Pony racism.	MLP
1444	Scoot, Scoot-A-Loo.	MLP
1445	Pony-Griffon marriage.	MLP
1446	Rarity.	MLP
1447	Rainbow Dash.	MLP
1448	Rainbow Crash.	MLP
1449	Ponychan.	MLP
1450	Raging wingboners.	MLP
1451	Queen Chrysalis.	MLP
1452	Princess Molestia.	MLP
1453	Princess Celestia.	MLP
1454	Princess Mi Amore Cadenza.	MLP
1455	Princess Luna.	MLP
1464	Santa's heavy sack.	❄
1465	Clearing a bloody path through Walmart with a scimitar.	❄
1466	Another shitty year.	❄
1467	Whatever Kwanzaa is supposed to be about.	❄
1468	A Christmas stocking full of coleslaw.	❄
1469	Elf cum.	❄
1470	The tiny, calloused hands of the Chinese children that made this card.	❄
1471	Taking down Santa with a surface-to-air missle.	❄
1473	Socks. 	❄
1474	Pretending to be happy.	❄
1475	Krampus, the Austrian Christmas monster.	❄
1476	The Star Wars Holiday Special.	❄
11	Viagra&reg;.	\N
1478	Mall Santa.	❄
1479	Several intertwining love stories featuring Hugh Grant.	❄
1481	Gift-wrapping a live hamster.	❄
1482	Space Jam on VHS.	❄
1483	Immaculate conception.	❄
1484	Fucking up "Silent Night" in front of 300 parents.	❄
1485	A visually arresting turtleneck.	❄
1486	A toxic family environment.	❄
1487	Eating an entire snowman.	❄
3687	Mr. Hankey the Christmas Poo.	RS
509	Show me your tits!	VS
510	Thanking your sex slaves.	VS
511	Dickcheese.	VS
512	Googly eyes on a cock.	VS
513	Typing with your genitals.	VS
514	Pirate hookers.	VS
515	Poopcake.	VS
516	Mandatory Sex Party.	VS
517	A WHOLE GALLON.	VS
518	Games you can play with bricks.	VS
519	Lewhora.	VS
520	Fancy tampons.	VS
521	Very Serious Island.	VS
522	COLLIN.	VS
523	Ferngully.	VS
524	Velociraptor.	VS
525	Thundercunting.	VS
526	Werewolf.	VS
527	Cultist.	VS
528	Vejazzled vagina.	VS
529	HODOR.	VS
530	Simple dog.	VS
531	Butt oranges.	VS
532	Sweater kittens.	VS
533	Baby batter.	VS
534	Meat curtains.	VS
535	Strawberry Shortcake sexing up a Carebear and giving birth to NyanCat.	VS
536	Blowjob Jesus.	VS
537	GOATS.	VS
538	Welcome Taco.	VS
539	Boobs.	VS
540	Moobs.	VS
541	Tinychat.	VS
542	Centaur Therapist Jesus.	VS
543	LOUD NOISES.	VS
544	THE GODDAMN BATMAN.	VS
545	Swinging an axe in the air while cornholing a bear.	VS
546	WIIINES.	VS
547	A Wende head tilt.	VS
548	Chris Gaines.	VS
549	Fuck you, I'm a bear.	VS
550	Doctor Who.	VS
551	EXTERMINATE.	VS
552	Landshark.	VS
553	Bearshark.	VS
554	SCIENCE!!1!	VS
555	The Great Dildo, Thor.	VS
556	Just the tip!	VS
557	Daddy foam.	VS
558	PooooooP!	VS
10001	Dragon dildos.	Furry
560	Buttpirate Pokemon.	VS
561	A really good booby weight.	VS
562	Tubemonster.	VS
563	Bevis.	VS
564	Trouser snakes.	VS
565	A WHOLE GALLON OF BOOBS.	VS
566	Barfstab.	VS
567	LYNCH LUPUS.	VS
568	Drinking on live TV.	VS
569	Shooting heroin into my eyeballs.	VS
570	Skittering ovaries.	VS
571	Ricardo.	VS
572	The Power of Greyskull.	VS
573	The revolution.	VS
574	The establishment.	VS
575	Queer Lesbian Jesus.	VS
576	Hello Kitty.	VS
577	Readying my torch for burnination.	VS
578	Tots.	VS
579	Getting drunk before noon.	VS
580	In a sneaky hate spiral.	VS
581	Clown strippers.	VS
582	KERMIT FLAIL.	VS
583	Certified Breast Maintenance Engineer.	VS
584	A test tube baby.	VS
585	Dancing naked.	VS
586	Moist and Juicy.	VS
587	Orgy.	VS
588	Premature ejaculation.	VS
589	Bounty, the Quicker Picker Upper.	VS
590	Lotion.	VS
591	Rapey dolphin.	VS
592	Werepoo.	VS
593	Handbra.	VS
594	A moose giving birth in Maggly's yard.	VS
595	More bandaids.	VS
596	Fuckweasel.	VS
597	Curious hands.	VS
598	Spagbag.	VS
599	Tears of manly pain.	VS
130	Twinkies&reg;.	\N
600	Cthulu.	VS
601	Surprise penis.	VS
602	SEX.	VS
603	Mr. Tinycheeks.	VS
604	A spoon that is too big.	VS
605	Bleeding Anuses.	VS
606	Not being pregnant.	VS
607	An Olive Ewe.	VS
608	Hookers and blow.	VS
609	Dropbears.	VS
610	Standing next to short people to use them as armrests.	VS
611	Making a random guess in Werewolf that gets you killed later.	VS
612	INTERNET FOREVER!	VS
613	The jitters you get before a meetup.	VS
614	Shenaniganty.	VS
615	I AM HOW BABIES ARE MADE.	VS
616	Noble whore.	VS
617	Kangaroo stripper.	VS
618	Droopums.	VS
619	Nonni's mantis.	VS
620	Ginger baby.	VS
621	Drunk foruming.	VS
1477	My hot cousin.	❄
100008	The sound a single ThunderStix&reg; makes.	SG
100009	The Chilled Knife.	SG
145	Five-Dollar Footlongs&trade;.	\N
100011	Dr. Phil.	SG
100012	Paul and Storm.	SG
100013	Jonathan Coulton.	SG
100014	MC Frontalot.	SG
100015	Pretending you're Xyzzy.	SG
100018	Cleveland (it's not Detroit!).	SG
100019	An immediately regrettable $9 hot dog from the Boston Convention Center.	PAX A
100020	Running out of stamina.	PAX A
100021	Casting Magic Missile at a bully.	PAX A
100022	Getting bitch slapped by Dhalsim.	PAX A
100023	Firefly: Season 2.	PAX A
100024	Rotating shapes in mid-air so that they fit into other shapes when they fall.	PAX A
100025	Jiggle physics.	PAX A
100026	Paying the iron price.	PAX A
100029	Loading from a previous save.	PAX B
100030	Sharpening a foam broadsword on a foam whetstone.	PAX B
100031	The rocket launcher.	PAX B
100032	The depression that ensues after catching 'em all.	PAX B
100033	Violating the First Law of Robotics.	PAX B
100034	Getting inside the Horadric Cube with a hot babe and pressing the transmute button.	PAX B
100035	Punching a tree to gather wood.	PAX B
100036	Spending the year's insulin budget on Warhammer 40k figurines.	PAX B
100039	Achieving 500 actions per minute.	PAX C
100040	Forgetting to eat, and consequently dying.	PAX C
100041	Wil Wheaton crashing an actual spaceship.	PAX C
100042	The Klobb.	PAX C
100043	Charging up all the way.	PAX C
100044	Vespene gas.	PAX C
100045	Judging elves by the color of their skin and not by the content of their character.	PAX C
100046	Smashing all the pottery in a Pottery Barn in search of rupees.	PAX C
100052	The best card in my hand.	SG
100053	The primal, ball-slapping sex your parents are having right now.	X3
100055	A cat video so cute that your eyes roll back and your spine slides out of your anus.	X3
100056	Cock.	X3
100057	The biggest, blackest dick.	SG
100060	A cop who is also a dog.	X3
100061	Dying alone and in pain.	X3
100062	Gay aliens.	X3
100063	The way white people is.	X3
100064	Reverse cowgirl.	X3
100067	The Quesadilla Explosion Salad&trade; from Chili's&reg;.	X3
100068	Actually getting shot, for real.	X3
100069	Not having sex.	X3
100071	Vietnam flashbacks.	X3
100072	Running naked through a mall, pissing and shitting everywhere.	X3
100073	Nothing.	X3
100075	Warm, velvety muppet sex.	X3
100076	Self-flagellation.	X3
100077	The systematic destruction of an entire people and their way of life.	X3
100079	Samuel L. Jackson.	X3
100080	A boo-boo.	X3
100081	Going around punching people.	X3
100082	The entire Internet.	X3
100083	Some kind of bird-man.	X3
100084	Chugging a lava lamp.	X3
100086	Having sex on top of a pizza.	X3
100087	Indescribable loneliness.	X3
100088	An ass disaster.	X3
100090	Shutting the fuck up.	X3
100091	All my friends dying.	X3
100099	Putting an entire peanut butter and jelly sandwich into the VCR.	X3
100101	Spending lots of money.	X3
100102	Some douche with an acoustic guitar.	X3
100107	Flying robots that kill people.	X3
100109	A greased-up Matthew McConaughey.	X3
100111	An unstoppable wave of fire ants.	X3
100112	Not contributing to society in any meaningful way.	X3
100114	An all-midget production of Shakespeare's <i>Richard III</i>.	X3
100115	Screaming like a maniac.	X3
100116	The moist, demanding chasm of his mouth.	X3
100117	Filling every orifice with butterscotch pudding.	X3
100118	Unlimited soup, salad, and breadsticks.	X3
100119	Crying into the pages of Sylvia Plath.	X3
10002	Adam Wan.	Furry
100121	A PowerPoint presentation.	X3
100122	A surprising amount of hair.	X3
100123	Eating Tom Selleck's mustache to gain his powers.	X3
100124	Roland the Farter, flatulist to the king.	X3
100125	That ass.	X3
100126	A pile of squirming bodies.	X3
100127	Buying the right pants to be cool.	X3
100128	Blood farts.	X3
100129	Three months in the hole.	X3
100130	A botched circumcision.	X3
100131	The Land of Chocolate.	X3
100132	Slapping a racist old lady.	X3
100133	A lamprey swimming up the toilet and latching onto your taint.	X3
100134	Jumping out at people.	X3
100135	A black male in his early 20s, last seen wearing a hoodie.	X3
100136	Mufasa's death scene.	X3
100137	Bill Clinton, naked on a bearskin rug with a saxophone.	X3
100138	Demonic possession.	X3
100139	The Harlem Globetrotters.	X3
100140	Vomiting mid-blowjob.	X3
100141	My manservant, Claude.	X3
100142	Having shotguns for legs.	X3
100143	Letting everyone down.	X3
100144	A spontaneous conga line.	X3
100145	A vagina that leads to another dimension.	X3
100146	Disco fever.	X3
100147	Getting your dick stuck in a Chinese finger trap with another dick.	X3
100148	Fisting.	X3
100149	The thin veneer of situational causality that underlies porn.	X3
100150	Girls that always be textin'.	X3
100151	Blowing some dudes in an alley.	X3
3688	The Columbine Shooting.	RS
100153	Sneezing, farting, and coming at the same time.	X3
167	The Tempur-Pedic&reg; Swedish Sleep System&trade;.	\N
192	Fancy Feast&reg;.	\N
229	Hot Pockets&reg;.	\N
247	A neglected Tamagotchi&trade;.	\N
267	Domino's&trade; Oreo&trade; Dessert Pizza.	\N
284	The &Uuml;bermensch.	\N
311	Adderall&trade;.	\N
350	Sobbing into a Hungry-Man&reg; Frozen Dinner.	\N
353	Ring Pops&trade;.	\N
354	GoGurt&reg;.	\N
404	A Super Soaker&trade; full of cat pee.	\N
440	Lunchables&trade;.	\N
460	The Make-A-Wish&reg; Foundation.	\N
472	A Bop It&trade;.	1.2
482	Home video of Oprah sobbing into a Lean Cuisine&reg;.	1.2
486	Euphoria&trade; by Calvin Klein.	1.2
487	Switching to Geico&reg;.	1.2
507	The Donald Trump Seal of Approval&trade;.	1.2
1114	Medieval Times&reg; Dinner &amp; Tournament.	X1
1136	The Fanta&reg; girls.	X1
1182	The mere concept of Applebee's&reg;.	X2
1187	A pi&ntilde;ata full of scorpions.	X2
1228	Pretty Pretty Princess Dress-Up Board Game&reg;.	X2
1480	A Hungry-Man&trade; Frozen Christmas Dinner for One.	❄
3689	Shag carpeting.	RS
100156	Suddenly realizing you're retarded.	SG
3001	Steven Docking.	NL
3002	/r/Letsplay.	NL
3003	/r/sloths.	NL
3004	#Krazymike.	NL
3005	A Bane impression.	NL
3006	A big wet pink laser sword.	NL
3007	A brief moment of aptitude.	NL
3008	A bunch of jabronies.	NL
3009	A butt egg.	NL
15368	Rock-hard, glistening abs.	ANX1
3011	A delicious baby.	NL
3012	A docking sleeve.	NL
3013	A little bit of added defense.	NL
3014	A street cleaning simulator.	NL
3015	An old man carrying a box of glass down stairs.	NL
3016	Anything from http://www.thenorthernlionstory.com/.	NL
3017	Beating it on camera.	NL
3018	Being terrible at games.	NL
3019	Bejeweed.	NL
3020	Big Hat Logan.	NL
3021	Blondes, brunettes, and redheads.	NL
3022	Blue Baby.	NL
3023	BOOYAH!	NL
3024	Bow to your sensei!	NL
3025	Brimstone.	NL
3026	Butt meat.	NL
3027	Checking the wiki.	NL
3028	Cheeseysaurus Rex.	NL
3029	Classic Northernlion.	NL
3030	Coming on Milhouse.	NL
3031	Corner fucking.	NL
3032	Crazy Mike.	NL
3033	Cross-dimensional fucking.	NL
3034	Dark holes.	NL
3035	Detroit Dock City.	NL
3036	Docking.	NL
3037	DockLeeSmile.	NL
3038	Dung pies.	NL
3039	Dying in a hang gliding accident. 	NL
3040	Excuse me?	NL
3041	Eyeless ooze guys.	NL
3042	Falling down the stairs with a bag full of glass.	NL
3043	Fat Robert Downey Jr.	NL
3044	Feline eugenics.	NL
3045	Fuck tables.	NL
3046	Fucking during a Diphtheria epidemic.	NL
3047	Garglebutts.	NL
3048	Getting corner fucked.	NL
3049	Getting wood.	NL
3050	Greed.	NL
3051	Harry Potter and the Chamber of a Salty Surprise.	NL
3052	Hookers, blow, and JSmithOTI.	NL
3053	Infomercials.	NL
3054	John Madden.	NL
3055	JSmithOTI.	NL
3056	Kate's Mario Party skills.	NL
3057	Krazy Mike doing a backflip, throwing a talking nut, and chanting "Hello!"	NL
3058	Krazy Mike.	NL
3059	Laura Croft.	NL
3060	Like you, but not rogue-like you.	NL
3061	Losing to Monstro after 300 hours of experience.	NL
3062	The backroom casting couch.	NL
3063	The fuck zone.	NL
3064	Losing to Quelaag 12 times in 72 minutes.	NL
3065	Maple syrup.	NL
3066	Michael Caine's spider collection.	NL
3067	Michaelalfox.	NL
3068	Michaelalfox's love of cheese.	NL
3069	Michaelalfox's muscles.	NL
3070	A mile-long penis.	NL
3071	Milking the poop for red hearts.	NL
3072	Mom's knife.	NL
3073	Mom's pad.	NL
3074	Monty.	NL
3075	A motherfucker.	NL
3076	Motherfucking.	NL
3077	Nipple hair.	NL
3078	Northernlion.	NL
100152	Drinking ten 5-hour ENERGYs&reg; to get fifty continuous hours of energy.	X3
3079	Northernlion's cancelled Assassin's Creed II let's play.	NL
3080	Northernlion's coffee maker.	NL
3081	Northernlion's hair.	NL
3082	Northernlion's pooping album.	NL
3083	Not Satan, I promise.	NL
3084	Novelty Twitter accounts.	NL
3085	Olmec.	NL
3086	Permanent Polaroid invincibility.	NL
3087	Poison Mushroom.	NL
3088	Poutine-induced diabetes.	NL
3089	Pretending youtube let's playing is a real job.	NL
3090	Projectile annoyance.	NL
3091	Putting your balls in her butt.	NL
3092	Puzzle platformers with rogue-like elements.	NL
3093	Quelaag's Furysword.	NL
3094	Reddit.	NL
3095	Residue.	NL
3096	RockLeeSmile.	NL
3097	Rogue-like likes.	NL
3098	Roll Fizzlebeef.	NL
3099	Ronald McDonald.	NL
3100	Sex.	NL
3101	Shit happens.	NL
3102	Shooting the poop.	NL
3103	Solaire of Astora.	NL
3104	South Korea.	NL
3105	Stream lag.	NL
3106	Stupid damage.	NL
3107	A tactical backflip.	NL
3108	The Northernlion Story.	NL
3109	Whispering sweet nothings into your rear.	NL
3110	The notorious Grey's Anatomy let's play.	NL
3111	The Binding of Isaac wiki.	NL
3112	Thornforg.	NL
3113	When you fuck a dog in the ass and it shits all over your dick.	NL
3114	The USS Buttfucker.	NL
3115	Vaginal silk worms.	NL
3116	The Anor Londo Archers.	NL
3117	YouTube.	NL
3118	The saga of Krazy Mike.	NL
3119	A urination break.	NL
3120	The World Docking Champion.	NL
3121	Type-C Tetris music.	NL
3122	The Thug of Porn.	NL
3123	That damned HDPVR.	NL
3124	The NLSS: drawing unwanted attention from the actual docking community.	NL
3125	Patrick Dempsey thrusting violently into my midsection.	NL
3126	Well, what is it?	NL
3127	The Four Horsemen of The Apocolypse.	NL
3128	Talking nuts.	NL
3129	The Ozymandias head.	NL
3130	A total scumbag.	NL
3131	Striking fear into the hearts of your enemies.	NL
100158	Using the tears of an abused toddler to conquer my foes.	NL
3690	The Eiffel Tower.	RS
3691	Chicken and Waffles.	RS
3692	The Oculus Rift.	RS
3693	Banana Hammocks.	RS
3694	Dirty hippies.	RS
3695	Hey Arnold!	RS
3696	Air Bud.	RS
3697	Yankee Stadium.	RS
3698	Hump Day.	RS
3699	Sheepskin Condoms.	RS
3700	Cranky Kong.	RS
3701	The DK Rap.	RS
3702	Donkey Shows.	RS
3703	Hordes of zombies.	RS
3704	Monkeys throwing shit.	RS
3705	Rainbows and magic.	RS
3706	Tits.	RS
3707	The brown note.	RS
3708	Hentai.	RS
3709	Indiana Jones.	RS
3710	ALL the things!	RS
3711	Hitler's mustache.	RS
3712	Gerudo Valley.	RS
3713	Song of Storms.	RS
3714	Bill Gates pissing on Steve Jobs's grave.	RS
3715	A giant purple dildo sword.	RS
3716	Hipsters on their iPhones at Starbucks.	RS
3717	Catdog.	RS
3718	A boat load of cocaine.	RS
3719	Smooth jazz.	RS
3720	Lemon grenades.	RS
3721	Blue Waffles.	RS
3722	360 no scopes.	RS
3723	Soviet Russia.	RS
3724	The Mushroom Kingdom.	RS
3725	Outsourcing jobs to India.	RS
3726	Hooters.	RS
3727	The Hokey Pokey.	RS
3728	Kaizo Mario.	RS
3729	FrankerZ.	RS
3730	Spontaneous Combustion.	RS
3731	Kappa.	RS
3732	Insane Clown Posse.	RS
3733	Nu Metal.	RS
3734	The Wiggles.	RS
3735	Blue's Clues.	RS
3736	Using hot sauce as lube.	RS
3737	Mating season.	RS
3738	The Ouya.	RS
3739	Jew-Fros.	RS
3740	Fruit Fuckers.	RS
3741	Blowing your hand off with a firework.	RS
3742	Beer Pong.	RS
3743	Duke Nukem Forever.	RS
3744	Rule 34.	RS
3745	Made-for-TV movies.	RS
3746	Spanish soap operas.	RS
3747	Teh Urn.	RS
3748	Viking Metal.	RS
3749	Tickle Me Elmo.	RS
3750	Barney's rape dungeon.	RS
3751	Nurse Joy.	RS
3752	Canadian tuxedo.	RS
3753	Hungry Hungry Hippos.	RS
3754	The smallest, whitest dick.	RS
3755	Abusive fathers.	RS
3756	Rich, chocolatey Ovaltine&reg;.	RS
3757	Ringworm.	RS
3758	The hero of time.	RS
3759	Terabytes of horse porn.	RS
3760	Blowing the President.	RS
3761	Skullcrusher Mountain.	RS
3762	Mr. Fancy Pants.	RS
3763	TotalBiscuit's top hat.	RS
3764	Demi Moore's bush.	RS
3765	Eating 120 White Castle burgers&reg;.	RS
3766	A walrus with a beret.	RS
3767	Speedrunning life.	RS
3768	Scotsman marring their sheep.	RS
3769	The truffle shuffle.	RS
3770	An 8-ball.	RS
3771	Quiznos&reg;.	RS
3772	Bong hits for Jesus.	RS
3773	Penn and Teller.	RS
3774	Indentured servants.	RS
3775	Sex in your mouth.	RS
3776	Hoola hoops.	RS
4109	Literally drinking bottled fangirl tears.	TGWTG
4110	LordKaT's used nipple tassles.	TGWTG
4111	Luke's curly hair.	TGWTG
4112	Lupa's brand of hair dye.	TGWTG
4113	Ma-Ti being castrated and having his balls shipped to Oancitizen in the mail by Diamanda Hagan.	TGWTG
4114	Magical fairy sex.	TGWTG
4115	Making angry love to a DVD copy of "Neverending Story III".	TGWTG
4116	Mako.	TGWTG
4117	Malachite's Hand.	TGWTG
4118	Maven's secret sparkling vampire dildo.	TGWTG
4119	Melvin, brother of the Joker.	TGWTG
4120	My mom.	TGWTG
4121	My penis catching fire.	TGWTG
4122	Naked crazy.	TGWTG
4123	Nash breaking his ass.	TGWTG
4124	Nash dressed in drag.	TGWTG
4125	Nash in a gimp suit.	TGWTG
4126	Nash popping a blood vessel over Florida.	TGWTG
4127	Nash.	TGWTG
4128	Nash's long, long hair.	TGWTG
4129	Newborn porn.	TGWTG
4130	Nun fuckery.	TGWTG
4131	Oancitizen.	TGWTG
4132	Over-intrusive fanboys.	TGWTG
4133	Having sex at a screening of Mr. Popper's Penguins.	TGWTG
4134	Phelous making love to his Turtles collection.	TGWTG
4135	Poop, as a plan.	TGWTG
4136	Punching your foe in the stomach and screaming "I AM A MAN!"	TGWTG
4137	PushingUpRoses' bird tattoos.	TGWTG
4138	Putting sexy pantyhose on your dog.	TGWTG
4139	Radio Dead Air.	TGWTG
10003	Non-consensual sex with Zaush.	Furry
4141	Reading fan fiction on a live stream.	TGWTG
4142	Reading the comments.	TGWTG
4143	Requesting John Cage's "4'33" on Radio Dead Air.	TGWTG
4144	Reviewer dibs.	TGWTG
4145	Robotic sex slaves that are made to feel sadness.	TGWTG
4146	Rule 34 of Linkara and a lamp.	TGWTG
4147	Sad Panda.	TGWTG
4148	Santa Christ.	TGWTG
4149	Santa Christ's raging boner.	TGWTG
10004	My tailhole.	Furry
4151	Sharkleberry Finn-flavored Kool-Aid.	TGWTG
4152	Shooting colored corn syrup up your nose.	TGWTG
4153	Slightly creepy comments about Tara's hair.	TGWTG
4154	Smoking kittens.	TGWTG
4155	Snowdicking.	TGWTG
4156	Snowflame, feeling no pain.	TGWTG
4157	Sodomizing a loved one with a baseball bat.	TGWTG
4158	Space Guy.	TGWTG
4159	Spoony's fans.	TGWTG
4160	Spoony's sexy goth pixie girlfriend.	TGWTG
4161	Stick figure porn.	TGWTG
4162	Stickboy.	TGWTG
4163	Storing your dead friend's ashes into a Quaker Oats can.	TGWTG
4164	Suggestively eating a banana at the sight of David Bowie.	TGWTG
4165	SYMBOLISM!	TGWTG
4166	Taking someone by the shoulders, throwing them on the bed and riding them like a stallion.	TGWTG
4167	That Aussie Guy.	TGWTG
4168	That goddamned Colossus roar.	TGWTG
4169	That one guy with snails.	TGWTG
4170	The Angry Video Game Nerd.	TGWTG
4171	The Blockbuster Buster.	TGWTG
4172	The Cinema Snob Movie DVD.	TGWTG
4173	THE COCK.	TGWTG
4174	The Continuity Alarm.	TGWTG
4175	The elephant in the room.	TGWTG
4176	The Film Renegado.	TGWTG
4177	The five months when the Nostalgia Critic was dead.	TGWTG
4178	The LAAAAAAAAAAAAAAAAAAAAAW!	TGWTG
4179	The Makeover Fairy.	TGWTG
4180	The Nostalgia Critic.	TGWTG
4181	The pig fucking movie.	TGWTG
4182	The plot hole.	TGWTG
4183	The Power Glove.	TGWTG
4184	The RDA drinking game.	TGWTG
4185	The RDA IRC channel.	TGWTG
4186	The Spocker.	TGWTG
4187	The TGWTG site redesign.	TGWTG
4188	The Wunder Boner.	TGWTG
4189	This fecal matter you call "Fluttershy".	TGWTG
4190	Throwing a Baby Tumbles Surprise down a staircase.	TGWTG
4191	Time travel.	TGWTG
4192	Timing.	TGWTG
4193	Todd's unmasked visage.	TGWTG
4194	Using Crystal Pepsi as a substitute for lube.	TGWTG
4195	Using your underwear to shoplift raw meat from your local Wal-Mart.	TGWTG
4196	Vigorously shagging your sister while holding a mug of warm tea.	TGWTG
4197	Welshy.	TGWTG
4199	Whatever the hell Barfiesta was supposed to be.	TGWTG
4200	Yet another Thunderdome reference.	TGWTG
4201	Your mom.	TGWTG
4202	Zodan The Unbouncable.	TGWTG
4203	90's Kid's comic collection.	TGWTG
4204	A Linkara cameo.	TGWTG
4205	A plushie cybermat.	TGWTG
4206	ALL THE COCAINE!!!	TGWTG
4207	Bees!	TGWTG
4208	Being fed up with reviewing lamps, what obscure topic did Linkara review next?	TGWTG
4209	Harvey Finevoice's fine voice.	TGWTG
4210	Killing clowns.	TGWTG
4211	Linkara crying in his Gatorade made of cybermat tears.	TGWTG
4212	Linkara stalking Gail Simone on Twitter.	TGWTG
4213	Linkara's cybermat invasion force.	TGWTG
4214	Linkara's fangirl support group.	TGWTG
4215	Linkara's magic gun.	TGWTG
4216	Linkara's masculine arms.	TGWTG
4217	MAGfest.	TGWTG
4218	Marzkara fanfiction.	TGWTG
4219	Mechakara's phallic drill.	TGWTG
4220	Reviews of $20 lamps.	TGWTG
4198	What did the commenters bitch about next to Doug?	TGWTG
15369	A diet consisting almost entirely of potatoes.	ANX1
3994	A baseball to the nuts.	TGWTG
3995	A bat credit card.	TGWTG
3996	A Big Lipped Alligator Moment.	TGWTG
3997	A big long pink ding dong penis.	TGWTG
3998	A bird fucking a horse.	TGWTG
3999	A Blip check.	TGWTG
4000	A bootleg ninja turtle action figure possessed by Satan.	TGWTG
4001	A car landing on a roof.	TGWTG
4002	A case of disappearing bears.	TGWTG
4003	A Chia-Child.	TGWTG
4004	A congregation of bums.	TGWTG
4005	A Crystal Pepsi&reg;-flavored enema.	TGWTG
10005	Adoptables with visible genitalia.	Furry
10006	An embarrassingly long F-List profile.	Furry
4008	A drugged Oancitizen in a schoolgirl outfit.	TGWTG
4009	A greased-up meth guy.	TGWTG
10007	Catching STDs at conventions.	Furry
4011	A killer rabbit.	TGWTG
4012	A mexican car wash.	TGWTG
4013	A misguided Tumblr activism campaign.	TGWTG
4014	A mobile meth lab in your pants.	TGWTG
10008	Fursuit adventures.	Furry
4016	A novelty slot machine.	TGWTG
4017	A Pan-Galactic Gargle Blaster.	TGWTG
4018	A poorly-written ugly mess.	TGWTG
4019	A really pimped out DeLorean.	TGWTG
4020	A talking snail in a suit.	TGWTG
4021	A tiny white dick.	TGWTG
4022	A titanic, undead, six-headed space dragon spewing bubbles.	TGWTG
4023	A zombie fisherman.	TGWTG
4024	Accidentally punching your cohost in the face.	TGWTG
4025	ALL OF THE DICKS.	TGWTG
4026	Almost dying at Sesame Street.	TGWTG
4027	An art film Kyle's reviewed.	TGWTG
4028	An autoclitorodectomy.	TGWTG
10009	A semen-stained fursuit.	Furry
4030	An obscure reference only two people will get.	TGWTG
4031	Anal tearing.	TGWTG
4032	Andrew Dickman.	TGWTG
4033	Angrily playing piano.	TGWTG
4034	Ash.	TGWTG
4035	Ash and Checkers.	TGWTG
4036	Ask That Guy raped by Ma-Ti live.	TGWTG
4037	ASS ASS ASS ASS ASS ASS ASS ASS.	TGWTG
4038	Ass demons.	TGWTG
4039	Awkward pity sex with a sparkly teenage Cthulu.	TGWTG
10010	Fake furry girls.	Furry
4041	Because no one wants to see your dick.	TGWTG
4042	Because the Kool-Aid Man is red.	TGWTG
4043	Because there's nothing sexy at the Wal-Mart.	TGWTG
4044	Bees. My God.	TGWTG
4045	Being frozen today.	TGWTG
4046	Beppo the Invisible Monkey.	TGWTG
4047	BETRAYAL!	TGWTG
4048	Big Jim Slade.	TGWTG
4049	Blockbuster Buster busting a nut.	TGWTG
4050	Breaking someone's spine by fucking.	TGWTG
4051	Carl Copenhagen.	TGWTG
4052	Casper.	TGWTG
4053	Chuck Norris.	TGWTG
4054	Confusing The Last Angry Geek and Linkara.	TGWTG
4055	CR's collection of My Little Pony pins.	TGWTG
4056	Creepy fans at cons buying expensive stuff for MarzGurl.	TGWTG
4057	Creepy guys in the RDA chat hitting on Tara.	TGWTG
4058	Nash's creepy face.	TGWTG
4059	Crying your eyes out at a bunch of online reviewers.	TGWTG
4060	Crystal Pepsi&reg;.	TGWTG
4061	Dark Nella.	TGWTG
4062	David Bowie's package.	TGWTG
10011	That one straight guy at the party.	Furry
4064	Diamanda Hagan's sexbot.	TGWTG
4065	Diamanda's copy of Cockhammer.	TGWTG
4066	Disney's Anne Frank.	TGWTG
4067	Dogs wearing pantyhose.	TGWTG
4068	Dolphin rape.	TGWTG
4069	A douchequake.	TGWTG
4070	Dr. Insano.	TGWTG
4071	Dr. Wiki.	TGWTG
4072	Explosively masturbating with Malachite's Hand.	TGWTG
4073	Ferdinand Von Turrell.	TGWTG
4074	Film Brain's lovely accent.	TGWTG
4075	Finding out that "it's not Pop Tarts!"	TGWTG
4076	Firing a blue shell at the opposing house ship.	TGWTG
4077	Florida.	TGWTG
4078	Florida Man.	TGWTG
4079	Flying sex snakes in monocles and bow ties.	TGWTG
4080	Fort Super-Awesome.	TGWTG
4081	FOUR HOURS?!	TGWTG
10012	An apartment full of internet-obsessed losers.	Furry
4083	Fuck yeah, SPARKLE SPARKLE SPARKLE!	TGWTG
4084	Fuck you, I do what I want.	TGWTG
4085	FUCK YOU, I'M SPIDERMAN!	TGWTG
4086	Fucking bubbles.	TGWTG
4087	Getting buggered by a giant hamster.	TGWTG
4088	Getting mauled by a mountain lion AND a grizzly bear at the same time.	TGWTG
4089	Glenn Beck being torn apart by zombies.	TGWTG
4090	Going full retard.	TGWTG
4091	Going through the effort to build a wall in your back yard just to bash your head into it over and over again.	TGWTG
4092	Gooby.	TGWTG
4093	Hagan's dictator tendencies.	TGWTG
4094	Hagan's make up artist.	TGWTG
4095	Hagan's masturbating minion.	TGWTG
4096	Ham?	TGWTG
4097	Hippo Queen Tara.	TGWTG
4098	Hitler without the mustache.	TGWTG
15370	Mamoru Oshii's dog love.	ANX1
4100	Humping a can of trash.	TGWTG
4101	I AM A MAN!	TGWTG
4102	Invading a micronation in Nevada and making it your own.	TGWTG
4103	JewWario's solar penis.	TGWTG
4104	Kickassia.	TGWTG
4105	Kitler.	TGWTG
4106	Kyle humping a trashcan.	TGWTG
4107	Linkara's 'special' comic books.	TGWTG
4108	Linkara's hat.	TGWTG
4222	Superboy Prime.	TGWTG
4223	The Entity.	TGWTG
4224	The legendary MAGFest orgy.	TGWTG
4225	The most important job, reviewing a crappy comic book.	TGWTG
4226	The next History of Power Rangers.	TGWTG
4227	Youngblood's disease.	TGWTG
4228	Twin clones of Hitler.	TGWTG
559	Thundercunt.	VS
4006	A disembodied orgasm hippo.	TGWTG
4007	A doppelganger in black leather with a sword.	TGWTG
4010	A guest appearance by Giovanni Jones, the talking lobster.	TGWTG
4015	A naked rampage.	TGWTG
4029	An awkward slash fic between The Nostalgia Critic and The Angry Video Game Nerd.	TGWTG
4040	Bath salts.	TGWTG
4063	Diamanda Hagan.	TGWTG
4082	Frying the Coke.	TGWTG
4140	Rapidly pounding themselves in the face with a hammer.	TGWTG
100120	Velcro&trade;.	X3
4150	Sci-Fi Guy's ponytail.	TGWTG
4229	A beef swarm.	NL
3010	A butt pooping upwards an egg.	NL
100162	The League of Legends.	SG
100164	Advice from a wise, old black man.	1.3
100165	The Devil himself.	1.3
100166	The art of seduction.	1.3
100167	Funky fresh rhymes.	1.3
100168	The light of a billion suns.	1.3
10013	A tub of Vaseline.	Furry
100170	Destroying the evidence.	1.3
10014	Sex with strangers.	Furry
100172	Silence.	1.3
100173	Growing a pair.	1.3
100174	Synergistic management solutions.	1.3
100175	Wet dreams.	1.3
100176	A live studio audience.	1.3
100177	The Great Depression.	1.3
100178	An M16 assault rifle.	1.3
100179	Poopy diapers.	1.3
100180	Tickling Sean Hannity, even after he tells you to stop.	1.3
100181	Stalin.	1.3
100182	A spastic nerd.	1.3
100183	Rush Limbaugh's soft, shitty body.	1.3
100184	Capturing Newt Gingrich and forcing him to dance in a monkey suit.	1.3
100185	Battlefield amputations.	1.3
100186	Brown people.	1.3
100187	Rehab.	1.3
100188	An ugly face.	1.3
100189	Menstrual rage.	1.3
100190	An uppercut.	1.3
100191	Shiny objects.	1.3
100192	50,000 volts straight to the nipples.	1.3
100193	A bucket of fish heads.	1.3
100194	Hospice care.	1.3
100195	Being fat and stupid.	1.3
100196	Getting married, having a few kids, buying some stuff, retiring to Florida, and dying.	1.3
100197	A pyramid of severed heads.	1.3
100198	Crucifixion.	1.3
100199	A subscription to Men's Fitness.	1.3
100200	Some god-damn peace and quiet.	1.3
100201	A micropig wearing a tiny raincoat and booties.	1.3
100202	Used panties.	1.3
100204	The penny whistle solo from "My Heart Will Go On."	1.3
100205	A tribe of warrior women.	1.3
100212	An oversized lollipop.	1.3
100213	Helplessly giggling at the mention of Hutus and Tutsis.	1.3
100214	Not wearing pants.	1.3
100215	Consensual sex.	1.3
100216	Her Majesty, Queen Elizabeth II.	1.3
4230	Angry Joe.	TGWTG
4231	Marzgurl.	TGWTG
4232	Chester A. Bum.	TGWTG
4233	Ask That Guy With The Glasses.	TGWTG
4234	Dominic the Bartender.	TGWTG
4235	Obscurus Lupa.	TGWTG
4236	ChaosD1.	TGWTG
4237	Skitch.	TGWTG
4238	Y Ruler Of Time.	TGWTG
4239	Linkara.	TGWTG
4240	Mechakara.	TGWTG
4241	Lord Vyce.	TGWTG
4242	90's Kid.	TGWTG
4243	Corporate Commander.	TGWTG
4244	JewWario.	TGWTG
4245	A demonic Teddy Ruxpin doll.	TGWTG
4246	Luke.	TGWTG
4247	Luke's inners.	TGWTG
4248	PhelousD1.	TGWTG
4249	Phelous.	TGWTG
4250	Filmbrain.	TGWTG
4251	Iron Liz.	TGWTG
4252	Malachite.	TGWTG
4253	Zodd.	TGWTG
4254	The Executor.	TGWTG
4255	PhilBuni.	TGWTG
4256	Ven Gethenian.	TGWTG
4257	That Sci-Fi Guy.	TGWTG
4258	Black Lantern Spoony.	TGWTG
4259	The Trousers Cosmic.	TGWTG
4260	Nash's folksy, velvety voice.	TGWTG
4261	Australia, Florida of the Pacific.	TGWTG
4262	Angrily eating lettuce.	TGWTG
4263	Mary Sewage.	TGWTG
4264	A legion of mechawolves.	TGWTG
4265	Linkara's futon.	TGWTG
4266	The Gooby Curse.	TGWTG
4267	ANCIENT EGYPT!	TGWTG
4268	An obligatory cameo.	TGWTG
4269	Dodger of Zion.	TGWTG
4270	An elevator party.	TGWTG
4271	Pants that need to be darkened.	TGWTG
4272	Only being on the site because of the influence of famous acquaintences.	TGWTG
4273	Enoby Dark'ness Dementia Raven TARA Way.	TGWTG
4274	JSmith's salty nuts.	NL
4275	#ShotsFired.	NL
4276	Banana bread.	NL
4277	Butterjail.	NL
10015	People who cosplay at furry conventions.	Furry
10016	Fursuiters at anime conventions.	Furry
10017	Embarrassing craigslist ads.	Furry
10018	Pounced.org.	Furry
10019	A large, flared Chance.	Furry
10020	Stretching your anus in preparation for horse cock.	Furry
10021	A hermaphrodite foxtaur.	Furry
10022	Babyfurs.	Furry
10023	Uncomfortably attractive animals.	Furry
10024	Confusing feelings about cartoon characters.	Furry
10025	PetSmart.	Furry
10026	Krystal, the fox.	Furry
10027	StarFox.	Furry
10028	Sonic the Hedgehog.	Furry
10029	Bowser's sweaty balls.	Furry
10030	A furpile.	Furry
10031	The stench of half a dozen unwashed bronies.	Furry
10032	Intimacy with the family dog.	Furry
10033	Horses.	Furry
10034	Fursecution.	Furry
10035	Chakats.	Furry
10036	DeviantArt.	Furry
10037	Otherkin.	Furry
10038	Heated debates about human genitalia versus animal genitalia.	Furry
10039	Taking the knot.	Furry
10040	Really, really liking Disney's Robin Hood.	Furry
10041	Applying your obscure, unrealistic fetishes to 90's cartoon characters.	Furry
10042	The texture and color of raw meat.	Furry
10043	An oversized clitoris that acts as a functional penis.	Furry
10044	A hermaphrodite snow leopard.	Furry
10045	Drawing furry porn.	Furry
10046	Lovingly rendered dragon anus.	Furry
10047	Cloaca.	Furry
10048	Animal genitalia.	Furry
10049	Motherfucking wolves.	Furry
10050	Christian furries.	Furry
10051	Barbed penises.	Furry
10052	Two knots.	Furry
10053	A really attractive wolf.	Furry
10054	A slutty gay fox.	Furry
10055	A surprisingly attractive anteater.	Furry
10056	FUCK YOU, I'M A DRAGON.	Furry
10057	Tumbles, the Stair Dragon.	Furry
10058	Furry Weekend Atlanta.	Furry
10059	Further Confusion.	Furry
10060	AnthroCon.	Furry
10061	Literally a bucket of semen.	Furry
10062	Sexual interest in pretty much anything with a hole.	Furry
10063	Attraction to pretty much anything with a penis.	Furry
10064	Transformation porn.	Furry
10065	Anatomically incorrect genitalia.	Furry
10066	When you catch yourself glancing at the crotches of animated characters.	Furry
10067	Belly rubs leading to awkward boners.	Furry
10068	Scritches.	Furry
10069	Lifting your tail.	Furry
10070	Experimenting with fisting.	Furry
10071	Bad decisions.	Furry
10072	A little bitch.	Furry
10073	A lime Citra.	Furry
10074	Sergals.	Furry
10075	An autistic knife fight.	Furry
10076	The noises red pandas make during sex.	Furry
10077	About 16 ounces of horse semen.	Furry
10078	Dog cum.	Furry
10079	Oral knotting.	Furry
10080	Leaving your orifices bloody and sore.	Furry
10081	Rubbing peanut butter on your genitals.	Furry
10082	Bad Dragon&trade; cumlube.	Furry
10083	Piss.	Furry
10084	Smells.	Furry
10085	When "blowing ten bucks" makes you think of a long night with a bunch of deer.	Furry
10086	Forgetting which set of fursuit paws you use for handjobs.	Furry
10087	A strategically placed hole.	Furry
10088	Shitting on my face.	Furry
10089	Barking at strangers.	Furry
10090	Sitting on your face.	Furry
10091	Spending more money on commissions than food in a given week.	Furry
10092	A dick so big you have to give it a hugjob.	Furry
10093	The fine line between feral and outright bestiality.	Furry
10094	Anal training.	Furry
10095	Discovering monster porn.	Furry
10096	Realizing that rimming is pretty cool.	Furry
10097	Endearing social ineptitude.	Furry
10098	All this lube.	Furry
10099	That thing that gives your dick a knot IRL.	Furry
10100	Gay.	Furry
10101	Really, truly heterosexual.	Furry
10102	Drenching your fursuit in Febreeze.	Furry
10103	That time you let your dog go a little further than just sniffing your crotch.	Furry
10104	Poodles with afros.	Furry
10105	Offensively stereotyped African animals.	Furry
10106	A sassy lioness.	Furry
10107	Surprise hermaphrodites.	Furry
10152	Taking special interest in nature documentaries.	Furry
10153	Becoming a veterinarian for all the wrong reasons.	Furry
10154	The premise of every furry comic ever.	Furry
10155	Anal sex you didn't know you wanted.	Furry
10156	The incredibly satisfying sound it makes when you pull it out.	Furry
10157	Bear tits.	Furry
10158	Big cute paws.	Furry
10159	Paws.	Furry
10160	Furry porn, shamelessly taped to the walls.	Furry
10161	Grabby-paws.	Furry
10162	Masturbating, with claws.	Furry
10163	Pawing-off.	Furry
10164	Tail-sex.	Furry
10165	Mary, the anthro mare.	Furry
10166	Natascha, the anthro husky.	Furry
10167	Nipple buffet.	Furry
10168	Crotch-tits.	Furry
10169	The tailstar tango.	Furry
10170	Furries in heat.	Furry
10171	Fantasizing about sex with just about every monster you encounter in your video game.	Furry
10172	Impure thoughts about Kobolds.	Furry
10173	Erotic roleplay.	Furry
10174	Monsters with bedroom eyes.	Furry
10175	Accurate avian anatomy.	Furry
10176	Getting fur stuck in your teeth.	Furry
10177	Getting feathers stuck in your teeth.	Furry
10178	Ignoring a person's faults because their character is hot.	Furry
4099	A legion of spiders.	TGWTG
3993	A secret goat porn stash.	TGWTG
15371	An 8 million yen debt to a club of rich pretty boys.	ANX1
15372	Hideaki Anno's poor, tortured therapist.	ANX1
4360	Golby.	GFC
15373	Fucking postcards as a cheap-ass pack-in gift.	ANX1
15374	Wild Tiger's Hundred Power.	ANX1
15375	Totoro.	ANX1
15376	Traps.	ANX1
15377	Korean Jesus.	ANX1
15378	Astro Boy.	ANX1
15379	Jacking off into a bottle of formaldehyde and calling it our firstborn.	ANX1
15380	Valvrape the Dominator.	ANX1
15381	Piles of dead children.	ANX1
15382	An unending, unquenchable thirst for orange Fanta.	ANX1
15383	Breaking the fourth wall to kill the mangaka.	ANX1
15384	Hentai voice acting.	ANX1
15385	A vampire ninja.	ANX1
15386	A potato committing seppuku.	ANX1
15387	A giant robot German suplex.	ANX1
4358	Benchpressing.	GFC
4359	Mother's debit card.	GFC
4361	Kevin Golby.	GFC
4362	That Kevin Golby.	GFC
4363	The Golbies: like the jitters but with a concern towards stabbings.	GFC
4364	STEAL ALL THE FARM.	GFC
4365	Norwegian Oil.	GFC
4366	Grandiosa.	GFC
4367	Drilling.	GFC
4368	Barta's glorious hair.	GFC
4369	BENCH ALL THE MOTHERS.	GFC
4370	Taking the second and third blue buff.	GFC
4371	Invisible stabwounds.	GFC
4372	Lulu's double E.	GFC
4373	A blurry picture.	GFC
4374	The Merchant Navy.	GFC
4375	Extensive research by Trygve.	GFC
4376	The Trygvipedia.	GFC
4377	Chak looking like Ross Kemp on a good day.	GFC
4378	Manny's epic laugh.	GFC
4379	Clearly jealous.	GFC
4380	A very tight vest from Primark.	GFC
4381	Fisting a nun.	GFC
4382	Teabagging a siamese midget while benchpressing a cybernetically enhanced bear.	GFC
4383	From Primark.	GFC
4384	smoochy moochy.	GFC
4385	A Superman tattoo.	GFC
4386	Gary Glitter.	GFC
4387	Blanda Upp!.	GFC
4388	Hestkuk.	GFC
4389	A nice guy.	GFC
4390	My 6.3 KDA ratio.	GFC
4391	bronze scrub.	GFC
4392	Get on my level.	GFC
4393	Fucking tryhard.	GFC
4394	Those moments when you're bored and pucker your anus to a good beat.	GFC
4395	An undetermined but significant quantity of penis.	GFC
4396	PEEEEEEEEEEEEEEEENIIIISSSSSSSS.	GFC
4397	The Shawk.	GFC
4398	They're taking the hobbits to Isengard!	GFC
4399	Confounding jerry at every turn.	GFC
4400	Jumanji.	GFC
4401	Wards.	GFC
4402	Build an Aegis!	GFC
4403	Wildturtle's vast range of emotions.	GFC
4404	K-Pop.	GFC
4405	Doing Gangnam Style at a funeral.	GFC
4406	joseph gordon-Levitt wearing nothing but a kitten.	GFC
4407	125% Reccomended Daily Allowance of cock.	GFC
4408	Barta not being sarcastic.	GFC
4409	Golby's itchy testicles.	GFC
4410	Surgery to move the male g-spot to the naval.	GFC
4411	The Kirk vs Spock fight scene music.	GFC
4412	Golby not jungling.	GFC
4413	Feeling a fart pushing against your prostate.	GFC
4414	I'm Batman. WHERE ARE THEY?!?	GFC
4415	Band Camp.	GFC
4416	A corgi wearing a hat.	GFC
4417	A corgi wearing a sailor moon outfit.	GFC
4418	a corgi dressed as a viking.	GFC
4419	A corgi.	GFC
4420	Chak's bald spot.	GFC
4421	THE HAWK!	GFC
4422	When Aunt Erma visits.	GFC
4423	Jamiroquai.	GFC
4424	BAWNJOURNO.	GFC
4425	Black people's nostrils.	GFC
4426	LOOK AT MY HORSE.	GFC
4427	MY HORSE IS AMAZING.	GFC
4428	XPEKE!	GFC
4429	Because Froggen did it.	GFC
4430	Meowing Ride of the Valkyries during intercourse.	GFC
4431	CACAW!	GFC
4432	Dryhumping.	GFC
4433	Gilbert Gotfried.	GFC
4434	50 Shades of Gay.	GFC
4435	Maple Bourbon Bacon Jam.	GFC
4436	Chak making a sandwich.	GFC
4437	Jealous.	GFC
4438	Frozen Heart Ashe.	GFC
4439	Yorick Ult on Anivia Egg.	GFC
4440	David.	GFC
4441	A healthy dose of Vitamin Cock and Vitamin Dick.	GFC
4442	Questioning my sexuality.	GFC
4445	Tons of Damage.	GFC
15388	A Godzilla attack.	ANX1
15389	Eating KFC on Christmas day.	ANX1
15390	Hello Kitty! pregnancy doujins.	ANX1
15391	Waving it around all willy-nilly.	ANX1
15392	Hot anime moms.	ANX1
15393	Pissing yourself.	ANX1
15394	GAO! GAI! GAR!!!	ANX1
15395	Vocaloid death metal.	ANX1
15396	The Dark Lord Shawne Kleckner.	ANX1
15397	Yaoi paddles.	ANX1
15398	Bad Steven Foster dubs.	ANX1
15399	Mr. Satan.	ANX1
15400	An actual, honest-to-God black guy.	ANX1
15401	4,000 tacos, and one Diet Coke.	ANX1
15402	Sick with the cancer.	ANX1
15403	Black and white samurai movies.	ANX1
15404	A promotional crossover with Pizza Hut.	ANX1
15405	Transvestite police officers.	ANX1
15406	Con funk.	ANX1
15407	Star-shaped nipples.	ANX1
15408	A laser horse.	ANX1
15409	Girls with guns AND glasses.	ANX1
15410	Teenaged miniskirt-wearing space pirates.	ANX1
15411	Gas station sushi.	ANX1
4443	Deman making a racist pun.	GFC
4444	Phreak staring at you and never blinking.	GFC
4446	PENTAFAIL!	GFC
4447	I Can't Believe It's Not Butter.	GFC
4448	A Wanksock.	GFC
4449	An arsehole like a wellington top.	GFC
4450	Emma Watson dressed as a crab dancing to K-Pop.	GFC
4451	BORK.	GFC
4452	Handicapped people on Takeshi's Castle.	GFC
4453	The Chuckle Brothers at their mother's funeral.	GFC
4454	A 3am phone call.	GFC
4455	A cardboard cutout of Jennifer Lawrence.	GFC
4456	Robert Pattinson with Freddy Mercury's moustache and Gilbert.	GFC
4457	Gotfried's voice.	GFC
4458	Ezreal's hot sugary ass.	GFC
100220	A Canadian penny.	SG
100221	dho's penis.	SG
100222	Griffy's tits.	SG
4459	Kyubey.	AN
4460	Weeaboos.	AN
4461	Narutards.	AN
4462	Dead catgirls.	AN
4463	Aniplex of America.	AN
4464	Steve Motherfuckin' Blum.	AN
4465	Norio Wakamoto.	AN
4466	Tentacle rape.	AN
4467	Eating an entire box of Pocky in a single bite.	AN
4468	Lolis.	AN
4469	Hot-blooded shonen protagonists.	AN
4470	Crispin Freeman.	AN
4471	A fuck-mothering vampire.	AN
4472	A big-breasted 14-year-old wearing a bikini and sucking on a popsicle.	AN
4473	Henry Goto being savagely raped by a bear.	AN
4474	Yet another goddamn Goku vs. Superman argument.	AN
4475	FANSERVICE!!!	AN
4476	Gen Fukunaga counting his money.	AN
4477	FUNimation.	AN
4478	Hatsune Miku.	AN
4479	Strangling hardcore otaku nerds with razor wire.	AN
4480	Aya Hirano being gang-banged by her entire band.	AN
4481	Bukkake.	AN
4482	OVER 9000!!	AN
4483	Little Kuriboh.	AN
4484	Bulma's panties.	AN
4485	Mami getting her head bitten off.	AN
4486	A Captain Harlock body pillow.	AN
4487	Onii-chan.	AN
4488	MAWNING LESCUE!!!	AN
4489	Idiots who don't seem to realize that Avatar: The Last Airbender isn't really an anime.	AN
4490	Christopher R. Sabat.	AN
4491	PASTAAAAA!!!!	AN
4492	Johnny Yong Bosch.	AN
4493	Yu-Gi-Oh! The Abridged Series.	AN
4494	A fat middle-aged man in a Sailor Moon costume.	AN
4495	$300 anime bluray boxsets.	AN
4496	Man-Faye.	AN
4497	DAN GREEN.	AN
4498	"WE UNDERSTAND ANIME FAN WANTS!!"	AN
4499	Dio Brando.	AN
4500	Hokuto! Hyakurestu-ken!	AN
4501	Vic Micderpaderp.	AN
4502	Goku.	AN
4503	Soldier A.	AN
4504	Red-headed tsunderes.	AN
4505	That sound effect in every hentai when the guy ejaculates.	AN
4506	Sarah Fuckin' Palin.	AN
4507	Edward Wong Hau Pepelu Tivruski IV.	AN
4508	"Bang."	AN
4509	Prof's legs.	AN
4510	Naruto.	AN
4511	Wendee Lee.	AN
4512	Rice balls.	AN
4513	Monkey D. Luffy.	AN
4514	JesuOtaku's ginormous lips.	AN
4515	Princess Tutu.	AN
4516	Fujiko's boobs.	AN
4517	Vash the Stampede.	AN
4518	Shinji being a whiny little bitch.	AN
4519	Third Impact.	AN
4520	Kenshiro.	AN
4521	Puella Magi Madoka Magica.	AN
4522	Cowboy Bebop.	AN
4523	Fullmetal Alchemist.	AN
4524	Futanari.	AN
4525	Taking a potato chip... and EATING IT.	AN
4526	Unreasonably long transformation sequences.	AN
4527	Ass dance!! Ass dance!!	AN
4528	Stupid fucking Kululu.	AN
4529	CENTURY SOOOOUUUP!!!!!	AN
4530	The Gripper.	AN
4531	Thinking Misty from Pok&eacute;mon is... kinda sexy.	AN
4532	Garzey's Wing.	AN
4533	Reverse harems.	AN
4534	Mewtwo.	AN
4535	Tengen Toppa Gurren Lagann.	AN
4536	Sir Integra Fairbrook Wingates Hellsing.	AN
4537	Wearing panties on the head.	AN
4538	Brina Palencia as an angsty teenage boy, Monica Rial as his bratty little sister, and Shelley Calene-Black as their hot mom.	AN
4539	CARD GAMES ON MOTORCYCLES.	AN
4540	Nice boat.	AN
4541	Boku no Pico.	AN
4542	The One Piece rap.	AN
4543	A Bleach hentai doujin where Rukia rapes Ichigo.	AN
4544	Walpurgisnacht.	AN
4545	Bludgeoning Haruhi Suzumiya to death with a tire iron.	AN
4546	Girls with glasses.	AN
4547	Eating the wrong end of a chocolate cornet.	AN
4548	Being eaten by a titan.	AN
4549	Casca's hairy unshaven vag.	AN
4550	Tits on your hand.	AN
4551	That little fat kid from Accel World.	AN
4552	The Death Note.	AN
4553	A "read the manga" style ending.	AN
4554	Giant robots.	AN
4555	Osamu Tezuka.	AN
4556	Studio Ghibli.	AN
4557	Masa! <3	AN
4558	THE MAN-POLE OF <i>DOOOOOOOOOM!!!</i>	AN
4559	Ladd Russo.	AN
4560	Home For Infinite Losers (HFIL).	AN
4561	Moe Moe Kyun!	AN
4562	El Psy Congroo.	AN
4563	Sailor Moon and the 7 Ballz.	AN
4564	Gratuitous panty shots.	AN
4565	Sucking Kyle Hebert's dick for hamburgers.	AN
4566	Cartoon buttholes.	AN
4567	Muscle-bound shirtless MEN.	AN
4568	Recap episodes.	AN
4569	An overly defensive fanbase.	AN
4570	Fuckin' Bronies.	AN
4571	Groping strangers on a train.	AN
4572	My Cresta.	AN
4573	Nerdy kids in Speedos.	AN
4574	Bad K-on! fanart.	AN
4575	That stupid opening song from Steel Angel Kurumi getting stuck in your head.	AN
4576	Mamoru Miyano.	AN
4577	A Hello Kitty! vibrator.	AN
4578	TETSUOOOOOO!!!	AN
4579	Wibble.	AN
4580	Black cosplayers.	AN
4581	Fake Nendoroids.	AN
4582	Eating ramen noodles for a month because you HAD to have that out of print Macross boxset.	AN
4583	Showing Serial Experiments Lain to toddlers.	AN
4584	A mindfuck.	AN
4585	A puppy being beaten to death with a flower pot.	AN
4586	Gantz. Just.... Gantz.	AN
4587	Snapping the nipple off of a prostitute's breast and eating it.	AN
4588	Panty &amp; Stocking with Garterbelt.	AN
4589	Punching a man so hard his clothes fly off.	AN
4590	Banana sushi.	AN
4591	Oro?	AN
4592	Creamy Mami.	AN
4593	Whatever the hell the Utena movie was about.	AN
4594	Carl Macek.	AN
4595	The ungodly abomination that is Robotech.	AN
4596	Kira worshippers.	AN
4597	The thousands upon thousands of women that Golgo 13 has slept with.	AN
4598	Uguu...	AN
4599	Old man dragon dick.	AN
4600	Apocalypse Zero.	AN
4601	Ikki Tousen.	AN
4602	". . . ."	AN
4603	The inevitable beach episode.	AN
4604	A Japanese schoolgirl covered head-to-toe in semen.	AN
4605	Satoshi Kon.	AN
4606	Kigurumi.	AN
4607	Good ol' fashioned Japanese sexism.	AN
4608	Guro.	AN
4609	Dr. Who fans showing up at anime cons despite not being invited.	AN
4610	Plot armor.	AN
4611	Nekomimi.	AN
4612	Pure grade-A opium.	AN
4613	Banging 1,000 dudes.	AN
4614	A drunken Japanese businessman.	AN
4615	Maid cafes.	AN
4616	Host clubs.	AN
4617	Shooting out nearly an entire liter of cum.	AN
4618	The Hare Hare Yukai dance.	AN
4619	Shining Finger!	AN
4620	The inkvasion.	AN
4621	School swimsuits.	AN
4622	Underpants. Underpants. Underpants. Underpants. Under-	AN
4623	Acidic breast milk.	AN
4624	Kamen Rider.	AN
4625	The Major's hips and bust.	AN
4626	Captain Bravo.	AN
4627	Kirino's ass.	AN
4628	Crystal Boy's creepy smile.	AN
4629	Gackt.	AN
4630	Used panty vending machines.	AN
4631	Butt sniffing.	AN
4632	Vegeta's sweet goatee.	AN
4633	Sub-only releases.	AN
4634	Getting drunk on sake.	AN
4635	Flying Vortex of Fear.	AN
4636	Fishcake.	AN
4637	Go Nagai sideburns.	AN
4638	<i>CHIIIIIIIIN.</i>	AN
4639	Getting the bad ending of a visual novel.	AN
4640	The Tsukihime anime.	AN
4641	Jacuzzi Splot.	AN
4642	Juvijuvibro.	AN
4643	Bear punching, tiger chopping, shark suplexing, &amp; helicopter bodyslamming.	AN
4644	Getting your penis cut in half.	AN
4645	Stupid sexy Johan.	AN
4646	Naoki Urasawa.	AN
4647	Tachikoma-kun.	AN
4648	Dancin' on the Planet Dance.	AN
4649	Super Milk-chan.	AN
4650	You dumbass!	AN
4651	Being the uke.	AN
4652	The power of friendship.	AN
4653	An arm and a leg.	AN
4654	The entire cast of School Days.	AN
4655	Giant naked Rei.	AN
4656	Masturbating over Asuka's comatose body.	AN
4657	Let's Fighting Love!	AN
4658	Cousin marriage.	AN
4659	4Kids.	AN
4660	Making someone's head explode.	AN
4661	Michelle Ru-<br>er, I mean... "Sophie Roberts."	AN
4662	Calling out the name of your attack.	AN
4663	Multi-episode fights.	AN
4664	M.D. Geist.	AN
4665	Blue Water Studios.	AN
4666	Darrel Guilbeau trying to act.	AN
4667	Highschool of the Dead.	AN
4668	Girls with guns.	AN
4669	The goddamn Maho.	AN
4670	Fat, sweaty otaku.	AN
4671	Ganguro girls.	AN
4672	Magical girls.	AN
4673	Hot female bass players.	AN
4674	Goku, Luffy, Toriko, and Lina Inverse in an eating contest.	AN
4675	BlackStar	AN
4676	KING!!! KING!!! KING GAINER!!!<br><i>*does the Monkey*</i>	AN
4677	You cactus bastard!	AN
4678	Underwater Ray Romano.	AN
4679	Sexy schoolteacher types.	AN
4680	Tig ol' bitties.	AN
4681	Lesbian subtext.	AN
4682	Watching FLCL while tripping on acid.	AN
4683	Inspector Zenigata.	AN
4684	Pure fighting spirit.	AN
4685	The GARtender.	AN
4686	Mad Bull 34.	AN
4687	Sticking your finger up her ass.	AN
4688	Freddie riding to school on a wild black stallion.	AN
4689	Whatever turns you on, big guy.	AN
4690	Standing outside the gates of the White House completely naked with a revolver in your hand.	AN
4691	I'LL ANSWER THE PHONE FROM NOW ON, LILY!!	AN
4692	KITTEH. :3	AN
4693	Manly tears of manliness.	AN
4694	Zetman.	AN
4695	Giant mutant cockroaches.	AN
4696	Bible Black.	AN
4697	Rape fantasies.	AN
4698	Keith David's voice.	AN
4699	Scott McNeil.	AN
4700	The eternal pervert, Eric Vale.	AN
4701	The Irresponsible Captain Tylor.	AN
4702	Birdy the Mighty.	AN
4703	Prying SpacemanHardy's Master Keaton boxset from his cold, dead hands.	AN
4704	Satan worshipping Christians.	AN
4705	Hunting down every single copy of Ninja Resurrection and setting them on fire.	AN
4706	R-R-R-R-R-REDLINE!!!	AN
4707	Catholic priests who drink, smoke, and carry guns.	AN
4708	Badass 15-year-olds.	AN
4709	Losing 20 gallons of blood... and surviving.	AN
4710	One HELL of a butler.	AN
4711	Being beaten to a bloody pulp by a middle school student.	AN
4712	Anime News Network.	AN
4713	Having blackmail sex with your teacher.	AN
4714	A large paper fan.	AN
4715	The Shikon Jewel.	AN
4716	"INUYASHA!!"<br>"KAGOME!!"	AN
4717	Sneaking a peek at the girls' open bath.	AN
4718	Revy Two-Hands.	AN
4719	A Claymore swimsuit issue.	AN
4720	A samurai terminator.	AN
4721	Physics.	AN
4722	Gangnam Style.	AN
4723	MUNGLE!!<br><i>*shakes fist*</i>	AN
4724	A talking motorcycle.	AN
4725	Rie Kugimiya.	AN
4726	The Animatrix.	AN
4727	Your virgin soul.	AN
4728	Franky's awesome Speedo dance.	AN
4729	Soul traveling.	AN
4730	Production I.G.	AN
4731	GONZO.	AN
4732	Really shitty CGI effects.	AN
4733	The hot buttered sex voice of Patrick Seitz.	AN
4734	Sticking a chopstick in your pee-hole.	AN
4735	A copy of Trigun signed by Micah Solusod.	AN
4736	Gilgamesh.	AN
4737	That one guy who always dresses up as the Red Ranger.	AN
4738	Engrish.	AN
4739	A dead meme.	AN
4740	Madhouse.	AN
4741	ARMS.	AN
4742	Mr. Tadakichi.	AN
4743	Showing episodes of Toriko to starving children.	AN
4744	Governor Ishihara.	AN
4745	Shrine maidens.	AN
4746	Taking a shit in the shrine's donation box.	AN
4747	Farting... tadpoles?	AN
4748	Heavily-tattooed yakuza henchmen.	AN
4749	The life-sized Gundam statue.	AN
4750	Forcing someone to watch every episode of Dragon Ball GT.	AN
4751	ZA WARUDO.	AN
4752	Eating a banana all sexy-like.	AN
4753	Awesome Prussia.	AN
4754	Ora! Ora! Ora! Ora! Ora! Ora! Ora! Ora! Ora! Ora! Ora! Ora! Ora! Ora! Ora! Ora! Ora! Ora! Ora! Ora! Ora! Ora! Ora! Ora!	AN
4755	A shitload of yen.	AN
4756	Johannes Krauser II.	AN
4757	Raccoon testicles.	AN
4758	Beautiful bishonen boys.	AN
4759	Rule 63'd Death the Kid.	AN
4760	Hetalia porn.	AN
4761	1,000 years of pain.	AN
4762	Rally Vincent firing a gun in her underwear.	AN
4763	A Maka Chop.	AN
4764	Twincest.	AN
4765	Broken-ass Aizen.	AN
4766	The Garden of Sinners.	AN
4767	Romi Paku.	AN
4768	My Johnny!	AN
4769	Petite Princess Yucie.	AN
4770	Ice cold water<br>(and it's only a dollar).	AN
4771	Me wearing a penguin suit.	AN
4772	Farting on your cat.	AN
4773	Combat afros.	AN
4774	A brand new, mint condition copy of JoJo's Bizarre Adventure vol. 4, still in shrinkwrap.	AN
4775	Grave of the Fireflies.	AN
4776	Strapping hand grenades to your pubes.	AN
4777	Toilet worship.	AN
4778	My badass numchucks.	AN
4779	Trying to get your die-cast Gundam model through airport security.	AN
4780	Black&#x2605;Star	AN
4781	Octopus balls.	AN
4782	Getting in a fistfight with an earthquake.	AN
4783	WcDonald's.	AN
4784	Undead body-swapping space vampire teens.	AN
4785	The alpha bitch.	AN
4786	Eating someone else's drool.	AN
4787	My hot zombie girlfriend..	AN
4788	Puppets made from the skin of children.	AN
4789	Swallowing an entire carton of cigarettes before barfing them back up.	AN
4790	Giving a girl an orgasm using only your shoulderpads.	AN
4791	Being accidentally turned into a girl by aliens.	AN
4792	Ghosts that come out of your asscrack.	AN
4793	#DesuDes4Life.	AN
4794	Fucking a nun.	AN
4795	Raping Tokyo Tower.	AN
4796	A succubus living inside your testes.	AN
4797	Saber Starblast.	AN
4798	An argument lasting over an hour about what mo&eacute; really is.	AN
4799	Kotetsu T. Kaburagi, aka. "The D.I.L.F."	AN
4800	Japanese Spider-Man.	AN
4801	A bass guitar straight to the face.	AN
4802	Sonny Strait's manly parts.	AN
4803	Asian cock.	AN
4804	Guts.	AN
4805	Holy dildos.	AN
4806	Finger nigiri.	AN
4807	Dragon Balls.	AN
4808	Drills for hands.	AN
4809	Suplexing your teacher.	AN
4810	A leopard print fundoshi.	AN
4811	Breast envy.	AN
4812	The entire last episode of Blood-C.	AN
4813	Origami sex toys.	AN
4814	ALL OF THE HOMO!	AN
4815	Japanese rope bondage.	AN
4816	Griffith's mysterious disappearing penis.	AN
4817	Naughty geishas.	AN
4818	Ninjas!	AN
4819	Pubic hair needle attack.	AN
4820	Sexy jutsu.	AN
4821	Getting your fingernails ripped out.	AN
4822	Shinichiro Watanabe single-handedly curing cancer, ending world hunger, and bringing peace to the Middle East.	AN
4823	Love Machine.	AN
4824	Rapping samurai.	AN
4825	Putting all the condiments on your steak. ALL OF THEM.	AN
4826	Naga's extremely annoying laugh.	AN
4827	A dolphin in a mech suit.	AN
4828	Flying Nimbus.	AN
4829	Strikeman and his "Balls of Justice".	AN
4830	A busty, blonde, blue-eyed, dumb-as-rocks American.	AN
4831	Running during the credits.	AN
4832	Red bean paste.	AN
4833	Gender-swapped Oda Nobunaga.	AN
4834	Cutting off a finger to restore your honor.	AN
4835	Robots with tits.	AN
4836	Henry Goto.	AN:HG
4837	Henry Goto having an accident in his pants during the live Aniplex of America panel.	AN:HG
4838	Henry Goto's massive peyote &amp; wine cooler addiction.	AN:HG
4839	Henry Goto, John Sirabella, and Stu Levy in a three man fight to the death.	AN:HG
4840	Henry Goto fapping to a photograph of himself.	AN:HG
4841	Henry Goto being eaten by a group of backwoods hillbilly cannibals.	AN:HG
4842	Henry Goto ending up homeless on the streets and sucking dick for coke.	AN:HG
4843	Two gallons of elephant shit being dropped on Henry Goto's desk.	AN:HG
4844	Henry Goto falling down the stairs, receiving a massive head injury, and believing he's really Sailor Moon.	AN:HG
4845	A Henry Goto joke that no one will laugh at other than SpacemanHardy.	AN:HG
4846	Henry Goto bleeding profusely from his groin after having his penis bitten off by a 15-year-old Vietnamese prostitute.	AN:HG
4847	A 30-year-old man who's obsessed with K-on!	AN
4848	LAZAR!	AN
4849	I AM AWESOME!!	AN
4850	Getting kicked in the nuts by a mermaid.	AN
4851	Taking a seat with Chris Hansen.	MrMan
4852	The Village People.	MrMan
4853	A Cleveland steamer.	MrMan
4854	A big floppy donkey dick.	MrMan
4855	Pooping in the bathtub.	MrMan
4856	Bathing the homeless.	MrMan
4857	An awkward sponge bath.	MrMan
4858	Toilet paper.	MrMan
4859	Getting off on anime porn.	MrMan
4860	Enemas.	MrMan
4861	The Teenage Mutant Ninja Turtles.	MrMan
4862	Mining for nose gold.	MrMan
4863	Laxatives.	MrMan
4864	Putting the fucking lotion in the basket.	MrMan
4865	The tears of a clown.	MrMan
4866	Gangrene.	MrMan
4867	Gingivitis.	MrMan
4868	Two dogs humping.	MrMan
4869	Genital warts.	MrMan
4870	Suppositories.	MrMan
4871	Face painting.	MrMan
4872	A prolapse.	MrMan
4873	Digital piracy.	MrMan
4874	A poop sandwich.	MrMan
4875	Executive parking.	MrMan
4876	A dead hooker.	MrMan
4877	A skeptical sheriff.	MrMan
4878	A chatroom predator.	MrMan
4879	A loud mouth-breather.	MrMan
4880	The crushed dreams of a stripper.	MrMan
4881	Anorexia.	MrMan
4882	Gobots.	MrMan
4883	A Motown group.	MrMan
4884	a classy smoking jacket.	MrMan
4885	Giant areolas.	MrMan
4886	Peanutbutter jelly time.	MrMan
4887	A sexy senior citizen.	MrMan
4888	Granny panties.	MrMan
4889	A stuttering auctioneer.	MrMan
4890	Farting into a fancy handkerchief.	MrMan
4891	Lot lizards.	MrMan
4892	A LARPing sleeper cell.	MrMan
4893	A Fleshlite&trade;.	MrMan
4894	A molotov cocktail.	MrMan
4895	A cockblocker.	MrMan
4896	Public schooling.	MrMan
4897	The end of the world.	MrMan
4898	Dickjitsu.	MrMan
4899	A mushy tushy.	MrMan
4900	Don Knotts.	MrMan
4901	Morbid obesity.	MrMan
4902	Geriatric diaper rash.	MrMan
4903	A MILF.	MrMan
4904	Bigfoot.	MrMan
4905	Yellow snow.	MrMan
4906	A limp wrist.	MrMan
4907	An angry leprechaun.	MrMan
4908	The Tin Man.	MrMan
4909	Giving yourself a stranger.	MrMan
4910	Shitting into someone's hat for revenge.	MrMan
4911	Learning hypnosis to get laid.	MrMan
4912	The War of Northern Aggression.	MrMan
4913	A snot rocket.	MrMan
4914	Miss. Piggy.	MrMan
4915	Sailor Moon.	MrMan
4916	Mass graves.	MrMan
4917	A victim.	MrMan
4918	Soiling ones self.	MrMan
4919	A clone army.	MrMan
4920	Raw sewage.	MrMan
4921	War crimes.	MrMan
4922	A collapsed lung.	MrMan
4923	The town drunk.	MrMan
4924	The face of pure evil.	MrMan
4925	Spontaneous pie fights.	MrMan
4926	The Fresh Prince of Bel-Air.	MrMan
4927	Being screamed at in German.	MrMan
4928	A lesson in pain.	MrMan
4929	Talking like a pirate.	MrMan
4930	A Facebook stalker.	MrMan
4931	Sausage.	MrMan
4932	A compound fracture.	MrMan
4933	The magical land of Oz.	MrMan
4934	Pow-Pow-PowerWheeels&reg;!	MrMan
4935	Cheating death.	MrMan
4936	Clown Shoes.	MrMan
4937	Clown college.	MrMan
4938	A lousy comb-over.	MrMan
4939	Chaz Bono.	MrMan
4940	Hoarders.	MrMan
4941	Bed wetting.	MrMan
4942	Nuns.	MrMan
4943	A closed casket funeral.	MrMan
4944	Scotch.	MrMan
4945	A really ugly baby.	MrMan
4946	Dunkenly texting an ex.	MrMan
4947	Realizing, too late, that there is no toilet paper left.	MrMan
4948	Illegal immigrants.	MrMan
4949	Elder abuse.	MrMan
15412	Jerry Jewell's serial killer face.	ANX1
15413	A FUCKING DRAGONITE, MOTHERFUCKER!!	ANX1
15414	A school bus orgy.	ANX1
15415	Super Aryan Hitler.	ANX1
15416	Having sex with a dragon.	ANX1
15417	Manga Jesus.	ANX1
15418	Manly pink sparkles.	ANX1
15419	7 ft. tall red-headed Alexander the Great.	ANX1
15420	Training a dinosaur to ride a ball.	ANX1
15421	Samba-dancing dinosaurs.	ANX1
15422	An armored truck full of shit.	ANX1
15423	A Togepi omelet.	ANX1
15424	The Puchuu.	ANX1
15425	Dying over and over again.	ANX1
15426	Fuckingham Palace.	ANX1
15427	Epic old bald dudes.	ANX1
15428	A smashed-in face.	ANX1
15429	A Dragon Slave.	ANX1
15430	Zelgadis' flame-proof bikini briefs.	ANX1
15431	Morphin'.	ANX1
15432	A naughty nurse outfit.	ANX1
15433	A sweaty shirtless man holding a large, writhing fish against his chest.	ANX1
15434	Millionaire Beaver.	ANX1
15435	Dick Saucer.	ANX1
15436	A couple that spends over 30 manga volumes trying to get to first base.	ANX1
15437	Alice in Sexland.	ANX1
15438	Succubus-on-futanari action.	ANX1
15439	High-stakes mahjong.	ANX1
15440	Garbage collectors... IN SPACE!!	ANX1
15441	Magical friendship lasers.	ANX1
15442	The War on Pants.	ANX1
15443	An ending where everyone dies.	ANX1
15444	A cyborg assassin dressed as a magical girl fighting a talking lion and a floating psychic electric jellyfish.	ANX1
15445	J-pop idols.	ANX1
15446	Chest-hair afros.	ANX1
15447	Cowboy Andy.	ANX1
15448	A chainsaw-wielding male magical girl zombie.	ANX1
15449	Inoue Kikoku, 17-years old.	ANX1
15450	Fujoshi.	ANX1
15451	Matrix boobs.	ANX1
15452	Completely losing your shit over Endless Eight.	ANX1
15453	Violently beating your friends to death with a baseball bat.	ANX1
15454	Clothing-dissolving slime.	ANX1
15455	Involuntary crossdressing.	ANX1
15456	Getting sucked into a fantasy world.	ANX1
15457	Hentai artists who don't change their pen name when they go legit.	ANX1
15458	A Masamune Shirou artbook.	ANX1
15459	Loli in a box.	ANX1
15460	Romance of the Three Kingdoms, but everyone is gender-swapped.	ANX1
15461	Mo&eacute; schoolgirl Hitler.	ANX1
15462	Franken Fran.	ANX1
15463	A washpan falling onto someone's head from out of nowhere.	ANX1
15464	SHAFT being SHAFT.	ANX1
15465	A third-grader seducing her 23-year-old teacher.	ANX1
15466	Shotas.	ANX1
15467	One a them bamboo things that goes "doonk".	ANX1
15468	Banging your adopted daughter.	ANX1
15469	Tripping, falling, and landing with your face in a girl's breasts.	ANX1
15470	A bunny girl having a lightsaber duel with Darth Vader.	ANX1
15471	A 10-year old with boobs twice the size of her head.	ANX1
15472	An ancient vampire who looks like she's 10.	ANX1
15473	Literally ripping your own heart out.	ANX1
15474	Japanese-style elf ears.	ANX1
15475	Flamboyantly gay William Shakespeare.	ANX1
15476	Gen "The Uro-Butcher".	ANX1
15477	Mikuru Beam!	ANX1
15478	Tons and tons of close-up underaged schoolgirl ass-shots.	ANX1
15479	Starfish Hitler.	ANX1
15480	Pok&eacute;mon tears.	ANX1
15481	Pok&eacute;sexuality.	ANX1
15482	Chopstick-based martial arts.	ANX1
15483	All the gayness in GetBackers.	ANX1
15484	Naming yourself after the method of your suicide.	ANX1
15485	The Chupacabra.	ANX1
15486	Blowing a child's head off with a rocket launcher.	ANX1
15487	Erotic incestuous toothbrushing.	ANX1
15488	An artbox that feels like human skin.	ANX1
15489	Polygamy jokes in a kid's show.	ANX1
15490	Urd, Kana, and Misato in a drinking contest.	ANX1
15491	Cute stuff.	ANX1
15492	A robot having an orgasm.	ANX1
15493	Villagulio.	ANX1
15494	Dangling Pok&eacute;balls.	ANX1
15495	Having a giant drill for a dick.	ANX1
15522	An ingrown toenail on the tip of a penis.	AI
15523	Feline Leukemia.	AI
15524	Marky Mark's foam rubber penis from Boogie Nights.	AI
15525	My Spankerchief.	AI
15526	Pumping a chemical toilet.	AI
15527	The fine line between kinky and perverted.	AI
15528	A Rotisserie Chicken.	AI
15529	Vultures circling a birthday party.	AI
15530	An All White Jury.	AI
15531	Frottage.	AI
15532	Michael J. Fox trying to use a rotary phone.	AI
15533	The Five Knuckle Truffle Punch.	AI
15534	Flipper Babies.	AI
15535	Ejaculating into an insulin pump.	AI
15536	Rocky Dennis and John Merrick's lovechild.	AI
15537	The syrupy goop inside a Stretch Armstrong doll.	AI
15538	Finding an adhesive bandage at the bottom of your ice cream.	AI
15539	Life after Parole.	AI
15540	A cat's sand papery tongue bath.	AI
15541	A Pit Bull named Genghis.	AI
10108	Discovering that it's never just a big vagina.	Furry
10109	Dragoneer.	Furry
10110	A horny dragon.	Furry
10111	A sexually frustrated griffon.	Furry
10112	Species stereotypes.	Furry
10113	HELLO FURRIEND, HOWL ARE YOU DOING.	Furry
10114	Convention sluts.	Furry
10115	Horns and hooves.	Furry
10116	Being "prison gay."	Furry
10117	Microwaving diapers.	Furry
10118	Adorable dog people.	Furry
10119	Sexy the Cat.	Furry
10120	That one episode of CSI.	Furry
10121	SecondLife.	Furry
10122	The Gay Yiffy Club.	Furry
10123	Hyper-endowed squirrels.	Furry
10124	A spider furry who isn't even into bondage.	Furry
10125	Being really, really into monsters.	Furry
10126	Sexual arousal from children's cartoons.	Furry
10127	No males, no herms, no cuntboys, no shemales, no trannys, no furries, no aliens, no vampires, and no werewolves. ONLY STRAIGHT OR BI HUMAN FEMALES.	Furry
10128	Overcompensating with a huge horse penis.	Furry
10129	A fedora enthusiast.	Furry
10130	A tongue-beast.	Furry
10131	Frisky tentacles.	Furry
10132	A very steampunk rat.	Furry
10133	Canine superiority.	Furry
10134	Oviposition.	Furry
10135	Flares.	Furry
10136	Dogs wearing panties.	Furry
10137	Monster boys in lingerie.	Furry
10138	Power bottoms.	Furry
10139	Sheath licking.	Furry
10140	Sex with Pok&eacute;mon.	Furry
10141	Making out with dogs.	Furry
10142	YouTube videos of horse breeding.	Furry
10143	Pissing on your significant other to show ownership.	Furry
10144	Being able to recognize your friends by the scent of their asses.	Furry
10145	A notebook full of embarrassing niche porn sketches.	Furry
10146	Cockvore.	Furry
10147	A prehensile penis.	Furry
10148	Puns involving the word "knot."	Furry
10149	Jerking off on an unconscious friend's feet.	Furry
10150	CrusaderCat.	Furry
10151	Your Character Here.	Furry
15542	Sphincter Bleaching.	AI
15543	Bringing the Hamburglar to Justice.	AI
15544	Toilet Wine.	AI
15545	An Amputee's chapped limb nub.	AI
15546	Febreezing your Taint.	AI
15547	Leftist Propaganda.	AI
15548	Cookie Monster's substance abuse issues.	AI
14817	____.	TGWTG
14818	*liveshot*.	TGWTG
14819	8-Bit Mickey on an unstoppable merry-go-round.	TGWTG
14820	80's Dan.	TGWTG
14821	A Blip ad for the most embarrassing reality show ever.	TGWTG
14822	A Brad Jones impersonation.	TGWTG
14823	A crossover.	TGWTG
14824	A Cybermat in a bow tie.	TGWTG
14825	A delicious fried chicken holocaust.	TGWTG
14826	A DMCA takedown notice.	TGWTG
14827	A fan artist.	TGWTG
14828	A FUCKING PONCHO!	TGWTG
14829	A giant go-fuck-yourself spider.	TGWTG
14830	A half naked, fencing JewWario.	TGWTG
14831	A hand-basket of lobsters.	TGWTG
14832	A Mr. T Trading Card.	TGWTG
14833	A pile of skulls.	TGWTG
14834	A pink tutu.	TGWTG
14835	A plushie TARDIS.	TGWTG
14836	A poorly made knockoff action figure.	TGWTG
14837	A REALLY big hoopla about nothing.	TGWTG
14838	A Serbian Film.	TGWTG
14839	A smoking, muscled ice cream cone shooting guns and eye lasers.	TGWTG
14840	A speeding NERF dart to the junk.	TGWTG
14841	A squadron of attack Corgis.	TGWTG
14842	A squadron of line-dancing hippos.	TGWTG
14843	A strip-tease from the Nostalgia Critic.	TGWTG
14844	A tauntaun puppy.	TGWTG
14845	A very serious hat.	TGWTG
14846	Ambiguously nude Linkara.	TGWTG
14847	An electronic cigarette that resembles a Sonic Screwdriver.	TGWTG
14848	An evangelizing minion.	TGWTG
14849	An existential crisis over internet reviews.	TGWTG
14850	An impassioned plea for understanding.	TGWTG
14851	An unhinged Oancitizen rolling towards the sea.	TGWTG
14852	Angry Joe dancing in a squid suit.	TGWTG
14853	Angry Joe's raging boner.	TGWTG
14854	Another fucking Iron Liz pun.	TGWTG
14855	Another goddamn PhilBuni Vine.	TGWTG
14856	Aplos, or Steve, the Wizard.	TGWTG
14857	Arlo P. Arlo.	TGWTG
14858	Arlo the Orc.	TGWTG
14859	Ashens taking a blowtorch to a crappy toy.	TGWTG
14860	Ashens.	TGWTG
14861	Because...hippos.	TGWTG
14862	Becoming possessed and insulting your colleague.	TGWTG
14863	Being awkward around your favorite reviewer.	TGWTG
14864	Bennett the Sage.	TGWTG
14865	Big Butter Jesus.	TGWTG
14866	Blip.	TGWTG
14867	Brad, drinking a Turkey-flavored Jones Soda.	TGWTG
14868	Bruno Matei.	TGWTG
14869	Butchered Dutch.	TGWTG
14870	Comicron One.	TGWTG
14871	CR.	TGWTG
14872	Cynthia Rothrock	TGWTG
14873	DEATH FROM ABOOOOOVE!!!	TGWTG
14874	Derek the Bard.	TGWTG
14875	Derek the Bard's hat.	TGWTG
14876	Disturbing comments in the RDA chat.	TGWTG
14877	Dodger's ban chain.	TGWTG
14878	Dodging blowjobs.	TGWTG
14879	Dr. Tease & Dr. Block.	TGWTG
14880	Dragging Oancitizen back home from a wild night of partying.	TGWTG
14881	Dump cards.	TGWTG
14882	E Rod's smooth, smooth dance skills.	TGWTG
14883	Eating the flesh of your foes while howling at the moon.	TGWTG
14884	Evilina.	TGWTG
14885	Evilina's monstrous visage.	TGWTG
14886	Film Brain, dressed tastefully in fashionable clothing.	TGWTG
14887	Film Brain's hair.	TGWTG
14888	Film Renegado creaming himself over Pacific Rim.	TGWTG
14889	Forcing an NPC to haul your crap.	TGWTG
14890	Fuckstick the Magic Dragon.	TGWTG
14891	Gargoyle Cat.	TGWTG
14892	Haganistan.	TGWTG
14893	Harmony Korine.	TGWTG
14894	HIPPOS!	TGWTG
14895	Holly.	TGWTG
14896	Il Neige in a freakishly accurate Film Brain costume.	TGWTG
14897	Jaeris, the Gunslinger.	TGWTG
14898	Joe Quesada.	TGWTG
14899	Kali.	TGWTG
14900	Kung Tai Ted.	TGWTG
14901	Kyle playing GTA while drunk.	TGWTG
14902	Kyle's "unicorns."	TGWTG
14903	Laura, the Fender Stratocaster Goddess.	TGWTG
14904	Linkara lying naked on his futon, playing with a Cybermat.	TGWTG
14905	Linkara, dressed as the Green Ranger.	TGWTG
14906	Linkara, dropping an F-Bomb.	TGWTG
14907	Linkara, sexily eating a salad.	TGWTG
14908	Linkara's massive ego.	TGWTG
14909	Little Pluckies Ninja Protects.	TGWTG
14910	Luke Mochrie's trust fund.	TGWTG
14911	Maven of ze Eventide.	TGWTG
14912	Mexican Spider-Man.	TGWTG
14913	MikeJ.	TGWTG
14914	Moarte.	TGWTG
14915	Nash, dressed as The Undertaker.	TGWTG
14916	Nash, making "vroom vroom" noises.	TGWTG
14917	Nash, making train sounds in a bathtub.	TGWTG
14918	Nella.	TGWTG
14919	Nella's cleavage Altoids.	TGWTG
14920	Not reading the FAQ.	TGWTG
14921	Obelisk Blue Linkara.	TGWTG
14922	Paw.	TGWTG
14923	Paw's soul patch.	TGWTG
14924	Penis whiskers.	TGWTG
10509	the 8 million jews.	Vidya
10510	George Costanza	Viyda
10511	Honk! Honk!	Vidya
10512	Hideo Kojima	Vidya
10513	Alright	Vidya
10514	LIQUID!	Vidya
10515	BROTHER!	Vidya
10516	Gaben	Vidya
10517	Kirby's Air Ride	Vidya
10518	Yume Nikki	Vidya
10519	HL3 confirmed!	Vidya
10520	That feel	Vidya
10521	Tim Buckley	Vidya
10522	Bum Tickley	Vidya
10523	Star Wars: Battlefront	Vidya
10524	The Wii U	Vidya
10525	the PS4	Vidya
10526	the NES	Vidya
10527	the SNES	Vidya
10528	the SEGA Genesis	Vidya
10529	the PSX	Vidya
10530	Silent Hill	Vidya
10531	Harry Mason	Vidya
10532	James Sunderland	Vidya
10533	the plot of MGS4	Vidya
10534	Kramer	Vidya
10535	no games	Vidya
10536	Words, Words, Words	Vidya
10537	Le /v/ culture	Vidya
10538	Mods	Vidya
10539	Furfags	Vidya
10540	HERESY!	Vidya
10541	My waifu	Vidya
10542	Jews	Vidya
10543	the duck hunt dog	Vidya
10544	Max Payne	Vidya
10545	L.A. Noire	Vidya
10546	Call of Duty 4	Vidya
10547	Cowadooty Franchise	Vidya
10548	Master Chef	Vidya
10549	Samus Aran	Vidya
10550	Kamiya	Vidya
10551	The red ring of death	Vidya
10552	Toady	Vidya
10553	the mustard race	Vidya
10554	Klonies	Vidya
10555	Valve	Vidya
10556	source engine	Vidya
10557	Wii-tier graphics	Vidya
10558	brown and bloom	Vidya
10559	FUCKING GAMESTOP	Vidya
10560	Mountain Dew	Vidya
10561	Doritoes	Vidya
10562	Dante, but you an call him Dante the demon killer	Vidya
10563	FUCK YOU	Vidya
10564	Princess Peach	Vidya
10565	Ronnie	Vidya
10566	Wreck-It Ralph	Vidya
10567	Destroy-It Dan	Vidya
10568	Rape-It Randy	Vidya
10569	Bayonetta	Vidya
10570	Fifa 2014	Vidya
10571	Superman 64	Vidya
10572	E.T. for Atari	Vidya
10573	Dark Souls	Vidya
10574	Devil May Cry	Vidya
10575	Wubs	Vidya
10576	a custom built PC	Vidya
10577	making an email to gabe newell one post at a time	Vidya
10578	Warioware	Vidya
10579	Earthbound	Vidya
10580	Pikmen	Vidya
10581	Duck Hunt	Vidya
10582	Egoraptor	Vidya
10583	Cory in the House	Vidya
10584	Katawa Shoujio	Vidya
10585	Donte	Vidya
10586	/sp/	Vidya
10587	/pol/	Vidya
10588	/a/	Vidya
10589	Traps	Vidya
10590	Capitan Falcon	Vidya
10591	knowing that feel	Vidya
10592	my sides	Vidya
10593	wagglan	Vidya
10594	playing vidya	Vidya
10595	being a casual fuck	Vidya
10596	JonTron	Vidya
10597	Two Best Friends	Vidya
10598	Tropes vs Women in Video Games	Vidya
10599	Anita	Vidya
10600	Wiimote	Vidya
10601	Xbox Hueg	Vidya
10602	Japan Time	Vidya
10603	the orignal Xbox controller	Vidya
10604	Solid Snake's Ass	Vidya
10605	Big Boss	Vidya
10606	Kirby	Vidya
10607	Waluigi	Vidya
10608	Geno	Vidya
10609	Ridley	Vidya
10610	GLaDOS	Vidya
10611	Shigeru Miyamoto	Vidya
10612	Mother 3	Vidya
10613	Shigesato Itoi	Vidya
10614	Alexey Pajinov	Vidya
10615	Sam & Max	Vidya
10616	Banjo-Kazooie	Vidya
10617	Hank Hill	Vidya
10618	Pheonix Wright	Vidya
10619	the orange gem from Bejeweled&trade;	Vidya
10620	thowing bottles of holy water in the original Castlevania	Vidya
10621	using your PC as a heater in the winter	Vidya
10622	Wii Fit Trainer	Vidya
10623	Nanomachines, son	Vidya
10624	Creating a LttP vs Majora's Mask	Vidya
10625	Following the damn train	Vidya
10626	Kotaku	Vidya
10627	checking your privledge	Vidya
10628	having fun	Vidya
10629	Call of Cthulhu	Vidya
10630	Corruption of Champions	Vidya
10631	Sanic	Vidya
10632	Sanic Adventure 2	Vidya
10633	Civillization IV	Vidya
10634	League of Legends	Vidya
10635	DoTA 2	Vidya
10636	HoN	Vidya
10637	asking br? when joining a server	Vidya
10638	Geralt	Vidya
10639	Halo	Vidya
10640	Doomguy	Vidya
10641	Regginator	Vidya
10642	tfw no qt gf	Vidya
10643	Atelier	Vidya
10644	Asura	Vidya
10645	Obsidrones	Vidya
10646	Nintenyearolds	Vidya
10647	Xbots	Vidya
10648	Sonyggers	Vidya
10649	Hitscan	Vidya
10650	xX420blazeitXx	Vidya
10651	Sakurai	Vidya
10652	blowing into a catridge	Vidya
10653	Dragon Dildos	Vidya
10654	Nintendo	Vidya
10655	Sony	Vidya
10656	Microsoft	Vidya
10657	Sega	Vidya
10658	Konami	Vidya
10659	Game Freak	Vidya
10660	Fez	Vidya
10661	Cave Story	Vidya
10662	Wololololololololo	Vidya
10663	pirating games because you hate the government	Vidya
10664	New Super Luigi Bros	Vidya
10665	the Demoman (who takes skill)	Vidya
10666	the Pyro (who takes skill)	Vidya
10667	on disk DLC	Vidya
10668	sports games the come out year after year	Vidya
10669	Ass Creed	Vidya
10670	playing counterstrike too seriously	Vidya
10671	Minecraft	Vidya
10672	Notch	Vidya
10673	Buzzwords	Vidya
10674	OFF by Mortis Ghost	Vidya
10675	an indie dev that no one knows about	Vidya
10676	the Secret of Monkey Island	Vidya
10677	watching let's plays on youtube	Vidya
10678	grumpy dumpies	Vidya
10679	Spaghetti	Vidya
10680	the best Final Fantasy game	Vidya
10681	Grayson Hunt	Vidya
10682	not completing all the side quests	Vidya
10683	artificial difficulty	Vidya
10684	padding	Vidya
10685	artificial fun	Vidya
10686	Matt and Pat	Vidya
10687	Hamberger Helper	Vidya
10688	Yahtzee	Vidya
10689	iJustine	Vidya
10690	Jack Thompson	Vidya
10691	rebbit	Vidya
10692	The /v/idya gaem awards	Vidya
10693	Emi (from Katawa Shoujo)	Vidya
10694	Rin (from Katawa Shuojo)	Vidya
10695	Lilly (from Katawa Shuojo)	Vidya
10696	Hanako (from Katawa Shuojo)	Vidya
10697	Shizune (from Katawa Shuojo)	Vidya
10698	Misha (from Katawa Shuojo)	Vidya
10699	Kenji (from Katawa Shuojo)	Vidya
10700	The Last of Us	Vidya
10701	/v/	Vidya
10702	Video Games	Vidya
10703	NSA	Vidya
10704	Christopher Robin	Vidya
10705	The Master Race	Vidya
10706	/mlp/	Vidya
10707	Bronies	Vidya
10708	/vg/	Vidya
10709	/vr/	Vidya
10710	/vp/	Vidya
10711	p2w	Vidya
10712	the delay time of Duke Nukem Forever	Vidya
10713	Duke Nukem	Vidya
10714	WoW	Vidya
10715	Worth the Weight	Vidya
10716	anything but video games	Vidya
10717	Tom Preston	Vidya
10718	Andrew Dobson	Vidya
10719	nogames	Vidya
10720	2spooky	Vidya
10721	599 US Dollars 	Vidya
10722	Eight Point Eight	Vidya
10723	RAGE	Vidya
14925	Playing TGWTG Cards Against Humanity at stupid o'clock.	TGWTG
14926	Pol Pot pies.	TGWTG
14927	Rachel Tietz, trying to Kill the Nostalgia Critic.	TGWTG
14928	Ripping off part of your penis.	TGWTG
14929	ROCKET BOOTS!	TGWTG
14930	ROCKET PUNCH!	TGWTG
14931	Sad Panda's lanky, manly chest.	TGWTG
14932	Sage's "RAPE!" face.	TGWTG
14933	Sean.	TGWTG
14934	Sex, violence, and Daffy Duck screaming.	TGWTG
14935	Shouting "FUS-RO-DAH!" at a puppy.	TGWTG
14936	Smarty.	TGWTG
14937	Smarty's special bag of AIDS.	TGWTG
14938	Snowflame's cocaine flavored popsicles.	TGWTG
14939	Snowflame's fuzzy slippers.	TGWTG
14940	Space Core.	TGWTG
14941	Stealing money off dead wolves.	TGWTG
14942	Surprise blowjobs.	TGWTG
14943	Tara's tramautic childhood stories.	TGWTG
14944	That Dude In The Suede.	TGWTG
14945	The Adventures of Horsemeat and the Placenta #1.	TGWTG
14946	The Amazing Bulk.	TGWTG
14947	The Channel Awesome satellite.	TGWTG
14948	The Hippo Lantern Corps.	TGWTG
14949	The Last Angry Geek.	TGWTG
14950	The Longbox of the Damned.	TGWTG
14951	The Nostalgia Ranger.	TGWTG
14952	The Rap Critic.	TGWTG
14953	The thick, muscular arms of ChaosD1.	TGWTG
14954	The Uncanny Valley.	TGWTG
14955	The Wal-Mart.	TGWTG
14956	Todd in the Shadows.	TGWTG
14957	Todd trolling Chris Brown on Twitter.	TGWTG
14958	Tommy Wiseau.	TGWTG
14959	Turtle.	TGWTG
14960	Using a frontloader to steal deodorant.	TGWTG
14961	Using donation money for weed.	TGWTG
14962	Vangelus	TGWTG
14963	Ven's voice, a gift from the fairies.	TGWTG
14964	Zeo Linkara.	TGWTG
14965	A DraculaFetus animation.	NL
14966	A profile pic that looks like a dick and balls.	NL
14967	Spy Party racism.	NL
14968	The ghost of Ohmwrecker.	NL
14969	Shooting the black guy.	NL
14970	Ohm's mindgames.	NL
14971	DOTA 2.	NL
14972	Magic: The Gathering.	NL
14973	A failed challenge run.	NL
14974	Setting the world on fire.	NL
14975	Pot magic.	NL
14976	Josh's washing machine.	NL
14977	Dang it, Bobby!	NL
14978	Up in the air like a George Clooney movie.	NL
14979	A lemon mishap.	NL
14980	This cat, I swear to god.	NL
14981	Ohmwrecker.	NL
14982	youtube.com/Ohmwrecker.	NL
14983	Drinkable fire.	NL
14984	Ohmsdrawings.tumblr.com.	NL
14985	Soul level 1 invasions.	NL
14986	Ryuka.	NL
14987	The blue candle.	NL
14988	JSmith's laundry.	NL
14989	Mount Your Friends: Docking Edition.	NL
14990	Childlike bukakke.	NL
14991	A water supply full of leeches.	NL
14992	Travelling by bones.	NL
14993	AlpacaPatrol.	NL
14994	Zen.	NL
14995	Green9090.	NL
14996	#MikeBithell.	NL
14997	RedPandaGamer.	NL
14998	Ohm, our god.	NL
14999	...Metal Gear?!	GG
15000	A beautiful little moment.	GG
15001	A couch stinking of naked people.	GG
15002	A humanlike bat with tits.	GG
15003	A little dingle-dang.	GG
15004	A pretty epic poo.	GG
15005	A replay from Barry.	GG
15006	A Scottish bloke that talks too fast.	GG
15007	A smaller, whiter dick.	GG
15008	A Sonic.	GG
15009	A testicle examination.	GG
15010	A whale making a seal noise.	GG
15011	Accidentally resetting a video game.	GG
15012	An expensive rental costume.	GG
15013	Anne Frank doing a striptease.	GG
15014	Arin actually winning a Game Grumps VS.	GG
15015	Arin Hanson / Egoraptor.	GG
15016	Arin's big floppy penis.	GG
15017	Arin's dicksaber.	GG
15018	Arin's voice acting.	GG
15019	Barry Kramer.	GG
15020	Barry's censorship noises.	GG
15021	Becoming a vegetarian, then becoming clinically depressed.	GG
15022	Being forced to replay the same section of the game over and over.	GG
15023	Birdemic.	GG
15024	Borderline narcissism.	GG
15025	Breaking a basketball net's back board.	GG
15026	Breaking into song.	GG
15027	Brian / Frank / Steve / Willard / Jonathan / Michael IV / Michael III / Michael Jordan / Scott.	GG
15028	Bumping butts.	GG
15029	Buying chicken fingers for homeless people.	GG
15030	Carefully escorting Anna.	GG
15031	Catharsis.	GG
15032	Cheese pizza.	GG
15033	Chu Chu Rocket.	GG
15034	Chulip.	GG
15035	Comparing someone to a trainwreck.	GG
15036	Completely missing the tutorials and instructions.	GG
15037	Cumfaggots.	GG
15038	Dan getting some action with one of Egoraptor's action figures.	GG
15039	Danny Sexbang.	GG
15040	Danny's crippling Skittles addiction.	GG
15041	Dipping your balls in the sand.	GG
15042	Dixon.	GG
15043	Donkey-ass Kong.	GG
15044	Drakkhen's realistic fight sequences.	GG
15045	Drawing the line in the fucking sand.	GG
15046	Eating the Holocaust.	GG
15047	Eating your peas.	GG
15048	Egofaptor.	GG
15049	Ending an episode on "Heil Hitler!"	GG
15050	The eyeless girl demographic.	GG
15051	Fart science.	GG
15052	Fast-forwarding.	GG
15053	Fighting Iblis for the hundredth time.	GG
15054	Fooling me three times.	GG
15055	Fuckin' Larry.	GG
15056	FUCKING LEGO CARS!!?!	GG
15057	Game feel.	GG
15058	Game Grumps remixes.	GG
15059	Game Grumps VS.	GG
15060	Game Grumps.	GG
15061	Garshstostoles.	GG
15062	GeorgLopez.	GG
15063	Getting censored by a stampede of elephants.	GG
15064	Getting diddled again.	GG
15065	Getting fucking ganked.	GG
15066	Getting horribly diarrhea'd on by an owl.	GG
15067	Getting killed by a motherfucking paralyzed Taillow.	GG
15068	Getting stuck on the ceiling for no explicable reason.	GG
15069	Getting violently sick at MAGfest.	GG
15070	Goof Troop.	GG
15071	Goofy masturbating in the fields.	GG
15072	Grade A meat.	GG
15073	Grant Kirkhope.	GG
15074	Grant Kirkhope’s knackers.	GG
15075	GREAT! GREAT! GREAT!	GG
15076	Grep.	GG
15077	Grumping it.	GG
15078	Güf Troop.	GG
15079	Half the deal for twice the price!	GG
15080	Having a cough that lasts forever.	GG
15081	Helicopter tits.	GG
15082	Hepatitis Sea.	GG
15083	Hitting a Nightshade cartridge with Thor’s Hammer only to break the hammer.	GG
15084	Homoerotic subtext between two grown men playing video games.	GG
15085	Ice hair.	GG
15086	Incriminating footage of Jon.	GG
15087	Insta-killing your partner with the Select button.	GG
15088	It being no use.	GG
15089	Jacques.	GG
15090	JonTron.	GG
15091	Jon winning. AS USUAL.	GG
15092	Jon's soulful singing.	GG
15093	Jon/Arin slash fiction.	GG
15094	JonTron’s musical theater voice.	GG
15095	Js'keep goin'.	GG
15096	Killing zombies by typing on a keyboard-gun.	GG
15097	Kirby.	GG
15098	Kitty Cat Dance Party.	GG
15099	Learning that your son is dead, but not caring because you didn't want him anyway.	GG
15100	Lemon and Bill.	GG
15101	Lightsaber Fightsaber.	GG
15102	Literally going to Hell.	GG
15103	Mediocrity, as a power.	GG
15104	Mega Man.	GG
15105	Mike Tyson.	GG
15106	Mispronouncing Duran Duran.	GG
15107	Mister Mosquito.	GG
15108	MomTron.	GG
15109	Moundo.	GG
15110	Naughty Bear.	GG
15111	Nazi von Killyou.	GG
15112	Ninja Sex Party.	GG
15113	Nixon.	GG
15114	NO JON NO.	GG
15115	NOT FUCKING THIS!	GG
15116	Not knowing the controls to Nickelodeon GUTS.	GG
15117	Not reading the game's instructions.	GG
15118	Obeying Protoman and burning down a forest.	GG
15119	Pacific Rim.	GG
15120	Pause balls.	GG
15121	Pelistorm.	GG
15122	Playing a terrible game for more than a hundred episodes.	GG
15123	Playing slaps to break a tie.	GG
15124	PONY.MOV.	GG
15125	Poopy butt.	GG
15126	Poppy Bros.	GG
15127	Princess Elise's octopus face.	GG
15128	Punching a hole in a gingerbread house.	GG
15129	Queefing bombs out of your vagina.	GG
15130	Racial slurs.	GG
15131	Reading the manual.	GG
15132	RIDIN’ ON CARS!!!	GG
15133	Robots ordering cheese pizza.	GG
15134	Rocket. To the moon.	GG
15135	Rolling around at the speed of sound.	GG
15136	RubberRoss.	GG
15137	Rouge's gross bat face.	GG
15138	Screaming out Whitney Houston’s “I Will Always Love You” in primal agony.	GG
15139	Sequelitis.	GG
15140	Seven asses.	GG
15141	Signing and destroying a copy of Sonic '06.	GG
15142	Silver the Hedgehog.	GG
15143	Sneaking dirty British humour into an unassuming video game about a bear and a bird.	GG
15144	Snow white shit.	GG
15145	Snowboarding uphill	GG
15146	Solid Snake.	GG
15147	Sonic '06.	GG
15148	Spice World.	GG
15149	Spraying compressed air with a bittering agent in your face, and subsequently vomiting.	GG
15150	Stairfax Temperatures.	GG
15151	Staring at a menu while Ross stuffs his disgusting face with candy.	GG
15152	Stasis-ing the drill.	GG
15153	Steam Train.	GG
15154	Sticky sap.	GG
15155	Stretch Panic.	GG
15156	STRGG.	GG
15157	Struggling to fight Silver the Hedgehog.	GG
15158	Sucking blood from a Japanese girl's tits.	GG
15159	Suzy the Goose.	GG
15160	TENOUTTATEN.	GG
15161	That guy.	GG
15162	The Awesome Series.	GG
15163	The band Egoraptor.	GG
15164	The Chinless Wonder.	GG
15165	The Goshdangodon.	GG
15166	The Higgs Boson.	GG
15167	The Knuckles wall glitch.	GG
15168	The rarest form of Arin having fun.	GG
15169	The realization that friendship is more important.	GG
15170	Three big feet of pleasure.	GG
15171	Tonguing up.	GG
15172	Typing "C D PLAYER" and getting "MODEL CAR."	GG
15173	WAAAAAAAVE LAAAAZEEEEEEER.	GG
15174	Walking around in my banana shoes.	GG
15175	World Dick Barf Syndrome.	GG
15176	Man-Gobbler, the turkey bestiality movie.	RT
15177	RoosterTeeth.	RT
15178	Michael Jones.	RT
15179	Gavin Free.	RT
15180	Surgeon Simulator 2013.	RT
15181	Ray Narvaez, Jr.	RT
15182	Burnie Burns.	RT
15183	Geoff Lazer Ramsey.	RT
15184	Jack Pattillo.	RT
15185	Ryan Haywood.	RT
15186	Gus Sorola.	RT
15187	The cardboard cutout of Gus.	RT
15188	Joel Heyman.	RT
15189	Going cakeless.	RT
15190	Headlight fluid.	RT
15191	Playing Hitler twice.	RT
15192	Sarge.	RT
15193	Lopez la Pesado.	RT
15194	Franklin Delano Donut.	RT
15195	Dexter Grif.	RT
15196	Dick Simmons.	RT
15197	Agent Washington.	RT
15198	Andy the bomb.	RT
15199	Picking up chicks in a tank.	RT
15200	Michael J. Caboose.	RT
15201	Sheila the tank.	RT
15202	Leonard Church.	RT
15203	Lavernius Tucker.	RT
15204	Agent Texas / Allison.	RT
15205	Omega / O'Malley.	RT
15206	Agent Maine / the Meta.	RT
15207	Frank "Doc" DuFresne.	RT
15208	Screen looking.	RT
15209	A wet paper towel.	RT
15210	Minecraft.	RT
15211	MOGAR!	RT
15212	X-Ray and Vav.	RT
15213	Slo Mo Guys.	RT
15214	#DantheMan.	RT
15215	Joe the cat.	RT
15216	Pongo.	RT
15217	Soggy bread.	RT
15218	Rage Quit.	RT
15219	Achievement Hunter.	RT
15220	Team-killing fucktards.	RT
15221	Calling dibs on a spaceship.	RT
15222	Sarge's funeral.	RT
15223	Camping, as a legitimate strategy.	RT
15224	Epsilon's laser face.	RT
15225	MOTHERFUCKING TRIPLE SPIKES!	RT
15226	Because people like grapes.	RT
15227	Upside-down Kerry.	RT
15228	Ray's sombrero.	RT
15229	Doing a dig-down.	RT
15230	Mark Nutt.	RT
15231	AHWU.	RT
15232	Throwing shit at the AHWU announcer.	RT
15233	Red vs. Blue.	RT
15234	Geoff's cancer-curing laugh.	RT
15235	The Tower of Pimps.	RT
15236	The Frienderman.	RT
15237	Beating a man to death with his own skull.	RT
15238	Fighting to the death on pigback.	RT
15239	RWBY.	RT
15240	RT Shorts.	RT
15241	RT Animated Adventures.	RT
15242	Mega64.	RT
15243	Immersion.	RT
15244	Reaching a billion total views on YouTube.	RT
15245	Doing a double barrel roll and immediately running someone over.	RT
15246	A Ray-Cam masturbation moment.	RT
15247	Tackling Gavin to stop him from winning.	RT
15248	Losing an hour's worth of footage to a brief blackout.	RT
15249	Fails of the Weak.	RT
15250	Achievement HORSE.	RT
15251	Trials PIG.	RT
15252	Slapping the controller out of a competitor's hands.	RT
15253	Cockbites.	RT
15254	Achievement City.	RT
15255	Two bases in the middle of a box canyon. Whoop-dee-fuckin'-doo.	RT
15256	Blood Gulch.	RT
15257	Parkour.	RT
15258	Faffy Waffle.	RT
15259	Something that is top.	RT
15260	A plan that involves Grif dying.	RT
15261	Using CPR to treat a bullet wound to the head.	RT
15262	Front flip for style!	RT
15263	Trying to eat a five-pound gummy bear in one sitting.	RT
15264	RTX.	RT
15265	Randy Newman.	RT
15266	Slenderman.	RT
15267	The R&R Connection.	RT
15268	The Internet Box.	RT
15269	Performing surgery in space.	RT
15270	Jack's dick.	RT
15271	The Crev.	RT
15272	Team Nice Dynamite.	RT
15273	Team Lads.	RT
15274	Team Gents.	RT
15275	Plan G.	RT
15276	Team Neighborhood Watch.	RT
15277	Ray winning.	RT
15278	Edgar the cow.	RT
15279	Gavin's Trophy Room of Victory.	RT
15280	Jack's beard.	RT
15281	Being trapped in a dog cage.	RT
15282	Geoff's hobo beard.	RT
15283	Killing Gavin.	RT
15284	Discovering your long-lost Creeper parents.	RT
15285	A megalomaniac with a beard.	RT
15286	Ray's douche-cut.	RT
15287	The adventures of Batman and Randy Newman.	RT
15288	Because they'd like it.	RT
15289	Knobs.	RT
15290	Gubbins.	RT
15291	Meatspin.	RT
15292	Flynt Coal.	RT
15293	Tupperware.	RT
15294	A miniature Tower of Pimps.	RT
15295	Giving up and building a house.	RT
15296	Gavin's dick.	RT
15297	Wearing your headphones backwards during a podcast week after week.	RT
15298	Flicking the bean.	RT
15299	Getting minged up your quelch.	RT
15300	Grand Theft Auto IV.	RT
15301	Ray's wet sponge.	RT
15302	Bankrupting your company over a crane game.	RT
15303	A bag of dicks.	RT
15304	ENDERMAN!!!	RT
15305	Lightish red.	RT
15306	In denial.	RT
15307	Enwrong.	RT
15308	Papa BrownMan.	RT
15309	Caleb's house.	RT
15310	Evil Ryan.	RT
15311	Randy Savage.	RT
15312	RT Confessions.	RT
15313	Two dumb cunts.	RT
15314	Smegpot.	RT
15315	Guffpap.	RT
15316	Launching dump trucks off an unfinished bridge.	RT
15317	Because bitches ain't shit.	RT
15318	Gavino.	RT
15319	Monoray.	RT
15320	Montages no one will watch.	RT
15321	A gay cave. A gayve.	RT
15322	A squid orgy.	RT
15323	Getting boned.	RT
15324	300,000 Gamerscore.	RT
15325	Team Magnum Dong.	RT
15326	Lindsay Tuggey.	RT
15327	Barbara Dunkelman.	RT
15328	Mavin slash fiction.	RT
15329	Caleb Denecour.	RT
15330	Monty Oum.	RT
15331	The league of being a big faggot.	DAH
15332	GaLm's sunglasses.	DAH
15333	The Card Czar.	DAH
15334	Inside Shrek's asshole.	DAH
15335	Solving a rubiks cube with your bare nipples.	DAH
15336	A canoe with enough room for Phil.	DAH
15337	The Black Seed.	DAH
15338	That video of EatMyDiction1 twerking.	DAH
15339	The Sips Co. Dirt Factory.	DAH
15340	DarkSydePhil playing Dark Souls.	DAH
15341	Hitler's Train!	DAH
15342	That time when Machinima played actual machinima videos.	DAH
15343	Bajan Canadian's fridge.	DAH
15344	Seananners' dolphin laugh.	DAH
15345	Chilledchaos' homosexual tendencies.	DAH
15346	Bolshevik the wolf.	DAH
15347	Diction watching a burly outdoorsman skin a bear while eating honey and crying.	DAH
15348	The Tom Shark.	DAH
15349	#TysLeftFoot	DAH
15350	Seananners joyously dropping "presents" on the African minority in GTA.	DAH
15351	Jah be dwarfin' it up!	DAH
15352	Tom drunk off his ass.	DAH
15353	Getting anally violated by a silverback gorilla.	DAH
15354	A Big 'Ol Bowl of Fruit!	DAH
15355	An LP Smarty finished.	DAH
15356	BEARS!	DAH
15357	The Blue Yeti microphone.	DAH
15358	A Machinima contract.	DAH
15359	Criken's Fun House.	DAH
15360	A smart joke.	DAH
15361	One of Chuggaconroy's awful puns.	DAH
15362	The Great Youtube Unsubbing of 2012.	DAH
15363	A robot bird.	DAH
15364	Time to cancel Smash Fighter.	DAH
15365	Smash Fighter.	DAH
15366	Totalbiscuit and Angry Joe frolicking in a meadow.	DAH
15367	Chilled and Smarty's wedding.	DAH
\.


--
-- TOC entry 1948 (class 0 OID 0)
-- Dependencies: 167
-- Name: white_cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cah
--

SELECT pg_catalog.setval('white_cards_id_seq', 15548, true);


--
-- TOC entry 1911 (class 2606 OID 16414)
-- Name: black_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY black_cards
    ADD CONSTRAINT black_cards_pkey PRIMARY KEY (id);


--
-- TOC entry 1913 (class 2606 OID 16416)
-- Name: black_cards_text_key; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY black_cards
    ADD CONSTRAINT black_cards_text_key UNIQUE (text);


--
-- TOC entry 1917 (class 2606 OID 16418)
-- Name: card_set_black_card_pkey; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY card_set_black_card
    ADD CONSTRAINT card_set_black_card_pkey PRIMARY KEY (card_set_id, black_card_id);


--
-- TOC entry 1915 (class 2606 OID 16420)
-- Name: card_set_pkey; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY card_set
    ADD CONSTRAINT card_set_pkey PRIMARY KEY (id);


--
-- TOC entry 1919 (class 2606 OID 16422)
-- Name: card_set_white_card_pkey; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY card_set_white_card
    ADD CONSTRAINT card_set_white_card_pkey PRIMARY KEY (card_set_id, white_card_id);


--
-- TOC entry 1921 (class 2606 OID 16424)
-- Name: white_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY white_cards
    ADD CONSTRAINT white_cards_pkey PRIMARY KEY (id);


--
-- TOC entry 1923 (class 2606 OID 16426)
-- Name: white_cards_text_key; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY white_cards
    ADD CONSTRAINT white_cards_text_key UNIQUE (text);


--
-- TOC entry 1924 (class 2606 OID 16427)
-- Name: fk513da45c997611f9; Type: FK CONSTRAINT; Schema: public; Owner: cah
--

ALTER TABLE ONLY card_set_black_card
    ADD CONSTRAINT fk513da45c997611f9 FOREIGN KEY (black_card_id) REFERENCES black_cards(id);


--
-- TOC entry 1925 (class 2606 OID 16432)
-- Name: fk513da45cb2505f39; Type: FK CONSTRAINT; Schema: public; Owner: cah
--

ALTER TABLE ONLY card_set_black_card
    ADD CONSTRAINT fk513da45cb2505f39 FOREIGN KEY (card_set_id) REFERENCES card_set(id);


--
-- TOC entry 1926 (class 2606 OID 16437)
-- Name: fkc2487272b2505f39; Type: FK CONSTRAINT; Schema: public; Owner: cah
--

ALTER TABLE ONLY card_set_white_card
    ADD CONSTRAINT fkc2487272b2505f39 FOREIGN KEY (card_set_id) REFERENCES card_set(id);


--
-- TOC entry 1927 (class 2606 OID 16442)
-- Name: fkc2487272bfd29b4d; Type: FK CONSTRAINT; Schema: public; Owner: cah
--

ALTER TABLE ONLY card_set_white_card
    ADD CONSTRAINT fkc2487272bfd29b4d FOREIGN KEY (white_card_id) REFERENCES white_cards(id);


--
-- TOC entry 1942 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-08-10 16:48:57

--
-- PostgreSQL database dump complete
--

