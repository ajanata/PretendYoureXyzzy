-- Pretend You're Xyzzy cards by Andy Janata is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
-- Based on a work at www.cardsagainsthumanity.com.
-- For more information, see http://creativecommons.org/licenses/by-nc-sa/3.0/

-- This file contains the Black Cards and White Cards for Cards Against Humanity, as a script for importing into PostgreSQL. There should be a user named pyx.
-- This contains all of the official cards through Q3 2017, imported via pyx-importer from a spreadsheet provided by CAH.

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.7
-- Dumped by pg_dump version 10.1

-- Started on 2018-02-27 15:12:09

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12427)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2201 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 185 (class 1259 OID 17734)
-- Name: black_cards; Type: TABLE; Schema: public; Owner: pyx
--

CREATE TABLE black_cards (
    id integer NOT NULL,
    draw integer NOT NULL,
    pick integer NOT NULL,
    text character varying(255),
    watermark character varying(255)
);


ALTER TABLE black_cards OWNER TO pyx;

--
-- TOC entry 186 (class 1259 OID 17742)
-- Name: card_set; Type: TABLE; Schema: public; Owner: pyx
--

CREATE TABLE card_set (
    id integer NOT NULL,
    active boolean NOT NULL,
    base_deck boolean NOT NULL,
    description character varying(255),
    name character varying(255),
    weight integer NOT NULL
);


ALTER TABLE card_set OWNER TO pyx;

--
-- TOC entry 187 (class 1259 OID 17750)
-- Name: card_set_black_card; Type: TABLE; Schema: public; Owner: pyx
--

CREATE TABLE card_set_black_card (
    card_set_id integer NOT NULL,
    black_card_id integer NOT NULL
);


ALTER TABLE card_set_black_card OWNER TO pyx;

--
-- TOC entry 188 (class 1259 OID 17755)
-- Name: card_set_white_card; Type: TABLE; Schema: public; Owner: pyx
--

CREATE TABLE card_set_white_card (
    card_set_id integer NOT NULL,
    white_card_id integer NOT NULL
);


ALTER TABLE card_set_white_card OWNER TO pyx;

--
-- TOC entry 190 (class 1259 OID 17788)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: pyx
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hibernate_sequence OWNER TO pyx;

--
-- TOC entry 189 (class 1259 OID 17760)
-- Name: white_cards; Type: TABLE; Schema: public; Owner: pyx
--

CREATE TABLE white_cards (
    id integer NOT NULL,
    text character varying(255),
    watermark character varying(255)
);


ALTER TABLE white_cards OWNER TO pyx;

--
-- TOC entry 2189 (class 0 OID 17734)
-- Dependencies: 185
-- Data for Name: black_cards; Type: TABLE DATA; Schema: public; Owner: pyx
--

COPY black_cards (id, draw, pick, text, watermark) FROM stdin;
1	0	1	Here is the church Here is the steeple Open the doors And there is ____.	US
3	0	1	50% of all marriages end in ____.	US
4	0	1	As the mom of five rambunctious boys, I'm no stranger to ____.	US
5	0	1	Next from J.K. Rowling: <i>Harry Potter and the Chamber of ____.</i>	US
6	0	1	This is the way the world ends This is the way the world ends Not with a bang but with ____.	US
7	0	1	After four platinum albums and three Grammys, it's time to get back to my roots, to what inspired me to make music in the first place: ____.	US
8	0	1	When Pharaoh remained unmoved, Moses called down a Plague of ____.	US
9	0	1	What's there a ton of in heaven?	US
10	0	1	It's a pity that kids these days are all getting involved with ____.	US
11	0	1	What's a girl's best friend?	US
12	0	1	____. High five, bro.	US
13	0	2	Step 1: ____. Step 2: ____. Step 3: Profit.	US
14	2	3	Make a haiku.	US
15	0	1	The class field trip was completely ruined by ____.	US
16	0	1	If you can't be with the one you love, love ____.	US
17	0	1	When I am a billionaire, I shall erect a 50-foot statue to commemorate ____.	US
18	0	1	I'm LeBron James, and when I'm not slamming dunks, I love ____.	US
19	0	1	Uh, hey guys, I know this was my idea, but I'm having serious doubts about ____.	US
20	0	1	Alternative medicine is now embracing the curative powers of ____.	US
21	0	2	I never truly understood ____ until I encountered ____.	US
22	0	1	I'm sorry, Professor, but I couldn't complete my homework because of ____.	US
23	0	1	I drink to forget ____.	US
24	0	1	Next on ESPN2: The World Series of ____.	US
25	0	1	Hey Reddit! I'm ____. Ask me anything.	US
26	0	2	That's right, I killed ____. How, you ask? ____.	US
27	0	1	How did I lose my virginity?	US
28	0	1	I'm going on a cleanse this week. Nothing but kale juice and ____.	US
29	0	1	Dear Abby, I'm having some trouble with ____ and would like your advice.	US
30	0	1	____. That was so metal.	US
31	0	1	I got 99 problems but ____ ain't one.	US
32	0	1	Why can't I sleep at night?	US
33	0	1	Dude, <i>do not</i> go in that bathroom. There's ____ in there.	US
34	0	2	Lifetime&reg; presents "____: the Story of ____."	US
35	0	1	Hey guys, welcome to Chili's! Would you like to start the night off right with ____?	US
36	0	1	Just once, I'd like to hear you say "Thanks, Mom. Thanks for ____."	US
37	0	1	Old Macdonald had ____. E-I-E-I-O.	US
38	0	1	What made my first kiss so awkward?	US
39	0	1	Just saw this upsetting video! Please retweet!! #stop____	US
40	0	1	What never fails to liven up the party?	US
41	0	1	Kids, I don't need drugs to get high. I'm high on ____.	US
42	0	2	When I was tripping on acid, ____ turned into ____.	US
43	0	1	Life for American Indians was forever changed when the White Man introduced them to ____.	US
44	0	1	Men's Wearhouse. You're gonna like ____. I guarantee it.	US
45	0	1	____. Betcha can't have just one!	US
46	0	1	Instead of coal, Santa now gives the bad children ____.	US
47	0	1	The Chevy Tahoe. With the power and space to take ____ everywhere you go.	US
48	0	1	Click here for ____!!!	US
49	0	1	TSA guidelines now prohibit ____ on airplanes.	US
50	0	1	What would grandma find disturbing, yet oddly charming?	US
51	0	1	What's that sound?	US
52	0	1	What is Batman's guilty pleasure.	US
53	0	1	After eight years in the White House, how is Obama finally letting loose?	US
54	0	1	This season at Steppenwolf, Samuel Beckett's classic existential play: Waiting for ____.	US
55	0	1	A recent laboratory study shows that undergraduates have 50% less sex after being exposed to ____.	US
56	0	2	Introducing the amazing superhero/sidekick duo! It's ____ and ____!	US
57	0	1	Mabe she's born with it. Maybe it's ____.	US
58	0	2	They said we were crazy. They said we couldn't put ____ inside of ____. They were wrong.	US
59	0	1	Arby's: We Have ____.	US
60	0	1	What will always get you laid?	US
61	0	1	My fellow Americans: Before this decade is out, we <i>will</i> have ____ on the moon!	US
62	0	1	What ended my last relationship?	US
63	0	1	Why do I hurt all over?	US
64	0	1	When I am President, I will create the Department of ____.	US
65	0	1	But before I kill you, Mr. Bond, I must show you ____.	US
66	2	3	____ + ____ = ____.	US
67	0	1	What's Teach For America using to inspire inner city students to succeed?	US
68	0	1	War! What is it good for?	US
69	0	2	In M. Night Shyamalan's new movie, Bruce Willis discovers that ____ had really been ____ all along.	US
70	0	1	Military historians remember Alexander the Great for his brilliant use of ____ against the Persians.	US
71	0	1	A romantic, candlelit dinner would be incomplete without ____.	US
72	0	1	Coming to Broadway this season, ____: The Musical.	US
73	0	1	Brought to you by Bud Light&reg;, the official Beer of ____.	US
74	0	1	Check me out, yo! I call this dance move "____."	US
75	0	2	And the Academy Award for ____ goes to ____.	US
76	0	1	Introducing X-treme Baseball! It's like baseball, but with ____!	US
77	0	1	Fun tip! When your man asks you to go down on him, try surprising him with ____ instead.	US
78	0	1	I'm no doctor but I'm pretty sure what you're suffering from is called "____."	US
79	0	1	Bravo's new reality show features eight washed-up celebrities living with ____.	US
80	0	1	White people like ____.	US
81	0	1	____: kid-tested, mother-approved.	US
82	0	1	IF you like ____, YOU MIGHT BE A REDNECK.	US
83	0	1	What gives me uncontrollable gas?	US
84	0	2	____ is a slippery slope that leads to ____.	US
85	0	1	Today on <i>Maury</i> : "Help! My son is ____!"	US
86	0	1	What is George W. Bush thinking about right now?	US
87	0	2	For my next trick, I will pull ____ out of ____.	US
88	0	1	What's that smell?	US
89	0	1	____. It's a trap!	US
90	0	1	Well if you'll excuse me, gentlemen, I have a date with ____.	US
91	0	1	&#x2605;&#x2606;&#x2606;&#x2606;&#x2606; Do NOT go here! Found ____ in my Kung Pao chicken!	US
92	0	1	Why am I sticky?	US
93	0	1	What makes life worth living?	US
94	0	1	In the Disney Channel Original Movie, Hannah Montana struggles with ____ for the first time.	US
95	0	1	While the United States raced the Soviet Union to the moon, the Mexican government funneled millions of pesos into research on ____.	US
96	0	1	What's my secret power?	US
97	0	1	What are my parents hiding from me?	US
98	0	1	Daddy, why is mommy crying?	US
99	0	1	During sex, I like to think about ____.	US
100	0	1	Mr. and Mrs. Diaz, we called you in because we're concerned about Cynthia. Are you aware that your daughter is ____?	US
101	0	1	I get by with a little help from ____.	US
102	0	1	I'm no doctor, but I'm pretty sure what you're suffering from is called "____."	CA
104	0	1	As the mom of five rambunctious boys, I'm not stranger to ____.	CA
105	0	2	CBC presents "____: the Story of ____."	CA
106	0	1	Just once I'd like to hear you say "Thanks, Mom. Thanks for ____."	CA
107	0	1	Bravo's new reality show feature eight washed-up celebrities living with ____.	CA
108	0	1	Air Canada guidelines now prohibit ____ on airplanes.	CA
109	0	1	When I am Prime Minister of Canada, I will create the Ministry of ____.	CA
110	0	1	Coming to Broadway this season, ____; The Musical.	CA
111	0	1	This season at the Princess of Wales Theatre, Samuel Beckett's classic existential play: <i>Waiting for ____.</i>	CA
112	0	1	Here is church Here is the steeple Open the doors And there is ____.	CA
113	0	1	Penalty! ____: that's 5 minutes in the box!	CA
114	0	1	Click Here for ____!!!	CA
115	0	1	Hey guys, welcome to Boston Pizza! Would you like to start the night off right with ____?	CA
116	0	1	I know when that hotline bling, that can only mean one thing: ____.	CA
117	0	1	Dude, <i>do not</i> go in that washroom. There's ____ in there.	CA
118	0	1	Just saw this upsetting video! Please retweet!! #stop ____	CA
119	0	1	Brought to you by Molson Canadian, the Official Beer of ____.	CA
120	0	1	Maybe she's born with it. Maybe it's ____.	CA
121	0	1	Next on TSN: The World Series of ____.	CA
122	0	1	A romantic, candlelit dinner would be incomplete without  ____.	CA
123	0	1	O Canada, we stand on guard for ____.	CA
124	0	1	What is Batman's guilty pleasure?	CA
125	0	1	Old MacDonald has ____. E-I-E-I-O.	CA
126	0	1	A recent laboratory study shows that undergraduates have 50% less sex after being exposed to: ____.	CA
127	0	1	Dear Abby, I'm having some trouble ____ and would like your advice.	CA
128	0	1	In the new Disney Channel Original Movie, Hannah Montana struggles with ____ for the first time.	CA
129	0	1	Skidamarink a dink a dink, skidamarink a doo, I love ____.	CA
130	0	1	But before I kill you, Mr. Bond, I must show you.	CA
131	0	1	The new Chevy Tahoe. With the power and space to take ____ everywhere you go.	CA
132	0	1	When I am a billionaire, I shall erect a 20-metre statue to commemorate ____.	CA
133	0	1	Airport security guidelines now prohibit ____ on airplanes.	UK
135	0	1	____? Jim'll fix it!	UK
136	0	1	Daddy, why is mummy crying?	UK
137	0	1	Today on <i>The Jeremy Kyle Show:</i> "Help! My son is ____!"	UK
138	0	1	What did I bring back from Amsterdam?	UK
139	0	1	Mate, <i>do not go</i> in that bathroom. There's ____ in there.	UK
140	0	1	____. Once you pop, the fun don't stop!	UK
141	0	1	When I am Prime Minister of the United Kingdom, I will create the Ministry of ____.	UK
142	0	1	Instead of coal, Father Christmas now gives the bad children ____.	UK
143	0	1	Just once I'd like to hear you say "Thanks, Mum. Thanks for ____."	UK
144	0	1	UKIP: Putting ____ First!	UK
145	0	2	And the BAFTA for ____ goes to____.	UK
146	0	1	TFL apologizes for the delay in train service due to ____.	UK
147	0	1	Nobody expects the Spanish Inquisition. Our chief weapons are fear, surprise, and ____.	UK
148	0	1	The school trip was completely ruined by ____.	UK
149	0	1	How am I maintaining my relationship status?	UK
150	0	1	As the mum of five rambunctious boys, I'm not stranger to ____.	UK
151	0	1	Next on Sky Sports: The World Champion of ____..	UK
152	0	1	What's the next Happy Meal&reg; toy?	UK
153	0	1	The theme for next year's Eurovision Song Contest is "We are ____."	UK
154	0	1	Next up on Channel 4: Ramsay's ____ Nightmares.	UK
155	0	1	In Belmarsh Prison, word is you can trade 200 cigarettes for ____.	UK
156	0	1	Now at the Natural History Museum: an interactive exhibit on ____.	UK
157	0	1	Hey guys, welcome to TGIF! Would you like to start the night off right with ____?	UK
158	0	1	Coming to the West End this year, ____: The Musical.	UK
159	0	2	In a world ravaged by ____, our only solace is ____.	UK
160	0	1	This season at the Old Vic, Samuel Beckett's classic existential play: Waiting for ____.	UK
161	0	1	Channel 5's new reality show feature eight washed-up celebrities living with ____.	UK
162	0	1	I'm sorry, Sir, but I couldn't complete my homework because of ____.	UK
163	0	1	____. That's what mums go to Iceland.	UK
164	0	2	Channel 4 presents "____: the Story of ____."	UK
165	0	1	Dear Agony Aunt, I'm having some trouble with ____ and would like your advice.	UK
167	0	1	Oi! Show us ____!	AU
168	0	1	What did I bring back from Bali?	AU
169	0	1	MTV's new reality show features eight washed-up celebrities living with ____.	AU
170	0	1	&#x2605;&#x2606;&#x2606;&#x2606;&#x2606; Do NOT go here! Found ____ in my Mongolian chicken!	AU
171	0	1	What broke up the original Wiggles?	AU
172	0	1	Today on <i>Jerry Springer:</i> "Help! My son is ____!"	AU
173	0	1	This season at the Sydney Opera House, Samuel Beckett's classic existential play: <i>Waiting for ____.</i>	AU
174	0	1	Crikey! I've never seen ____ like this before! Let's get a bit closer.	AU
175	0	1	What's there a tonne of in heaven?	AU
176	0	1	What makes me a true blue Aussie?	AU
177	0	1	The school excursion was completely ruined by ____.	AU
178	0	1	Channel 9 is pleased to present its new variety show, "Hey Hey It's ____."	AU
179	0	1	Qantas now prohibits ____ on airplanes.	AU
180	0	2	ABC presents "____: the Story of ____."	AU
181	0	1	Next on Nine's Wide World of Sports: The World Series of ____.	AU
182	0	1	Are you thinking what I'm thinking, B1? I think I am, B2: it's ____ time!	AU
183	0	1	____? Yeah, nah.	AU
184	0	1	Life for Aboriginal people was forever changed when the white man introduced them to ____.	AU
185	0	1	Hey guys, welcome to Sizzler! Would you like to start the night off right with ____?	AU
186	0	1	Brought to you by XXXX Gold, the Official Beer of ____.	AU
187	0	1	Mate, <i>do not</i> go in that toilet. There's ____ in there.	AU
188	0	1	In Australia, ____ is twice as big and twice as deadly.	AU
189	0	1	When I am Prime Minister, I will create the Department of ____.	AU
190	0	1	What brought the orgy to a grinding halt?	INTL
192	0	1	Lovin' you is easy 'cause you're ____.	INTL
193	0	1	Your persistence is admirable, my dear Prince. But you cannot win my heart with ____ alone.	INTL
194	0	1	The blind date was going horrible until we discovered our shared interest in ____.	INTL
195	0	1	Science will never explain ____.	INTL
196	0	1	The Five Stages of Grief: denial, anger, bargaining, ____, acceptance.	INTL
197	0	1	What has been making life difficult at the nudist colony?	INTL
198	0	1	Charades was ruined for me forever when my mom had to act out ____.	INTL
199	0	1	Money can't buy me love, but it can buy me ____.	INTL
200	0	1	During his midlife crisis, my dad got really into ____.	INTL
201	0	2	When you get right down to it, ____ is just ____.	INTL
202	0	1	This is your captain speaking. Fasten your seatbelts and prepare for ____.	INTL
203	0	1	Tonight's top story: What you don't know about ____ could kills you.	INTL
204	0	1	Future historians will agree that ____ marked the beginning of America's decline.	INTL
205	0	1	Coming this season, Samuel Beckett's classic existential play: <i>Waiting for ____.</i>	INTL
206	0	1	When I pooped, what came out of my butt?	INTL
207	0	1	A successful job interview begins with a firm handshake and ends with ____.	INTL
208	0	1	Finally! A service that delivers ____ right to your door.	INTL
209	0	1	And what did <i>you</i> bring for show and tell?	INTL
210	0	1	When I am a billionaire, I shall erect a 20-meter statue to commemorate ____.	INTL
211	0	1	When all else fails, I can always masturbate to ____.	INTL
212	0	2	I spent my whole life working toward ____, only to have it ruined by ____.	INTL
213	0	2	____ would be woefully incomplete without ____.	INTL
214	0	1	Next on Eurosport: The World Championship of ____.	INTL
215	0	1	In his new self-produced album, Kanye West raps over the sounds of ____.	INTL
216	0	1	In Rome, there are whisperings that the Vatican has a secret room devoted to ____.	INTL
217	0	2	Having problems with ____? Try ____!	INTL
218	0	1	The secret to a lasting marriage is communication, communication, and ____.	INTL
219	0	2	My mom freaked out when she looked at my browser history and found ____.com/____.	INTL
220	0	1	In the seventh circle of Hell, sinners must endure ____ for all eternity.	INTL
221	0	1	____. Awesome in theory, kind of a mess in practice.	INTL
222	0	1	My plan for world domination begins with ____.	INTL
223	0	1	I learned the hard way that you can't cheer up a grieving friend with ____.	INTL
224	0	1	A remarkable new study shows that chimps have evolved their own primitive version of ____.	INTL
225	0	2	After months of practice with ____, I think I'm finally ready for ____.	INTL
226	0	1	When I am Prime Minister, I will create the Ministry of ____.	INTL
227	0	1	Turns out that ____-Man was neither the hero we needed nor wanted.	INTL
228	0	2	With enough time and pressure, ____ will turn into ____.	INTL
229	0	1	What left this stain on my couch?	INTL
230	0	2	Dear Sir or Madam, We regret to inform you that the Office of ____ has denied your request for ____.	INTL
231	0	1	I'm not like the rest of you. I'm too rich and busy for ____.	INTL
232	0	1	The healing process began when I joined a support group for victims of ____.	INTL
233	0	1	Doctor, you've gone too far! The human body wasn't meant to withstand that amount of ____!	INTL
234	0	1	Only two things in life are certain: death and ____.	INTL
236	0	1	This month's Cosmo: "Spice up your sex life by bringing ____ into the bedroom."	RED
237	0	1	Next time on Dr. Phil: How to talk to your child about ____.	RED
238	0	1	Tonight on 20/20: What you don't know about ____ could kill you.	RED
239	0	1	My new favorite porn star is Joey "____" McGee.	RED
240	0	2	Michael Bay's new three-hour action epic pits ____ against ____.	RED
241	0	2	Before ____, all we had was ____.	RED
242	2	3	I went from ____ to ____ all thanks to ____.	RED
243	0	1	Aww, sick! I just saw this skater do a 720 kickflip into ____!	RED
244	0	1	What's harshing my mellow, man?	RED
245	0	1	I love being a mom. But it's tough when my kids come home filthy from ____. That's why there's Tide&reg;.	RED
246	0	1	As part of his daily regimen, Anderson Cooper sets aside 15 minutes for ____.	RED
247	0	1	To prepare for his upcoming role, Daniel Day-Lewis immersed himself in the world of ____.	RED
248	0	1	Welcome to Se&ntilde;or Frog's! Would you like to try our signature cocktail, "____ on the Beach"?	RED
249	0	1	Hey baby, come back to my place and I'll show you ____.	RED
250	0	2	You haven't truly lived until you've experienced ____ and ____ at the same time.	RED
251	0	1	Your persistence is admirable, my dear Prince, But you cannot win my heart with ____ alone.	RED
252	0	2	In a pinch, ____ can be a suitable substitute for ____.	RED
253	0	1	During high school, I never really fit in until I found ____ club.	RED
254	0	1	Little Miss Muffet<br>Sat on a tuffet,<br>Eating her curds<br>and ____.	RED
255	0	1	In its new tourism campaign, Detroit proudly proclaims that it has finally eliminated ____.	RED
256	0	1	My gym teacher got fired for adding ____ to the obstacle course.	RED
257	0	1	The blind date was going horribly until we discovered our shared interest in ____.	RED
258	0	1	My country, 'tis of thee, sweet land of ____.	RED
259	0	1	Call the law offices of Goldstein &amp; Goldstein, because no one should have to tolerate ____ in the workplace.	RED
260	0	1	Members of New York's social elite are paying thousands of dollars just to experience ____.	RED
261	0	1	In his newest and most difficult stunt, David Blaine must escape from ____.	RED
262	0	2	Dear Sir or Madam, <br>We regret to inform you that the Office of ____ has denied your request for ____.	RED
263	0	2	____: Hours of fun. Easy to use. Perfect for ____!	RED
264	0	2	Listen, son. If you want to get involved with ____, I won't stop you. Just steer clear of ____.	RED
265	0	1	Next week on the Discovery Channel, one man must survive in the depths of the Amazon with only ____ and his wits.	RED
266	0	2	If God didn't want us to enjoy ____, he wouldn't have given us ____.	RED
267	0	2	My life is ruined by a vicious cycle of ____ and ____.	RED
268	0	1	And I would have gotten away with it, too, if it hadn't been for ____!	RED
269	0	1	Legend has it Prince wouldn't perform without ____ in his dressing room.	RED
270	0	1	Dear Leader Kim Jong-un, our village praises your infinite wisdom with a humble offering of ____.	BLUE
272	0	2	We never did find ____, but along the way we sure learned a lot about ____.	BLUE
273	0	1	Do <i>not</i> fuck with me! I am literally ____ right now.	BLUE
274	0	1	And would you like those buffalo wings mild, hot, or ____?	BLUE
275	0	1	What's fun until it gets weird?	BLUE
276	0	1	And today's soup is Cream of ____.	BLUE
277	0	1	Come to Dubai, where you can relax in our world-famous spas, experience the nightlife, or simply enjoy ____ by the poolside.	BLUE
278	0	1	She's up all night for good fun. I'm up all night for ____.	BLUE
279	0	1	Hi MTV! My name is Kendra, I live in Malibu, I'm into ____, and I love to have a good time.	BLUE
280	0	2	I am become ____, destroyer of ____!	BLUE
281	0	2	____ may pass, but ____ will last forever.	BLUE
282	0	2	In the beginning, there was ____. And the Lord said, "Let there be ____."	BLUE
283	2	3	You guys, I saw this crazy movie last night. It opens on ____, and then there's some stuff about ____, and then it ends with ____.	BLUE
284	0	2	This year's hottest album is "____" by ____.	BLUE
285	0	1	"This is madness!"<br><br>" <i>No.</i> THIS IS ____!"	BLUE
286	0	1	It lurks in the night. It hungers for flesh. This summer, no one is safe from ____.	BLUE
287	0	2	____ will never be the same after ____.	BLUE
288	0	1	I don't mean to brag, but they call me the Michael Jordan of ____.	BLUE
289	0	1	Don't forget! Beginning this week, Casual Friday will officially become "____ Friday."	BLUE
290	0	1	Having the worst day EVER. #____	BLUE
291	0	1	Why am I broke?	BLUE
292	0	1	Wes Anderson's new film tells the story of a precocious child coming to terms with ____.	BLUE
293	0	2	Adventure. Romance. ____. From Paramount Pictures, "____."	BLUE
294	0	2	Patient presents with ____. Likely a result of ____.	BLUE
295	0	1	Yo' mama so fat she ____!	BLUE
296	0	1	Now in bookstores: "The Audacity of ____," by Barack Obama.	BLUE
297	0	1	In his new action comedy, Jackie Chan must fend off ninjas while also dealing with ____.	BLUE
298	0	1	Armani suit: $1,000. Dinner for two at that swanky restaurant: $300. The look on her face when you surprise her with ____: priceless.	BLUE
299	0	1	Behind every powerful man is ____.	BLUE
300	0	1	Life's pretty tough in the fast lane. That's why I never leave the house without ____.	BLUE
301	0	1	You are not alone. Millions of Americans struggle with ____ every day.	BLUE
302	0	1	My grandfather worked his way up from nothing. When he came to this country, all he had was the shoes on his feet and ____.	BLUE
303	0	2	If you can't handle ____, you'd better stay away from ____.	BLUE
304	0	1	Man, this is bullshit. Fuck ____.	BLUE
305	0	2	In return for my soul, the Devil promised me ____, but all I got was ____.	BLUE
306	0	1	The Japanese have developed a smaller, more efficient version of ____.	BLUE
307	0	1	Do you lack energy? Does it sometimes feel like the whole world is ____? Ask your doctor about Zoloft&reg;.	BLUE
308	0	1	I work my ass off all day for this family, and this is what I come home to? ____!?	BLUE
309	0	1	This is America. If you don't work hard, you don't succeed. I don't care if you're black, white, purple, or ____.	BLUE
310	0	1	Dammit, Gary. You can't just solve every problem with ____.	BLUE
311	0	1	James is a lonely boy. But when he discovers a secret door in his attic, he meets a magical new friend: ____.	BLUE
312	0	1	This is the prime of my life. I'm young, hot, and full of ____.	BLUE
313	0	2	Every step towards ____ gets me a little bit closer to ____.	BLUE
314	0	2	Well if ____ is good enough for ____, it's good enough for me.	BLUE
315	0	1	WHOOO! God <i>damn</i> I love ____!	BLUE
316	0	1	You Won't Believe These 15 Hilarious ____ Bloopers!	BLUE
317	0	1	You've seen the bearded lady! You've seen the ring of fire! Now, ladies and gentlemen, feast your eyes upon ____!	BLUE
318	0	1	When I was a kid, we used to play Cowboys and ____.	BLUE
319	0	1	Do the Dew&reg; with our most extreme flavor yet! Get ready for Mountain Dew ____!	BLUE
320	0	2	Honey, I have a new role-play I want to try tonight! You can be ____, and I'll be ____.	BLUE
321	0	2	Forget everything you know about ____, because now we've supercharged it with ____!	BLUE
322	0	1	What's making things awkward in the sauna?	BLUE
323	0	1	Listen, Gary, I like you. But if you want that corner office, you're going to have to show me ____.	BLUE
324	0	1	Help me doctor, I've got ____ in my butt.	BLUE
325	0	2	Oprah's book of the month is "____ For ____: A Story of Hope."	BLUE
326	0	2	You know, once you get past ____, ____ ain't so bad.	BLUE
327	0	1	In his farewell address, George Washington famously warned Americans about the dangers of ____.	BLUE
328	0	1	Well what do you have to say for yourself, Casey? This is the third time you've been sent to the principal's office for ____.	BLUE
329	0	1	Here at the Academy for Gifted Children, we allow students to explore ____ at their own pace.	BLUE
330	0	1	Get ready for the movie of the summer! One cop plays by the book. The other's only interested in one thing: ____.	BLUE
331	0	2	Heed my voice, mortals! I am the god of ____, and I will not tolerate ____!	BLUE
332	0	1	As king, how will I keep the peasants in line?	BLUE
333	0	1	I'm sorry, sir, but we don't allow ____ at the country club.	BLUE
334	0	1	2 AM in the city that never sleeps. The door swings open and <i>she</i> walks in, legs up to here. Something in her eyes tells me she's looking for ____.	BLUE
335	0	1	I have a strict policy. First date, dinner. Second date, kiss. Third date, ____.	BLUE
336	0	1	What killed my boner?	BLUE
337	0	1	Hi, this is Jim from accounting. We noticed a $1,200 charge labeled "____." Can you explain?	BLUE
338	0	1	I'm pretty sure I'm high right now, because I'm absolutely mesmerized by ____.	BLUE
339	0	1	Don't worry, kid. It gets better. I've been living with ____ for 20 years.	BLUE
340	0	1	How am I compensating for my tiny penis?	BLUE
341	0	1	Ooo, daddy like ____.	GREEN
343	0	1	As reparations for slavery, all African Americans will receive ____.	GREEN
344	0	1	What's about to take this dance floor to the next level?	GREEN
345	0	1	What are all those whales singing about?	GREEN
346	0	1	I've got rhythm, I've got music, I've got ____. Who could ask for anything more?	GREEN
347	0	1	Then the princess kissed the frog, and all of a sudden the frog was ____!	GREEN
348	0	1	What turned me into a Republican?	GREEN
349	0	1	If at first you don't succeed, try ____.	GREEN
350	0	1	Poor Brandon, still living in his parents' basement. I hear he never got over ____.	GREEN
351	0	1	Coming to Red Lobster&reg; this month, ____.	GREEN
352	0	1	Most Americans would not vote for a candidate who is openly ____.	GREEN
353	0	1	This Friday at the Liquid Lounge, it's ____ Night! Ladies drink free.	GREEN
354	0	1	Well, shit. My eyes ain't so good, but I'll eat my own boot if that ain't ____!	GREEN
355	0	1	CNN breaking news! Scientists discover ____.	GREEN
356	0	1	She's a lady in the streets, ____ in the sheets.	GREEN
357	0	1	There is no God. It's just ____ and then you die.	GREEN
358	0	1	Best you go back where you came from, now. We don't take too kindly to ____ in these parts.	GREEN
359	0	1	I've had a horrible vision, father. I saw mountains crumbling, stars falling from the sky. I saw ____.	GREEN
360	0	1	Oh no! Siri, how do I fix ____?	GREEN
361	0	1	Girls just wanna have ____.	GREEN
362	0	1	What's the gayest?	GREEN
363	0	1	Son, take it from someone who's been around the block a few times. Nothin' puts her in the mood like ____.	GREEN
364	0	1	Mom's to-do list:<br><br>Buy groceries<br>Clean up ____<br>Soccer practice	GREEN
365	0	1	What will end racism once and for all?	GREEN
366	0	1	No, no, no, no, no, NO! I will NOT let ____ ruin this wedding.	GREEN
367	0	1	Summer lovin', had me a blast. ____, happened so fast.	GREEN
368	0	1	I'm sorry, sir, but your insurance plan doesn't cover injuries caused by ____.	GREEN
369	0	1	What sucks balls?	GREEN
370	0	1	Errbody in the club ____.	GREEN
371	0	1	I'll take the BBQ bacon burger with a fried egg and fuck it how about ____.	GREEN
372	0	1	You won't believe what's in my pussy. It's ____.	GREEN
373	0	1	The top Google auto-complete results for "Barack Obama": <br>Barack Obama height.<br>Barack Obama net worth.<br>Barack Obama ____.	GREEN
374	0	1	I may not be much to look at, but I fuck like ____.	GREEN
375	0	1	LSD + ____ = really bad time.	GREEN
376	0	1	Feeling so grateful! #amazing #mylife #____	GREEN
377	0	1	Art isn't just a painting in a stuffy museum. Art is alive. Art is ____.	GREEN
378	0	1	Why am I laughing and crying and taking off my clothes?	GREEN
379	0	1	Google Calendar alert: ____ in 10 minutes.	GREEN
380	0	1	One more thing. Watch out for Big Mike. They say he killed a man with ____.	GREEN
381	0	1	Dance like there's nobody watching, love like you'll never be hurt, and live like you're ____.	GREEN
382	0	2	____: Brought to you by ____.	GREEN
383	0	1	In the 1950s, psychologists prescribed ____ as a cure for homosexuality.	GREEN
384	0	1	Well if ____ is a crime, then lock me up!	GREEN
385	0	1	Run, run, as fast as you can! You can't catch me, I'm ____!	GREEN
386	0	1	What's the most problematic?	GREEN
387	0	1	With a one-time gift of just $10, you can save this child from ____.	GREEN
388	0	2	____ be all like ____.	GREEN
389	0	1	You know who else liked ____? Hitler.	GREEN
390	0	1	What totally destroyed my asshole?	GREEN
391	0	1	I don't believe in God. I believe in ____.	GREEN
392	0	1	She's just one of the guys, you know? She likes beer, and football, and ____.	GREEN
393	0	1	Congratulations! You have been selected for our summer internship program. While we are unable to offer a salary, we <i>can</i> offer you ____.	GREEN
394	0	1	I tell you, it was a non-stop fuckfest. When it was over, my asshole looked like ____.	GREEN
395	0	1	We do not shake with our left hands in this country. That is the hand we use for ____.	GREEN
396	0	1	As Teddy Roosevelt said, the four manly virtues are honor, temperance, industry, and ____.	GREEN
397	0	1	How did Stella get her groove back?	90s
399	0	1	Siskel and Ebert have panned ____ as "poorly conceived" and "sloppily executed."	90s
400	0	1	Up next on Nickelodeon: "Clarissa Explains ____."	90s
401	0	1	It's Morphin' Time! Mastodon! Pterodactyl! Triceratops! Sabertooth Tiger! ____!	90s
402	0	1	Believe it or not, Jim Carrey can do a dead-on impression of ____.	90s
403	0	1	I'm a bitch, I'm a lover, I'm a child, I'm ____.	90s
404	0	1	Tonight on SNICK: "Are You Afraid of ____?"	90s
405	0	1	After blacking out during New Year's Eve, I was awoken by ____.	❄2012
407	0	1	What keeps me warm during the cold, cold winter?	❄2012
408	0	1	Wake up, America. Christmas is under attack by secular liberals and their ____.	❄2012
409	0	1	Every Christmas, my uncle gets drunk and tells the story about ____.	❄2012
410	0	1	Jesus is ____.	❄2012
411	0	1	This holiday season, Tim Allen must overcome his fear of ____ to save Christmas.	❄2012
412	0	1	On the third day of Christmas, my true love gave to me: three French hens, two turtle doves, and ____.	❄2012
413	0	1	When you go to the polls on Tuesday, remember: a vote for me is a vote for ____.	V4HIL
415	0	1	Senator, I trust you enjoyed ____ last night. Now, can I count on your vote?	V4HIL
416	0	1	Trump's great! Trump's got ____. I love that.	V4 45
418	0	1	It's 3 AM. The red phone rings. It's ____. Who do you want answering?	V4 45
419	0	1	According to Arizona's stand-your-ground law, you're allowed to shoot someone if they're ____.	V4 45
420	0	1	I can't believe Netflix is using ____ to promote <i>House of Cards.</i>	HCARD
422	0	1	A wise man said, "Everything is about sex. Except sex. Sex is about ____."	HCARD
423	0	1	I'm not going to lie. I despise ____. There, I said it.	HCARD
424	0	2	Corruption. Betrayal. ____. Coming soon to Netflix, "House of ____."	HCARD
425	0	1	We're not like other news organizations. Here at Slugline, we welcome ____ in the office.	HCARD
426	0	2	Because you enjoyed ____, we thought you'd like ____.	HCARD
427	0	1	Cancel all my meetings. We've got a situation with ____ that requires my immediate attention.	HCARD
428	0	1	Our relationship is strictly professional. Let's not complicate things with ____.	HCARD
429	0	1	My memory of last night is pretty hazy. I remember ____ and that's pretty much it.	COLEG
431	0	1	Pledges! Time to prove you're Delta Phi material. Chug this beer, take off your shirts, and get ready for ____.	COLEG
432	0	1	All classes today are canceled due to ____.	COLEG
433	0	1	Did you know? Our college was recently named the #1 school for ____!	COLEG
434	0	1	The Department of Psychology is looking for paid research volunteers. Are you 18-25 and suffering from ____?	COLEG
435	0	1	In this paper, I will explore ____ from a feminist perspective.	COLEG
436	0	1	Because they are forbidden from masturbating, Mormons channel their repressed sexual energy into ____.	❄2013
438	0	1	Revealed: Why He Really Resigned! Pope Benedict's Secret Struggle with ____!	❄2013
439	0	1	Blessed are you, Lord our God, creator of the universe, who has granted us ____.	❄2013
440	0	1	Kids these days with their iPods and their internet. In my day, we all needed to pass the time was ____.	❄2013
441	0	1	GREETINGS<br>HUMANS<br><br>I AM ____ BOT<br><br>EXECUTING PROGRAM	❄2013
442	0	2	But wait, there's more! If you order ____ in the next 15 minutes, we'll throw in ____ absolutely free!	❄2013
443	0	2	Here's what you can expect for the new year. Out: ____. In: ____.	❄2013
444	0	1	What's the one thing that makes an elf instantly ejaculate?	❄2013
445	0	1	I really hope my grandma doesn't ask me to explain ____ again.	❄2013
446	0	2	Critics are raving about HBO's new <i>Game of Thrones</i> spin-off, "____ of ____."	FNTSY
448	0	1	Your father was a powerful wizard, Harry. Before he died, he left you something very precious: ____.	FNTSY
449	0	1	Having tired of poetry and music, the immortal elves now fill their days with ____.	FNTSY
450	0	1	And in the end, the dragon was not evil; he just wanted ____.	FNTSY
451	0	1	Who blasphemes and bubbles at the center of all infinity, whose name no lips dare speak aloud, and who gnaws hungrily in inconceivable, unlighted chambers beyond time?	FNTSY
452	0	1	Legend tells of a princess who has been asleep for a thousand years and can only be awoken by ____.	FNTSY
453	0	1	Coming this spring from BioWare, <i>Mass Effect: ____.</i>	MSFX
455	0	1	I'm Commander Shepard, and this is my favorite place for ____ on the Citadel.	MSFX
456	0	1	It turns out The Reapers didn't want to destroy the galaxy. They just wanted ____.	MSFX
457	0	1	We were the best hand-to-hand combatants on the ship. I had reach, but she had ____.	MSFX
458	0	1	Behold the Four Horsemen of the Apocalypse! War, Famine, Death, and ____.	❄2014
460	0	1	Honey, Mommy and Daddy love you very much.But apparently Mommy loves ____ more than she loves Daddy.	❄2014
461	0	2	A curse upon thee! Many years from now, just when you think you're safe, ____ shall turn into ____.	❄2014
462	0	1	Dear Mom and Dad, Camp is fun. I like capture the flag. Yesterday, one of the older kids taught me about ____. I love you, Casey	❄2014
463	0	2	Today on Buzzfeed: 10 Pictures of ____ That Look Like ____!	❄2014
464	0	1	Why am I so tired?	❄2014
465	0	1	Curiosity was put into safe mode after its hazcams detected ____.	NASA
467	0	1	NASA will spend 15 billion dollars on an unprecedented mission: ____ in space.	NASA
468	0	1	It's not delivery. It's ____.	FOOD
470	0	1	Don't miss Rachel Ray's hit new show, <i>Cooking with ____.</i>	FOOD
471	0	1	I'm Bobby Flay, and if you can't stand ____, get out of the kitchen!	FOOD
472	0	1	Now on Netflix: <i>Jiro Dreams of ____.</i>	FOOD
473	0	1	Aw babe, your burps smell like ____!	FOOD
474	0	1	Excuse me, waiter. Could you take this back? This soup tastes like ____.	FOOD
475	0	1	You have been waylaid by ____ and must defend yourself.	PE13A
477	0	1	I have an idea even better than Kickstarter, and it's called ____starter.	PE13A
479	0	1	Donna, pick up my dry cleaning and get my wife something for christmas. I think she likes ____.	❄
480	0	1	It's beginning to look a lot like ____.	❄
481	0	1	In the final round of this year's Omegathon, Omeganauts must face off in a game of ____.	PE13B
483	0	1	Action stations! Action stations! Set condition one throughout the fleet and brace for ____!	PE13B
484	0	1	Press &darr;&darr;&larr;&rarr;B to unleash ____.	PE13C
486	0	1	I don't know exactly how I got the PAX plague, but I suspect it had something to do with ____.	PE13C
488	0	2	____ is way better in ____ mode.	GEEK
489	0	1	____: Achievement unlocked.	GEEK
490	0	1	<i>(Heavy breathing)</i> Luke, I am ____.	GEEK
491	0	1	What's the latest bullshit that's troubling this quaint fantasy town?	GEEK
492	0	1	What made Spock cry?	GEEK
493	0	1	What the hell?! They added a 6/6 with flying, trample, and ____.	PXE14
495	0	2	____ is way better in ____mode.	PXE14
496	0	1	Unfortunately, Neo, no one can be <i>told</i> what ____ is. You have to see it for yourself.	PXE14
497	0	1	You think you have defeated me? Well, let's see how you handle ____!	PXE14
498	0	1	What's so important right now that you can't call your mother?	JEW
500	0	1	According to Freud, all children progress through three stages of development: the oral stage, the anal stage, and the ____ stage.	JEW
501	0	1	Oh, your daughter should meet my son! He gives to charity, he loves ____ and did I mention he's a doctor?	JEW
502	0	1	Coming to Broadway next season: "____ on the Roof."	JEW
503	0	1	Can't you see? The Jews are behind everything--the banks, the media, even ____!	JEW
504	0	1	In the new DLC for Mass Effect, Shepard must save the galaxy from ____.	13PAX
506	0	1	The most controversial game at PAX this year is an 8-bit indie platformer about ____.	13PAX
507	0	1	There was a riot at the Gearbox panel when they gave the attendees ____.	13PAX
508	0	1	No Enforcer wants to manage the panel on ____.	13PAX
509	0	1	What gets me wet?	.
511	0	1	My body, my voice! ____, my choice!	.
512	0	1	My vagina's angry. My vagina's furious and it needs to talk. It needs to talk about ____.	.
513	0	1	Can a woman really have it all? A career <i>and ____?</i>	.
514	0	1	Tampax&reg;: Don't let your period ruin ____.	.
515	0	1	New from Mattel, it's ____ Barbie!	.
516	0	1	Donald Trump's first act as president was to outlaw ____.	PST45
518	0	1	Donald Trump has nominated ____ for his VP.	PST45
519	0	1	In 2019, Donald Trump eliminated our national parks to make room for ____.	PST45
520	0	2	What are two cards in your hand that you want to get rid of?	RJECT
522	0	1	From WBEZ Chicago, it's <i>This American Life.</i> Today on our program, ____. Stay with us.	RJECT
523	0	1	My name is Inigo Montoya. You killed my father. Prepare for ____.	RJECT
524	0	1	[rorschach test] What do you see?	RJECT
525	0	1	Sir, we found you passed out naked on the side of the road. What's the last thing you remember?	RJECT
526	0	1	You can't wait forever. It's time to talk to your doctor about ____.	RJECT
527	0	1	The elders of the Ibo tribe of Nigeria recommend ____ as a cure for impotence.	RJECT
528	0	1	The Westboro Baptist Church is now picketing soldiers' funerals with signs that read 'GOD HATES ____!'	RJECT
529	0	1	Looking to earn big bucks? Learn how to make ____ work for you!	RTAIL
531	0	1	How are the writers of Cards Against Humanity spending your $25?	RTAIL
532	0	1	Fear leads to anger. Anger leads to hate. Hate leads to ____.	SCIFI
534	0	1	Computer! Display ____ on screen. Enhance.	SCIFI
535	0	1	You're not going to believe this, but I'm you from the future! You've got to stop ____.	SCIFI
536	0	1	This won't be like negotiating with the Vogons. Humans only respond to one thing: ____.	SCIFI
537	0	1	Madam President, the asteroid is headed directly for Earth and there's one one thing that can stop it: ____.	SCIFI
538	0	1	You have violated the Prime Directive! You exposed an alien culture to ____ before they were ready.	SCIFI
539	0	1	What is the answer to life, the universe, and everything?	SCIFI
540	0	1	Why did the chicken cross the road?	RJCT2
542	0	1	Some men aren't looking for anything logical, like money. They can't be bought, bullied, reasoned, or negotiated with. Some men just want ____.	RJCT2
543	0	1	America is hungry. America needs ____.	RJCT2
544	0	1	In bourgeois society, capital is independent and has individuality, while the living person is ____.	RJCT2
545	0	1	Housekeeping! You want ____?	RJCT2
546	0	1	BowWOW! is the first pet hotel in LA that offers ____ for dogs.	RJCT2
547	0	1	Astronomers have discovered that the universe consists of 5% ordinary matter, 25% dark matter, and 70% ____.	RJCT2
548	0	1	Hey, whatever happened to Renee Zellweger?	RJCT2
549	0	1	What's wrong with these gorillas?	RJCT2
550	0	1	You say tomato, I say ____.	RJCT2
551	0	1	A study published in <i>Nature</i> this week found that ____ is good for you in small doses.	SCI
553	0	1	What really killed the dinosaurs?	SCI
554	0	2	In line with our predictions, we find a robust correlation between ____ and ____ ( <i>p&lt;.05).</i>	SCI
555	0	2	In an attempt to recreate conditions just after the Big Bang, physicists at the LHC are observing collisions between ____ and ____.	SCI
556	0	1	In what's being hailed as a major breakthrough, scientists have synthesized ____ in the lab.	SCI
557	0	1	Hey there, Young Scientists! Put on your labcoats and strap on your safety goggles, because today we're learning about ____!	SCI
558	0	2	Today on <i>Mythbusters,</i> we find out how long ____ can withstand ____.	SCI
559	0	1	Hold up. I gotta deal with ____, then I'mma smoke this.	WEED
561	0	1	Okay here's the pitch. James Franco and Seth Rogen are trying to score some weed, and then ____ happens.	WEED
562	0	1	You know what's like, really funny when you think about it? ____.	WEED
563	0	1	Instead of playing a card this round, everyone must stare at the Card Czar while making a sound you'd make after tasting something delicious.	WEED
564	0	1	Everyone is staring at you because you're ____.	WEED
565	0	1	Wait, I came here to buy socks. How did I wind up with ____?	RTPRD
567	0	1	Hey, you guys want to try this awesome new game? It's called ____.	TBLTP
569	0	1	For my turn, I will spend four gold and allocate all three workers to ____.	TBLTP
570	0	1	Backers who supported Tabletop at the $25,000 level were astonished to receive ____ from Wil Wheaton himself.	TBLTP
571	0	1	I'm just gonna stay in tonight. You know, Netflix and ____.	WWW
573	0	1	What did I nickname my genitals?	WWW
574	0	1	This app is basically Tinder, but for ____.	WWW
575	0	1	You guys, you can buy ____ on the dark web.	WWW
576	0	1	Don't worry, Penny! Go Go Gadget ____!	WWW
577	0	1	TRIGGER WARNING: ____.	WWW
578	0	2	I need you like ____ needs ____.	WWW
579	0	2	Such ____. Very ____. Wow.	WWW
580	0	1	Nothing says "I love you" like ____.	WWW
\.


--
-- TOC entry 2190 (class 0 OID 17742)
-- Dependencies: 186
-- Data for Name: card_set; Type: TABLE DATA; Schema: public; Owner: pyx
--

COPY card_set (id, active, base_deck, description, name, weight) FROM stdin;
2	t	f	Base Game (US)	Base Game (US)	1
103	t	f	Base Game (Canada)	Base Game (Canada)	2
134	t	f	Base Game (UK)	Base Game (UK)	3
166	t	f	Base Game (Australia)	Base Game (Australia)	4
191	t	f	Base Game (International)	Base Game (International)	5
235	t	f	Red Box Expansion	Red Box Expansion	10
271	t	f	Blue Box Expansion	Blue Box Expansion	10
342	t	f	Green Box Expansion	Green Box Expansion	10
398	t	f	90s Nostalgia Pack	90s Nostalgia Pack	30
406	t	f	Holiday Pack 2012	Holiday Pack 2012	80
414	t	f	Vote for Hillary Pack	Vote for Hillary Pack	70
417	t	f	Vote for Trump Pack	Vote for Trump Pack	71
421	t	f	House of Cards Pack	House of Cards Pack	30
430	t	f	College Pack	College Pack	30
437	t	f	Holiday Pack 2013	Holiday Pack 2013	80
447	t	f	Fantasy Pack	Fantasy Pack	30
454	t	f	Mass Effect Pack	Mass Effect Pack	101
459	t	f	Holiday Pack 2014	Holiday Pack 2014	80
466	t	f	NASA Pack	NASA Pack	30
469	t	f	Food Pack	Food Pack	30
476	t	f	PAX East 2013 Pack A	PAX East 2013 Pack A	102
478	t	f	Season's Greetings Pack	Season's Greetings Pack	83
482	t	f	PAX East 2013 Pack B	PAX East 2013 Pack B	103
485	t	f	PAX East 2013 Pack C	PAX East 2013 Pack C	104
487	t	f	Geek Pack	Geek Pack	30
494	t	f	PAX East 2014 Pack	PAX East 2014 Pack	106
499	t	f	Jew Pack	Jew Pack	30
505	t	f	PAX Prime 2013 Pack	PAX Prime 2013 Pack	105
510	t	f	Period Pack	Period Pack	30
517	t	f	Post-Trump Pack	Post-Trump Pack	72
521	t	f	Reject Pack	Reject Pack	30
530	t	f	Retail Pack	Retail Pack	30
533	t	f	Sci-Fi Pack	Sci-Fi Pack	30
541	t	f	Reject Pack 2	Reject Pack 2	30
552	t	f	Science Pack	Science Pack	30
560	t	f	Weed Pack	Weed Pack	30
566	t	f	Retail Product Pack	Retail Product Pack	30
568	t	f	Tabletop Pack	Tabletop Pack	100
572	t	f	World Wide Web Pack	World Wide Web Pack	30
2131	t	f	Box Expansion Pack	Box Expansion Pack	30
2152	t	f	Hidden Compartment Pack	Hidden Compartment Pack	30
2374	t	f	PAX Prime 2014 Pack	PAX Prime 2014 Pack	107
\.


--
-- TOC entry 2191 (class 0 OID 17750)
-- Dependencies: 187
-- Data for Name: card_set_black_card; Type: TABLE DATA; Schema: public; Owner: pyx
--

COPY card_set_black_card (card_set_id, black_card_id) FROM stdin;
2	1
2	3
2	4
2	5
2	6
2	7
2	8
2	9
2	10
2	11
2	12
2	13
2	14
2	15
2	16
2	17
2	18
2	19
2	20
2	21
2	22
2	23
2	24
2	25
2	26
2	27
2	28
2	29
2	30
2	31
2	32
2	33
2	34
2	35
2	36
2	37
2	38
2	39
2	40
2	41
2	42
2	43
2	44
2	45
2	46
2	47
2	48
2	49
2	50
2	51
2	52
2	53
2	54
2	55
2	56
2	57
2	58
2	59
2	60
2	61
2	62
2	63
2	64
2	65
2	66
2	67
2	68
2	69
2	70
2	71
2	72
2	73
2	74
2	75
2	76
2	77
2	78
2	79
2	80
2	81
2	82
2	83
2	84
2	85
2	86
2	87
2	88
2	89
2	90
2	91
2	92
2	93
2	94
2	95
2	96
2	97
2	98
2	99
2	100
2	101
103	3
103	5
103	6
103	7
103	8
103	9
103	10
103	11
103	12
103	13
103	14
103	15
103	16
103	18
103	19
103	20
103	21
103	22
103	23
103	25
103	26
103	27
103	28
103	30
103	31
103	32
103	38
103	40
103	41
103	42
103	43
103	45
103	46
103	50
103	51
103	56
103	58
103	60
103	61
103	62
103	63
103	66
103	68
103	69
103	70
103	74
103	75
103	76
103	77
103	80
103	81
103	82
103	83
103	84
103	85
103	86
103	87
103	88
103	89
103	90
103	91
103	92
103	93
103	95
103	96
103	97
103	98
103	99
103	100
103	101
103	102
103	104
103	105
103	106
103	107
103	108
103	109
103	110
103	111
103	112
103	113
103	114
103	115
103	116
103	117
103	118
103	119
103	120
103	121
103	122
103	123
103	124
103	125
103	126
103	127
103	128
103	129
103	130
103	131
103	132
134	3
134	5
134	6
134	7
134	8
134	9
134	10
134	11
134	13
134	14
134	16
134	19
134	20
134	21
134	23
134	25
134	26
134	27
134	28
134	30
134	31
134	32
134	38
134	40
134	41
134	42
134	43
134	50
134	51
134	56
134	58
134	60
134	62
134	63
134	66
134	68
134	69
134	70
134	74
134	77
134	80
134	81
134	83
134	84
134	86
134	87
134	88
134	89
134	90
134	91
134	92
134	93
134	96
134	97
134	99
134	100
134	101
134	102
134	112
134	114
134	118
134	120
134	122
134	124
134	125
134	126
134	130
134	132
134	133
134	135
134	136
134	137
134	138
134	139
134	140
134	141
134	142
134	143
134	144
134	145
134	146
134	147
134	148
134	149
134	150
134	151
134	152
134	153
134	154
134	155
134	156
134	157
134	158
134	159
134	160
134	161
134	162
134	163
134	164
134	165
166	3
166	5
166	6
166	7
166	8
166	10
166	11
166	12
166	13
166	14
166	16
166	18
166	19
166	20
166	21
166	23
166	25
166	26
166	27
166	28
166	30
166	31
166	32
166	38
166	40
166	41
166	42
166	45
166	46
166	50
166	51
166	56
166	58
166	60
166	62
166	63
166	66
166	68
166	69
166	70
166	71
166	72
166	74
166	75
166	77
166	80
166	81
166	83
166	84
166	86
166	87
166	88
166	89
166	90
166	92
166	93
166	96
166	97
166	99
166	100
166	101
166	102
166	112
166	114
166	118
166	120
166	124
166	125
166	126
166	128
166	130
166	132
166	136
166	143
166	149
166	150
166	162
166	167
166	168
166	169
166	170
166	171
166	172
166	173
166	174
166	175
166	176
166	177
166	178
166	179
166	180
166	181
166	182
166	183
166	184
166	185
166	186
166	187
166	188
166	189
191	5
191	9
191	10
191	11
191	14
191	15
191	19
191	21
191	22
191	23
191	153
191	25
191	31
191	159
191	32
191	33
191	36
191	38
191	39
191	40
191	50
191	51
191	60
191	190
191	62
191	63
191	192
191	193
191	65
191	194
191	195
191	196
191	68
191	197
191	198
191	199
191	71
191	200
191	72
191	201
191	202
191	203
191	75
191	204
191	205
191	77
191	206
191	207
191	208
191	209
191	210
191	211
191	83
191	212
191	213
191	214
191	215
191	87
191	216
191	88
191	217
191	89
191	218
191	90
191	219
191	220
191	92
191	221
191	93
191	222
191	223
191	224
191	96
191	225
191	97
191	226
191	98
191	227
191	99
191	228
191	100
191	229
191	102
191	230
191	231
191	232
191	233
191	234
191	114
191	124
235	256
235	257
235	258
235	259
235	260
235	261
235	262
235	263
235	264
235	265
235	266
235	267
235	268
235	269
235	190
235	192
235	195
235	196
235	197
235	198
235	199
235	200
235	201
235	202
235	204
235	206
235	207
235	208
235	209
235	211
235	212
235	213
235	215
235	216
235	217
235	218
235	219
235	220
235	221
235	222
235	223
235	224
235	225
235	227
235	228
235	229
235	231
235	232
235	233
235	234
235	236
235	237
235	238
235	239
235	240
235	241
235	242
235	243
235	244
235	245
235	246
235	247
235	248
235	249
235	250
235	251
235	252
235	253
235	254
235	255
271	270
271	272
271	273
271	274
271	275
271	276
271	277
271	278
271	279
271	280
271	281
271	282
271	283
271	284
271	285
271	286
271	287
271	288
271	289
271	290
271	291
271	292
271	293
271	294
271	295
271	296
271	297
271	298
271	299
271	300
271	301
271	302
271	303
271	304
271	305
271	306
271	307
271	308
271	309
271	310
271	311
271	312
271	313
271	314
271	315
271	316
271	317
271	318
271	319
271	320
271	321
271	322
271	323
271	324
271	325
271	326
271	327
271	328
271	329
271	330
271	331
271	332
271	333
271	334
271	335
271	336
271	337
271	338
271	339
271	340
342	384
342	385
342	386
342	387
342	388
342	389
342	390
342	391
342	392
342	393
342	394
342	395
342	396
342	341
342	343
342	344
342	345
342	346
342	347
342	348
342	349
342	350
342	351
342	352
342	353
342	354
342	355
342	356
342	357
342	358
342	359
342	360
342	361
342	362
342	363
342	364
342	365
342	366
342	367
342	368
342	369
342	370
342	371
342	372
342	373
342	374
342	375
342	376
342	377
342	378
342	379
342	380
342	381
342	382
342	383
398	400
398	401
398	402
398	403
398	404
398	397
398	399
406	405
406	407
406	408
406	409
406	410
406	411
406	412
414	343
414	413
414	415
417	416
417	418
417	419
421	420
421	422
421	423
421	424
421	425
421	426
421	427
421	428
430	432
430	433
430	434
430	435
430	429
430	431
437	436
437	438
437	439
437	440
437	441
437	442
437	443
437	444
437	445
447	448
447	449
447	450
447	451
447	452
447	446
454	453
454	455
454	456
454	457
459	464
459	458
459	460
459	461
459	462
459	463
466	465
466	467
469	468
469	470
469	471
469	472
469	473
469	474
476	475
476	477
478	480
478	439
478	410
478	411
478	443
478	444
478	479
482	481
482	483
485	484
485	486
487	484
487	488
487	489
487	490
487	491
487	492
494	496
494	497
494	490
494	493
494	495
499	498
499	500
499	501
499	502
499	503
505	504
505	489
505	506
505	507
505	491
505	492
505	508
510	512
510	513
510	514
510	515
510	509
510	511
517	516
517	518
517	519
521	528
521	520
521	522
521	523
521	524
521	525
521	526
521	527
530	529
530	531
533	532
533	534
533	535
533	536
533	537
533	538
533	539
541	544
541	545
541	546
541	547
541	548
541	549
541	550
541	540
541	542
541	543
552	551
552	553
552	554
552	555
552	556
552	557
552	558
560	561
560	562
560	563
560	564
560	559
566	565
568	567
568	569
568	570
572	576
572	577
572	578
572	579
572	580
572	571
572	573
572	574
572	575
\.


--
-- TOC entry 2192 (class 0 OID 17755)
-- Dependencies: 188
-- Data for Name: card_set_white_card; Type: TABLE DATA; Schema: public; Owner: pyx
--

COPY card_set_white_card (card_set_id, white_card_id) FROM stdin;
2	1024
2	1025
2	1026
2	1027
2	1028
2	1029
2	1030
2	1031
2	1032
2	1033
2	1034
2	1035
2	1036
2	1037
2	1038
2	1039
2	1040
2	1041
2	1042
2	1043
2	1044
2	1045
2	1046
2	1047
2	1048
2	1049
2	1050
2	1051
2	1052
2	1053
2	1054
2	1055
2	1056
2	1057
2	1058
2	1059
2	1060
2	1061
2	1062
2	1063
2	1064
2	1065
2	1066
2	1067
2	1068
2	1069
2	1070
2	1071
2	1072
2	1073
2	1074
2	1075
2	1076
2	1077
2	1078
2	1079
2	1080
2	581
2	582
2	583
2	584
2	585
2	586
2	587
2	588
2	589
2	590
2	591
2	592
2	593
2	594
2	595
2	596
2	597
2	598
2	599
2	600
2	601
2	602
2	603
2	604
2	605
2	606
2	607
2	608
2	609
2	610
2	611
2	612
2	613
2	614
2	615
2	616
2	617
2	618
2	619
2	620
2	621
2	622
2	623
2	624
2	625
2	626
2	627
2	628
2	629
2	630
2	631
2	632
2	633
2	634
2	635
2	636
2	637
2	638
2	639
2	640
2	641
2	642
2	643
2	644
2	645
2	646
2	647
2	648
2	649
2	650
2	651
2	652
2	653
2	654
2	655
2	656
2	657
2	658
2	659
2	660
2	661
2	662
2	663
2	664
2	665
2	666
2	667
2	668
2	669
2	670
2	671
2	672
2	673
2	674
2	675
2	676
2	677
2	678
2	679
2	680
2	681
2	682
2	683
2	684
2	685
2	686
2	687
2	688
2	689
2	690
2	691
2	692
2	693
2	694
2	695
2	696
2	697
2	698
2	699
2	700
2	701
2	702
2	703
2	704
2	705
2	706
2	707
2	708
2	709
2	710
2	711
2	712
2	713
2	714
2	715
2	716
2	717
2	718
2	719
2	720
2	721
2	722
2	723
2	724
2	725
2	726
2	727
2	728
2	729
2	730
2	731
2	732
2	733
2	734
2	735
2	736
2	737
2	738
2	739
2	740
2	741
2	742
2	743
2	744
2	745
2	746
2	747
2	748
2	749
2	750
2	751
2	752
2	753
2	754
2	755
2	756
2	757
2	758
2	759
2	760
2	761
2	762
2	763
2	764
2	765
2	766
2	767
2	768
2	769
2	770
2	771
2	772
2	773
2	774
2	775
2	776
2	777
2	778
2	779
2	780
2	781
2	782
2	783
2	784
2	785
2	786
2	787
2	788
2	789
2	790
2	791
2	792
2	793
2	794
2	795
2	796
2	797
2	798
2	799
2	800
2	801
2	802
2	803
2	804
2	805
2	806
2	807
2	808
2	809
2	810
2	811
2	812
2	813
2	814
2	815
2	816
2	817
2	818
2	819
2	820
2	821
2	822
2	823
2	824
2	825
2	826
2	827
2	828
2	829
2	830
2	831
2	832
2	833
2	834
2	835
2	836
2	837
2	838
2	839
2	840
2	841
2	842
2	843
2	844
2	845
2	846
2	847
2	848
2	849
2	850
2	851
2	852
2	853
2	854
2	855
2	856
2	857
2	858
2	859
2	860
2	861
2	862
2	863
2	864
2	865
2	866
2	867
2	868
2	869
2	870
2	871
2	872
2	873
2	874
2	875
2	876
2	877
2	878
2	879
2	880
2	881
2	882
2	883
2	884
2	885
2	886
2	887
2	888
2	889
2	890
2	891
2	892
2	893
2	894
2	895
2	896
2	897
2	898
2	899
2	900
2	901
2	902
2	903
2	904
2	905
2	906
2	907
2	908
2	909
2	910
2	911
2	912
2	913
2	914
2	915
2	916
2	917
2	918
2	919
2	920
2	921
2	922
2	923
2	924
2	925
2	926
2	927
2	928
2	929
2	930
2	931
2	932
2	933
2	934
2	935
2	936
2	937
2	938
2	939
2	940
2	941
2	942
2	943
2	944
2	945
2	946
2	947
2	948
2	949
2	950
2	951
2	952
2	953
2	954
2	955
2	956
2	957
2	958
2	959
2	960
2	961
2	962
2	963
2	964
2	965
2	966
2	967
2	968
2	969
2	970
2	971
2	972
2	973
2	974
2	975
2	976
2	977
2	978
2	979
2	980
2	981
2	982
2	983
2	984
2	985
2	986
2	987
2	988
2	989
2	990
2	991
2	992
2	993
2	994
2	995
2	996
2	997
2	998
2	999
2	1000
2	1001
2	1002
2	1003
2	1004
2	1005
2	1006
2	1007
2	1008
2	1009
2	1010
2	1011
2	1012
2	1013
2	1014
2	1015
2	1016
2	1017
2	1018
2	1019
2	1020
2	1021
2	1022
2	1023
103	1024
103	1025
103	1026
103	1027
103	1028
103	1030
103	1031
103	1032
103	1033
103	1034
103	1035
103	1036
103	1037
103	1038
103	1039
103	1040
103	1041
103	1042
103	1043
103	1044
103	1045
103	1046
103	1047
103	1048
103	1049
103	1050
103	1051
103	1052
103	1053
103	1054
103	1055
103	1056
103	1057
103	1058
103	1059
103	1060
103	1061
103	1062
103	1063
103	1064
103	1065
103	1066
103	1067
103	1068
103	1069
103	1070
103	1071
103	1072
103	1073
103	1074
103	1075
103	1076
103	1077
103	1078
103	1080
103	1081
103	1082
103	1083
103	1084
103	1085
103	1086
103	1087
103	1088
103	1089
103	1090
103	1091
103	1092
103	1093
103	1094
103	1095
103	1096
103	1097
103	1098
103	1099
103	1100
103	1101
103	1102
103	1103
103	1104
103	1105
103	1106
103	581
103	582
103	583
103	584
103	585
103	586
103	587
103	588
103	589
103	590
103	591
103	592
103	593
103	594
103	595
103	596
103	597
103	598
103	599
103	600
103	601
103	602
103	603
103	604
103	606
103	607
103	609
103	610
103	611
103	613
103	614
103	615
103	616
103	617
103	618
103	619
103	620
103	621
103	622
103	623
103	625
103	626
103	627
103	628
103	629
103	630
103	631
103	632
103	633
103	634
103	635
103	636
103	637
103	638
103	639
103	640
103	641
103	642
103	643
103	644
103	646
103	647
103	649
103	650
103	651
103	652
103	653
103	654
103	655
103	656
103	657
103	658
103	659
103	660
103	662
103	663
103	664
103	665
103	666
103	667
103	668
103	669
103	670
103	671
103	672
103	673
103	674
103	675
103	676
103	677
103	678
103	679
103	680
103	681
103	682
103	683
103	685
103	686
103	687
103	688
103	689
103	690
103	691
103	692
103	693
103	694
103	695
103	696
103	697
103	698
103	699
103	700
103	702
103	703
103	704
103	705
103	706
103	707
103	708
103	709
103	710
103	711
103	712
103	713
103	714
103	715
103	716
103	717
103	718
103	719
103	720
103	721
103	722
103	723
103	724
103	725
103	726
103	727
103	728
103	729
103	730
103	731
103	732
103	733
103	734
103	735
103	737
103	738
103	739
103	740
103	741
103	742
103	743
103	744
103	745
103	746
103	747
103	748
103	750
103	751
103	752
103	753
103	754
103	755
103	756
103	757
103	758
103	759
103	760
103	762
103	763
103	764
103	765
103	766
103	767
103	768
103	769
103	770
103	771
103	772
103	773
103	774
103	775
103	776
103	777
103	778
103	779
103	780
103	781
103	782
103	783
103	784
103	785
103	786
103	787
103	789
103	790
103	791
103	792
103	794
103	796
103	797
103	798
103	799
103	800
103	801
103	802
103	803
103	804
103	805
103	807
103	808
103	809
103	810
103	811
103	812
103	813
103	814
103	815
103	816
103	817
103	819
103	820
103	821
103	822
103	823
103	824
103	825
103	826
103	827
103	828
103	829
103	830
103	831
103	832
103	833
103	834
103	835
103	836
103	837
103	838
103	839
103	840
103	841
103	842
103	843
103	844
103	845
103	846
103	847
103	848
103	849
103	850
103	851
103	852
103	853
103	854
103	855
103	856
103	857
103	858
103	859
103	860
103	861
103	862
103	863
103	864
103	865
103	866
103	867
103	869
103	871
103	872
103	873
103	874
103	875
103	876
103	877
103	878
103	879
103	880
103	881
103	882
103	883
103	884
103	885
103	886
103	887
103	888
103	889
103	890
103	891
103	892
103	893
103	894
103	895
103	896
103	897
103	898
103	899
103	900
103	901
103	902
103	903
103	904
103	905
103	906
103	907
103	908
103	909
103	910
103	911
103	912
103	913
103	914
103	915
103	916
103	917
103	918
103	919
103	920
103	921
103	922
103	923
103	924
103	925
103	926
103	927
103	928
103	930
103	931
103	932
103	933
103	934
103	935
103	936
103	937
103	938
103	939
103	940
103	941
103	942
103	943
103	944
103	945
103	946
103	947
103	948
103	949
103	950
103	951
103	952
103	953
103	954
103	955
103	956
103	957
103	958
103	959
103	960
103	961
103	962
103	963
103	964
103	965
103	966
103	967
103	968
103	969
103	970
103	971
103	972
103	973
103	974
103	975
103	976
103	977
103	978
103	979
103	980
103	981
103	982
103	984
103	985
103	987
103	988
103	989
103	990
103	991
103	993
103	994
103	995
103	996
103	997
103	998
103	999
103	1000
103	1001
103	1002
103	1003
103	1005
103	1006
103	1007
103	1008
103	1009
103	1010
103	1011
103	1012
103	1013
103	1014
103	1015
103	1016
103	1017
103	1018
103	1019
103	1020
103	1021
103	1022
103	1023
134	1025
134	1026
134	1027
134	1028
134	1030
134	1031
134	1032
134	1034
134	1035
134	1037
134	1038
134	1039
134	1041
134	1042
134	1044
134	1045
134	1046
134	1047
134	1048
134	1049
134	1050
134	1052
134	1053
134	1054
134	1055
134	1056
134	1057
134	1058
134	1059
134	1060
134	1061
134	1062
134	1063
134	1067
134	1068
134	1069
134	1070
134	1071
134	1072
134	1076
134	1077
134	1078
134	1080
134	1085
134	1087
134	1100
134	1107
134	1108
134	1109
134	1110
134	1111
134	1112
134	1113
134	1114
134	1115
134	1116
134	1117
134	1118
134	1119
134	1120
134	1121
134	1122
134	1123
134	1124
134	1125
134	1126
134	1127
134	1128
134	1129
134	1130
134	1131
134	1132
134	1133
134	1134
134	1135
134	1136
134	1137
134	1138
134	1139
134	1140
134	1141
134	1142
134	1143
134	1144
134	1145
134	1146
134	1147
134	1148
134	1149
134	1150
134	1151
134	1152
134	1153
134	1154
134	1155
134	1156
134	1157
134	1158
134	1159
134	1160
134	1161
134	1162
134	1163
134	1164
134	1165
134	1166
134	1167
134	1168
134	1169
134	1170
134	1171
134	1172
134	1173
134	1174
134	1175
134	1176
134	1177
134	1178
134	1179
134	1180
134	1181
134	1182
134	1183
134	1184
134	1185
134	1186
134	1187
134	1188
134	1189
134	1190
134	1191
134	1192
134	1193
134	1194
134	1195
134	1196
134	1197
134	1198
134	1199
134	1200
134	1201
134	1202
134	1203
134	1204
134	1205
134	1206
134	1207
134	581
134	582
134	584
134	585
134	586
134	587
134	589
134	590
134	591
134	593
134	594
134	595
134	596
134	597
134	598
134	599
134	600
134	601
134	602
134	603
134	606
134	607
134	609
134	610
134	611
134	614
134	615
134	616
134	617
134	618
134	619
134	620
134	621
134	622
134	623
134	625
134	626
134	627
134	628
134	629
134	630
134	631
134	632
134	633
134	634
134	636
134	637
134	638
134	639
134	641
134	642
134	643
134	644
134	647
134	649
134	650
134	651
134	652
134	653
134	654
134	655
134	656
134	657
134	658
134	660
134	662
134	663
134	664
134	665
134	666
134	667
134	668
134	669
134	671
134	672
134	673
134	674
134	675
134	676
134	679
134	680
134	681
134	682
134	683
134	684
134	685
134	686
134	687
134	688
134	689
134	690
134	691
134	692
134	693
134	695
134	697
134	698
134	699
134	700
134	702
134	703
134	704
134	705
134	706
134	707
134	708
134	709
134	710
134	711
134	712
134	713
134	714
134	715
134	716
134	717
134	718
134	719
134	720
134	721
134	722
134	724
134	725
134	726
134	727
134	728
134	729
134	730
134	731
134	733
134	734
134	735
134	737
134	738
134	739
134	741
134	742
134	743
134	744
134	745
134	746
134	747
134	748
134	751
134	755
134	756
134	757
134	759
134	760
134	762
134	763
134	765
134	766
134	767
134	768
134	769
134	770
134	771
134	772
134	773
134	774
134	775
134	777
134	778
134	779
134	781
134	782
134	783
134	784
134	786
134	787
134	789
134	791
134	792
134	794
134	797
134	799
134	800
134	801
134	802
134	803
134	804
134	805
134	806
134	808
134	809
134	810
134	812
134	813
134	814
134	815
134	816
134	817
134	819
134	820
134	822
134	824
134	825
134	826
134	827
134	828
134	829
134	830
134	831
134	832
134	833
134	834
134	835
134	836
134	837
134	839
134	840
134	841
134	843
134	844
134	845
134	847
134	848
134	849
134	850
134	851
134	852
134	853
134	854
134	855
134	856
134	857
134	858
134	859
134	860
134	861
134	862
134	863
134	864
134	865
134	866
134	869
134	871
134	872
134	873
134	874
134	875
134	876
134	877
134	878
134	879
134	880
134	882
134	883
134	884
134	885
134	886
134	888
134	889
134	891
134	892
134	893
134	894
134	895
134	897
134	898
134	899
134	902
134	903
134	904
134	905
134	906
134	907
134	909
134	910
134	911
134	913
134	914
134	915
134	916
134	918
134	919
134	920
134	922
134	923
134	924
134	925
134	927
134	928
134	930
134	932
134	936
134	937
134	938
134	939
134	940
134	941
134	942
134	943
134	944
134	945
134	946
134	947
134	948
134	949
134	950
134	952
134	953
134	956
134	957
134	958
134	963
134	964
134	965
134	968
134	969
134	970
134	972
134	973
134	974
134	977
134	979
134	980
134	981
134	983
134	984
134	985
134	986
134	987
134	988
134	989
134	990
134	991
134	993
134	994
134	996
134	998
134	999
134	1000
134	1001
134	1003
134	1005
134	1006
134	1007
134	1008
134	1009
134	1010
134	1011
134	1012
134	1013
134	1015
134	1016
134	1017
134	1018
134	1019
134	1020
134	1021
134	1022
134	1023
166	1025
166	1026
166	1027
166	1030
166	1031
166	1032
166	1034
166	1035
166	1037
166	1038
166	1039
166	1040
166	1041
166	1042
166	1044
166	1045
166	1046
166	1047
166	1048
166	1049
166	1050
166	1053
166	1054
166	1055
166	1056
166	1057
166	1058
166	1059
166	1060
166	1061
166	1062
166	1063
166	1064
166	1068
166	1069
166	1070
166	1071
166	1072
166	1075
166	1076
166	1077
166	1078
166	1080
166	1085
166	1087
166	1092
166	1094
166	1100
166	1102
166	1108
166	1110
166	1115
166	1121
166	1122
166	1128
166	1130
166	1134
166	1138
166	1141
166	1145
166	1146
166	1147
166	1154
166	1167
166	1172
166	1179
166	1184
166	1185
166	1187
166	1192
166	1208
166	1209
166	1210
166	1211
166	1212
166	1213
166	1214
166	1215
166	1216
166	1217
166	1218
166	1219
166	1220
166	1221
166	1222
166	1223
166	1224
166	1225
166	1226
166	1227
166	1228
166	1229
166	1230
166	1231
166	1232
166	1233
166	1234
166	1235
166	1236
166	1237
166	1238
166	1239
166	1240
166	1241
166	1242
166	1243
166	1244
166	1245
166	1246
166	1247
166	1248
166	1249
166	1250
166	1251
166	1252
166	1253
166	1254
166	1255
166	1256
166	1257
166	1258
166	1259
166	1260
166	1261
166	1262
166	1263
166	1264
166	1265
166	1266
166	1267
166	1268
166	1269
166	1270
166	1271
166	1272
166	1273
166	1274
166	1275
166	1276
166	1277
166	1278
166	1279
166	1280
166	1281
166	1282
166	581
166	582
166	584
166	585
166	586
166	587
166	589
166	590
166	591
166	593
166	594
166	595
166	596
166	597
166	598
166	599
166	600
166	601
166	602
166	603
166	606
166	607
166	609
166	610
166	611
166	614
166	615
166	616
166	617
166	618
166	619
166	620
166	621
166	622
166	623
166	625
166	626
166	628
166	629
166	630
166	631
166	632
166	633
166	634
166	636
166	637
166	638
166	639
166	641
166	642
166	643
166	644
166	647
166	649
166	650
166	651
166	652
166	653
166	654
166	655
166	656
166	657
166	660
166	662
166	664
166	665
166	666
166	667
166	668
166	669
166	671
166	672
166	673
166	674
166	675
166	676
166	679
166	680
166	681
166	682
166	683
166	684
166	685
166	686
166	687
166	688
166	689
166	690
166	691
166	692
166	693
166	695
166	697
166	698
166	699
166	700
166	702
166	703
166	704
166	705
166	706
166	707
166	708
166	709
166	710
166	711
166	713
166	714
166	715
166	716
166	717
166	718
166	719
166	720
166	721
166	722
166	724
166	725
166	726
166	727
166	729
166	730
166	731
166	733
166	734
166	735
166	737
166	738
166	739
166	741
166	742
166	743
166	744
166	745
166	746
166	747
166	748
166	751
166	752
166	753
166	754
166	755
166	756
166	757
166	759
166	760
166	762
166	763
166	765
166	766
166	767
166	768
166	769
166	770
166	771
166	772
166	773
166	774
166	775
166	777
166	778
166	779
166	780
166	781
166	782
166	783
166	784
166	785
166	786
166	787
166	789
166	790
166	791
166	792
166	794
166	796
166	798
166	799
166	800
166	801
166	802
166	803
166	804
166	805
166	806
166	807
166	808
166	810
166	812
166	813
166	814
166	816
166	817
166	819
166	820
166	822
166	824
166	825
166	826
166	827
166	828
166	829
166	830
166	831
166	832
166	833
166	834
166	835
166	836
166	837
166	839
166	841
166	842
166	843
166	844
166	845
166	847
166	849
166	850
166	851
166	852
166	853
166	854
166	855
166	856
166	857
166	858
166	859
166	860
166	861
166	863
166	864
166	865
166	866
166	867
166	869
166	871
166	872
166	873
166	874
166	875
166	876
166	877
166	878
166	879
166	880
166	882
166	883
166	884
166	885
166	886
166	888
166	889
166	891
166	892
166	893
166	894
166	895
166	897
166	898
166	899
166	902
166	903
166	904
166	905
166	906
166	907
166	909
166	910
166	911
166	913
166	914
166	915
166	916
166	918
166	919
166	920
166	922
166	923
166	924
166	925
166	927
166	929
166	930
166	932
166	936
166	937
166	938
166	939
166	940
166	941
166	942
166	943
166	944
166	945
166	946
166	947
166	948
166	949
166	950
166	951
166	952
166	953
166	956
166	957
166	958
166	963
166	964
166	965
166	968
166	969
166	970
166	971
166	972
166	973
166	974
166	975
166	977
166	978
166	979
166	980
166	981
166	984
166	985
166	987
166	988
166	989
166	990
166	991
166	994
166	995
166	996
166	997
166	999
166	1000
166	1001
166	1003
166	1005
166	1006
166	1007
166	1008
166	1009
166	1010
166	1011
166	1012
166	1013
166	1015
166	1016
166	1017
166	1018
166	1019
166	1020
166	1021
166	1022
166	1023
191	1025
191	1026
191	1027
191	1031
191	1032
191	1034
191	1035
191	1037
191	1038
191	1039
191	1040
191	1041
191	1044
191	1046
191	1048
191	1050
191	1053
191	1054
191	1055
191	1057
191	1059
191	1060
191	1061
191	1063
191	1065
191	1067
191	1068
191	1070
191	1072
191	1075
191	1076
191	1077
191	1078
191	1080
191	1102
191	1115
191	1137
191	1147
191	1184
191	1189
191	1192
191	1215
191	1260
191	1276
191	1279
191	1280
191	1283
191	1284
191	1285
191	1286
191	1287
191	1288
191	1289
191	1290
191	1291
191	1292
191	1293
191	1294
191	1295
191	1296
191	1297
191	1298
191	1299
191	1300
191	1301
191	1302
191	1303
191	1304
191	1305
191	1306
191	1307
191	1308
191	1309
191	1310
191	1311
191	1312
191	1313
191	1314
191	1315
191	1316
191	1317
191	1318
191	1319
191	1320
191	1321
191	1322
191	1323
191	1324
191	1325
191	1326
191	1327
191	1328
191	1329
191	1330
191	1331
191	1332
191	1333
191	1334
191	1335
191	1336
191	1337
191	1338
191	1339
191	1340
191	1341
191	1342
191	1343
191	1344
191	1345
191	1346
191	1347
191	1348
191	1349
191	1350
191	1351
191	1352
191	1353
191	1354
191	1355
191	1356
191	1357
191	1358
191	1359
191	1360
191	1361
191	1362
191	1363
191	1364
191	1365
191	1366
191	1367
191	1368
191	1369
191	1370
191	1371
191	1372
191	1373
191	1374
191	1375
191	1376
191	1377
191	1378
191	1379
191	1380
191	1381
191	1382
191	1383
191	1384
191	1385
191	1386
191	1387
191	1388
191	1389
191	1390
191	1391
191	1392
191	1393
191	1394
191	1395
191	1396
191	1397
191	1398
191	1399
191	1400
191	1401
191	1402
191	1403
191	1404
191	1405
191	1406
191	1407
191	1408
191	1409
191	1410
191	1411
191	1412
191	1413
191	1414
191	1415
191	1416
191	1417
191	1418
191	1419
191	1420
191	1421
191	1422
191	1423
191	1424
191	1425
191	1426
191	1427
191	1428
191	1429
191	1430
191	1431
191	1432
191	1433
191	1434
191	1435
191	1436
191	1437
191	1438
191	1439
191	1440
191	1441
191	1442
191	1443
191	1444
191	1445
191	1446
191	1447
191	1448
191	1449
191	1450
191	1451
191	1452
191	1453
191	1454
191	1455
191	1456
191	1457
191	1458
191	1459
191	581
191	584
191	586
191	587
191	589
191	590
191	591
191	597
191	598
191	599
191	600
191	601
191	602
191	603
191	606
191	609
191	610
191	611
191	613
191	614
191	615
191	616
191	618
191	619
191	620
191	621
191	623
191	625
191	629
191	630
191	631
191	632
191	633
191	634
191	635
191	636
191	637
191	638
191	639
191	642
191	643
191	647
191	649
191	650
191	652
191	653
191	654
191	655
191	656
191	657
191	660
191	662
191	664
191	665
191	667
191	670
191	671
191	672
191	673
191	674
191	675
191	676
191	679
191	680
191	681
191	682
191	683
191	685
191	686
191	687
191	688
191	689
191	691
191	692
191	693
191	697
191	698
191	699
191	703
191	706
191	707
191	708
191	709
191	710
191	713
191	714
191	716
191	717
191	718
191	719
191	720
191	722
191	724
191	725
191	726
191	727
191	728
191	729
191	730
191	731
191	733
191	734
191	735
191	737
191	738
191	739
191	740
191	742
191	743
191	744
191	745
191	746
191	748
191	751
191	752
191	753
191	755
191	756
191	757
191	759
191	760
191	761
191	762
191	763
191	766
191	767
191	768
191	770
191	771
191	775
191	778
191	781
191	782
191	784
191	786
191	787
191	788
191	789
191	791
191	792
191	794
191	797
191	799
191	800
191	802
191	803
191	804
191	805
191	807
191	808
191	810
191	813
191	815
191	816
191	817
191	819
191	820
191	822
191	824
191	825
191	826
191	827
191	828
191	829
191	831
191	832
191	834
191	835
191	836
191	837
191	840
191	845
191	847
191	849
191	850
191	852
191	853
191	854
191	856
191	857
191	858
191	859
191	860
191	861
191	863
191	864
191	865
191	866
191	868
191	869
191	871
191	872
191	873
191	874
191	875
191	876
191	877
191	879
191	882
191	883
191	884
191	885
191	886
191	888
191	889
191	890
191	892
191	893
191	894
191	897
191	899
191	902
191	903
191	904
191	905
191	906
191	907
191	909
191	910
191	912
191	913
191	915
191	916
191	918
191	920
191	923
191	924
191	925
191	926
191	927
191	930
191	931
191	932
191	933
191	936
191	937
191	938
191	939
191	940
191	941
191	942
191	943
191	944
191	945
191	946
191	947
191	949
191	950
191	952
191	956
191	957
191	958
191	963
191	965
191	966
191	968
191	969
191	970
191	973
191	974
191	977
191	979
191	980
191	983
191	984
191	985
191	988
191	989
191	990
191	993
191	994
191	997
191	998
191	999
191	1000
191	1001
191	1003
191	1006
191	1007
191	1008
191	1009
191	1011
191	1012
191	1018
191	1020
191	1022
191	1023
235	1536
235	1537
235	1538
235	1539
235	1540
235	1541
235	1542
235	1543
235	1544
235	1545
235	1546
235	1547
235	1548
235	1549
235	1550
235	1551
235	1552
235	1553
235	1554
235	1555
235	1556
235	1557
235	1558
235	1559
235	1560
235	1561
235	1562
235	1563
235	1564
235	1565
235	1566
235	1567
235	1568
235	1569
235	1570
235	1571
235	1572
235	1573
235	1283
235	1284
235	1286
235	1287
235	1288
235	1291
235	1292
235	1293
235	1295
235	1296
235	1297
235	1298
235	1299
235	1301
235	1302
235	1303
235	1304
235	1306
235	1307
235	1308
235	1310
235	1312
235	1313
235	1314
235	1315
235	1316
235	1319
235	1320
235	1322
235	1323
235	1324
235	1325
235	1326
235	1327
235	1329
235	1330
235	1331
235	1334
235	1335
235	1336
235	1337
235	1338
235	1339
235	1340
235	1341
235	1342
235	1343
235	1344
235	1345
235	1347
235	1348
235	1349
235	1352
235	1353
235	1354
235	1359
235	1360
235	1362
235	1363
235	1364
235	1366
235	1368
235	1370
235	1372
235	1373
235	1376
235	1379
235	1380
235	1381
235	1382
235	1386
235	1387
235	1389
235	1390
235	1391
235	1392
235	1395
235	1396
235	1398
235	1400
235	1402
235	1403
235	1407
235	1409
235	1412
235	1413
235	1414
235	1415
235	1416
235	1421
235	1422
235	1424
235	1425
235	1426
235	1428
235	1429
235	1430
235	1431
235	1432
235	1436
235	1439
235	1440
235	1441
235	1442
235	1444
235	1446
235	1448
235	1449
235	1451
235	1452
235	1453
235	1455
235	1456
235	1457
235	1458
235	1459
235	1460
235	1461
235	1462
235	1463
235	1464
235	1465
235	1466
235	1467
235	1468
235	1469
235	1470
235	1471
235	1472
235	1473
235	1474
235	1475
235	1476
235	1477
235	1478
235	1479
235	1480
235	1481
235	1482
235	1483
235	1484
235	1485
235	1486
235	1487
235	1488
235	1489
235	1490
235	1491
235	1492
235	1493
235	1494
235	1495
235	1496
235	1497
235	1498
235	1499
235	1500
235	1501
235	1502
235	1503
235	1504
235	1505
235	1506
235	1507
235	1508
235	1509
235	1510
235	1511
235	1512
235	1513
235	1514
235	1515
235	1516
235	1517
235	1518
235	1519
235	1520
235	1521
235	1522
235	1523
235	1524
235	1525
235	1526
235	1527
235	1528
235	1529
235	1530
235	1531
235	1532
235	1533
235	1534
235	1535
271	1574
271	1575
271	1576
271	1577
271	1578
271	1579
271	1580
271	1581
271	1582
271	1583
271	1584
271	1585
271	1586
271	1587
271	1588
271	1589
271	1590
271	1591
271	1592
271	1593
271	1594
271	1595
271	1596
271	1597
271	1598
271	1599
271	1600
271	1601
271	1602
271	1603
271	1604
271	1605
271	1606
271	1607
271	1608
271	1609
271	1610
271	1611
271	1612
271	1613
271	1614
271	1615
271	1616
271	1617
271	1618
271	1619
271	1620
271	1621
271	1622
271	1623
271	1624
271	1625
271	1626
271	1627
271	1628
271	1629
271	1630
271	1631
271	1632
271	1633
271	1634
271	1635
271	1636
271	1637
271	1638
271	1639
271	1640
271	1641
271	1642
271	1643
271	1644
271	1645
271	1646
271	1647
271	1648
271	1649
271	1650
271	1651
271	1652
271	1653
271	1654
271	1655
271	1656
271	1657
271	1658
271	1659
271	1660
271	1661
271	1662
271	1663
271	1664
271	1665
271	1666
271	1667
271	1668
271	1669
271	1670
271	1671
271	1672
271	1673
271	1674
271	1675
271	1676
271	1677
271	1678
271	1679
271	1680
271	1681
271	1682
271	1683
271	1684
271	1685
271	1686
271	1687
271	1688
271	1689
271	1690
271	1691
271	1692
271	1693
271	1694
271	1695
271	1696
271	1697
271	1698
271	1699
271	1700
271	1701
271	1702
271	1703
271	1704
271	1705
271	1706
271	1707
271	1708
271	1709
271	1710
271	1711
271	1712
271	1713
271	1714
271	1715
271	1716
271	1717
271	1718
271	1719
271	1720
271	1721
271	1722
271	1723
271	1724
271	1725
271	1726
271	1727
271	1728
271	1729
271	1730
271	1731
271	1732
271	1733
271	1734
271	1735
271	1736
271	1737
271	1738
271	1739
271	1740
271	1741
271	1742
271	1743
271	1744
271	1745
271	1746
271	1747
271	1748
271	1749
271	1750
271	1751
271	1752
271	1753
271	1754
271	1755
271	1756
271	1757
271	1758
271	1759
271	1760
271	1761
271	1762
271	1763
271	1764
271	1765
271	1766
271	1767
271	1768
271	1769
271	1770
271	1771
271	1772
271	1773
271	1774
271	1775
271	1776
271	1777
271	1778
271	1779
271	1780
271	1781
271	1782
271	1783
271	1784
271	1785
271	1786
271	1787
271	1788
271	1789
271	1790
271	1791
271	1792
271	1793
342	1794
342	1795
342	1796
342	1797
342	1798
342	1799
342	1800
342	1801
342	1802
342	1803
342	1804
342	1805
342	1806
342	1807
342	1808
342	1809
342	1810
342	1811
342	1812
342	1813
342	1814
342	1815
342	1816
342	1817
342	1818
342	1819
342	1820
342	1821
342	1822
342	1823
342	1824
342	1825
342	1826
342	1827
342	1828
342	1829
342	1830
342	1831
342	1832
342	1833
342	1834
342	1835
342	1836
342	1837
342	1838
342	1839
342	1840
342	1841
342	1842
342	1843
342	1844
342	1845
342	1846
342	1847
342	1848
342	1849
342	1850
342	1851
342	1852
342	1853
342	1854
342	1855
342	1856
342	1857
342	1858
342	1859
342	1860
342	1861
342	1862
342	1863
342	1864
342	1865
342	1866
342	1867
342	1868
342	1869
342	1870
342	1871
342	1872
342	1873
342	1874
342	1875
342	1876
342	1877
342	1878
342	1879
342	1880
342	1881
342	1882
342	1883
342	1884
342	1885
342	1886
342	1887
342	1888
342	1889
342	1890
342	1891
342	1892
342	1893
342	1894
342	1895
342	1896
342	1897
342	1898
342	1899
342	1900
342	1901
342	1902
342	1903
342	1904
342	1905
342	1906
342	1907
342	1908
342	1909
342	1910
342	1911
342	1912
342	1913
342	1914
342	1915
342	1916
342	1917
342	1918
342	1919
342	1920
342	1921
342	1922
342	1923
342	1924
342	1925
342	1926
342	1927
342	1928
342	1929
342	1930
342	1931
342	1932
342	1933
342	1934
342	1935
342	1936
342	1937
342	1938
342	1939
342	1940
342	1941
342	1942
342	1943
342	1944
342	1945
342	1946
342	1947
342	1948
342	1949
342	1950
342	1951
342	1952
342	1953
342	1954
342	1955
342	1956
342	1957
342	1958
342	1959
342	1960
342	1961
342	1962
342	1963
342	1964
342	1965
342	1966
342	1967
342	1968
342	1969
342	1970
342	1971
342	1972
342	1973
342	1974
342	1975
342	1976
342	1977
342	1978
342	1979
342	1980
342	1981
342	1982
342	1983
342	1984
342	1985
342	1986
342	1987
342	1988
342	1989
342	1990
342	1991
342	1992
342	1993
342	1994
342	1995
342	1996
342	1997
342	1998
342	1999
342	2000
342	2001
342	2002
342	2003
342	2004
342	2005
342	2006
342	2007
342	2008
342	2009
342	2010
342	2011
342	2012
342	2013
342	2014
342	2015
342	2016
342	2017
342	2018
342	2019
342	2020
342	2021
342	2022
342	2023
342	2024
342	2025
342	2026
342	2027
342	2028
342	2029
342	2030
342	2031
342	2032
342	2033
342	2034
342	2035
342	2036
342	2037
342	2038
398	2048
398	2049
398	2050
398	2051
398	2052
398	2053
398	2054
398	2055
398	2056
398	2057
398	2058
398	2059
398	2060
398	2061
398	2039
398	2040
398	2041
398	2042
398	2043
398	2044
398	2045
398	2046
398	2047
406	2062
414	2064
414	2065
414	2066
414	2067
414	2068
414	2069
414	2070
414	2071
414	2072
414	2073
414	2074
414	2063
417	2128
417	2129
417	2118
417	2119
417	2120
417	2121
417	2122
417	2123
417	2124
417	2125
417	2126
417	2127
421	2176
421	645
421	714
421	1971
421	2164
421	2165
421	2166
421	2167
421	2168
421	2169
421	2170
421	2171
421	2172
421	2173
421	2174
421	2175
430	2177
430	2178
430	2179
430	2180
430	2181
430	2182
430	2183
430	2184
430	2185
430	2186
430	2187
430	2188
430	2189
430	2190
430	2191
430	2192
430	2193
430	2194
430	2195
430	2196
430	2197
430	2198
430	2199
430	2200
437	2112
437	2113
437	2114
437	2115
437	2116
437	2117
437	2075
437	2076
437	2077
437	2078
437	2079
437	2080
437	2081
437	2082
437	2083
437	2084
437	2085
437	2086
437	2087
437	2088
437	2089
437	2090
437	2091
437	2092
437	2093
437	2094
437	2095
437	2096
437	2097
437	2098
437	2099
437	2100
437	2101
437	2102
437	2103
437	2104
437	2105
437	2106
437	2107
437	2108
437	2109
437	2110
437	2111
447	2243
447	2244
447	2245
447	2246
447	2247
447	2248
447	2249
447	2250
447	2251
447	2252
447	2253
447	2254
447	2255
447	2256
447	2257
447	2258
447	2259
447	2260
447	2261
447	2262
447	2263
447	2264
447	2265
447	2266
447	2267
447	2268
454	2225
454	2226
454	2227
454	2228
454	2229
454	2230
454	2231
454	2232
454	2233
454	2234
459	2208
459	2209
459	2210
459	2211
459	2212
459	2213
459	2214
459	2215
459	2216
459	2217
459	2218
459	2219
459	2220
459	2221
459	2222
459	2223
459	2224
459	2201
459	2202
459	2203
459	2204
459	2205
459	2206
459	2207
466	2240
466	2241
466	2242
466	2235
466	2236
466	2237
466	2238
466	2239
469	2304
469	2305
469	2306
469	2307
469	2308
469	2309
469	2310
469	2311
469	2312
469	2313
469	2314
469	2315
469	2316
469	2317
469	2318
469	2319
469	2320
469	2321
469	2322
469	2323
469	2324
469	2325
469	2326
469	2327
476	2280
476	2281
476	2282
476	2283
476	2284
476	2285
476	2286
476	2287
478	2272
478	2081
478	2273
478	2274
478	2275
478	2276
478	2277
478	2278
478	2087
478	2279
478	2088
478	2090
478	2091
478	2092
478	2223
478	2098
478	2102
478	2108
478	2269
478	2077
478	2270
478	2271
478	2111
482	2288
482	2289
482	2290
482	2291
482	2292
482	2293
482	2294
482	2295
485	2296
485	2297
485	2298
485	2299
485	2300
485	2301
485	2302
485	2303
487	2368
487	2369
487	2338
487	2370
487	2371
487	2372
487	2347
487	2286
487	2287
487	2288
487	2289
487	2354
487	2290
487	2356
487	2358
487	2359
487	2328
487	2296
487	2363
487	2300
487	2365
487	2366
487	2302
487	2367
499	2388
499	2389
499	2390
499	2391
499	2392
499	2393
499	2394
499	2395
499	2396
499	2397
499	2398
499	2399
499	2400
499	2401
499	2402
499	2403
499	2404
499	2405
499	2406
499	2407
499	2408
499	2409
499	2410
499	2411
499	2412
505	2328
505	2329
505	2330
505	2331
505	2332
505	2333
505	2334
505	2335
505	2336
505	2337
505	2338
505	2339
505	2340
505	2341
505	2342
505	2343
505	2344
505	2345
505	2346
505	2347
505	2348
505	2349
505	2350
505	2351
505	2352
505	2353
505	2354
505	2355
505	2356
505	2357
505	2358
505	2359
505	2360
505	2361
505	2362
505	2363
505	2364
510	2435
510	2436
510	2437
510	2438
510	2439
510	2440
510	2441
510	2442
510	2443
510	2444
510	2445
510	2446
510	2447
510	2448
510	2449
510	2450
510	2451
510	2452
510	2453
510	2454
510	2455
510	2456
510	2457
510	2458
517	2432
517	2433
517	2434
517	2413
517	2414
517	2415
517	2416
517	2417
517	2418
517	2419
517	2420
517	2421
517	2422
517	2423
517	2424
517	2425
517	2426
517	2427
517	2428
517	2429
517	2430
517	2431
521	2464
521	2465
521	2466
521	2467
521	2468
521	2469
521	2470
521	2471
521	2472
521	2473
521	2474
521	2459
521	2460
521	2461
521	2462
521	2463
530	2475
530	2476
530	2477
533	2496
533	2497
533	2498
533	2499
533	2478
533	2479
533	2480
533	2481
533	2482
533	2483
533	2484
533	2485
533	2486
533	2487
533	2488
533	2489
533	2490
533	2491
533	2492
533	2493
533	2494
533	2495
541	2500
541	2501
541	2502
541	2503
541	2504
541	2505
541	2506
541	2507
541	2508
541	2509
541	2510
541	2511
541	2512
541	2513
541	2514
541	2515
541	2516
541	2517
541	2518
541	2519
541	2520
541	2521
541	2522
541	2523
552	2528
552	2529
552	2530
552	2531
552	2532
552	2533
552	2534
552	2535
552	2536
552	2537
552	2538
552	2539
552	2540
552	2541
552	2542
552	2543
552	2544
552	2545
552	2524
552	2236
552	2525
552	2526
552	2527
560	2577
560	2578
560	2579
560	2580
560	2581
560	2582
560	2583
560	2584
560	2585
560	2586
560	2587
560	2588
560	2589
560	2590
560	2591
560	2592
560	2593
560	2594
560	2595
560	2596
560	2597
560	2598
560	2599
560	2600
560	2601
566	2560
566	2561
566	2562
566	2563
566	2564
566	2546
566	2547
566	2548
566	2549
566	2550
566	2551
566	2552
566	2553
566	2554
566	2555
566	2556
566	2557
566	2558
566	2559
568	2576
568	2565
568	2566
568	2567
568	2568
568	2569
568	2570
568	2571
568	2572
568	2573
568	2574
568	2575
572	2602
572	2603
572	2604
572	2605
572	2606
572	2607
572	2608
572	2609
572	2610
572	2611
572	2612
572	2613
572	2614
572	2615
572	2616
572	2617
572	2618
572	2619
572	2620
572	2621
572	2622
2131	2144
2131	2145
2131	2146
2131	2147
2131	2148
2131	2149
2131	2150
2131	2130
2131	2132
2131	2133
2131	2134
2131	2135
2131	2136
2131	2137
2131	2138
2131	2139
2131	2140
2131	2141
2131	2142
2131	2143
2152	2151
2152	2153
2152	2154
2152	618
2152	2155
2152	2156
2152	2157
2152	2158
2152	2159
2152	2160
2152	2161
2152	1042
2152	2162
2152	2163
2152	762
2374	2368
2374	2369
2374	2370
2374	2371
2374	2372
2374	2373
2374	2375
2374	2376
2374	2377
2374	2378
2374	2379
2374	2380
2374	2381
2374	2382
2374	2383
2374	2384
2374	2385
2374	2386
2374	2387
2374	2365
2374	2366
2374	2367
\.


--
-- TOC entry 2193 (class 0 OID 17760)
-- Dependencies: 189
-- Data for Name: white_cards; Type: TABLE DATA; Schema: public; Owner: pyx
--

COPY white_cards (id, text, watermark) FROM stdin;
581	Throwing grapes at a man until he loses touch with reality.	US
582	My Uber driver, Pavel.	US
583	The Hamburglar.	US
584	A stray pube.	US
585	White privilege.	US
586	Facebook.	US
587	Pac-Man uncontrollably guzzling cum.	US
588	Forced sterilization.	US
589	An Oedipus complex.	US
590	Scientology.	US
591	My fat daughter.	US
592	Active listening.	US
593	Vigorous jazz hands.	US
594	An M. Night Shyamalan plot twist.	US
595	The rhythms of Africa.	US
596	The homosexual agenda.	US
597	Having big dreams but no realistic way to achieve them.	US
598	A time travel paradox.	US
599	Lactation.	US
600	Dick fingers.	US
601	Dying.	US
602	My good bra.	US
603	Me time.	US
604	Smallpox blankets.	US
605	J.D. Power and his associates.	US
606	Seeing my father cry.	US
607	Seppuku.	US
608	Adderall.&reg;	US
609	Hot people.	US
610	Dead babies.	US
611	Not reciprocating oral sex.	US
612	50 mg of Zoloft daily.	US
613	A bleached asshole.	US
614	Flesh-eating bacteria.	US
615	Itchy pussy.	US
616	Foreskin.	US
617	Worshipping that pussy.	US
618	How far I can get my own penis up my butt.	US
619	World peace.	US
620	Expecting a burp and vomiting on the floor.	US
621	Kamikaze pilots.	US
622	Anal beads.	US
623	Being rich.	US
624	The Three-Fifths Compromise.	US
625	Shapeshifters.	US
626	Lockjaw.	US
627	Getting so angry that you pop a boner.	US
628	Child beauty pageants.	US
629	Breaking out into song and dance.	US
630	Pretending to care.	US
631	Waiting till marriage.	US
632	The wifi password.	US
633	Being a woman.	US
634	The past.	US
635	Catapults.	US
636	A lifetime of sadness.	US
637	Going an entire day without masturbating.	US
638	Dwayne "The Rock" Johnson.	US
639	A saxophone solo.	US
640	Being marginalized.	US
641	The penny whistle solo from "My Heart Will Go On."	US
642	A fart so powerful that it wakes the giants from their thousand-year slumber.	US
643	My genitals.	US
644	Little boy penises.	US
645	Punching a congressman in the face.	US
646	Some god damn peace and quiet.	US
647	BATMAN!	US
648	Ruth Bader Ginsburg brutally gaveling your penis.	US
649	Preteens.	US
650	More elephant cock than I bargained for.	US
651	Smegma.	US
652	A micropenis.	US
653	My ugly face and bad personality.	US
654	A good sniff.	US
655	Explaining how vaginas work.	US
656	Genuine human connection.	US
657	An old guy who's almost dead.	US
658	My cheating son-of-a-bitch husband.	US
659	Fox News.	US
660	Being a motherfucking sorcerer.	US
661	The Red Hot Chili Peppers.	US
662	Holding down a child and farting all over him.	US
663	The KKK.	US
664	Land mines.	US
665	Centaurs.	US
666	Seven dead and three in critical condition.	US
667	My relationship status.	US
668	A mating display.	US
669	Auschwitz.	US
670	Used panties.	US
671	Alcoholism.	US
672	Sexual peeing.	US
673	A windmill full of corpses.	US
674	Darth Vader.	US
675	Daniel Radcliffe's delicious asshole.	US
676	A good, strong gorilla.	US
677	Huffing spray paint.	US
678	Half-assed foreplay.	US
679	Nipple blades.	US
680	Being able to talk to elephants.	US
681	Making a pouty face.	US
682	Drowning the kids in the bathtub.	US
683	Emerging from the sea and rampaging through Tokyo.	US
684	Hospice care.	US
685	Magnets.	US
686	Touching a pug right on his penis.	US
687	Vladimir Putin.	US
688	Spontaneous human combustion.	US
689	Leprosy.	US
690	Seething with quiet resentment.	US
691	Explosions.	US
692	Licking things to claim them as your own.	US
693	Consensual sex.	US
694	Getting married, having a few kids, buying some stuff, retiring to Florida, and dying.	US
695	Nickelback.	US
696	The Boy Scouts of America.	US
697	Bananas.	US
698	Masturbating.	US
699	All the dues I've fucked.	US
700	Famine.	US
701	Hillary Clinton's emails.	US
702	Executing a hostage every hour.	US
703	Running out of semen.	US
704	Jews, gypsies, and homosexuals.	US
705	The arrival of the pizza.	US
706	Goblins.	US
707	Laying an egg.	US
708	A bowl of mayonnaise and human teeth.	US
709	A micropig wearing a tiny raincoat and booties.	US
710	A bitch slap.	US
711	Giving 110%.	US
712	Inserting a Mason jar into my anus.	US
713	A man on the brink of orgasm.	US
714	A much younger woman.	US
715	10,000 Syrian refugees.	US
716	A sad handjob.	US
717	Police brutality.	US
718	Throwing a virgin into a volcano.	US
719	A sea of troubles.	US
720	Multiple stab wounds.	US
721	Filling my briefcase with business stuff.	US
722	A tiny horse.	US
723	The Kool-Aid Man.	US
724	Grandma.	US
725	A bag of magic beans.	US
726	Doing the right thing.	US
727	Emma Watson.	US
728	Racism.	US
729	Powerful thighs.	US
730	Men.	US
731	Farting and walking away.	US
732	Pedophiles.	US
733	German Chancellor Angela Merkel.	US
734	Peeing a little bit.	US
735	Viagra.&reg;	US
736	Ronald Reagan.	US
737	Bisexuality.	US
738	The clitoris.	US
739	Soft, kissy missionary sex.	US
740	Sitting on my face and telling me I'm garbage.	US
741	A balanced breakfast.	US
742	Puberty.	US
743	Poor people.	US
744	Harry Potter erotica.	US
745	Penis breath.	US
746	Agriculture.	US
747	Committing suicide.	US
748	The heart of a child.	US
749	Aaron Burr.	US
750	Republicans.	US
751	Justin Bieber.	US
752	Concealing a boner.	US
753	Not vaccinating my children because I am stupid.	US
754	Judge Judy.	US
755	Sex with animals.	US
756	Men discussing their feelings in an emotionally healthy way.	US
757	Dead birds everywhere.	US
758	All-you-can-eat shrimp for $8.99.	US
759	My bright pink fuckhole.	US
760	Having sex for the first time.	US
761	An endless stream of diarrhea.	US
762	Getting drugs off the street and into my body.	US
763	German dungeon porn.	US
764	Bingeing and purging.	US
765	Kourtney, Kim, Khloe, Kendall, and Kylie.	US
766	Mouth herpes.	US
767	Seeing what happens when you lock people in a room with hungry seagulls.	US
768	72 virgins.	US
769	Not giving a shit about the Third World.	US
770	Getting cummed on.	US
771	Poor life choices.	US
772	Firing a rifle into the air while balls deep in a squealing hog.	US
773	Opposable thumbs.	US
774	Geese.	US
775	Being fat and stupid.	US
776	Fancy Feast.&reg;	US
777	Serfdom.	US
778	Teaching a robot to love.	US
779	A Super Soaker&trade; full of cat pee.	US
780	NBA superstar LeBron James.	US
781	Child abuse.	US
782	Fucking my sister.	US
783	Natural male enhancement.	US
784	Science.	US
785	<i>The Bachelorette</i> season finale.	US
786	The gays.	US
787	Becoming a blueberry.	US
788	Oprah.	US
789	Three dicks at the same time.	US
790	The wonders of the Orient.	US
791	Puppies!	US
792	An unwanted pregnancy.	US
793	Racially-biased SAT questions.	US
794	The Holy Bible.	US
795	Women of color.	US
796	However much weed $20 can buy.	US
797	Doing crimes.	US
798	A whole thing of butter.	US
799	Having anuses for eyes.	US
800	Silence.	US
801	Lumberjack fantasies.	US
802	My balls on your face.	US
803	Dead parents.	US
804	Barack Obama.	US
805	A snapping turtle biting the tip of your penis.	US
806	A salad for men that's made of metal.	US
807	African children.	US
808	Fading away into nothingness.	US
809	Illegal immigrants.	US
810	Spaghetti? Again?	US
811	The Amish.	US
812	Wizard music.	US
813	The miracle of childbirth.	US
814	Eating a hard boiled egg out of my husband's asshole.	US
815	Selling crack to children.	US
816	Menstrual rage.	US
817	Still being a virgin.	US
818	Mike Pence.	US
819	Shiny objects.	US
820	Giving birth to the Antichrist.	US
821	The entire Mormon Tabernacle Choir.	US
822	The placenta.	US
823	Count Chocula.	US
824	Bees?	US
825	Drinking alone.	US
826	Telling a shitty story that goes nowhere.	US
827	Sunshine and rainbows.	US
828	A little boy who won't shut the fuck up about dinosaurs.	US
829	Finger painting.	US
830	Hobos.	US
831	Natural selection.	US
832	An erection that lasts longer than four hours.	US
833	Bubble butt bottom boys.	US
834	My soul.	US
835	A middle-aged man on roller skates.	US
836	Being a dick to children.	US
837	Mutually assured destruction.	US
838	Eating the last known bison.	US
839	A mopey zoo lion.	US
840	The cool, refreshing taste of Pepsi.&reg;	US
841	Extremely tight pants.	US
842	Queefing.	US
843	A live studio audience.	US
844	An oversized lollipop.	US
845	Nicolas Cage.	US
846	The Rapture.	US
847	Daddy issues.	US
848	Chunks of dead hitchhiker.	US
849	Accepting the way things are.	US
850	The Big Bang.	US
851	Women's suffrage.	US
852	Inappropriate yodeling.	US
853	An older woman who knows her way around the penis.	US
854	Raptor attacks.	US
855	Sex with Patrick Stewart.	US
856	The Patriarchy.	US
857	Free samples.	US
858	My ex-wife.	US
859	The Pope.	US
860	Covering myself with Parmesan cheese and chili flakes because I am pizza.	US
861	White people.	US
862	The unstoppable tide of Islam.	US
863	Unfathomable stupidity.	US
864	A bird that shits human turds.	US
865	Your weird brother.	US
866	Jobs.	US
867	Former President George W. Bush.	US
868	Estrogen.	US
869	Donald J. Trump.	US
870	An AR-15 assault rifle.	US
871	Casually suggesting a threesome.	US
872	David Bowie flying in on a tiger made of lightning.	US
873	Memes.	US
874	A salty surprise.	US
875	Balls.	US
876	The Devil himself.	US
877	Fucking the weatherman on live television.	US
878	The female orgasm.	US
879	Necrophilia.	US
880	The magic of live theatre.	US
881	Some punk kid who stole my turkey sandwich.	US
882	Vomiting seafood and bleeding anally.	US
883	Pulling out.	US
884	Spectacular abs.	US
885	Full frontal nudity.	US
886	A tiny, gay guitar called a ukulele.	US
887	Mansplaining.	US
888	Poorly-timed Holocaust jokes.	US
889	Sweet, sweet vengeance.	US
890	How amazing it is to be on mushrooms.	US
891	Lance Armstrong's missing testicle.	US
892	Hope.	US
893	The screams... the terrible screams.	US
894	Gandhi.	US
895	Only dating Asian women.	US
896	Switching to Geico.&reg;	US
897	Getting fingered.	US
898	Yeast.	US
899	Emotions.	US
900	Crumbs all over the god damn carpet.	US
901	A brain tumor.	US
902	Wet dreams.	US
903	Dark and mysterious forces beyond our control.	US
904	Shaking a baby until it stops crying.	US
905	Being on fire.	US
906	Huge biceps.	US
907	My vagina.	US
908	Bill Nye the Science Guy.	US
909	My inner demons.	US
910	Pooping in a laptop and closing it.	US
911	Battlefield amputations.	US
912	A fetus.	US
913	Strong female characters.	US
914	Dry heaving.	US
915	Tentacle porn.	US
916	The Jews.	US
917	The South.	US
918	Teenage pregnancy.	US
919	A pangender octopus who roams the cosmos in search of love.	US
920	Saying "I love you."	US
921	Doin' it in the butt.	US
922	Synergistic management solutions.	US
923	50,000 volts straight to the nipples.	US
924	Self-loathing.	US
925	Erectile dysfunction.	US
926	Poopy diapers.	US
927	Friction.	US
928	A sassy black woman.	US
929	Liberals.	US
930	Oompa-Loompas.	US
931	Drinking out of the toilet and eating garbage.	US
932	Fragile masculinity.	US
933	Kissing grandma on the forehead and turning off her life support.	US
934	Rap music.	US
935	GoGurt.&reg;	US
936	The true meaning of Christmas.	US
937	A pyramid of severed heads.	US
938	Getting really high.	US
939	Hot cheese.	US
940	Incest.	US
941	Elderly Japanese men.	US
942	Announcing that I am about to cum.	US
943	Invading Poland.	US
944	RoboCop.	US
945	Flying sex snakes.	US
946	Slaughtering innocent civilians.	US
947	Establishing dominance.	US
948	Some guy.	US
949	Girls.	US
950	Italians.	US
951	Shutting up so I can watch the game.	US
952	Jennifer Lawrence.	US
953	Blowing my boyfriend so hard he shits.	US
954	A Mexican.	US
955	The Underground Railroad.	US
956	Penis envy.	US
957	Repression.	US
958	Cards Against Humanity.	US
959	The Hustle.	US
960	Jerking off into a pool of children's tears.	US
961	Heteronormativity.	US
962	A Bop It.&trade;	US
963	Heartwarming orphans.	US
964	The Great Depression.	US
965	A falcon with a cap on its head.	US
966	AXE Body Spray.	US
967	Prescription pain killers.	US
968	Solving problems with violence.	US
969	Gloryholes.	US
970	A homoerotic volleyball montage.	US
971	This month's mass shooting.	US
972	Radical Islamic terrorism.	US
973	Flightless birds.	US
974	A disappointing birthday party.	US
975	Assless chaps.	US
976	Vehicular manslaughter.	US
977	Permanent Orgasm-Face Disorder.	US
978	Boogers.	US
979	The Blood of Christ.	US
980	Cuddling.	US
981	Looking in the mirror, applying lipstick, and whispering "tonight, you will have sex with Tom Cruise."	US
982	Authentic Mexican cuisine.	US
983	The American Dream.	US
984	Pooping back and forth. Forever.	US
985	The Force.	US
986	The only gay person in a hundred miles.	US
987	Ethnic cleansing.	US
988	Exactly what you'd expect.	US
989	Getting crushed by a vending machine.	US
990	A ball of earwax, semen, and toenail clippings.	US
991	Brown people.	US
992	Steve Bannon.	US
993	Diversity.	US
994	Pixelated bukkake.	US
995	Tearing that ass up like wrapping paper on Christmas morning.	US
996	Sideboob.	US
997	Seeing Grandma naked.	US
998	Women in yogurt commercials.	US
999	Arnold Schwarzenegger.	US
1000	The bombing of Nagasaki.	US
1001	Chainsaws for hands.	US
1002	Getting naked and watching Nickelodeon.	US
1003	Fear itself.	US
1004	The Trail of Tears.	US
1005	Swooping.	US
1006	Ghosts.	US
1007	My neck, my back, my pussy, and my crack.	US
1008	God.	US
1009	Nazis.	US
1010	MechaHitler.	US
1011	My collection of Japanese sex toys.	US
1012	One titty hanging out.	US
1013	Crippling debt.	US
1014	Passive aggressive Post-it notes.	US
1015	Whipping it out.	US
1016	Academy Award winner Meryl Streep.	US
1017	Funky fresh rhymes.	US
1018	How bad my daughter fucked up her dance recital.	US
1019	Fellowship in Christ.	US
1020	The violation of our most basic human rights.	US
1021	Coat hanger abortions.	US
1022	Morgan Freeman's voice.	US
1023	Stalin.	US
1024	8 oz. of sweet Mexican black-tar heroin.	US
1025	Old-people smell.	US
1026	Fake tits.	US
1027	Sexual tension.	US
1028	The inevitable heat death of the universe.	US
1029	A fuck-ton of almonds.	US
1030	Muhammad (Peace Be Upon Him).	US
1031	A really cool hat.	US
1032	An octopus giving seven handjobs and smoking a cigarette.	US
1033	These hoes.	US
1034	Listening to her problems without trying to solve them.	US
1035	The Russians.	US
1036	Waking up half-naked in a Denny's parking lot.	US
1037	Murder.	US
1038	A crucifixion.	US
1039	Her Majesty, Queen Elizabeth II.	US
1040	Not wearing pants.	US
1041	Man meat.	US
1042	A gossamer stream of jizz that catches the light as it arcs through the morning air.	US
1043	Lena Dunham.	US
1044	Many bats.	US
1045	Gay conversion therapy.	US
1046	Horse meat.	US
1047	The glass ceiling.	US
1048	Dick pics.	US
1049	Completely unwarranted confidence.	US
1050	One trillion dollars.	US
1051	Some of the best rappers in the game.	US
1052	Black people.	US
1053	Sperm whales.	US
1054	My sex life.	US
1055	Chemical weapons.	US
1056	A Fleshlight.&reg;	US
1057	Pictures of boobs.	US
1058	William Shatner.	US
1059	AIDS.	US
1060	Autocannibalism.	US
1061	A horde of Vikings.	US
1062	Danny DeVito.	US
1063	My abusive boyfriend who really isn't so bad once you get to know him.	US
1064	A three-way with my wife and Shaquille O'Neal.	US
1065	Fiery poops.	US
1066	Lunchables.&trade;	US
1067	Meth.	US
1068	Soup that is too hot.	US
1069	Tap dancing like there's no tomorrow.	US
1070	Stephen Hawking talking dirty.	US
1071	Object permanence.	US
1072	The milkman.	US
1073	Braiding three penises into a Twizzler.	US
1074	My black ass.	US
1075	Kanye West.	US
1076	Poverty.	US
1077	Judging everyone.	US
1078	PTSD.	US
1079	Wondering if it's possible to get some of that salsa to go.	US
1080	Bitches.	US
1081	An icy handjob from an Edmonton hooker.	CA
1082	An Evening with Michael Bubl&eacute;.	CA
1083	Getting a DUI on a Zamboni.	CA
1084	The Royal Canadian Mounted Police.	CA
1085	Oestrogen.	CA
1086	Heritage minutes.	CA
1087	An endless stream of diarrhoea.	CA
1088	A hairless little shitstain named Caillou.	CA
1089	A despondent Maple Leafs fan sitting all alone.	CA
1090	Apologizing.	CA
1091	Syrupy sex with a maple tree.	CA
1092	An M16 assault rifle.	CA
1093	Canadian Netflix.	CA
1094	Punching an MP in the face.	CA
1095	Burning down the White House.	CA
1096	Newfies.	CA
1097	A vastly superior healthcare system.	CA
1098	Women of colour.	CA
1099	Living in Yellowknife.	CA
1100	A fuck-tonne of almonds.	CA
1101	Clubbing baby seals.	CA
1102	The only gay person in a hundred kilometers.	CA
1103	The Official Languages Act. La Loi sur les langues officielles.	CA
1104	Terry Fox's prosthetic leg.	CA
1105	Mr. Dressup.	CA
1106	Justin Trudeau.	CA
1107	Germans on holiday.	UK
1108	Sitting on my face.	UK
1109	The Hillsborough Disaster.	UK
1110	Queen Elizabeth's immaculate anus.	UK
1111	Druids.	UK
1112	The way James Bond treats women.	UK
1113	Blowing up Parliament.	UK
1114	A white van man.	UK
1115	Wanking into a pool of children's tears.	UK
1116	Benedict Cumberbatch.	UK
1117	Shitting out a perfect Cumberland sausage.	UK
1118	Shutting up so I can watch the match.	UK
1119	Faffing about.	UK
1120	Blood, toil, tears, and sweat.	UK
1121	Dirty nappies.	UK
1122	Catapult.	UK
1123	Your mum.	UK
1124	Dogging.	UK
1125	Concealing an erection.	UK
1126	Polish people.	UK
1127	Waking up in Idris Elba's arms.	UK
1128	A bleached arsehole.	UK
1129	Braiding three penises into a Curly Wurly.	UK
1130	Kissing nan on the forehead and turning off her life support.	UK
1131	However much weed &pound;20 can buy.	UK
1132	A Chelsea smile.	UK
1133	The EDL.	UK
1134	Being marginalised.	UK
1135	Ecstasy.	UK
1136	England.	UK
1137	The Black Death.	UK
1138	Jehovah's Witnesses.	UK
1139	Egging an MP.	UK
1140	The Scouts.	UK
1141	The end of days.	UK
1142	The North.	UK
1143	Maureen of Blackpool, Reader's Wife of the Year 1988.	UK
1144	Spaniards.	UK
1145	Forced sterilisation.	UK
1146	Some bloody peace and quiet.	UK
1147	A brain tumour.	UK
1148	Pikies.	UK
1149	An entrenched class system.	UK
1150	Just touching David Beckham's hair.	UK
1151	Used knickers.	UK
1152	A hen night in Slough.	UK
1153	Waking up half-naked in a Little Chef car park.	UK
1154	Paedophiles.	UK
1155	Haggis.	UK
1156	Anything that comes out of Prince Philip's mouth.	UK
1157	The bloody Welsh.	UK
1158	Mad cow disease.	UK
1159	The sudden appearance of the Go Compare man.	UK
1160	The smell of Primark.	UK
1161	Theresa May.	UK
1162	My mate Dave.	UK
1163	Cottaging.	UK
1164	Not wearing trousers.	UK
1165	A nice cup of tea.	UK
1166	Jimmy Savile.	UK
1167	Drinking out of the toilet and eating rubbish.	UK
1168	A posh wank.	UK
1169	A foul mouth.	UK
1170	Trench foot.	UK
1171	An AK-47 assault rifle.	UK
1172	A foetus.	UK
1173	Cheeky bum sex.	UK
1174	The <i>Strictly Come Dancing</i> season finale.	UK
1175	Bogies.	UK
1176	The Daily Mail.	UK
1177	A fanny fart.	UK
1178	Tories.	UK
1179	Perfunctory foreplay.	UK
1180	Slapping Nigel Farage over and over.	UK
1181	Madeleine McCann.	UK
1182	400 years of colonial atrocities.	UK
1183	Queuing.	UK
1184	Passive-aggressive Post-it notes.	UK
1185	LYNX&reg; Body Spray.	UK
1186	9 oz. of sweet Mexican black-tar heroin.	UK
1187	Crumbs all over the bloody carpet.	UK
1188	Chivalry.	UK
1189	Amputees.	UK
1190	A bit of slap and tickle.	UK
1191	Seeing Granny naked.	UK
1192	Sniffing glue.	UK
1193	The petty troubles of the landed gentry.	UK
1194	Lads.	UK
1195	The French.	UK
1196	Ed Balls.	UK
1197	A vindaloo poo.	UK
1198	Scousers.	UK
1199	Getting naked and watching CBeebies.	UK
1200	Rubbing Boris Johnson's belly until he falls asleep.	UK
1201	A sober Irishman who doesn't care for potatoes.	UK
1202	Daddies&reg; Brown Sauce.	UK
1203	Brexit.	UK
1204	Knife crime.	UK
1205	Getting married, having a few kids, buying some stuff, retiring to the south of France, and dying.	UK
1206	Africa children.	UK
1207	Somali pirates.	UK
1208	Hooning.	AU
1209	Waking up half-naked in a Macca's car park.	AU
1210	Half a kilo of pure China White heroin.	AU
1211	100% Pure New Zealand.	AU
1212	Pauline Hanson.	AU
1213	Skippy the Bush Kangaroo.	AU
1214	A slab of VB and a pack of durries.	AU
1215	Winking at old people.	AU
1216	Getting married, having a few kids, buying some stuff, retiring to Queensland, and dying.	AU
1217	Fiery poos.	AU
1218	Having a Golden Gaytime.	AU
1219	Total control of the media.	AU
1220	All four prongs of an echidna's penis.	AU
1221	The White Australia Policy.	AU
1222	Making up for centuries of oppression with one day of apologising.	AU
1223	Glassing a wanker.	AU
1224	Dropping a baby down the dunny.	AU
1225	A sick burnout.	AU
1226	Rupert Murdoch.	AU
1227	Women in yoghurt commercials.	AU
1228	Tony Abbott in budgie smugglers.	AU
1229	Contagious face cancer.	AU
1230	Mr. Squiggle, the Man from the Moon.	AU
1231	Taking a sheep-wife.	AU
1232	Crazy hot cousin sex.	AU
1233	Getting so angry that you pop a stiffy.	AU
1234	Nothing but sand.	AU
1235	A cute, fuzzy koala with chlamydia.	AU
1236	Profound respect and appreciation for indigenous culture.	AU
1237	John Howard's eyebrows.	AU
1238	Selling ice to children.	AU
1239	A sick wombat.	AU
1240	A Halal Snack Pack.	AU
1241	Braiding three penises into a licorice twist.	AU
1242	The cool, refreshing taste of Coca-Cola.&reg;	AU
1243	Getting naked and watching <i>Play School.</i>	AU
1244	Women's undies.	AU
1245	Nippers.	AU
1246	Summoning Harold Holt from the sea in a time of great need.	AU
1247	A didgeridildo.	AU
1248	A five-litre goon bag.	AU
1249	Vegemite.&trade;	AU
1250	Good-natured, fun-loving Aussie racism.	AU
1251	A fair go.	AU
1252	Cashed-up bogans.	AU
1253	Inserting a jam jar into my anus.	AU
1254	Doin' it up the bum.	AU
1255	A stingray barb through the chest.	AU
1256	Pingers.	AU
1257	The bush.	AU
1258	Sorry, this content cannot be viewed in your region.	AU
1259	A shark!	AU
1260	Americanization.	AU
1261	Having a shag in the back of a ute.	AU
1262	Australia.	AU
1263	Massive, widespread drought.	AU
1264	Millions of cane toads.	AU
1265	Alcohol poisoning.	AU
1266	Xenophobia.	AU
1267	Ice.	AU
1268	A decent fucking Internet connection.	AU
1269	What's left of the Great Barrier Reef.	AU
1270	The Hemsworth brothers.	AU
1271	A literal tornado of fire.	AU
1272	The Great Emu War.	AU
1273	Chundering into a kangaroo's pouch.	AU
1274	The big fucking hole in the ozone layer.	AU
1275	My cheating prick of a husband.	AU
1276	Denying climate change.	AU
1277	Whiskas&reg; Catmilk.	AU
1278	Steve Irwin.	AU
1279	Chunks of dead backpacker.	AU
1280	The inevitable heath death of the universe.	AU
1281	A six-point plan to stop the boats.	AU
1282	Whoever the Prime Minister is these days.	AU
1283	An ass disaster.	INTL
1284	Disco fever.	INTL
1285	Words.	INTL
1286	Spending lots of money.	INTL
1287	Mooing.	INTL
1288	A cat video so cute that your eyes roll back and your spine slides out of your anus.	INTL
1289	Michael Jackson.	INTL
1290	Horrifying laser hair removal accidents.	INTL
1291	Dying alone and in pain.	INTL
1292	Shitting out a screaming face.	INTL
1293	Literally eating shit.	INTL
1294	A monkey smoking a cigar.	INTL
1295	Rich people.	INTL
1296	An evil man in evil clothes.	INTL
1297	A low standard of living.	INTL
1298	Wearing an octopus for a hat.	INTL
1299	Whining like a little bitch.	INTL
1300	Not having sex,	INTL
1301	A fat bald man from the Internet.	INTL
1302	Basic human decency.	INTL
1303	How awesome it is to be white.	INTL
1304	Nothing.	INTL
1305	Doing it in the butt.	INTL
1306	Moral ambiguity.	INTL
1307	Dining with cardboard cutouts of the cast of <i>Friends.</i>	INTL
1308	A big black dick.	INTL
1309	The arrival of pizza.	INTL
1310	An unstoppable wave of fire ants.	INTL
1311	Extremely tight jeans.	INTL
1312	A web of lies.	INTL
1313	Ominous background music.	INTL
1314	My machete.	INTL
1315	Multiple orgasms.	INTL
1316	Daddy's belt.	INTL
1317	Eating a hard boiled out of my husband's asshole.	INTL
1318	Friendly fire.	INTL
1319	The boners of the elderly.	INTL
1320	The hiccups.	INTL
1321	The crazy, ball-slapping sex your parents are having right now.	INTL
1322	Going around punching people.	INTL
1323	Letting everyone down.	INTL
1324	Nunchuck moves.	INTL
1325	The prunes I've been saving for you in my armpits.	INTL
1326	A PowerPoint presentation.	INTL
1327	The entire Internet.	INTL
1328	An AK-47.	INTL
1329	Walking in on Dad peeing into Mom's mouth.	INTL
1330	Dad's funny balls.	INTL
1331	Flying robots that kill people.	INTL
1332	Weapons-grade plutonium.	INTL
1333	Sexy pillow fights.	INTL
1334	Being white.	INTL
1335	A slightly shittier parallel universe.	INTL
1336	Having sex on top of a pizza.	INTL
1337	Power.	INTL
1338	Scrotum tickling.	INTL
1339	An army of skeletons.	INTL
1340	Actually getting shot, for real.	INTL
1341	A cop who is also a dog.	INTL
1342	A vagina that leads to another dimension.	INTL
1343	A man in yoga pants with a ponytail and feather earrings.	INTL
1344	Converting to Islam.	INTL
1345	Me.	INTL
1346	Tom Cruise.	INTL
1347	Intimacy problems.	INTL
1348	Leveling up.	INTL
1349	That ass.	INTL
1350	Kim Jong-un.	INTL
1351	The Dalai Lama.	INTL
1352	Ripping open a man's chest and pulling out his still-beating heart.	INTL
1353	A sad fat dragon with no friends.	INTL
1354	A surprising amount of hair.	INTL
1355	Some really fucked-up shit.	INTL
1356	Robert Downey Jr.	INTL
1357	Ryan Gosling riding in on a white horse.	INTL
1358	Sexual humiliation.	INTL
1359	Fisting.	INTL
1360	The human body.	INTL
1361	A defective condom.	INTL
1362	My father, who died when I was seven.	INTL
1363	The economy.	INTL
1364	Deflowering the princess.	INTL
1365	A Chinese tourist who wants something very badly but cannot communicate it.	INTL
1366	Graphic violence, adult language, and some sexual content.	INTL
1367	Self-flagellation.	INTL
1368	Shutting the fuck up.	INTL
1369	FIlling my son with spaghetti.	INTL
1370	The baby that ruined my pussy.	INTL
1371	Buying the right clothes to be cool.	INTL
1372	Being black.	INTL
1373	All of this blood.	INTL
1374	Edible underwear.	INTL
1375	An oversized lollipop,	INTL
1376	Stockholm Syndrome.	INTL
1377	The World of Warcraft.	INTL
1378	Grave robbing.	INTL
1379	Gandalf.	INTL
1380	Sneezing, farting, and cumming at the same time.	INTL
1381	Running naked through a mall, pissing and shitting everywhere.	INTL
1382	Blood farts.	INTL
1383	Panda sex.	INTL
1384	A thermonuclear detonation.	INTL
1385	Destroying the evidence.	INTL
1386	Vomiting mid-blowjob.	INTL
1387	A pi&ntilde;ata full of scorpions.	INTL
1388	Miley Cyrus.	INTL
1389	A Japanese toaster you can fuck.	INTL
1390	Suicidal thoughts.	INTL
1391	Grandpa's ashes.	INTL
1392	Reverse cowgirl.	INTL
1393	Keanu Reeves.	INTL
1394	LIving in a trashcan.	INTL
1395	My first kill.	INTL
1396	Mom.	INTL
1397	Children on leashes.	INTL
1398	Double penetration.	INTL
1399	Slave.	INTL
1400	White power.	INTL
1401	Indescribable loneliness.	INTL
1402	Tongue.	INTL
1403	Tiny nipples.	INTL
1404	Being fabulous.	INTL
1405	Homeless people.	INTL
1406	My cheating-son-of-a-bitch-husband.	INTL
1407	Screaming like a maniac.	INTL
1408	Heroin.	INTL
1409	Existing.	INTL
1410	The pirate's life.	INTL
1411	One Ring to rule them all.	INTL
1412	The flute.	INTL
1413	Being a busy adult with many important things to do.	INTL
1414	Slapping a racist old lady.	INTL
1415	Genetically engineered super-soldiers.	INTL
1416	Pumping out a baby every nine months.	INTL
1417	A mime having a stroke.	INTL
1418	Women voting.	INTL
1419	Gladiatorial combat.	INTL
1420	Some kind of bird man.	INTL
1421	Taking a man's eyes and balls out and putting his eyes where his balls go and then his balls in the eye holes.	INTL
1422	Mild autism.	INTL
1423	Rising from the grave.	INTL
1424	Not contributing to society in any meaningful way.	INTL
1425	Cock.	INTL
1426	Some douche with an acoustic guitar.	INTL
1427	Terrorists.	INTL
1428	Overpowering your father.	INTL
1429	Being a hideous beast that no one could love.	INTL
1430	Samuel L. Jackson.	INTL
1431	Making the penises kiss.	INTL
1432	Being a dinosaur.	INTL
1433	Staring at a painting and going "hmmmmmmm..."	INTL
1434	A sweet spaceships.	INTL
1435	Lady Gaga.	INTL
1436	Tripping balls.	INTL
1437	Eating an albino.	INTL
1438	Our first chimpanzee Prime Minister.	INTL
1439	Sudden Poop Explosion Disease.	INTL
1440	The total collapse of the global financial system.	INTL
1441	Loki, the trickster god.	INTL
1442	Making a friend.	INTL
1443	The Gulags.	INTL
1444	Hipsters.	INTL
1445	Wiping her butt.	INTL
1446	All my friends dying.	INTL
1447	The land of chocolate.	INTL
1448	Jesus.	INTL
1449	Another shot of morphine.	INTL
1450	Bosnian chicken farmers.	INTL
1451	How wet my pussy is.	INTL
1452	Having shotguns for legs.	INTL
1453	Bullshit.	INTL
1454	Blowing my boyfriend so hard so he shits.	INTL
1455	Cumming deep inside my best bro.	INTL
1456	Being awesome at sex.	INTL
1457	Santa Claus.	INTL
1458	Having a penis.	INTL
1459	Gay aliens.	INTL
1460	Jafar.	RED
1461	Jumping out at people.	RED
1462	The mixing of the races.	RED
1463	The Harlem Globetrotters.	RED
1464	Scrotal frostbite.	RED
1465	Statistically validated stereotypes.	RED
1466	Pretty Pretty Princess Dress-Up Board Game.&reg;	RED
1467	Making shit up.	RED
1468	Mufasa's death scene.	RED
1469	Having $57 in the bank.	RED
1470	A sales team of clowns and pedophiles.	RED
1471	Survivor's guilt.	RED
1472	The mere concept of Applebees.&reg;	RED
1473	Boris the Soviet Love Hammer.	RED
1474	Not having sex.	RED
1475	Indescribably loneliness.	RED
1476	One thousand Slim Jims.	RED
1477	A nuanced critique.	RED
1478	A nautical theme.	RED
1479	The black Power Ranger.	RED
1480	Neil Patrick Harris.	RED
1481	Bill Clinton, naked on a bearskin rug with a saxophone.	RED
1482	The hose.	RED
1483	Finding Waldo.	RED
1484	Fuck Mountain.	RED
1485	Unlimited soup, salad, and breadsticks.	RED
1486	Syphilitic insanity.	RED
1487	Oncoming traffic.	RED
1488	Suicide bombers.	RED
1489	Some kind of bird-man.	RED
1490	Ryan Goslin riding in on a white horse.	RED
1491	Living in a trash can.	RED
1492	Historical revisionism.	RED
1493	A passionate Latino lover.	RED
1494	Roland the Farter, flatulist to the king.	RED
1495	Consent.	RED
1496	An unhinged Ferris wheel rolling toward the sea.	RED
1497	A plunger to the face.	RED
1498	Shaft.	RED
1499	Big Bird's crown, crusty asshole.	RED
1500	Filling every orifice with butterscotch pudding.	RED
1501	A fortuitous turnip harvest.	RED
1502	Buying the right pants to be cool.	RED
1503	Getting hilariously gang-banged by the Blue Man Group.	RED
1504	A phantasmagoria of anal delights.	RED
1505	The new Radiohead album.	RED
1506	24-hour media coverage.	RED
1507	Gargling jizz.	RED
1508	A dollop of sour cream.	RED
1509	Demonic possession.	RED
1510	Chugging a lava lamp.	RED
1511	Jeff Goldblum.	RED
1512	The day the birds attacked.	RED
1513	Subduing a grizzly bear and making her your wife.	RED
1514	A sofa that says "I have style, but I like to be comfortable."	RED
1515	Dorito breath.	RED
1516	The way white people is.	RED
1517	Fetal alcohol syndrome.	RED
1518	The Quesadilla Explosion Salad&trade; from Chili's.&reg;	RED
1519	Racial profiling.	RED
1520	Special musical guest, Cher.	RED
1521	A crappy little hand.	RED
1522	The systemic destruction of an entire people and their way of life.	RED
1523	Clenched butt cheeks.	RED
1524	Filing my son with spaghetti.	RED
1525	Blowing some dudes in an alley.	RED
1526	Words, words, words.	RED
1527	Clams.	RED
1528	Hot doooooooogs!	RED
1529	Andr&eacute; the Giant's enormous, leathery scrotum.	RED
1530	A greased-up Matthew McConaughey.	RED
1531	A pile of squirming bodies.	RED
1532	A bloody pacifier.	RED
1533	Medieval Times&reg; Dinner &amp; Tournament.	RED
1534	Just the tip.	RED
1535	One ring to rule them all.	RED
1536	The milk that comes out of a person.	RED
1537	A sweet spaceship.	RED
1538	Big ol' floppy titties.	RED
1539	A 55-gallon drum of lube.	RED
1540	Sorcery.	RED
1541	Getting your dick stuck in a Chinese finger trap with another dick.	RED
1542	Weapons grade plutonium.	RED
1543	Mad hacky-sack skills.	RED
1544	Emotional baggage.	RED
1545	Insatiable bloodlust.	RED
1546	Hillary Clinton.	RED
1547	Catastrophic urethral trauma.	RED
1548	Putting an entire peanut butter and jelly sandwich into the VCR.	RED
1549	Crying into the pages of Sylvia Plath.	RED
1550	A spontaneous conga line.	RED
1551	A Japanese tourist who wants something very badly but cannot communicate it.	RED
1552	A boo-boo.	RED
1553	A black-owned and operated business.	RED
1554	The moist, demanding chasm of his mouth.	RED
1555	Velcro.&trade;	RED
1556	The shambling corpse of Larry King.	RED
1557	Drinking my bro's pee-pee right out of his peen.	RED
1558	Quiche.	RED
1559	Some really fucked up shit.	RED
1560	Warm, velvety muppet sex.	RED
1561	The primal, ball-slapping sex your parents are having right now.	RED
1562	A bigger, blacker dick.	RED
1563	Crabapples all over the fucking sidewalk.	RED
1564	Bosnian chick farmers.	RED
1565	Sanding off a man's nose.	RED
1566	The harsh light of day.	RED
1567	Vietnam flashbacks.	RED
1568	Savagely beating a mascot.	RED
1569	Staring at a painting and going "hmmmmmm..."	RED
1570	Nubile slave boys.	RED
1571	Drinking ten 5-hour ENERGYs&reg; to get fifty continuous hours of energy.	RED
1572	A sweaty, panting leather daddy.	RED
1573	My manservant, Claude.	RED
1574	Khakis.	BLUE
1575	Bathing in moonsblood and dancing around the ancient oak.	BLUE
1576	The passage of time.	BLUE
1577	A one-way ticket to Gary, Indiana.	BLUE
1578	The power of the Dark Side.	BLUE
1579	A team of lawyers.	BLUE
1580	Getting eaten alive by Guy Fieri.	BLUE
1581	Figuring out how to have sex with a dolphin.	BLUE
1582	Some sort of Asian.	BLUE
1583	Vegetarian options.	BLUE
1584	An inability to form meaningful relationships.	BLUE
1585	One unforgettable night of passion.	BLUE
1586	Important news about Taylor Swift.	BLUE
1587	The all-new Nissan Pathfinder with 0.9% APR financing!	BLUE
1588	Free ice cream, yo.	BLUE
1589	My boyfriend's stupid penis.	BLUE
1590	A mouthful of potato salad.	BLUE
1591	Our new Buffalo Chicken Dippers&reg;!	BLUE
1592	Crying and shitting and eat spaghetti.	BLUE
1593	A fart.	BLUE
1594	Actual mutants with medical conditions and no superpowers.	BLUE
1595	Deez nuts.	BLUE
1596	Africa.	BLUE
1597	Finally finishing off the Indians.	BLUE
1598	Owls, the perfect predator.	BLUE
1599	A dance move that's just sex.	BLUE
1600	Ass to mouth.	BLUE
1601	Bouncing up and down.	BLUE
1602	Walking into a glass door.	BLUE
1603	Eating together like a god damn family for once.	BLUE
1604	No longer finding any Cards Against Humanity card funny.	BLUE
1605	Treasures beyond your wildest dreams.	BLUE
1606	Ejaculating live bees and the bees are angry.	BLUE
1607	Sucking all the milk out of a yak.	BLUE
1608	Falling into the toilet.	BLUE
1609	The color "puce."	BLUE
1610	An oppressed people with a vibrant culture.	BLUE
1611	Out-of-this-world bazongas.	BLUE
1612	Getting caught by the police and going to jail.	BLUE
1613	The sweet song of sword against sword and the braying of mighty war beasts.	BLUE
1614	A sex goblin with a carnival penis.	BLUE
1615	Genghis Khan's DNA.	BLUE
1616	A gender identity that can only be conveyed through slam poetry.	BLUE
1617	The ghost of Marlon Brando.	BLUE
1618	Immortality cream.	BLUE
1619	Butt stuff.	BLUE
1620	Getting offended.	BLUE
1621	My dad's dumb fucking face.	BLUE
1622	A bunch of idiots playing a card game instead of interacting like normal humans.	BLUE
1623	Neil Diamond's Greatest Hits.	BLUE
1624	Whatever a McRib&reg; is made of.	BLUE
1625	Total fucking chaos.	BLUE
1626	Whispering all sexy.	BLUE
1627	Calculating every mannerism so as not to suggest homosexuality.	BLUE
1628	Some shit-hot guitar licks.	BLUE
1629	No clothes on, penis in vagina.	BLUE
1630	Sports.	BLUE
1631	How awesome I am.	BLUE
1632	The white half of Barack Obama.	BLUE
1633	An overwhelming variety of cheeses.	BLUE
1634	Ejaculating inside another man's wife.	BLUE
1635	Getting shot by the police.	BLUE
1636	Beloved television star Bill Cosby.	BLUE
1637	The tiger that killed my father.	BLUE
1638	Changing a person's mind with logic and facts.	BLUE
1639	Child Protective Services.	BLUE
1640	A peyote-fueled vision quest.	BLUE
1641	Cute boys.	BLUE
1642	A hopeless amount of spiders.	BLUE
1643	The swim team, all at once.	BLUE
1644	Whatever you wish, mother.	BLUE
1645	A possible Muslim.	BLUE
1646	All the single ladies.	BLUE
1647	Letting out 20 years' worth of farts.	BLUE
1648	Being paralyzed from the neck down.	BLUE
1649	The eight gay warlocks who dictate the rules of fashion.	BLUE
1650	Shapes and colors.	BLUE
1651	Seeing my village burned and my family slaughtered before my eyes.	BLUE
1652	Filling a man's anus with concrete.	BLUE
1653	Peeing into a girl's butt to make a baby.	BLUE
1654	Meaningless sex.	BLUE
1655	Wearing glasses and sounding smart.	BLUE
1656	Setting my balls on fire and cartwheeling to Ohio.	BLUE
1657	Child support payments.	BLUE
1658	Being John Malkovich.	BLUE
1659	Throwing stones at a man until he dies.	BLUE
1660	A shiny rock that proves I love you.	BLUE
1661	Kale.	BLUE
1662	Stuffing a child's face with Fun Dip&reg; until he starts having fun.	BLUE
1663	A turd.	BLUE
1664	Party Mexicans.	BLUE
1665	Too much cocaine.	BLUE
1666	Like a million alligators.	BLUE
1667	Grammar nazis who are also regular Nazis.	BLUE
1668	A face full of horse cum.	BLUE
1669	Fresh dill from the patio.	BLUE
1670	Boring vaginal sex.	BLUE
1671	Crazy opium eyes.	BLUE
1672	AIDS monkeys.	BLUE
1673	Crippling social anxiety.	BLUE
1674	Not believing in giraffes.	BLUE
1675	An interracial handshake.	BLUE
1676	Irrefutable evidence that God is real.	BLUE
1677	A zero-risk way to make $2,000 from home.	BLUE
1678	My sex dungeon.	BLUE
1679	Being nine years old.	BLUE
1680	Daddy.	BLUE
1681	Unquestioning obedience.	BLUE
1682	A bass drop so huge it tears the starry vault asunder to reveal the face of God.	BLUE
1683	Sharks with legs.	BLUE
1684	Generally having no idea what's going on.	BLUE
1685	Bullets.	BLUE
1686	An unforgettable quincea&ntilde;era.	BLUE
1687	Two whales fucking the shit out of each other.	BLUE
1688	A whole lotta woman.	BLUE
1689	A self-microwaving burrito.	BLUE
1690	Snorting coke off a clown's boner.	BLUE
1691	A buttload of candy.	BLUE
1692	A thrilling chase over the rooftops of Rio de Janeiro.	BLUE
1693	Dem titties.	BLUE
1694	The amount of gay I am.	BLUE
1695	My first period.	BLUE
1696	Common-sense gun control legislation.	BLUE
1697	Being a terrible mother.	BLUE
1698	Being popular and good at sports.	BLUE
1699	Never having sex again.	BLUE
1700	A giant powdery manbaby.	BLUE
1701	A crazy little thing called love.	BLUE
1702	Stupid.	BLUE
1703	The best taquito in the galaxy.	BLUE
1704	Fucking a corpse back to life.	BLUE
1705	A pizza guy who fucked up.	BLUE
1706	Ennui.	BLUE
1707	Injecting speed into one arm and horse tranquilizer into the other.	BLUE
1708	Lots and lots of abortions.	BLUE
1709	Eggs.	BLUE
1710	My worthless son.	BLUE
1711	Blowjobs for everyone.	BLUE
1824	Critical thinking.	GREEN
1712	Shitting all over the floor like a bad, bad girl.	BLUE
1713	An uninterrupted history of imperialism and exploitation.	BLUE
1714	The unbelievable world of mushrooms.	BLUE
1715	A horse with no legs.	BLUE
1716	Having been dead for a while.	BLUE
1717	Drinking responsibly.	BLUE
1718	Breastfeeding a ten-year-old.	BLUE
1719	Going to a high school reunion on ketamine.	BLUE
1720	Backwards knees.	BLUE
1721	Gwyneth Paltrow's opinions.	BLUE
1722	The basic suffering that pervades all of existence.	BLUE
1723	Cutting off a flamingo's legs with garden shears.	BLUE
1724	The secret formula for ultimate female satisfaction.	BLUE
1725	Seeing things from Hitler's perspective.	BLUE
1726	A constant need for validation.	BLUE
1727	Jizz.	BLUE
1728	What Jesus would do.	BLUE
1729	A Ugandan warlord.	BLUE
1730	Slowly easing down onto a cucumber.	BLUE
1731	Smoking crack, for instance.	BLUE
1732	A kiss on the lips.	BLUE
1733	The haunting stare of an Iraqi child.	BLUE
1734	A sex comet from Neptune that plunges the Earth into eternal sexiness.	BLUE
1735	Giant sperm from outer space.	BLUE
1736	The euphoric rush of strangling a drifter.	BLUE
1737	Morpheus.	BLUE
1738	Mom's new boyfriend.	BLUE
1739	Blackface.	BLUE
1740	Every ounce of charisma left in Mick Jagger's tired body.	BLUE
1741	Sudden penis loss.	BLUE
1742	Daddy's credit card.	BLUE
1743	Ripping a dog in half.	BLUE
1744	Angelheaded hipsters burning for the ancient heavenly connection to the starry dynamo in the machinery of the night.	BLUE
1745	Interspecies marriage.	BLUE
1746	Cancer.	BLUE
1747	The male gaze.	BLUE
1748	Being worshipped as the one true God.	BLUE
1749	All these decorative pillows.	BLUE
1750	Unrelenting genital punishment.	BLUE
1751	Exploding pigeons.	BLUE
1752	A disappointing salad.	BLUE
1753	The dentist.	BLUE
1754	Moderate-to-severe joint pain.	BLUE
1755	Getting drive-by shot.	BLUE
1756	The black half of Barack Obama.	BLUE
1757	Western standards of beauty.	BLUE
1758	A reason not to commit suicide.	BLUE
1759	40 acres and a mule.	BLUE
1760	Such a big boy.	BLUE
1761	10 Incredible Facts About the Anus.	BLUE
1762	A manhole.	BLUE
1763	The size of my penis.	BLUE
1764	The complex geopolitical quagmire that is the Middle East.	BLUE
1765	My dead son's baseball glove.	BLUE
1766	Robots who just want to party.	BLUE
1767	A whole new kind of porn.	BLUE
1768	Ambiguous sarcasm.	BLUE
1769	Russian super-tuberculosis.	BLUE
1770	Prince Ali, fabulous he, Ali Ababwa.	BLUE
1771	Doing the right stuff to her nipples.	BLUE
1772	Ancient Athenian boy-fucking.	BLUE
1773	The eighth graders.	BLUE
1774	September 11th, 2001.	BLUE
1775	The safe word.	BLUE
1776	Doo-doo.	BLUE
1777	Blackula.	BLUE
1778	Anal fissures like you wouldn't believe.	BLUE
1779	Texas.	BLUE
1780	Going down on a woman, discovering that her vaginas is filled with eyeballs, and being totally into that.	BLUE
1781	P.F. Chang himself.	BLUE
1782	Almost giving money to a homeless person.	BLUE
1783	Depression.	BLUE
1784	Growing up chained to a radiator in perpetual darkness.	BLUE
1785	Three consecutive seconds of happiness.	BLUE
1786	Going inside at some point because of the mosquitoes.	BLUE
1787	Pussy.	BLUE
1788	Unsheathing my massive horse cock.	BLUE
1789	A woman.	BLUE
1790	Turning the rivers red with the blood of infidels.	BLUE
1791	A woman who is so cool that he rides on a motorcycle.	BLUE
1792	The peaceful and nonthreatening rise of China.	BLUE
1793	A chimpanzee in sunglasses fucking your wife.	BLUE
1794	Finding a nice elevator to poop in.	GREEN
1795	An incurable homosexual.	GREEN
1796	The body of a 46-year-old man.	GREEN
1797	Mixing M&amp;Ms and Skittles like some kind of psychopath.	GREEN
1798	Grunting for ten minutes and then peeing sand.	GREEN
1799	Gay thoughts.	GREEN
1800	When the big truck goes "Toot! Toot!"	GREEN
1801	Water.	GREEN
1802	Becoming the President of the United States.	GREEN
1803	Hot lettuce.	GREEN
1804	Rock-hard tits and a huge vagina.	GREEN
1805	Meatloaf, the man.	GREEN
1806	Smashing my balls at the moment of climax.	GREEN
1807	A creature made of penises that must constantly arouse itself to survive.	GREEN
1808	My brother's hot friends.	GREEN
1809	You.	GREEN
1810	Getting high with mom.	GREEN
1811	Twisting my cock and balls into a balloon poodle.	GREEN
1812	Loud, scary thunder.	GREEN
1813	Whomsoever let the dogs out.	GREEN
1814	Having a vagina.	GREEN
1815	A man with the head of a goat and the body of a goat.	GREEN
1816	Taking the form of a falcon.	GREEN
1817	A hug.	GREEN
1818	Putting more black people in jail.	GREEN
1819	Trevor, the world's greatest boyfriend.	GREEN
1820	Anal.	GREEN
1821	Just now finding out about the Armenian Genocide.	GREEN
1822	Getting the Dorito crumbs out of my pubes.	GREEN
1823	A man in a suit with perfect hair who tells you beautiful lies.	GREEN
1825	Quacking like a duck in lieu of a cogent argument.	GREEN
1826	A long business meeting with no obvious purpose.	GREEN
1827	Facilitating dialogue and deconstructing binaries.	GREEN
1828	Getting killed and dragged up a tree by a leopard.	GREEN
1829	Brunch.	GREEN
1830	Child labor.	GREEN
1831	Esmeralda, my most beautiful daughter.	GREEN
1832	The feeling of going to McDonald's as a 6-year-old.	GREEN
1833	Eating people.	GREEN
1834	Art.	GREEN
1835	Having sex with your mom.	GREEN
1836	The hottest MILF in Dallas.	GREEN
1837	Getting trapped in a conversation about Ayn Rand.	GREEN
1838	Happy daddies with happy sandals.	GREEN
1839	A dolphin that learns to talk and becomes the Dead of Harvard Law School.	GREEN
1840	The graceful path of an autumn leaf as it falls to its earthen cradle.	GREEN
1841	Meatloaf, the food.	GREEN
1842	10,000 shrieking teenage girls.	GREEN
1843	Chris Hemsworth.	GREEN
1844	Straight blazin' 24/7.	GREEN
1845	Objectifying women.	GREEN
1846	The mysterious fog rolling into town.	GREEN
1847	Math.	GREEN
1848	Restoring Germany to its former glory.	GREEN
1849	Exploring each other's buttholes.	GREEN
1850	An old dog full of tumors.	GREEN
1851	Antidepressants.	GREEN
1852	Having an awesome time drinking and driving.	GREEN
1853	Jazz.	GREEN
1854	Dumpster juice.	GREEN
1855	Raising three kids on minimum wage.	GREEN
1856	Going to bed at a reasonable hour.	GREEN
1857	10 football players with erections barreling towards you at full speed.	GREEN
1858	Working so hard to have muscles and then having them.	GREEN
1859	Turning 32.	GREEN
1860	Albert Einstein but if he had a huge muscles and a rhinoceros cock.	GREEN
1861	Assassinating the president.	GREEN
1862	A woman's right to choose.	GREEN
1863	Eternal screaming madness.	GREEN
1864	Late-stage dementia.	GREEN
1865	Consensual, nonreproductive incest.	GREEN
1866	Swearing praise upon the Sultan's hideous daughters.	GREEN
1867	A cheerfulness that belies a deep-seated self-loathing.	GREEN
1868	An arrangement wherein I give a person money they have sex with me.	GREEN
1869	A genetic predisposition for alcoholism.	GREEN
1870	The wind.	GREEN
1871	Getting pegged.	GREEN
1872	Period poops.	GREEN
1873	The chicken from Popeyes. &reg;	GREEN
1874	A massive collection of child pornography.	GREEN
1875	A big, beautiful mouth packed to the brim with sparkling teeth.	GREEN
1876	Pooping in the potty.	GREEN
1877	Getting eaten out by a dog.	GREEN
1878	Munchin' puss.	GREEN
1879	It being too late to stop having sex with a horse.	GREEN
1880	One of those "blow jobs" I've been hearing so much about.	GREEN
1881	The lived experience of African Americans.	GREEN
1882	Prematurely ejaculating like a total loser.	GREEN
1883	Big, smart money boys tap-tapping on their keyboards.	GREEN
1884	Homework.	GREEN
1885	A finger up the butt.	GREEN
1886	Tiny, rancid girl farts.	GREEN
1887	The sweet, forbidden meat of the money.	GREEN
1888	Farting all over my face with your tight little asshole.	GREEN
1889	Doing a somersault and barfing.	GREEN
1890	The government.	GREEN
1891	How good lead paint taste.	GREEN
1892	Every man's ultimate fantasy: a perfectly cylindrical vagina.	GREEN
1893	Rubbing my bush all over your bald head.	GREEN
1894	Feeling the emotion of anger.	GREEN
1895	Gregor, my largest son.	GREEN
1896	A strong horse and enough rations for thirty days.	GREEN
1897	Getting aborted.	GREEN
1898	Systems and policies designed to preserve centuries-old power structures.	GREEN
1899	Overthrowing the democratically-elected government of Chile.	GREEN
1900	A weird guy who says weird stuff and weirds me out.	GREEN
1901	How strange it is to be anything at all.	GREEN
1902	Twenty cheerleaders laughing at your tiny penis.	GREEN
1903	Everything.	GREEN
1904	The flaming wreckage of the International Space Station.	GREEN
1905	A duffel bag full of lizards.	GREEN
1906	Beyonc&eacute;.	GREEN
1907	The fear and hatred in men's hearts.	GREEN
1908	One of them big-city Jew lawyers.	GREEN
1909	An empowered woman.	GREEN
1910	Tables.	GREEN
1911	The amount of baby carrots I can fit up my ass.	GREEN
1912	Farting a huge shit out of my pussy.	GREEN
1913	Being sexually attracted to children.	GREEN
1914	Participating.	GREEN
1915	Blossoming into a beautiful young woman.	GREEN
1916	Discovering that what I really want in life is to kill people and have sex with their corpses.	GREEN
1917	Breastfeeding in public like a radiant earth goddess.	GREEN
1918	ISIS.	GREEN
1919	All these people I've killed.	GREEN
1920	The full force of the American military.	GREEN
1921	Eating ass.	GREEN
1922	Who really did 9/11.	GREEN
1923	Condoleezza Rice.	GREEN
1924	Content.	GREEN
1925	Creamy slices of real, California avocado.	GREEN
1926	How sad it will be when Morgan Freeman dies.	GREEN
1927	A black friend.	GREEN
1928	Whooping your ass at Mario Kart.	GREEN
1929	Sudden and unwanted slam poetry.	GREEN
1930	A cold and indifferent universe.	GREEN
2041	<i>Pure Moods</i> , Vol. 1.	90s
1931	The best, deepest quotes from The Dark Night.	GREEN
1932	Salsa Night at Dave's Cantina.	GREEN
1933	Dominating a man by peeing on his eldest son.	GREEN
1934	Two shitty kids and a garbage husband.	GREEN
1935	The Rwandan Genocide.	GREEN
1936	The LGBT community.	GREEN
1937	Founding a major world religion.	GREEN
1938	Rolling so hard.	GREEN
1939	My huge penis and substantial fortune.	GREEN
1940	Forty-five minutes of finger blasting.	GREEN
1941	How great my ass looks in these jeans.	GREEN
1942	Pooping in a leotard and hoping no one notices.	GREEN
1943	Guns.	GREEN
1944	Getting this party started!	GREEN
1945	Twenty bucks.	GREEN
1946	Getting laid like all the time.	GREEN
1947	A big ol' plate of fettuccine alfredo.	GREEN
1948	Showing all the boys my pussy.	GREEN
1949	Fucking me good and taking me to Red Lobster.&reg;	GREEN
1950	A terrified fat child who won't come out of the bushes.	GREEN
1951	Doritos and a Fruit Roll-Up.	GREEN
1952	Mommy and daddy fighting all the time.	GREEN
1953	Holding the proper political beliefs of my time to attract a mate.	GREEN
1954	Onions.	GREEN
1955	Self-identifying as a DJ.	GREEN
1956	Watching you die.	GREEN
1957	Some real spicy shrimps.	GREEN
1958	A burrito that's just sour cream.	GREEN
1959	The bond between a woman and her horse.	GREEN
1960	The secret to truly resilient hair.	GREEN
1961	Mental illness.	GREEN
1962	Gayle from HR.	GREEN
1963	Informing you that I am a registered sex offender.	GREEN
1964	A negative body image that is totally justified.	GREEN
1965	Political correctness.	GREEN
1966	The clown that followed me home from the grocery store.	GREEN
1967	That bitch, Stacy.	GREEN
1968	Ejaculating at the apex of a cartwheel.	GREEN
1969	Gazpacho.	GREEN
1970	Having sex with a man and then eating his head.	GREEN
1971	An older man.	GREEN
1972	An X-Man whose power is that he has sex with dogs and children.	GREEN
1973	Out-of-control teenage blowjob parties.	GREEN
1974	Tender chunks of all-white-meat chicken.	GREEN
1975	Crushing the patriarchy.	GREEN
1976	The full blown marginalization of ugly people.	GREEN
1977	Aborting the shit out of a fetus.	GREEN
1978	Film roles for actresses over 40.	GREEN
1979	Plowing that ass like a New England corn farmer.	GREEN
1980	Huge big balls full of jizz.	GREEN
1981	Some of that good dick.	GREEN
1982	Being turned into sausages.	GREEN
1983	Hating Jews.	GREEN
1984	Crazy anal orgasms.	GREEN
1985	Regurgitating a half-digested sparrow.	GREEN
1986	The ol' penis-in-the-popcorn surprise.	GREEN
1987	A tiny fireman who puts out tiny fires.	GREEN
1988	Dis bitch.	GREEN
1989	Trees.	GREEN
1990	Three hours of nonstop penetration.	GREEN
1991	Slamming a dunk.	GREEN
1992	Starting a shitty podcast.	GREEN
1993	Gary.	GREEN
1994	Feminism.	GREEN
1995	Our baby.	GREEN
1996	Falling into a pit of waffles.	GREEN
1997	A woman's perspective.	GREEN
1998	Chipotle.	GREEN
1999	Scissoring, if that's a thing.	GREEN
2000	Watching a hot person eat.	GREEN
2001	Defeating a gorilla in single combat.	GREEN
2002	Bad emotions I don't want.	GREEN
2003	A creepy child singing a nursery rhyme.	GREEN
2004	Comprehensive immigration reform.	GREEN
2005	Denying the Holocaust.	GREEN
2006	Two beautiful pig sisters.	GREEN
2007	Catching a live salmon in your mouth.	GREEN
2008	Daddy going away forever.	GREEN
2009	A medium horchata.	GREEN
2010	Libertarians.	GREEN
2011	Picking up a glass of water and taking a sip and being the president.	GREEN
2012	Waking up inside of a tornado.	GREEN
2013	Making out and stuff.	GREEN
2014	A slowly encroaching circle of wolves.	GREEN
2015	Opening your mouth to talk and a big penis fops out.	GREEN
2016	Eating too many Cinnabons and then vomiting and then eating the vomit.	GREEN
2017	Seizing control of the means of production.	GREEN
2018	Misogyny.	GREEN
2019	Thinking about what eating even is.	GREEN
2020	Dropping dead in a Sbarro's bathroom and not being found for 72 hours.	GREEN
2021	Sucking each other's penises for hours on end.	GREEN
2022	Awesome pictures of planets and stuff.	GREEN
2023	Microaggressions.	GREEN
2024	Pretending to be one of the guys but actually being the spider god.	GREEN
2025	Fucking my therapist.	GREEN
2026	Having sex with a beautiful person.	GREEN
2027	Moon people.	GREEN
2028	Jason, the teen mayor.	GREEN
2029	Quinoa.	GREEN
2030	China.	GREEN
2031	Menopause.	GREEN
2032	My dog dying.	GREEN
2033	A gun that shoots cobras.	GREEN
2034	Reaching an age where barbecue chips are better than sex.	GREEN
2035	Going around pulling people's tampons out.	GREEN
2036	Playing my asshole like a trumpet.	GREEN
2037	Getting blasted in the face by a t-shirt cannon.	GREEN
2038	Getting naked too soon.	GREEN
2039	Pamela Anderson's boobs running in slow motion.	90s
2040	A bus that will explode if it goes under 50 miles per hour.	90s
2042	Jerking off to a 10-second RealMedia clip.	90s
2043	Pizza in the morning, pizza in the evening, pizza at supper time.	90s
2044	Stabbing the shit out of a Capri Sun.	90s
2045	Angels interfering in an otherwise fair baseball game.	90s
2046	Sucking the President's dick.	90s
2047	Sunny D! Alright!	90s
2048	The Great Cornholio.	90s
2049	Painting with all the colors of the wind.	90s
2050	Cool 90s up-in-the-front hair.	90s
2051	The Y2K bug.	90s
2052	A mulatto, an albino, a mosquito, and my libido.	90s
2053	Liking big butts and not being able to lie about it.	90s
2054	Deregulating the mortgage market.	90s
2055	Kurt Cobain's death.	90s
2056	A threesome with 1996 Denise Richards and 1999 Denise Richards.	90s
2057	Freeing Willy.	90s
2058	Several Michael Keatons.	90s
2059	Patti Mayonnaise.	90s
2060	Wearing Nicolas Cage's face.	90s
2061	Log.&trade;	90s
2062	Santa's heavy sack.	❄2012
2063	Donald Trump holding his nose while he eats pussy.	V4HIL
2064	Black lives mattering.	V4HIL
2065	Kicking the middle class in the balls with a regressive tax code.	V4HIL
2066	Slapping Ted Cruz over and over.	V4HIL
2067	Eating the president's pussy.	V4HIL
2068	Keeping the government out of my vagina.	V4HIL
2069	The fact that Hillary Clinton is a woman.	V4HIL
2070	Increasing economic inequality and political polarization.	V4HIL
2071	The Bernie Sanders revolution.	V4HIL
2072	A beautiful, ever-expanding circle of inclusivity that will never include Republicans.	V4HIL
2073	Letting Bernie Sanders rest his world-weary head on your lap.	V4HIL
2074	The systemic disenfranchisement of black voters.	V4HIL
2075	Eating an entire snowman.	❄2013
2076	A Christmas stocking full of coleslaw.	❄2013
2077	Elf cum.	❄2013
2078	Giving money and personal information to strangers on the Internet.	❄2013
2079	The royal afterbirth.	❄2013
2080	A magical tablet containing a world of unlimited pornography.	❄2013
2081	A toxic family environment.	❄2013
2082	Breeding elves for their priceless semen.	❄2013
2083	Clearing a bloody path through Walmart with a scimitar.	❄2013
2084	Slicing a ham in icy silence.	❄2013
2085	A simultaneous nightmare and wet dream starring Sigourney Weaver.	❄2013
2086	A visually arresting turtleneck.	❄2013
2087	The shittier, Jewish version of Christmas.	❄2013
2088	Gift-wrapping a live hamster.	❄2013
2089	Moses gargling Jesus's balls while Shiva and the Buddha penetrate his divine hand holes.	❄2013
2090	Socks.	❄2013
2091	These low, low prices!	❄2013
2092	Finding out that Santa isn't real.	❄2013
2093	The tiny, calloused hands of the Chinese children that made this card.	❄2013
2094	The Star Wars Holiday Special.	❄2013
2095	Rudolph's bright red balls.	❄2013
2096	Jizzing into Santa's beard.	❄2013
2097	Being blind and deaf and having no limbs.	❄2013
2098	My hot cousin.	❄2013
2099	Mall Santa.	❄2013
2100	The Hawaiian goddess Kapo and her flying detachable vagina.	❄2013
2101	Taking down Santa with a surface-to-air missile.	❄2013
2102	Pretending to be happy.	❄2013
2103	Fucking up "Silent Night" in front of 300 parents.	❄2013
2104	Krampus, the Austrian Christmas monster.	❄2013
2105	Several intertwining love stories featuring Hugh Grant.	❄2013
2106	Space Jam on VHS.	❄2013
2107	Swapping bodies with mom for a day.	❄2013
2108	Another shitty year.	❄2013
2109	Immaculate conception.	❄2013
2110	People with cake in their mouths talking about how good cake is.	❄2013
2111	Piece of shit Christmas cards with no money in them.	❄2013
2112	Congress's flaccid penises withering away beneath their suit pants.	❄2013
2113	Having a strong opinion about Obamacare.	❄2013
2114	Whatever Kwanzaa is supposed to be about.	❄2013
2115	A Hungry-Man&trade; Frozen Christmas Dinner for One.	❄2013
2116	Making up for 10 years of shitty parenting with a PlayStation.	❄2013
2117	The Grinch's musty, cum-stained pelt.	❄2013
2118	Actually voting for Donald Trump to be President of the actual United States.	V4 45
2119	Growing up and becoming a Republican.	V4 45
2120	A liberal bias.	V4 45
2121	Full-on socialism.	V4 45
2122	Hating Hillary Clinton.	V4 45
2123	Jeb!	V4 45
2124	Conservative talking points.	V4 45
2125	Courageously going ahead with that racist comment.	V4 45
2126	The good, hardworking people of Dubuque, Iowa.	V4 45
2127	Dispelling with this fiction that Barack Obama doesn't know what he's doing.	V4 45
2128	Shouting the loudest.	V4 45
2129	Sound fiscal policy.	V4 45
2130	Boxing up my feelings.	BOX
2132	An alternate universe in which boxes store things inside of people.	BOX
2133	Being a motherfucking box.	BOX
2134	The Boxcar Children.	BOX
2135	A box that is conscious and wishes it weren't a box.	BOX
2136	A box within a box.	BOX
2137	A man-shaped box.	BOX
2138	A world without boxes.	BOX
2139	A box of biscuits, a box of mixed biscuits, and a biscuit mixer.	BOX
2140	Former President George W. Box.	BOX
2141	A box without hinges, key, or lid, yet golden treasure inside is hid.	BOX
2142	A box-shaped man.	BOX
2143	The J15 Patriot Assault Box.	BOX
2342	Temporary invincibility.	13PAX
2144	A falcon with a box on its head.	BOX
2145	Two midgets shitting into a box.	BOX
2146	An outbreak of smallbox.	BOX
2147	Something that looks like a box but turns out to be a crate.	BOX
2148	Pandora's vagina.	BOX
2149	A boxing match with a giant box.	BOX
2150	A box.	BOX
2151	Eight beautiful men jerking each other off in front of a fountain.	HIDDN
2153	Ruth Bader Ginsberg brutally gaveling your penis.	HIDDN
2154	A blind, quadriplegic AIDS survivor with face cancer and diarrhea.	HIDDN
2155	Free ice cream forever, or getting fingered by Chris Hemsworth for five minutes.	HIDDN
2156	Digging up Heath Ledger's corpse to reenact the prom scene from Ten Things I Hate About You.	HIDDN
2157	Throwing your hands in the air and waving them despite caring deeply.	HIDDN
2158	Chugging a gallon of milk and then vomiting a gallon of milk.	HIDDN
2159	How wonderful it is when my master throws the ball and I go and get it for him.	HIDDN
2160	Giving ISIS whatever they want so they leave us alone.	HIDDN
2161	Throwing a baby dolphin back into the ocean with a perfect spiral.	HIDDN
2162	Sitting in a jar of vinegar all night because I am pickle.	HIDDN
2163	Hickory-fucked pork ribs smothered in hot garbage.	HIDDN
2164	A homoerotic subplot.	HCARD
2165	The sensitive European photographer who's fucking my wife.	HCARD
2166	An origami swan that's some kind of symbol?	HCARD
2167	Carbon monoxide poisoning.	HCARD
2168	A childless marriage.	HCARD
2169	Ribs so good they transcend race and class.	HCARD
2170	25 shitty jokes about <i>House of Cards.</i>	HCARD
2171	Making it look like a suicide.	HCARD
2172	Forcing a handjob on a dying man.	HCARD
2173	Getting eaten out while on the phone with Dad.	HCARD
2174	My constituents.	HCARD
2175	Strangling a dog to make a point to the audience.	HCARD
2176	Discharging a firearm in a residential area.	HCARD
2177	Performative wokeness.	COLEG
2178	The sound of my roommate masturbating.	COLEG
2179	Rocking a 1.5 GPA.	COLEG
2180	Pretending to have done the reading.	COLEG
2181	Throw up.	COLEG
2182	Uggs, leggings, and a North Face.	COLEG
2183	Valuable leadership experience.	COLEG
2184	Whichever one of you took a shit in the shower.	COLEG
2185	Fucking the beat boxer from the a cappella group.	COLEG
2186	Five morons signing a lease together.	COLEG
2187	Googling how to eat pussy.	COLEG
2188	Sucking a flaccid penis for 20 minutes.	COLEG
2189	My high school boyfriend.	COLEG
2190	A bachelor's degree in communications.	COLEG
2191	Calling mom because it's just really hard and I miss her and I don't know anyone here.	COLEG
2192	Wandering the streets in search of a party.	COLEG
2193	Underage drinking.	COLEG
2194	Young Republicans.	COLEG
2195	A Yale man.	COLEG
2196	An emergency all-floor meeting of inclusion.	COLEG
2197	Going to college and becoming a new person, who has sex.	COLEG
2198	How many Asians there are.	COLEG
2199	A girl who is so interesting that she has blue hair.	COLEG
2200	Falling in love with poetry.	COLEG
2201	Being replaced by a robot.	❄2014
2202	The events depicted in James Cameron's <i>Avatar.</i>	❄2014
2203	Blockbuster late fees up the wazoo.	❄2014
2204	All the poop inside of my body.	❄2014
2205	A protracted siege.	❄2014
2206	The diminishing purity of the white race.	❄2014
2207	Trying to feel something, anything.	❄2014
2208	A cloud of ash that darkens the Earth for a thousand years.	❄2014
2209	A vague fear of something called ISIS.	❄2014
2210	200 years of slavery.	❄2014
2211	The transience of all things.	❄2014
2212	Ebola.	❄2014
2213	Small-town cops with M4 assault rifles.	❄2014
2214	Rising sea levels consistent with scientific predictions.	❄2014
2215	What remains of my penis.	❄2014
2216	Harnessing the miraculous power of the atom to slaughter 200,000 Japanese people.	❄2014
2217	This groovy new thing called LSD.	❄2014
2218	Building a ladder of hot dogs to the moon.	❄2014
2219	Rock music and premarital sex.	❄2014
2220	The Great Lizard Uprising of 2352.	❄2014
2221	The dying breath of the last human.	❄2014
2222	Reading an entire book.	❄2014
2223	The 9,000 children who starved to death today.	❄2014
2224	The Bowflex Revolution.	❄2014
2225	Falling in actual love with a video game character.	MSFX
2226	My complicated backstory that you will soon learn about.	MSFX
2227	The Genophage.	MSFX
2228	Totally fuckable aliens.	MSFX
2229	Running a few errands before saving the galaxy.	MSFX
2230	Bone-shattering sex with a metal woman.	MSFX
2231	Space racism.	MSFX
2232	An emergency induction port.	MSFX
2233	An armored Krogan war-clitoris.	MSFX
2234	An extremely long elevator ride.	MSFX
2235	Forgetting to convert pound-seconds into newton-seconds.	NASA
2236	Uranus.	NASA
2237	A zero-g cumshot.	NASA
2238	Seven minutes of terror.	NASA
2239	A slow, shitty car that drives around Mars for no reason.	NASA
2240	Discovering some bullshit microscopic life instead of anything cool.	NASA
2241	Achieving escape velocity.	NASA
2242	Dreaming of going to space, but being hopelessly fat.	NASA
2243	Dinosaurs who wear armor and you ride them and they kick ass.	FNTSY
2343	Full HD.	13PAX
2244	Accidentally conjuring a legless horse that can't stop ejaculating.	FNTSY
2245	Shitting in a wizard's spell book and jizzing in his hat.	FNTSY
2246	A Hitachi Magic Wand.	FNTSY
2247	Reading <i>The Hobbit</i> under the covers while mom and dad scream at each other downstairs.	FNTSY
2248	How hot Orlando Bloom was in <i>Lord of the Rings.</i>	FNTSY
2249	A mysterious, floating orb.	FNTSY
2250	Shooting a wizard with a gun.	FNTSY
2251	Hodor.	FNTSY
2252	Make-believe stories for autistic white men.	FNTSY
2253	A magical kingdom with dragons and elves and no black people.	FNTSY
2254	The card Neil Gaiman wrote: "Three elves at a time."	FNTSY
2255	Gender equality.	FNTSY
2256	Going on an epic adventure and learning a valuable lesson about friendship.	FNTSY
2257	True love's kiss.	FNTSY
2258	Eternal darkness.	FNTSY
2259	The all-seeing Eye of Sauron.	FNTSY
2260	Bathing naked in a moonlit grove.	FNTSY
2261	Handcuffing a wizard to a radiator and dousing him with kerosene.	FNTSY
2262	Kneeing a wizard in the balls.	FNTSY
2263	A ghoul.	FNTSY
2264	A weed elemental who gets everyone high.	FNTSY
2265	A gay sorcerer who turns everyone gay.	FNTSY
2266	A CGI dragon.	FNTSY
2267	Freaky, pan-dimensional sex with a demigod.	FNTSY
2268	A dwarf who won't leave you alone until you compare penis sizes.	FNTSY
2269	How many drinks Aunt Deborah has had.	❄
2270	A snowman that contains the soul of my dead father.	❄
2271	A choir of angels descending from the sky and jizzing all over dad's sweater.	❄
2272	Probably Grandma's last Christmas, kids.	❄
2273	A frozen homeless man shattering on your doorstep.	❄
2274	Snow falling gently on the frozen body of an orphan boy.	❄
2275	My uncle who voted for Trump.	❄
2276	How great of a blowjob Jesus could give.	❄
2277	Starting to see where ISIS is coming from.	❄
2278	Fucking up <i>Silent Night</i> in front of 300 parents.	❄
2279	How cool it is that I love Jesus and he loves me back.	❄
2280	An immediately regrettable $9 hot dog from the Boston Convention Center.	PE13A
2281	Paying the iron price.	PE13A
2282	Casting Magic Missile at a bully.	PE13A
2283	Rotating shapes in mid-air so that they fit into other shapes when they fall.	PE13A
2284	Firefly: Season 2.	PE13A
2285	Jiggle physics.	PE13A
2286	Getting bitch slapped by Dhalsim.	PE13A
2287	Running out of stamina.	PE13A
2288	Sharpening a foam broadsword on a foam whetstone.	PE13B
2289	The depression that ensues after catching 'em all.	PE13B
2290	Loading from a previous save.	PE13B
2291	The rocket launcher.	PE13B
2292	Getting inside the Horadric Cube with a hot babe and pressing the transmute button.	PE13B
2293	Spending the year's insulin budget on Warhammer 40k figurines.	PE13B
2294	Punching a tree to gather wood.	PE13B
2295	Violating the First Law of Robotics.	PE13B
2296	Charging up all the way.	PE13C
2297	Vespene gas.	PE13C
2298	Wil Wheaton crashing an actual spaceship.	PE13C
2299	The Klobb.	PE13C
2300	Achieving 500 actions per minute.	PE13C
2301	Smashing all the pottery in a Pottery Barn in search of rupees.	PE13C
2302	Forgetting to eat, and consequently dying.	PE13C
2303	Judging elves by the color of their skin and not by the content of their character.	PE13C
2304	Kevin Bacon Bits.	FOOD
2305	Being emotionally and physically dominated by Gordon Ramsay.	FOOD
2306	A belly full of hard-boiled eggs.	FOOD
2307	Kale farts.	FOOD
2308	Clamping down on a gazelle's jugular and tasting its warm life waters.	FOOD
2309	A table for one at The Cheesecake Factory.	FOOD
2310	The hot dog I put in my vagina ten days ago.	FOOD
2311	The Dial-A-Slice Apple Divider from Williams-Sonoma.	FOOD
2312	Oreos for dinner.	FOOD
2313	A joyless vegan patty.	FOOD
2314	Soup that's better than pussy.	FOOD
2315	The Hellman's Mayonnaise Corporation.	FOOD
2316	Going vegetarian and feeling so great all the time.	FOOD
2317	Not knowing what to believe anymore about butter.	FOOD
2318	A sobering quantity of chili cheese fries.	FOOD
2319	Licking the cake batter off of grandma's fingers.	FOOD
2320	Real cheese flavor.	FOOD
2321	Swishing the wine around and sniffing it like a big fancy man.	FOOD
2322	Sucking down thousands of pounds of krill every day.	FOOD
2323	The inaudible screams of carrots.	FOOD
2324	Committing suicide at the Old Country Buffet.	FOOD
2325	What to do with all of this chocolate on my penis.	FOOD
2326	Father's forbidden chocolates.	FOOD
2327	Jizz Twinkies.	FOOD
2328	Tapping Serra Angel.	13PAX
2329	The gravity gun.	13PAX
2330	Never watching, discussing, or thinking about My Little Pony.	13PAX
2331	Reading the comments.	13PAX
2332	The Sarlacc.	13PAX
2333	Unlocking a new sex position.	13PAX
2334	Being an attractive elf trapped in an unattractive human's body.	13PAX
2335	Bowser's aching heart.	13PAX
2336	Charles Barkley Shut Up and Jam!	13PAX
2337	70,000 games sweating and farting inside an airtight steel dome.	13PAX
2338	The collective wail of every <i>Magic</i> player suddenly realizing that they've spent hundreds of dollars on pieces of cardboard.	13PAX
2339	Legendary Creature -- Robert Khoo.	13PAX
2340	Allowing nacho cheese to curdle in your beard while you creep in League of Legends.	13PAX
2341	Winning the approval of Cooking Mama that you never got from actual mama.	13PAX
2344	The boner hatch in the Iron Man suit.	13PAX
2345	Buying virtual clothes for a Sim family instead of real clothes for a real family.	13PAX
2346	An angry stone head that stomps on the floor every three seconds.	13PAX
2347	Offering sexual favors for an ore and a sheep.	13PAX
2348	Turn-of-the-century-sky racists.	13PAX
2349	Getting into a situation with an owlbear.	13PAX
2350	Grand Theft Auto: Fort Lauderdale.	13PAX
2351	Achieving the manual dexterity and tactical brilliance of a 12-year-old Korean boy.	13PAX
2352	The decade of legal inquests following a single hour of Grand Theft Auto.	13PAX
2353	SNES cartridge cleaning fluid.	13PAX
2354	Eating a pizza that's lying in the street to gain health.	13PAX
2355	Mario Kart rage.	13PAX
2356	A homemade, cum-stained <i>Star Trek</i> uniform.	13PAX
2357	Google Glass + e-cigarette: Ultimate Combo!	13PAX
2358	Yoshi's huge egg-laying cloaca.	13PAX
2359	A fully-dressed female videogame character.	13PAX
2360	Nude-modding Super Mario World.	13PAX
2361	A madman who lives in a policebox and kidnaps women.	13PAX
2362	Filling every pouch of a UtiliKilt&trade; with pizza.	13PAX
2363	The Cock Ring of Alacrity.	13PAX
2364	Rolling a D20 to save a failing marriage.	13PAX
2365	Getting bitten by a radioactive spider and then battling leukemia for 30 years.	GEEK
2366	Separate drinking fountains for dark elves.	GEEK
2367	Stuffing my balls into a Sega Genesis and pressing the power button.	GEEK
2368	Ser Jorah Mormont's cerulean-blue balls.	GEEK
2369	A grumpy old Harrison Ford who'd rather be doing anything else.	GEEK
2370	Taking 2d6 emotional damage.	GEEK
2371	KHAAAAAAAAAN!	GEEK
2372	Endless ninjas.	GEEK
2373	Demons and shit.	14PAX
2375	Collecting all seven power crystals.	14PAX
2376	Xena, Warrior Princess.	14PAX
2377	The old gods.	14PAX
2378	The Star Wars Universe.	14PAX
2379	The imagination of Peter Jackson.	14PAX
2380	Lagging out.	14PAX
2381	All of the good times and premium gaming entertainment available to you in the Kickstarter room.	14PAX
2382	Attacking from Kamchatka.	14PAX
2383	The pure, Zen-like state that exists between micro and macro.	14PAX
2384	Mistakenly hitting on a <i>League of Legends</i> statue.	14PAX
2385	A giant mechanical bird with a tragic backstory.	14PAX
2386	Whatever <i>Final Fantasy</i> bullshit happened this year.	14PAX
2387	Futuristic death sports.	14PAX
2388	Resurrecting an army of six million Jews and conquering Germany.	JEW
2389	The part of Anne Frank's diary where she talks about her vagina.	JEW
2390	Sacrificing Isaac to the Lord.	JEW
2391	The ethical implications of enjoying a Woody Allen film in light of the allegations against him.	JEW
2392	Chopping off a bit of the penis.	JEW
2393	Some kind of concentrated encampment for people.	JEW
2394	Pork products.	JEW
2395	Wandering the desert for 40 years.	JEW
2396	What it means to be a Jewish woman in contemporary society.	JEW
2397	Suddenly remembering that the Holocaust happened.	JEW
2398	Thy neighbor's wife.	JEW
2399	Holding up the line at Walgreens by trying to use an expired coupon.	JEW
2400	Demolishing that ass like a Palestinian village.	JEW
2401	Being chosen by God to win a free iPod Nano.	JEW
2402	A little bit of schmutz right there.	JEW
2403	Torturing Jews until they say they're not Jews anymore.	JEW
2404	A lifetime of internalized guilt.	JEW
2405	A three-foot-tall corned beef sandwich.	JEW
2406	Usury.	JEW
2407	Hiding from the Nazis.	JEW
2408	Bags of money.	JEW
2409	The blood of Christian babies.	JEW
2410	A headache that's definitely cancer.	JEW
2411	A big brain full of facts and sadness.	JEW
2412	Whoopi Goldberg.	JEW
2413	Whipping lower-class white men into a xenophobic frenzy.	PST45
2414	Extra rations for my little girl.	PST45
2415	Roaming through a wasteland of windblown trash and deserted highways.	PST45
2416	Drinking urine to survive.	PST45
2417	A legitimate reason to commit suicide.	PST45
2418	Burying my only son.	PST45
2419	Desperately hurling insults at Donald Trump as he absorbs them into his rapidly expanding body.	PST45
2420	Trying to remember what music was.	PST45
2421	Casual dismissiveness.	PST45
2422	Finding out that democracy might not be such a great idea.	PST45
2423	A father and son fighting each other over the last scrap of bread.	PST45
2424	Mild amusement.	PST45
2425	A back-alley abortion from a Mexican cyborg doctor.	PST45
2426	Rage.	PST45
2427	World Wards 3 through 5.	PST45
2428	President Donald Trump.	PST45
2429	Making Islam illegal.	PST45
2430	Trying to wake up from this nightmare.	PST45
2431	The purging of the disloyal.	PST45
2432	Nuclear winter.	PST45
2433	Bringing millions of dangerous, low-paying manufacturing jobs back to America.	PST45
2434	A gnawing sense of dread.	PST45
2435	Period globs.	.
2436	Always&reg; Infinity Extra Heavy Overnight Pads with Wings.	.
2437	Wringing out a sopping wet maxi pad in Donald Trump's mouth.	.
2438	Playing with my pussy while I watch TV.	.
2439	An emotionally draining friendship.	.
2440	Post-partum depression.	.
2441	Full bush.	.
2442	Drinking Beyonce's DivaCup and becoming immortal.	.
2443	Feeling lots of feelings.	.
2444	Carrying a fetus to term.	.
2445	Eating three sleeves of Chips Ahoy!	.
2446	Destroying a pair of underwear.	.
2447	Masturbating with a Sonicare.	.
2448	How bloody that dick's about to be.	.
2449	The vagina hole.	.
2450	Dancing carefree in white linen pants.	.
2451	Pussy lips of all shapes and sizes.	.
2452	Using a Smucker's Uncrustable&trade; as a maxi pad.	.
2453	Pulling out a never-ending tampon.	.
2454	Catching a whiff of my vag.	.
2455	A diverse group of female friends casually discussing the side effects of birth control.	.
2456	A woman president.	.
2457	Driving my daughter to her abortion.	.
2458	Feeling bloaty and crampy.	.
2459	Caribbean Jesus.	RJECT
2460	Corn.	RJECT
2461	Super yoga.	RJECT
2462	A sexy naked interactive theater thing.	RJECT
2463	Actually believing that the Bible happened.	RJECT
2464	A giant squid in a wedding gown.	RJECT
2465	A heart that is two sizes too small and that therefore cannot pump an adequate amount of blood.	RJECT
2466	Ejaculating a pound of tinsel.	RJECT
2467	Crawling into a vagina.	RJECT
2468	Faking a jellyfish sting so someone will pee on you.	RJECT
2469	My dick in your mouth.	RJECT
2470	Asshole pomegranates that are hard to eat.	RJECT
2471	The John D. and Catherine T. MacArthur Foundation.	RJECT
2472	Dividing by zero.	RJECT
2473	Becoming so rich that you shed your body and turn into vapor.	RJECT
2474	Playing an ocarina to summon Ultra-Congress from the sea.	RJECT
2475	Feeding a man a pie made of his own children.	RTAIL
2476	Ironically buying a trucker hat and then ironically being a trucker for 38 years.	RTAIL
2477	A teenage boy gunning for a handjob.	RTAIL
2478	Going too far with science and bad things happening.	SCIFI
2479	Frantically writing equations on a chalkboard.	SCIFI
2480	An alternate history where Hitler was gay but he still killed all those people.	SCIFI
2481	A hazmat suit full of farts.	SCIFI
2482	That girl from the Hungry Games.	SCIFI
2483	Funkified aliens from the planet Groovius.	SCIFI
2484	The ending of <i>Lost.</i>	SCIFI
2485	Vulcan sex-madness.	SCIFI
2486	Three boobs.	SCIFI
2487	A misty room full of glistening egg sacs.	SCIFI
2488	Cheerful blowjob robots.	SCIFI
2489	How great of a movie <i>Men in Black</i> was.	SCIFI
2490	A planet-devouring space worm named Rachel.	SCIFI
2491	Beep beep boop beep boop.	SCIFI
2492	Nine seasons of sexual tension with David Duchovny.	SCIFI
2493	Darmok and Jalad at Tanagra.	SCIFI
2494	A protagonist with no qualities.	SCIFI
2495	The dystopia we're living in right now.	SCIFI
2496	Cosmic bowling.	SCIFI
2497	Masturbating Yoda's leathery turtle-penis.	SCIFI
2498	Laying thousands of eggs in a man's colon.	SCIFI
2499	Trimming poop out of Chewbacca's butt hair.	SCIFI
2500	Sandwich.	RJCT2
2501	At least three ducks.	RJCT2
2502	Mushy tushy.	RJCT2
2503	Saving the Rainforest Cafe.	RJCT2
2504	Becoming engorged with social justice jelly and secreting a thinkpiece.	RJCT2
2505	That one leftover screw.	RJCT2
2506	Greg Kinnear's terrible lightning breath.	RJCT2
2507	Sir Thomas More's Fruitopia.&trade;	RJCT2
2508	Mr. and Mrs. Tambourine Man's jingle-jangle morning sex.	RJCT2
2509	The spooky skeleton under my skin.	RJCT2
2510	A double murder suicide barbeque.	RJCT2
2511	Sweating it out on the streets of a runaway American Dream.	RJCT2
2512	Disco Mussolini.	RJCT2
2513	That thing politicians do with their thumbs when they talk.	RJCT2
2514	These dolphins.	RJCT2
2515	A dick so big and so black that not even light can escape its pull.	RJCT2
2516	Being the absolute worst.	RJCT2
2517	A primordial soup and salad bar.	RJCT2
2518	Three hairs from the silver-golden head of Galadriel.	RJCT2
2519	A stack of bunnies in a trenchcoat.	RJCT2
2520	Mitt Romney's eight sons Kip, Sam, Trot, Fergis, Toolshed, Grisham, Hawkeye, and Thorp.	RJCT2
2521	Ringo Starr &amp; His All-Starr Band.	RJCT2
2522	The token lesbian.	RJCT2
2523	Water so cold it turned into a rock.	RJCT2
2524	Being knowledgeable in a narrow domain that nobody understands or cares about.	SCI
2525	A supermassive black hole.	SCI
2526	A 0.7 waist-to-hip ratio.	SCI
2527	The quiet majesty of the sea turtle.	SCI
2528	Photosynthesis.	SCI
2529	Getting really worried about global warming for a few seconds.	SCI
2530	Infinity.	SCI
2531	Reconciling quantum theory with general relativity.	SCI
2532	Driving into a tornado to learn about tornadoes.	SCI
2533	Explosive decompression.	SCI
2534	Oxytocin release via manual stimulation of the nipples.	SCI
2535	Developing secondary sex characteristics.	SCI
2536	David Attenborough watching us mate.	SCI
2537	Achieving reproductive success.	SCI
2538	Electroejaculating a capuchin monkey.	SCI
2539	Insufficient serotonin.	SCI
2540	Slowly evaporating.	SCI
2541	Failing the Turing test.	SCI
2542	Evolving a labyrinthe vagina.	SCI
2543	Fun and interesting facts about rocks.	SCI
2544	The Sun engulfing the Earth.	SCI
2545	3.7 billion years of evolution.	SCI
2546	A Pringles&reg; can full of screams.	RTPRD
2547	A framed photocopy of an oil painting of Paris, France.	RTPRD
2548	Buying the right toothbrush cup for my lifestyle.	RTPRD
2549	Shiny gadgets for sadness distraction.	RTPRD
2550	Saving 20% or more on khakis.	RTPRD
2551	How fun it is to eat Pringles&reg;.	RTPRD
2552	Refusing to go up a size.	RTPRD
2553	An exclusive partnership with Taylor Swift.	RTPRD
2554	An 800-foot-long pool noodle.	RTPRD
2555	Confusing possessions with accomplishments.	RTPRD
2556	Blood Pringles&reg;.	RTPRD
2557	Crunchy snacks for my big flappy mouth.	RTPRD
2558	A Pringle&reg;.	RTPRD
2559	Subsisting on tiny pizzas.	RTPRD
2560	Extracting the maximum amount of money from naive consumers.	RTPRD
2561	The obscene amount of money Cards Against Humanity is making by selling this game at Target.&reg;	RTPRD
2562	Gender-neutral toys that make children feel no emotions whatsoever.	RTPRD
2563	Getting eaten out in the family fitting room.	RTPRD
2564	Buying and returning clothes just to have someone to talk to.	RTPRD
2565	A marriage-destroying game of <i>The Resistance</i> .	TBLTP
2566	SIX GOD DAMN HOURS OF FUCKING DIPLOMACY.	TBLTP
2567	Condensing centuries of economic exploitation into 90 minutes of gaming fun.	TBLTP
2568	Spending 8 years in the Himalayas becoming a master of dice-rolling and resource allocation.	TBLTP
2569	A disappointing season of Tabletop that's just about tables.	TBLTP
2570	A zombie with a tragic backstory.	TBLTP
2571	A Wesley Crusher blow-up doll.	TBLTP
2572	The porn set that Tabletop is filmed on.	TBLTP
2573	An owlbear.	TBLTP
2574	The pooping position.	TBLTP
2575	A German-style board game where you invade Poland.	TBLTP
2576	Victory points.	TBLTP
2577	How bright the sun is.	WEED
2578	Grinning like an idiot.	WEED
2579	Smoking a blunt butt-ass naked.	WEED
2580	Forgetting to breathe and then dying.	WEED
2581	Dank ass cancer weed.	WEED
2582	Snoop Dogg.	WEED
2583	A whole cheese pizza just for me.	WEED
2584	Dicking around on the guitar for an hour.	WEED
2585	Cheesy crunchies.	WEED
2586	Whatever the fuck I was just talking about.	WEED
2587	Ancient aliens.	WEED
2588	Huge popcorn nugs of hairy alien weed.	WEED
2589	Too much edibles.	WEED
2590	An eight-foot man smoking a six-foot bong.	WEED
2591	Unbelievably soft carpet.	WEED
2592	Dropping stuff and knocking everything over.	WEED
2593	My own fingers.	WEED
2594	The banks, the media, the entire system, man.	WEED
2595	A sandwich with Cheetos in it!	WEED
2596	A bong rip so massive it restores justice to the kingdom.	WEED
2597	Being too high for airplane.	WEED
2598	Hot tub.	WEED
2599	Eating all the skin off a rotisserie chicken.	WEED
2600	Smoking a joint with former President Barack Obama.	WEED
2601	Getting high and watching <i>Planet Earth.</i>	WEED
2602	A fun, sexy time at the nude beach.	WWW
2603	A complete inability to understand anyone else's perspective.	WWW
2604	Three years of semen in a shoebox.	WWW
2605	A respectful discussion of race and gender on the Internet.	WWW
2606	Taking a shit while running at full speed.	WWW
2607	A night of Taco Bell and anal sex.	WWW
2608	Googling.	WWW
2609	Smash Mouth.	WWW
2610	A man from Craigslist.	WWW
2611	My browser history.	WWW
2612	Getting teabagged by a fifth grader in <i>Call of Duty.</i>	WWW
2613	My privileged white penis.	WWW
2614	Internet porn analysis paralysis.	WWW
2615	YouTube comments.	WWW
2616	Pretending to be black.	WWW
2617	That thing on the Internet everyone's talking about.	WWW
2618	Goats screaming like people.	WWW
2619	Destroying Dick Cheney's last horcrux.	WWW
2620	Game of Thrones spoilers.	WWW
2621	Cat massage.	WWW
2622	Matching with Mom on Tinder.	WWW
\.


--
-- TOC entry 2202 (class 0 OID 0)
-- Dependencies: 190
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: pyx
--

SELECT pg_catalog.setval('hibernate_sequence', 2622, true);


--
-- TOC entry 2059 (class 2606 OID 17741)
-- Name: black_cards black_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: pyx
--

ALTER TABLE ONLY black_cards
    ADD CONSTRAINT black_cards_pkey PRIMARY KEY (id);


--
-- TOC entry 2063 (class 2606 OID 17754)
-- Name: card_set_black_card card_set_black_card_pkey; Type: CONSTRAINT; Schema: public; Owner: pyx
--

ALTER TABLE ONLY card_set_black_card
    ADD CONSTRAINT card_set_black_card_pkey PRIMARY KEY (card_set_id, black_card_id);


--
-- TOC entry 2061 (class 2606 OID 17749)
-- Name: card_set card_set_pkey; Type: CONSTRAINT; Schema: public; Owner: pyx
--

ALTER TABLE ONLY card_set
    ADD CONSTRAINT card_set_pkey PRIMARY KEY (id);


--
-- TOC entry 2065 (class 2606 OID 17759)
-- Name: card_set_white_card card_set_white_card_pkey; Type: CONSTRAINT; Schema: public; Owner: pyx
--

ALTER TABLE ONLY card_set_white_card
    ADD CONSTRAINT card_set_white_card_pkey PRIMARY KEY (card_set_id, white_card_id);


--
-- TOC entry 2067 (class 2606 OID 17767)
-- Name: white_cards white_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: pyx
--

ALTER TABLE ONLY white_cards
    ADD CONSTRAINT white_cards_pkey PRIMARY KEY (id);


--
-- TOC entry 2069 (class 2606 OID 17773)
-- Name: card_set_black_card fk513da45c3166b76a; Type: FK CONSTRAINT; Schema: public; Owner: pyx
--

ALTER TABLE ONLY card_set_black_card
    ADD CONSTRAINT fk513da45c3166b76a FOREIGN KEY (black_card_id) REFERENCES black_cards(id);


--
-- TOC entry 2068 (class 2606 OID 17768)
-- Name: card_set_black_card fk513da45c985dacea; Type: FK CONSTRAINT; Schema: public; Owner: pyx
--

ALTER TABLE ONLY card_set_black_card
    ADD CONSTRAINT fk513da45c985dacea FOREIGN KEY (card_set_id) REFERENCES card_set(id);


--
-- TOC entry 2071 (class 2606 OID 17783)
-- Name: card_set_white_card fkc248727257c340be; Type: FK CONSTRAINT; Schema: public; Owner: pyx
--

ALTER TABLE ONLY card_set_white_card
    ADD CONSTRAINT fkc248727257c340be FOREIGN KEY (white_card_id) REFERENCES white_cards(id);


--
-- TOC entry 2070 (class 2606 OID 17778)
-- Name: card_set_white_card fkc2487272985dacea; Type: FK CONSTRAINT; Schema: public; Owner: pyx
--

ALTER TABLE ONLY card_set_white_card
    ADD CONSTRAINT fkc2487272985dacea FOREIGN KEY (card_set_id) REFERENCES card_set(id);


-- Completed on 2018-02-27 15:12:09

--
-- PostgreSQL database dump complete
--

