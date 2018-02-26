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

-- Started on 2018-02-25 13:58:24

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
-- TOC entry 185 (class 1259 OID 17423)
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
-- TOC entry 186 (class 1259 OID 17431)
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
-- TOC entry 187 (class 1259 OID 17439)
-- Name: card_set_black_card; Type: TABLE; Schema: public; Owner: pyx
--

CREATE TABLE card_set_black_card (
    card_set_id integer NOT NULL,
    black_card_id integer NOT NULL
);


ALTER TABLE card_set_black_card OWNER TO pyx;

--
-- TOC entry 188 (class 1259 OID 17444)
-- Name: card_set_white_card; Type: TABLE; Schema: public; Owner: pyx
--

CREATE TABLE card_set_white_card (
    card_set_id integer NOT NULL,
    white_card_id integer NOT NULL
);


ALTER TABLE card_set_white_card OWNER TO pyx;

--
-- TOC entry 190 (class 1259 OID 17477)
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
-- TOC entry 189 (class 1259 OID 17449)
-- Name: white_cards; Type: TABLE; Schema: public; Owner: pyx
--

CREATE TABLE white_cards (
    id integer NOT NULL,
    text character varying(255),
    watermark character varying(255)
);


ALTER TABLE white_cards OWNER TO pyx;

--
-- TOC entry 2189 (class 0 OID 17423)
-- Dependencies: 185
-- Data for Name: black_cards; Type: TABLE DATA; Schema: public; Owner: pyx
--

COPY black_cards (id, draw, pick, text, watermark) FROM stdin;
1	0	1	In the new DLC for Mass Effect, Shepard must save the galaxy from ____.	13PAX
3	0	1	The most controversial game at PAX this year is an 8-bit indie platformer about ____.	13PAX
4	0	1	____: Achievement unlocked.	13PAX
5	0	1	There was a riot at the Gearbox panel when they gave the attendees ____.	13PAX
6	0	1	What's the latest bullshit that's troubling this quaint fantasy town?	13PAX
7	0	1	What made Spock cry?	13PAX
8	0	1	No Enforcer wants to manage the panel on ____.	13PAX
9	0	1	Behold the Four Horsemen of the Apocalypse! War, Famine, Death, and ____.	❄2014
11	0	1	Honey, Mommy and Daddy love you very much.But apparently Mommy loves ____ more than she loves Daddy.	❄2014
12	0	2	A curse upon thee! Many years from now, just when you think you're safe, ____ shall turn into ____.	❄2014
13	0	1	Dear Mom and Dad, Camp is fun. I like capture the flag. Yesterday, one of the older kids taught me about ____. I love you, Casey	❄2014
14	0	2	Today on Buzzfeed: 10 Pictures of ____ That Look Like ____!	❄2014
15	0	1	Why am I so tired?	❄2014
16	0	1	I'm just gonna stay in tonight. You know, Netflix and ____.	WWW
18	0	1	What did I nickname my genitals?	WWW
19	0	1	This app is basically Tinder, but for ____.	WWW
20	0	1	You guys, you can buy ____ on the dark web.	WWW
21	0	1	Don't worry, Penny! Go Go Gadget ____!	WWW
22	0	1	TRIGGER WARNING: ____.	WWW
23	0	2	I need you like ____ needs ____.	WWW
24	0	2	Such ____. Very ____. Wow.	WWW
25	0	1	Nothing says "I love you" like ____.	WWW
26	0	1	Jesus is ____.	❄
28	0	1	Blessed are you, Lord our God, creator of the universe, who has granted us ____.	❄
29	0	1	This holiday season, Tim Allen must overcome his fear of ____ to save Christmas.	❄
30	0	1	Donna, pick up my dry cleaning and get my wife something for christmas. I think she likes ____.	❄
31	0	1	It's beginning to look a lot like ____.	❄
32	0	2	Here's what you can expect for the new year. Out: ____. In: ____.	❄
33	0	1	What's the one thing that makes an elf instantly ejaculate?	❄
34	0	1	Press &darr;&darr;&larr;&rarr;B to unleash ____.	PE13C
36	0	1	I don't know exactly how I got the PAX plague, but I suspect it had something to do with ____.	PE13C
37	0	1	I'm no doctor, but I'm pretty sure what you're suffering from is called "____."	AU
39	0	1	50% of all marriages end in ____.	AU
40	0	1	This is the way the world ends This is the way the world ends Not with a bang but with ____.	AU
41	0	1	After four platinum albums and three Grammys, it's time to get back to my roots, to what inspired me to make music in the first place: ____.	AU
42	0	1	When Pharaoh remained unmoved, Moses called down a Plague of ____.	AU
43	0	1	Oi! Show us ____!	AU
44	0	1	It's a pity that kids these days are all getting involved with ____.	AU
45	0	1	What's a girl's best friend?	AU
46	0	1	____. High five, bro.	AU
47	0	2	Step 1: ____. Step 2: ____. Step 3: Profit.	AU
48	0	1	Make a haiku.	AU
49	0	1	What did I bring back from Bali?	AU
50	0	1	If you can't be with the one you love, love ____.	AU
51	0	1	MTV's new reality show features eight washed-up celebrities living with ____.	AU
52	0	1	Daddy, why is mummy crying?	AU
53	0	1	&#x2605;&#x2606;&#x2606;&#x2606;&#x2606; Do NOT go here! Found ____ in my Mongolian chicken!	AU
54	0	1	I'm LeBron James, and when I'm not slamming dunks, I love ____.	AU
55	0	1	Uh, hey guys, I know this was my idea, but I'm having serious doubts about ____.	AU
56	0	1	Alternative medicine is now embracing the curative powers of ____.	AU
57	0	1	What broke up the original Wiggles?	AU
58	0	2	I never truly understood ____ until I encountered ____.	AU
59	0	1	I drink to forget ____.	AU
60	0	1	Hey Reddit! I'm ____. Ask me anything.	AU
61	0	2	That's right, I killed ____. How, you ask? ____.	AU
62	0	1	How did I lose my virginity?	AU
63	0	1	I'm going on a cleanse this week. Nothing but kale juice and ____.	AU
64	0	1	____. That was so metal.	AU
65	0	1	I got 99 problems but ____ ain't one.	AU
66	0	1	Why can't I sleep at night?	AU
67	0	1	Here is church Here is the steeple Open the doors And there is ____.	AU
68	0	1	This season at the Sydney Opera House, Samuel Beckett's classic existential play: <i>Waiting for ____.</i>	AU
69	0	1	Crikey! I've never seen ____ like this before! Let's get a bit closer.	AU
70	0	1	Click Here for ____!!!	AU
71	0	1	What made my first kiss so awkward?	AU
72	0	1	Just once I'd like to hear you say "Thanks, Mum. Thanks for ____."	AU
73	0	1	What never fails to liven up the party?	AU
74	0	1	Kids, I don't need drugs to get high. I'm high on ____.	AU
75	0	2	When I was tripping on acid, ____ turned into ____.	AU
76	2	3	____+____=____.	AU
77	0	1	____. Betcha can't have just one!	AU
78	0	1	What's there a tonne of in heaven?	AU
79	0	1	Just saw this upsetting video! Please retweet!! #stop ____	AU
80	0	1	What makes me a true blue Aussie?	AU
81	0	1	Instead of coal, Santa now gives the bad children ____.	AU
82	0	1	Maybe she's born with it. Maybe it's ____.	AU
83	0	1	What would grandma find disturbing, yet oddly charming?	AU
84	0	1	What's that sound?	AU
85	0	1	Next from J.K. Rowling: <i>Harry Potter and the Chamber of ____. </i>	AU
86	0	1	The school excursion was completely ruined by ____.	AU
87	0	2	Introducing the amazing superhero/sidekick duo! It's ____ and ____!	AU
88	0	1	How am I maintaining my relationship status?	AU
89	0	1	As the mum of five rambunctious boys, I'm not stranger to ____.	AU
90	0	1	What is Batman's guilty pleasure?	AU
91	0	2	They said we were crazy. They said we couldn't put ____ inside of ____. They were wrong.	AU
92	0	1	Channel 9 is pleased to present its new variety show, "Hey Hey It's ____."	AU
93	0	1	What will always get you laid?	AU
94	0	1	What ended my last relationship?	AU
95	0	1	Old MacDonald has ____. E-I-E-I-O.	AU
96	0	1	Qantas now prohibits ____ on airplanes.	AU
97	0	1	Why do I hurt all over?	AU
98	0	1	War! What is it good for?	AU
99	0	2	In M. Night Shyamalan's new movie, Bruce Willis discovers that ____ had really been ____ all along.	AU
100	0	1	Military historians remember Alexander the Great for his brilliant use of ____ against the Persians.	AU
101	0	2	ABC presents "____: the Story of ____."	AU
102	0	1	A romantic, candlelit dinner would be incomplete without ____.	AU
103	0	1	Next on Nine's Wide World of Sports: The World Series of ____.	AU
104	0	1	Coming to Broadway this season, ____: The Musical.	AU
105	0	1	Are you thinking what I'm thinking, B1? I think I am, B2: it's ____ time!	AU
106	0	1	____? Yeah, nah.	AU
107	0	1	Check me out, yo! I call this dance move "____."	AU
108	0	2	And the Academy Award for ____ goes to ____.	AU
109	0	1	Today on <i>Jerry Springer: </i>"Help! My son is ____!"	AU
110	0	1	Fun tip! When your man asks you to go down on him, try surprising him with ____ instead.	AU
111	0	1	A recent laboratory study shows that undergraduates have 50% less sex after being exposed to: ____.	AU
112	0	1	White people like ____.	AU
113	0	1	____: kid-tested, mother-approved.	AU
114	0	1	Life for Aboriginal people was forever changed when the white man introduced them to ____.	AU
115	0	1	Hey guys, welcome to Sizzler! Would you like to start the night off right with ____?	AU
116	0	1	What gives me uncontrollable gas?	AU
117	0	2	____ is a slippery slope that leads to ____.	AU
118	0	1	What is George W. Bush thinking about right now?	AU
119	0	1	In the new Disney Channel Original Movie, Hannah Montana struggles with ____ for the first time.	AU
120	0	1	Brought to you by XXXX Gold, the Official Beer of ____.	AU
121	0	2	For my next trick, I will pull ____ out of ____.	AU
122	0	1	What's that smell?	AU
123	0	1	____. It's a trap!	AU
124	0	1	Well if you'll excuse me, gentlemen, I have a date with ____.	AU
125	0	1	Why am I sticky?	AU
126	0	1	I'm sorry, Sir, but I couldn't complete my homework because of ____.	AU
127	0	1	Mate, <i>do not</i> go in that toilet. There's ____ in there.	AU
128	0	1	What makes life worth living?	AU
129	0	1	But before I kill you, Mr. Bond, I must show you.	AU
130	0	1	What's my secret power?	AU
131	0	1	In Australia, ____ is twice as big and twice as deadly.	AU
132	0	1	What are my parents hiding from me?	AU
133	0	1	When I am a billionaire, I shall erect a 20-metre statue to commemorate ____.	AU
134	0	1	During sex, I like to think about ____.	AU
135	0	1	Mr. and Mrs. Diaz, we called you in because we're concerned about Cynthia. Are you aware that your daughter is ____?	AU
136	0	1	I get by with a little help from ____.	AU
137	0	1	When I am Prime Minister, I will create the Department of ____.	AU
138	0	1	Why did the chicken cross the road?	RJCT2
140	0	1	Some men aren't looking for anything logical, like money. They can't be bought, bullied, reasoned, or negotiated with. Some men just want ____.	RJCT2
141	0	1	America is hungry. America needs ____.	RJCT2
142	0	1	In bourgeois society, capital is independent and has individuality, while the living person is ____.	RJCT2
143	0	1	Housekeeping! You want ____?	RJCT2
144	0	1	BowWOW! is the first pet hotel in LA that offers ____ for dogs.	RJCT2
145	0	1	Astronomers have discovered that the universe consists of 5% ordinary matter, 25% dark matter, and 70% ____.	RJCT2
146	0	1	Hey, whatever happened to Renee Zellweger?	RJCT2
147	0	1	What's wrong with these gorillas?	RJCT2
148	0	1	You say tomato, I say ____.	RJCT2
149	0	1	You have been waylaid by ____ and must defend yourself.	PE13A
151	0	1	I have an idea even better than Kickstarter, and it's called ____starter.	PE13A
152	0	1	Curiosity was put into safe mode after its hazcams detected ____.	NASA
154	0	1	NASA will spend 15 billion dollars on an unprecedented mission: ____ in space.	NASA
155	0	1	In the final round of this year's Omegathon, Omeganauts must face off in a game of ____.	PE13B
157	0	1	Action stations! Action stations! Set condition one throughout the fleet and brace for ____!	PE13B
158	0	1	Airport security guidelines now prohibit ____ on airplanes.	UK
160	0	1	What's there a ton of in heaven?	UK
161	0	1	____? Jim'll fix it!	UK
162	0	1	What did I bring back from Amsterdam?	UK
163	0	1	____. Once you pop, the fun don't stop!	UK
164	0	1	When I am Prime Minister of the United Kingdom, I will create the Ministry of ____.	UK
165	0	1	Mate, <i>do not go </i>in that bathroom. There's ____ in there.	UK
166	0	1	Instead of coal, Father Christmas now gives the bad children ____.	UK
167	0	1	UKIP: Putting ____ First!	UK
168	0	1	Life for American Indians was forever changed when the White Man introduced them to ____.	UK
169	0	2	And the BAFTA for ____ goes to____.	UK
170	0	1	TFL apologizes for the delay in train service due to ____.	UK
171	0	1	A romantic, candlelit dinner would be incomplete without  ____.	UK
172	0	1	Nobody expects the Spanish Inquisition. Our chief weapons are fear, surprise, and ____.	UK
173	0	1	The school trip was completely ruined by ____.	UK
174	0	1	Next on Sky Sports: The World Champion of ____..	UK
175	0	1	What's the next Happy Meal&reg; toy?	UK
176	0	1	The theme for next year's Eurovision Song Contest is "We are ____."	UK
177	0	1	Next up on Channel 4: Ramsay's ____ Nightmares.	UK
178	0	1	Today on <i>The Jeremy Kyle Show: </i>"Help! My son is ____!"	UK
179	0	1	In Belmarsh Prison, word is you can trade 200 cigarettes for ____.	UK
180	0	1	Now at the Natural History Museum: an interactive exhibit on ____.	UK
181	0	1	Hey guys, welcome to TGIF! Would you like to start the night off right with ____?	UK
182	0	1	Coming to the West End this year, ____: The Musical.	UK
183	0	2	In a world ravaged by ____, our only solace is ____.	UK
184	0	1	This season at the Old Vic, Samuel Beckett's classic existential play: Waiting for ____.	UK
185	0	1	Channel 5's new reality show feature eight washed-up celebrities living with ____.	UK
186	0	1	&#x2605;&#x2606;&#x2606;&#x2606;&#x2606; Do NOT go here! Found ____ in my Kung Pao chicken!	UK
187	0	1	____. That's what mums go to Iceland.	UK
188	0	2	Channel 4 presents "____: the Story of ____."	UK
189	0	1	Dear Agony Aunt, I'm having some trouble with ____ and would like your advice.	UK
190	0	1	How did Stella get her groove back?	90s
192	0	1	Siskel and Ebert have panned ____ as "poorly conceived" and "sloppily executed."	90s
193	0	1	Up next on Nickelodeon: "Clarissa Explains ____."	90s
194	0	1	It's Morphin' Time! Mastodon! Pterodactyl! Triceratops! Sabertooth Tiger! ____!	90s
195	0	1	Believe it or not, Jim Carrey can do a dead-on impression of ____.	90s
196	0	1	I'm a bitch, I'm a lover, I'm a child, I'm ____.	90s
197	0	1	Tonight on SNICK: "Are You Afraid of ____?"	90s
198	0	1	Wait, I came here to buy socks. How did I wind up with ____?	RTPRD
200	0	1	Here is the church Here is the steeple Open the doors And there is ____.	US
202	0	1	Dude, do not go in that bathroom. There's ____ in there.	US
203	0	1	As the mom of five rambunctious boys, I'm no stranger to ____.	US
204	0	1	The class field trip was completely ruined by ____.	US
205	0	1	When I am a billionaire, I shall erect a 50-foot statue to commemorate ____.	US
206	0	1	Next from J.K. Rowling: Harry Potter and the Chamber of ____.	US
207	0	1	I'm sorry, Professor, but I couldn't complete my homework because of ____.	US
208	0	1	Next on ESPN2: The World Series of ____.	US
209	0	1	Dear Abby, I'm having some trouble with ____ and would like your advice.	US
210	0	2	Lifetime&reg; presents "____: the Story of ____."	US
211	0	1	Hey guys, welcome to Chili's! Would you like to start the night off right with ____?	US
212	0	1	Just once, I'd like to hear you say "Thanks, Mom. Thanks for ____."	US
213	0	1	Old Macdonald had ____. E-I-E-I-O.	US
214	0	1	Just saw this upsetting video! Please retweet!! #stop____	US
215	0	1	Men's Wearhouse. You're gonna like ____. I guarantee it.	US
216	0	1	The Chevy Tahoe. With the power and space to take ____ everywhere you go.	US
217	0	1	Click here for ____!!!	US
218	0	1	TSA guidelines now prohibit ____ on airplanes.	US
219	0	1	What is Batman's guilty pleasure.	US
220	0	1	After eight years in the White House, how is Obama finally letting loose?	US
221	0	1	This season at Steppenwolf, Samuel Beckett's classic existential play: Waiting for ____.	US
222	0	1	A recent laboratory study shows that undergraduates have 50% less sex after being exposed to ____.	US
223	0	1	Mabe she's born with it. Maybe it's ____.	US
224	0	1	Arby's: We Have ____.	US
225	0	1	When I am President, I will create the Department of ____.	US
226	0	1	But before I kill you, Mr. Bond, I must show you ____.	US
227	2	3	____ + ____ = ____.	US
228	0	1	What's Teach For America using to inspire inner city students to succeed?	US
229	0	1	Brought to you by Bud Light&reg;, the official Beer of ____.	US
230	0	1	Today on Maury: "Help! My son is ____!"	US
231	0	1	Introducing X-treme Baseball! It's like baseball, but with ____!	US
232	0	1	I'm no doctor but I'm pretty sure what you're suffering from is called "____."	US
233	0	1	Bravo's new reality show features eight washed-up celebrities living with ____.	US
234	0	1	IF you like ____, YOU MIGHT BE A REDNECK.	US
235	0	1	My fellow Americans: Before this decade is out, we will have ____ on the moon!	US
236	0	1	In the Disney Channel Original Movie, Hannah Montana struggles with ____ for the first time.	US
237	0	1	While the United States raced the Soviet Union to the moon, the Mexican government funneled millions of pesos into research on ____.	US
238	0	1	Daddy, why is mommy crying?	US
239	0	1	Ooo, daddy like ____.	GREEN
241	0	1	As reparations for slavery, all African Americans will receive ____.	GREEN
242	0	1	What's about to take this dance floor to the next level?	GREEN
243	0	1	What are all those whales singing about?	GREEN
244	0	1	I've got rhythm, I've got music, I've got ____. Who could ask for anything more?	GREEN
245	0	1	Then the princess kissed the frog, and all of a sudden the frog was ____!	GREEN
246	0	1	What turned me into a Republican?	GREEN
247	0	1	If at first you don't succeed, try ____.	GREEN
248	0	1	Poor Brandon, still living in his parents' basement. I hear he never got over ____.	GREEN
249	0	1	Coming to Red Lobster&reg; this month, ____.	GREEN
250	0	1	Most Americans would not vote for a candidate who is openly ____.	GREEN
251	0	1	This Friday at the Liquid Lounge, it's ____ Night! Ladies drink free.	GREEN
252	0	1	Well, shit. My eyes ain't so good, but I'll eat my own boot if that ain't ____!	GREEN
253	0	1	CNN breaking news! Scientists discover ____.	GREEN
254	0	1	She's a lady in the streets, ____ in the sheets.	GREEN
255	0	1	There is no God. It's just ____ and then you die.	GREEN
256	0	1	Best you go back where you came from, now. We don't take too kindly to ____ in these parts.	GREEN
257	0	1	I've had a horrible vision, father. I saw mountains crumbling, stars falling from the sky. I saw ____.	GREEN
258	0	1	Oh no! Siri, how do I fix ____?	GREEN
259	0	1	Girls just wanna have ____.	GREEN
260	0	1	What's the gayest?	GREEN
261	0	1	Son, take it from someone who's been around the block a few times. Nothin' puts her in the mood like ____.	GREEN
262	0	1	Mom's to-do list:<br><br>Buy groceries<br>Clean up ____<br>Soccer practice	GREEN
263	0	1	What will end racism once and for all?	GREEN
264	0	1	No, no, no, no, no, NO! I will NOT let ____ ruin this wedding.	GREEN
265	0	1	Summer lovin', had me a blast. ____, happened so fast.	GREEN
266	0	1	I'm sorry, sir, but your insurance plan doesn't cover injuries caused by ____.	GREEN
267	0	1	What sucks balls?	GREEN
268	0	1	Errbody in the club ____.	GREEN
269	0	1	I'll take the BBQ bacon burger with a fried egg and fuck it how about ____.	GREEN
270	0	1	You won't believe what's in my pussy. It's ____.	GREEN
271	0	1	The top Google auto-complete results for "Barack Obama": <br>Barack Obama height.<br>Barack Obama net worth.<br>Barack Obama ____.	GREEN
272	0	1	I may not be much to look at, but I fuck like ____.	GREEN
273	0	1	LSD + ____ = really bad time.	GREEN
274	0	1	Feeling so grateful! #amazing #mylife #____	GREEN
275	0	1	Art isn't just a painting in a stuffy museum. Art is alive. Art is ____.	GREEN
276	0	1	Why am I laughing and crying and taking off my clothes?	GREEN
277	0	1	Google Calendar alert: ____ in 10 minutes.	GREEN
278	0	1	One more thing. Watch out for Big Mike. They say he killed a man with ____.	GREEN
279	0	1	Dance like there's nobody watching, love like you'll never be hurt, and live like you're ____.	GREEN
280	0	2	____: Brought to you by ____.	GREEN
281	0	1	In the 1950s, psychologists prescribed ____ as a cure for homosexuality.	GREEN
282	0	1	Well if ____ is a crime, then lock me up!	GREEN
283	0	1	Run, run, as fast as you can! You can't catch me, I'm ____!	GREEN
284	0	1	What's the most problematic?	GREEN
285	0	1	With a one-time gift of just $10, you can save this child from ____.	GREEN
286	0	2	____ be all like ____.	GREEN
287	0	1	You know who else liked ____? Hitler.	GREEN
288	0	1	What totally destroyed my asshole?	GREEN
289	0	1	I don't believe in God. I believe in ____.	GREEN
290	0	1	She's just one of the guys, you know? She likes beer, and football, and ____.	GREEN
291	0	1	Congratulations! You have been selected for our summer internship program. While we are unable to offer a salary, we <i>can</i> offer you ____.	GREEN
292	0	1	I tell you, it was a non-stop fuckfest. When it was over, my asshole looked like ____.	GREEN
293	0	1	We do not shake with our left hands in this country. That is the hand we use for ____.	GREEN
294	0	1	As Teddy Roosevelt said, the four manly virtues are honor, temperance, industry, and ____.	GREEN
295	0	1	What the hell?! They added a 6/6 with flying, trample, and ____.	PXE14
297	0	2	____ is way better in ____mode.	PXE14
298	0	1	You think you have defeated me? Well, let's see how you handle ____!	PXE14
299	0	1	Unfortunately, Neo, no one can be <i>told </i>what ____ is. You have to see it for yourself.	PXE14
300	0	1	<i>(Heavy breathing)</i> Luke, I am ____.	PXE14
301	0	1	When you go to the polls on Tuesday, remember: a vote for me is a vote for ____.	V4HIL
303	0	1	Senator, I trust you enjoyed ____ last night. Now, can I count on your vote?	V4HIL
305	0	2	____ is way better in ____ mode.	GEEK
306	0	1	Hold up. I gotta deal with ____, then I'mma smoke this.	WEED
308	0	1	Okay here's the pitch. James Franco and Seth Rogen are trying to score some weed, and then ____ happens.	WEED
309	0	1	You know what's like, really funny when you think about it? ____.	WEED
310	0	1	Instead of playing a card this round, everyone must stare at the Card Czar while making a sound you'd make after tasting something delicious.	WEED
311	0	1	Everyone is staring at you because you're ____.	WEED
312	0	1	Donald Trump's first act as president was to outlaw ____.	PST45
314	0	1	Donald Trump has nominated ____ for his VP.	PST45
315	0	1	In 2019, Donald Trump eliminated our national parks to make room for ____.	PST45
316	0	1	A study published in <i>Nature</i> this week found that ____ is good for you in small doses.	SCI
318	0	1	What really killed the dinosaurs?	SCI
319	0	2	Today on <i>Mythbusters, </i>we find out how long ____ can withstand ____.	SCI
320	0	2	In an attempt to recreate conditions just after the Big Bang, physicists at the LHC are observing collisions between ____ and ____.	SCI
321	0	1	In what's being hailed as a major breakthrough, scientists have synthesized ____ in the lab.	SCI
322	0	2	In line with our predictions, we find a robust correlation between ____ and ____ (<i>p&lt;.05).</i>	SCI
323	0	1	Hey there, Young Scientists! Put on your labcoats and strap on your safety goggles, because today we're learning about ____!	SCI
324	0	1	It's not delivery. It's ____.	FOOD
326	0	1	Don't miss Rachel Ray's hit new show, <i>Cooking with ____.</i>	FOOD
327	0	1	I'm Bobby Flay, and if you can't stand ____, get out of the kitchen!	FOOD
328	0	1	Now on Netflix: <i>Jiro Dreams of ____.</i>	FOOD
329	0	1	Aw babe, your burps smell like ____!	FOOD
330	0	1	Excuse me, waiter. Could you take this back? This soup tastes like ____.	FOOD
331	0	1	Looking to earn big bucks? Learn how to make ____ work for you!	RTAIL
333	0	1	How are the writers of Cards Against Humanity spending your $25?	RTAIL
334	0	1	Coming this spring from BioWare, <i>Mass Effect: ____.</i>	MSFX
336	0	1	I'm Commander Shepard, and this is my favorite place for ____ on the Citadel.	MSFX
337	0	1	It turns out The Reapers didn't want to destroy the galaxy. They just wanted ____.	MSFX
338	0	1	We were the best hand-to-hand combatants on the ship. I had reach, but she had ____.	MSFX
339	0	1	Dear Leader Kim Jong-un, our village praises your infinite wisdom with a humble offering of ____.	BLUE
341	0	2	We never did find ____, but along the way we sure learned a lot about ____.	BLUE
342	0	1	Do <i>not</i> fuck with me! I am literally ____ right now.	BLUE
343	0	1	And would you like those buffalo wings mild, hot, or ____?	BLUE
344	0	1	What's fun until it gets weird?	BLUE
345	0	1	And today's soup is Cream of ____.	BLUE
346	0	1	Come to Dubai, where you can relax in our world-famous spas, experience the nightlife, or simply enjoy ____ by the poolside.	BLUE
347	0	1	She's up all night for good fun. I'm up all night for ____.	BLUE
348	0	1	Hi MTV! My name is Kendra, I live in Malibu, I'm into ____, and I love to have a good time.	BLUE
349	0	2	I am become ____, destroyer of ____!	BLUE
350	0	2	____ may pass, but ____ will last forever.	BLUE
351	0	2	In the beginning, there was ____. And the Lord said, "Let there be ____."	BLUE
352	2	3	You guys, I saw this crazy movie last night. It opens on ____, and then there's some stuff about ____, and then it ends with ____.	BLUE
353	0	2	This year's hottest album is "____" by ____.	BLUE
354	0	1	It lurks in the night. It hungers for flesh. This summer, no one is safe from ____.	BLUE
355	0	2	____ will never be the same after ____.	BLUE
356	0	1	I don't mean to brag, but they call me the Michael Jordan of ____.	BLUE
357	0	1	Don't forget! Beginning this week, Casual Friday will officially become "____ Friday."	BLUE
358	0	1	Having the worst day EVER. #____	BLUE
359	0	1	Why am I broke?	BLUE
360	0	1	Wes Anderson's new film tells the story of a precocious child coming to terms with ____.	BLUE
361	0	1	2 AM in the city that never sleeps. The door swings open and <i>she </i>walks in, legs up to here. Something in her eyes tells me she's looking for ____.	BLUE
362	0	2	Adventure. Romance. ____. From Paramount Pictures, "____."	BLUE
363	0	2	Patient presents with ____. Likely a result of ____.	BLUE
364	0	1	Yo' mama so fat she ____!	BLUE
365	0	1	Now in bookstores: "The Audacity of ____," by Barack Obama.	BLUE
366	0	1	In his new action comedy, Jackie Chan must fend off ninjas while also dealing with ____.	BLUE
367	0	1	Armani suit: $1,000. Dinner for two at that swanky restaurant: $300. The look on her face when you surprise her with ____: priceless.	BLUE
368	0	1	Behind every powerful man is ____.	BLUE
369	0	1	Life's pretty tough in the fast lane. That's why I never leave the house without ____.	BLUE
370	0	1	You are not alone. Millions of Americans struggle with ____ every day.	BLUE
371	0	1	My grandfather worked his way up from nothing. When he came to this country, all he had was the shoes on his feet and ____.	BLUE
372	0	2	If you can't handle ____, you'd better stay away from ____.	BLUE
373	0	1	Man, this is bullshit. Fuck ____.	BLUE
374	0	2	In return for my soul, the Devil promised me ____, but all I got was ____.	BLUE
375	0	1	The Japanese have developed a smaller, more efficient version of ____.	BLUE
376	0	1	"This is madness!"<br><br>"<i>No.</i> THIS IS ____!"	BLUE
377	0	1	Do you lack energy? Does it sometimes feel like the whole world is ____? Ask your doctor about Zoloft&reg;.	BLUE
378	0	1	I work my ass off all day for this family, and this is what I come home to? ____!?	BLUE
379	0	1	This is America. If you don't work hard, you don't succeed. I don't care if you're black, white, purple, or ____.	BLUE
380	0	1	Dammit, Gary. You can't just solve every problem with ____.	BLUE
381	0	1	James is a lonely boy. But when he discovers a secret door in his attic, he meets a magical new friend: ____.	BLUE
382	0	1	This is the prime of my life. I'm young, hot, and full of ____.	BLUE
383	0	2	Every step towards ____ gets me a little bit closer to ____.	BLUE
384	0	2	Well if ____ is good enough for ____, it's good enough for me.	BLUE
385	0	1	WHOOO! God <i>damn</i> I love ____!	BLUE
386	0	1	You Won't Believe These 15 Hilarious ____ Bloopers!	BLUE
387	0	1	You've seen the bearded lady! You've seen the ring of fire! Now, ladies and gentlemen, feast your eyes upon ____!	BLUE
388	0	1	When I was a kid, we used to play Cowboys and ____.	BLUE
389	0	1	Do the Dew&reg; with our most extreme flavor yet! Get ready for Mountain Dew ____!	BLUE
390	0	2	Honey, I have a new role-play I want to try tonight! You can be ____, and I'll be ____.	BLUE
391	0	2	Forget everything you know about ____, because now we've supercharged it with ____!	BLUE
392	0	1	What's making things awkward in the sauna?	BLUE
393	0	1	Listen, Gary, I like you. But if you want that corner office, you're going to have to show me ____.	BLUE
394	0	1	Help me doctor, I've got ____ in my butt.	BLUE
395	0	2	Oprah's book of the month is "____ For ____: A Story of Hope."	BLUE
396	0	2	You know, once you get past ____, ____ ain't so bad.	BLUE
397	0	1	In his farewell address, George Washington famously warned Americans about the dangers of ____.	BLUE
398	0	1	Well what do you have to say for yourself, Casey? This is the third time you've been sent to the principal's office for ____.	BLUE
399	0	1	Here at the Academy for Gifted Children, we allow students to explore ____ at their own pace.	BLUE
400	0	1	Get ready for the movie of the summer! One cop plays by the book. The other's only interested in one thing: ____.	BLUE
401	0	2	Heed my voice, mortals! I am the god of ____, and I will not tolerate ____!	BLUE
402	0	1	As king, how will I keep the peasants in line?	BLUE
403	0	1	I'm sorry, sir, but we don't allow ____ at the country club.	BLUE
404	0	1	I have a strict policy. First date, dinner. Second date, kiss. Third date, ____.	BLUE
405	0	1	What killed my boner?	BLUE
406	0	1	Hi, this is Jim from accounting. We noticed a $1,200 charge labeled "____." Can you explain?	BLUE
407	0	1	I'm pretty sure I'm high right now, because I'm absolutely mesmerized by ____.	BLUE
408	0	1	Don't worry, kid. It gets better. I've been living with ____ for 20 years.	BLUE
409	0	1	How am I compensating for my tiny penis?	BLUE
410	0	1	What brought the orgy to a grinding halt?	INTL
412	0	1	Lovin' you is easy 'cause you're ____.	INTL
413	0	1	Your persistence is admirable, my dear Prince. But you cannot win my heart with ____ alone.	INTL
414	0	1	The blind date was going horrible until we discovered our shared interest in ____.	INTL
415	0	1	Science will never explain ____.	INTL
416	0	1	The Five Stages of Grief: denial, anger, bargaining, ____, acceptance.	INTL
417	0	1	Next from J.K. Rowling: <i>Harry Potter and the Chamber of ____.</i>	INTL
418	0	1	What has been making life difficult at the nudist colony?	INTL
419	0	1	Charades was ruined for me forever when my mom had to act out ____.	INTL
420	0	1	Money can't buy me love, but it can buy me ____.	INTL
421	0	1	During his midlife crisis, my dad got really into ____.	INTL
422	0	2	When you get right down to it, ____ is just ____.	INTL
423	0	1	This is your captain speaking. Fasten your seatbelts and prepare for ____.	INTL
424	0	1	Tonight's top story: What you don't know about ____ could kills you.	INTL
425	0	1	Future historians will agree that ____ marked the beginning of America's decline.	INTL
426	0	1	Coming this season, Samuel Beckett's classic existential play: <i>Waiting for ____.</i>	INTL
427	0	1	When I pooped, what came out of my butt?	INTL
428	0	1	A successful job interview begins with a firm handshake and ends with ____.	INTL
429	0	1	Finally! A service that delivers ____ right to your door.	INTL
430	0	1	And what did <i>you</i> bring for show and tell?	INTL
431	0	1	When I am a billionaire, I shall erect a 20-meter statue to commemorate ____.	INTL
432	0	1	When all else fails, I can always masturbate to ____.	INTL
433	0	2	I spent my whole life working toward ____, only to have it ruined by ____.	INTL
434	0	2	____ would be woefully incomplete without ____.	INTL
435	0	1	Next on Eurosport: The World Championship of ____.	INTL
436	0	1	Dude, <i>do not</i> go in that bathroom. There's ____ in there.	INTL
437	0	1	In his new self-produced album, Kanye West raps over the sounds of ____.	INTL
438	0	1	In Rome, there are whisperings that the Vatican has a secret room devoted to ____.	INTL
439	0	2	Having problems with ____? Try ____!	INTL
440	0	1	The secret to a lasting marriage is communication, communication, and ____.	INTL
441	0	2	My mom freaked out when she looked at my browser history and found ____.com/____.	INTL
442	0	1	In the seventh circle of Hell, sinners must endure ____ for all eternity.	INTL
443	0	1	____. Awesome in theory, kind of a mess in practice.	INTL
444	0	1	My plan for world domination begins with ____.	INTL
445	0	1	I learned the hard way that you can't cheer up a grieving friend with ____.	INTL
446	0	1	A remarkable new study shows that chimps have evolved their own primitive version of ____.	INTL
447	0	2	After months of practice with ____, I think I'm finally ready for ____.	INTL
448	0	1	When I am Prime Minister, I will create the Ministry of ____.	INTL
449	0	1	Turns out that ____-Man was neither the hero we needed nor wanted.	INTL
450	0	2	With enough time and pressure, ____ will turn into ____.	INTL
451	0	1	What left this stain on my couch?	INTL
452	0	2	Dear Sir or Madam, We regret to inform you that the Office of ____ has denied your request for ____.	INTL
453	0	1	I'm not like the rest of you. I'm too rich and busy for ____.	INTL
454	0	1	The healing process began when I joined a support group for victims of ____.	INTL
455	0	1	Doctor, you've gone too far! The human body wasn't meant to withstand that amount of ____!	INTL
456	0	1	Only two things in life are certain: death and ____.	INTL
457	0	1	Hey, you guys want to try this awesome new game? It's called ____.	TBLTP
459	0	1	For my turn, I will spend four gold and allocate all three workers to ____.	TBLTP
460	0	1	Backers who supported Tabletop at the $25,000 level were astonished to receive ____ from Wil Wheaton himself.	TBLTP
462	0	1	This month's Cosmo: "Spice up your sex life by bringing ____ into the bedroom."	RED
463	0	1	Next time on Dr. Phil: How to talk to your child about ____.	RED
464	0	1	Tonight on 20/20: What you don't know about ____ could kill you.	RED
465	0	1	My new favorite porn star is Joey "____" McGee.	RED
466	0	2	Michael Bay's new three-hour action epic pits ____ against ____.	RED
467	0	2	Before ____, all we had was ____.	RED
468	2	3	I went from ____ to ____ all thanks to ____.	RED
469	0	1	Aww, sick! I just saw this skater do a 720 kickflip into ____!	RED
470	0	1	What's harshing my mellow, man?	RED
471	0	1	I love being a mom. But it's tough when my kids come home filthy from ____. That's why there's Tide&reg;.	RED
472	0	1	As part of his daily regimen, Anderson Cooper sets aside 15 minutes for ____.	RED
473	0	1	To prepare for his upcoming role, Daniel Day-Lewis immersed himself in the world of ____.	RED
474	0	1	Welcome to Se&ntilde;or Frog's! Would you like to try our signature cocktail, "____ on the Beach"?	RED
475	0	1	Hey baby, come back to my place and I'll show you ____.	RED
476	0	2	You haven't truly lived until you've experienced ____ and ____ at the same time.	RED
477	0	1	Your persistence is admirable, my dear Prince, But you cannot win my heart with ____ alone.	RED
478	0	2	In a pinch, ____ can be a suitable substitute for ____.	RED
479	0	1	During high school, I never really fit in until I found ____ club.	RED
480	0	1	Little Miss Muffet<br>Sat on a tuffet,<br>Eating her curds<br>and ____.	RED
481	0	1	And what did <i>you </i>bring for show and tell?	RED
482	0	1	In its new tourism campaign, Detroit proudly proclaims that it has finally eliminated ____.	RED
483	0	1	My gym teacher got fired for adding ____ to the obstacle course.	RED
484	0	1	The blind date was going horribly until we discovered our shared interest in ____.	RED
485	0	1	My country, 'tis of thee, sweet land of ____.	RED
486	0	1	Call the law offices of Goldstein &amp; Goldstein, because no one should have to tolerate ____ in the workplace.	RED
487	0	1	Members of New York's social elite are paying thousands of dollars just to experience ____.	RED
488	0	1	In his newest and most difficult stunt, David Blaine must escape from ____.	RED
489	0	2	Dear Sir or Madam, <br>We regret to inform you that the Office of ____ has denied your request for ____.	RED
490	0	2	____: Hours of fun. Easy to use. Perfect for ____!	RED
491	0	2	Listen, son. If you want to get involved with ____, I won't stop you. Just steer clear of ____.	RED
492	0	1	Next week on the Discovery Channel, one man must survive in the depths of the Amazon with only ____ and his wits.	RED
493	0	2	If God didn't want us to enjoy ____, he wouldn't have given us ____.	RED
494	0	2	My life is ruined by a vicious cycle of ____ and ____.	RED
495	0	1	And I would have gotten away with it, too, if it hadn't been for ____!	RED
496	0	1	Legend has it Prince wouldn't perform without ____ in his dressing room.	RED
497	0	1	I can't believe Netflix is using ____ to promote <i>House of Cards.</i>	HCARD
499	0	1	A wise man said, "Everything is about sex. Except sex. Sex is about ____."	HCARD
500	0	1	I'm not going to lie. I despise ____. There, I said it.	HCARD
501	0	2	Corruption. Betrayal. ____. Coming soon to Netflix, "House of ____."	HCARD
502	0	1	We're not like other news organizations. Here at Slugline, we welcome ____ in the office.	HCARD
503	0	2	Because you enjoyed ____, we thought you'd like ____.	HCARD
504	0	1	Cancel all my meetings. We've got a situation with ____ that requires my immediate attention.	HCARD
505	0	1	Our relationship is strictly professional. Let's not complicate things with ____.	HCARD
506	0	1	What are two cards in your hand that you want to get rid of?	RJECT
508	0	1	From WBEZ Chicago, it's <i>This American Life.</i> Today on our program, ____. Stay with us.	RJECT
509	0	1	My name is Inigo Montoya. You killed my father. Prepare for ____.	RJECT
510	0	1	[rorschach test] What do you see?	RJECT
511	0	1	Sir, we found you passed out naked on the side of the road. What's the last thing you remember?	RJECT
512	0	1	You can't wait forever. It's time to talk to your doctor about ____.	RJECT
513	0	1	The elders of the Ibo tribe of Nigeria recommend ____ as a cure for impotence.	RJECT
514	0	1	The Westboro Baptist Church is now picketing soldiers' funerals with signs that read 'GOD HATES ____!'	RJECT
515	0	1	Trump's great! Trump's got ____. I love that.	V4 45
517	0	1	It's 3 AM. The red phone rings. It's ____. Who do you want answering?	V4 45
518	0	1	According to Arizona's stand-your-ground law, you're allowed to shoot someone if they're ____.	V4 45
520	0	1	As the mom of five rambunctious boys, I'm not stranger to ____.	CA
521	0	2	CBC presents "____: the Story of ____."	CA
522	0	1	Just once I'd like to hear you say "Thanks, Mom. Thanks for ____."	CA
523	0	1	Bravo's new reality show feature eight washed-up celebrities living with ____.	CA
524	0	1	Air Canada guidelines now prohibit ____ on airplanes.	CA
525	0	1	When I am Prime Minister of Canada, I will create the Ministry of ____.	CA
526	0	1	Coming to Broadway this season, ____; The Musical.	CA
527	0	1	This season at the Princess of Wales Theatre, Samuel Beckett's classic existential play: <i>Waiting for ____.</i>	CA
528	0	1	Penalty! ____: that's 5 minutes in the box!	CA
529	0	1	Hey guys, welcome to Boston Pizza! Would you like to start the night off right with ____?	CA
530	0	1	I know when that hotline bling, that can only mean one thing: ____.	CA
531	0	1	Today on <i>Maury</i>: "Help! My son is ____!"	CA
532	0	1	Brought to you by Molson Canadian, the Official Beer of ____.	CA
533	0	1	Next on TSN: The World Series of ____.	CA
534	0	1	O Canada, we stand on guard for ____.	CA
535	0	1	My fellow Americans: Before this decade is out, we <i>will</i> have ____ on the moon!	CA
536	0	1	Dude, <i>do not </i>go in that washroom. There's ____ in there.	CA
537	0	1	Dear Abby, I'm having some trouble ____ and would like your advice.	CA
538	0	1	Skidamarink a dink a dink, skidamarink a doo, I love ____.	CA
539	0	1	The new Chevy Tahoe. With the power and space to take ____ everywhere you go.	CA
540	0	1	What's so important right now that you can't call your mother?	JEW
542	0	1	According to Freud, all children progress through three stages of development: the oral stage, the anal stage, and the ____ stage.	JEW
543	0	1	Oh, your daughter should meet my son! He gives to charity, he loves ____ and did I mention he's a doctor?	JEW
544	0	1	Coming to Broadway next season: "____ on the Roof."	JEW
545	0	1	Can't you see? The Jews are behind everything--the banks, the media, even ____!	JEW
546	0	1	Because they are forbidden from masturbating, Mormons channel their repressed sexual energy into ____.	❄2013
548	0	1	Revealed: Why He Really Resigned! Pope Benedict's Secret Struggle with ____!	❄2013
549	0	1	Kids these days with their iPods and their internet. In my day, we all needed to pass the time was ____.	❄2013
550	0	1	GREETINGS<br>HUMANS<br><br>I AM ____ BOT<br><br>EXECUTING PROGRAM	❄2013
551	0	2	But wait, there's more! If you order ____ in the next 15 minutes, we'll throw in ____ absolutely free!	❄2013
552	0	1	I really hope my grandma doesn't ask me to explain ____ again.	❄2013
553	0	2	Critics are raving about HBO's new <i>Game of Thrones</i> spin-off, "____ of ____."	FNTSY
555	0	1	Your father was a powerful wizard, Harry. Before he died, he left you something very precious: ____.	FNTSY
556	0	1	Having tired of poetry and music, the immortal elves now fill their days with ____.	FNTSY
557	0	1	And in the end, the dragon was not evil; he just wanted ____.	FNTSY
558	0	1	Who blasphemes and bubbles at the center of all infinity, whose name no lips dare speak aloud, and who gnaws hungrily in inconceivable, unlighted chambers beyond time?	FNTSY
559	0	1	Legend tells of a princess who has been asleep for a thousand years and can only be awoken by ____.	FNTSY
560	0	1	Fear leads to anger. Anger leads to hate. Hate leads to ____.	SCIFI
562	0	1	Computer! Display ____ on screen. Enhance.	SCIFI
563	0	1	You're not going to believe this, but I'm you from the future! You've got to stop ____.	SCIFI
564	0	1	This won't be like negotiating with the Vogons. Humans only respond to one thing: ____.	SCIFI
565	0	1	Madam President, the asteroid is headed directly for Earth and there's one one thing that can stop it: ____.	SCIFI
566	0	1	You have violated the Prime Directive! You exposed an alien culture to ____ before they were ready.	SCIFI
567	0	1	What is the answer to life, the universe, and everything?	SCIFI
568	0	1	After blacking out during New Year's Eve, I was awoken by ____.	❄2012
570	0	1	What keeps me warm during the cold, cold winter?	❄2012
571	0	1	Wake up, America. Christmas is under attack by secular liberals and their ____.	❄2012
572	0	1	Every Christmas, my uncle gets drunk and tells the story about ____.	❄2012
573	0	1	On the third day of Christmas, my true love gave to me: three French hens, two turtle doves, and ____.	❄2012
574	0	1	My memory of last night is pretty hazy. I remember ____ and that's pretty much it.	COLEG
576	0	1	Pledges! Time to prove you're Delta Phi material. Chug this beer, take off your shirts, and get ready for ____.	COLEG
577	0	1	All classes today are canceled due to ____.	COLEG
578	0	1	Did you know? Our college was recently named the #1 school for ____!	COLEG
579	0	1	The Department of Psychology is looking for paid research volunteers. Are you 18-25 and suffering from ____?	COLEG
580	0	1	In this paper, I will explore ____ from a feminist perspective.	COLEG
581	0	1	What gets me wet?	.
583	0	1	My body, my voice! ____, my choice!	.
584	0	1	My vagina's angry. My vagina's furious and it needs to talk. It needs to talk about ____.	.
585	0	1	Can a woman really have it all? A career <i>and ____?</i>	.
586	0	1	Tampax&reg;: Don't let your period ruin ____.	.
587	0	1	New from Mattel, it's ____ Barbie!	.
\.


--
-- TOC entry 2190 (class 0 OID 17431)
-- Dependencies: 186
-- Data for Name: card_set; Type: TABLE DATA; Schema: public; Owner: pyx
--

COPY card_set (id, active, base_deck, description, name, weight) FROM stdin;
2	t	f	PAX Prime 2013 Pack	PAX Prime 2013 Pack	105
10	t	f	Holiday Pack 2014	Holiday Pack 2014	80
17	t	f	World Wide Web Pack	World Wide Web Pack	30
27	t	f	Season's Greetings Pack	Season's Greetings Pack	83
35	t	f	PAX East 2013 Pack C	PAX East 2013 Pack C	104
38	t	f	Base Game (Australia)	Base Game (Australia)	4
139	t	f	Reject Pack 2	Reject Pack 2	30
150	t	f	PAX East 2013 Pack A	PAX East 2013 Pack A	102
153	t	f	NASA Pack	NASA Pack	30
156	t	f	PAX East 2013 Pack B	PAX East 2013 Pack B	103
159	t	f	Base Game (UK)	Base Game (UK)	3
191	t	f	90s Nostalgia Pack	90s Nostalgia Pack	30
199	t	f	Retail Product Pack	Retail Product Pack	30
201	t	f	Base Game (US)	Base Game (US)	1
240	t	f	Green Box Expansion	Green Box Expansion	10
296	t	f	PAX East 2014 Pack	PAX East 2014 Pack	106
302	t	f	Vote for Hillary Pack	Vote for Hillary Pack	70
304	t	f	Geek Pack	Geek Pack	30
307	t	f	Weed Pack	Weed Pack	30
313	t	f	Post-Trump Pack	Post-Trump Pack	72
317	t	f	Science Pack	Science Pack	30
325	t	f	Food Pack	Food Pack	30
332	t	f	Retail Pack	Retail Pack	30
335	t	f	Mass Effect Pack	Mass Effect Pack	101
340	t	f	Blue Box Expansion	Blue Box Expansion	10
411	t	f	Base Game (International)	Base Game (International)	5
458	t	f	Tabletop Pack	Tabletop Pack	100
461	t	f	Red Box Expansion	Red Box Expansion	10
498	t	f	House of Cards Pack	House of Cards Pack	30
507	t	f	Reject Pack	Reject Pack	30
516	t	f	Vote for Trump Pack	Vote for Trump Pack	71
519	t	f	Base Game (Canada)	Base Game (Canada)	2
541	t	f	Jew Pack	Jew Pack	30
547	t	f	Holiday Pack 2013	Holiday Pack 2013	80
554	t	f	Fantasy Pack	Fantasy Pack	30
561	t	f	Sci-Fi Pack	Sci-Fi Pack	30
569	t	f	Holiday Pack 2012	Holiday Pack 2012	80
575	t	f	College Pack	College Pack	30
582	t	f	Period Pack	Period Pack	30
1731	t	f	Box Expansion Pack	Box Expansion Pack	30
1762	t	f	Hidden Compartment Pack	Hidden Compartment Pack	30
2404	t	f	PAX Prime 2014 Pack	PAX Prime 2014 Pack	107
\.


--
-- TOC entry 2191 (class 0 OID 17439)
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
10	9
10	11
10	12
10	13
10	14
10	15
17	16
17	18
17	19
17	20
17	21
17	22
17	23
17	24
17	25
27	32
27	33
27	26
27	28
27	29
27	30
27	31
35	34
35	36
38	37
38	39
38	40
38	41
38	42
38	43
38	44
38	45
38	46
38	47
38	48
38	49
38	50
38	51
38	52
38	53
38	54
38	55
38	56
38	57
38	58
38	59
38	60
38	61
38	62
38	63
38	64
38	65
38	66
38	67
38	68
38	69
38	70
38	71
38	72
38	73
38	74
38	75
38	76
38	77
38	78
38	79
38	80
38	81
38	82
38	83
38	84
38	85
38	86
38	87
38	88
38	89
38	90
38	91
38	92
38	93
38	94
38	95
38	96
38	97
38	98
38	99
38	100
38	101
38	102
38	103
38	104
38	105
38	106
38	107
38	108
38	109
38	110
38	111
38	112
38	113
38	114
38	115
38	116
38	117
38	118
38	119
38	120
38	121
38	122
38	123
38	124
38	125
38	126
38	127
38	128
38	129
38	130
38	131
38	132
38	133
38	134
38	135
38	136
38	137
139	144
139	145
139	146
139	147
139	148
139	138
139	140
139	141
139	142
139	143
150	149
150	151
153	152
153	154
156	155
156	157
159	37
159	39
159	40
159	41
159	42
159	44
159	45
159	47
159	48
159	50
159	52
159	55
159	56
159	58
159	59
159	60
159	61
159	62
159	63
159	64
159	65
159	66
159	67
159	70
159	71
159	72
159	73
159	74
159	75
159	76
159	79
159	82
159	83
159	84
159	85
159	87
159	88
159	89
159	90
159	91
159	93
159	94
159	95
159	97
159	98
159	99
159	100
159	107
159	110
159	111
159	112
159	113
159	116
159	117
159	118
159	121
159	122
159	123
159	124
159	125
159	126
159	128
159	129
159	130
159	132
159	133
159	134
159	135
159	136
159	158
159	160
159	161
159	162
159	163
159	164
159	165
159	166
159	167
159	168
159	169
159	170
159	171
159	172
159	173
159	174
159	175
159	176
159	177
159	178
159	179
159	180
159	181
159	182
159	183
159	184
159	185
159	186
159	187
159	188
159	189
191	192
191	193
191	194
191	195
191	196
191	197
191	190
199	198
201	39
201	40
201	41
201	42
201	44
201	45
201	46
201	47
201	48
201	50
201	54
201	55
201	56
201	58
201	59
201	60
201	61
201	62
201	63
201	64
201	65
201	66
201	71
201	73
201	74
201	75
201	77
201	81
201	83
201	84
201	87
201	91
201	93
201	94
201	97
201	98
201	99
201	100
201	102
201	104
201	107
201	108
201	110
201	112
201	113
201	116
201	117
201	118
201	121
201	122
201	123
201	124
201	125
201	128
201	130
201	132
201	134
201	135
201	136
201	160
201	168
201	186
201	200
201	202
201	203
201	204
201	205
201	206
201	207
201	208
201	209
201	210
201	211
201	212
201	213
201	214
201	215
201	216
201	217
201	218
201	219
201	220
201	221
201	222
201	223
201	224
201	225
201	226
201	227
201	228
201	229
201	230
201	231
201	232
201	233
201	234
201	235
201	236
201	237
201	238
240	256
240	257
240	258
240	259
240	260
240	261
240	262
240	263
240	264
240	265
240	266
240	267
240	268
240	269
240	270
240	271
240	272
240	273
240	274
240	275
240	276
240	277
240	278
240	279
240	280
240	281
240	282
240	283
240	284
240	285
240	286
240	287
240	288
240	289
240	290
240	291
240	292
240	293
240	294
240	239
240	241
240	242
240	243
240	244
240	245
240	246
240	247
240	248
240	249
240	250
240	251
240	252
240	253
240	254
240	255
296	295
296	297
296	298
296	299
296	300
302	241
302	301
302	303
304	305
304	34
304	4
304	6
304	7
304	300
307	306
307	308
307	309
307	310
307	311
313	312
313	314
313	315
317	320
317	321
317	322
317	323
317	316
317	318
317	319
325	324
325	326
325	327
325	328
325	329
325	330
332	331
332	333
335	336
335	337
335	338
335	334
340	384
340	385
340	386
340	387
340	388
340	389
340	390
340	391
340	392
340	393
340	394
340	395
340	396
340	397
340	398
340	399
340	400
340	401
340	402
340	403
340	404
340	405
340	406
340	407
340	408
340	409
340	339
340	341
340	342
340	343
340	344
340	345
340	346
340	347
340	348
340	349
340	350
340	351
340	352
340	353
340	354
340	355
340	356
340	357
340	358
340	359
340	360
340	361
340	362
340	363
340	364
340	365
340	366
340	367
340	368
340	369
340	370
340	371
340	372
340	373
340	374
340	375
340	376
340	377
340	378
340	379
340	380
340	381
340	382
340	383
411	128
411	130
411	132
411	134
411	135
411	410
411	412
411	413
411	414
411	415
411	416
411	160
411	417
411	418
411	419
411	420
411	37
411	421
411	422
411	423
411	424
411	425
411	426
411	427
411	44
411	428
411	45
411	429
411	430
411	431
411	48
411	176
411	432
411	433
411	434
411	435
411	436
411	437
411	438
411	55
411	439
411	183
411	440
411	441
411	58
411	442
411	59
411	443
411	60
411	444
411	445
411	446
411	447
411	448
411	65
411	449
411	66
411	450
411	451
411	452
411	453
411	70
411	454
411	71
411	455
411	456
411	73
411	204
411	207
411	83
411	212
411	84
411	214
411	90
411	93
411	94
411	97
411	226
411	98
411	102
411	104
411	108
411	110
411	238
411	116
411	121
411	122
411	123
411	124
411	125
458	457
458	459
458	460
461	410
461	412
461	415
461	416
461	418
461	419
461	420
461	421
461	422
461	423
461	425
461	427
461	428
461	429
461	432
461	433
461	434
461	437
461	438
461	439
461	440
461	441
461	442
461	443
461	444
461	445
461	446
461	447
461	449
461	450
461	451
461	453
461	454
461	455
461	456
461	462
461	463
461	464
461	465
461	466
461	467
461	468
461	469
461	470
461	471
461	472
461	473
461	474
461	475
461	476
461	477
461	478
461	479
461	480
461	481
461	482
461	483
461	484
461	485
461	486
461	487
461	488
461	489
461	490
461	491
461	492
461	493
461	494
461	495
461	496
498	497
498	499
498	500
498	501
498	502
498	503
498	504
498	505
507	512
507	513
507	514
507	506
507	508
507	509
507	510
507	511
516	515
516	517
516	518
519	520
519	521
519	522
519	523
519	524
519	525
519	526
519	527
519	528
519	529
519	530
519	531
519	532
519	533
519	534
519	535
519	536
519	537
519	538
519	539
519	37
519	39
519	40
519	41
519	42
519	44
519	45
519	46
519	47
519	48
519	50
519	54
519	55
519	56
519	58
519	59
519	60
519	61
519	62
519	63
519	64
519	65
519	66
519	67
519	70
519	71
519	73
519	74
519	75
519	76
519	77
519	79
519	81
519	82
519	83
519	84
519	87
519	90
519	91
519	93
519	94
519	95
519	97
519	98
519	99
519	100
519	107
519	108
519	110
519	111
519	112
519	113
519	116
519	117
519	118
519	119
519	121
519	122
519	123
519	124
519	125
519	128
519	129
519	130
519	132
519	133
519	134
519	135
519	136
519	160
519	417
519	168
519	171
519	186
519	204
519	207
519	231
519	234
519	237
519	238
541	544
541	545
541	540
541	542
541	543
547	32
547	33
547	546
547	548
547	549
547	550
547	551
547	552
547	28
554	553
554	555
554	556
554	557
554	558
554	559
561	560
561	562
561	563
561	564
561	565
561	566
561	567
569	568
569	570
569	26
569	571
569	572
569	29
569	573
575	576
575	577
575	578
575	579
575	580
575	574
582	581
582	583
582	584
582	585
582	586
582	587
\.


--
-- TOC entry 2192 (class 0 OID 17444)
-- Dependencies: 188
-- Data for Name: card_set_white_card; Type: TABLE DATA; Schema: public; Owner: pyx
--

COPY card_set_white_card (card_set_id, white_card_id) FROM stdin;
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
10	640
10	641
10	642
10	643
10	644
10	645
10	646
10	647
10	648
10	625
10	626
10	627
10	628
10	629
10	630
10	631
10	632
10	633
10	634
10	635
10	636
10	637
10	638
10	639
17	672
17	673
17	674
17	675
17	676
17	677
17	678
17	679
17	680
17	681
17	682
17	683
17	684
17	685
17	686
17	687
17	688
17	689
17	690
17	691
17	671
27	647
27	649
27	650
27	651
27	652
27	653
27	654
27	655
27	656
27	657
27	658
27	659
27	660
27	661
27	662
27	663
27	664
27	665
27	666
27	667
27	668
27	669
27	670
35	692
35	693
35	694
35	695
35	696
35	697
35	698
35	699
38	1024
38	1025
38	1026
38	1027
38	1028
38	1029
38	1030
38	1031
38	1032
38	1033
38	1034
38	1035
38	1036
38	1037
38	1038
38	1039
38	1040
38	1041
38	1042
38	1043
38	1044
38	1045
38	1046
38	1047
38	1048
38	1049
38	1050
38	1051
38	1052
38	1053
38	1054
38	1055
38	1056
38	1057
38	1058
38	1059
38	1060
38	1061
38	1062
38	1063
38	1064
38	1065
38	1066
38	1067
38	1068
38	1069
38	1070
38	1071
38	1072
38	1073
38	1074
38	1075
38	1076
38	1077
38	1078
38	1079
38	1080
38	1081
38	1082
38	1083
38	1084
38	1085
38	1086
38	1087
38	1088
38	1089
38	1090
38	1091
38	1092
38	1093
38	1094
38	1095
38	1096
38	1097
38	1098
38	1099
38	1100
38	1101
38	1102
38	1103
38	1104
38	1105
38	1106
38	1107
38	1108
38	1109
38	1110
38	1111
38	1112
38	1113
38	1114
38	1115
38	1116
38	1117
38	1118
38	1119
38	1120
38	1121
38	1122
38	1123
38	1124
38	1125
38	1126
38	1127
38	1128
38	1129
38	1130
38	1131
38	1132
38	1133
38	1134
38	1135
38	1136
38	1137
38	1138
38	1139
38	1140
38	1141
38	1142
38	1143
38	1144
38	1145
38	1146
38	1147
38	1148
38	1149
38	1150
38	1151
38	1152
38	1153
38	1154
38	1155
38	1156
38	1157
38	1158
38	1159
38	1160
38	1161
38	1162
38	1163
38	1164
38	1165
38	1166
38	1167
38	1168
38	1169
38	1170
38	1171
38	1172
38	1173
38	1174
38	1175
38	1176
38	1177
38	1178
38	1179
38	1180
38	1181
38	1182
38	1183
38	1184
38	1185
38	1186
38	1187
38	1188
38	1189
38	1190
38	1191
38	1192
38	1193
38	1194
38	1195
38	1196
38	1197
38	1198
38	1199
38	700
38	701
38	702
38	703
38	704
38	705
38	706
38	707
38	708
38	709
38	710
38	711
38	712
38	713
38	714
38	715
38	716
38	717
38	718
38	719
38	720
38	721
38	722
38	723
38	724
38	725
38	726
38	727
38	728
38	729
38	730
38	731
38	732
38	733
38	734
38	735
38	736
38	737
38	738
38	739
38	740
38	741
38	742
38	743
38	744
38	745
38	746
38	747
38	748
38	749
38	750
38	751
38	752
38	753
38	754
38	755
38	756
38	757
38	758
38	759
38	760
38	761
38	762
38	763
38	764
38	765
38	766
38	767
38	768
38	769
38	770
38	771
38	772
38	773
38	774
38	775
38	776
38	777
38	778
38	779
38	780
38	781
38	782
38	783
38	784
38	785
38	786
38	787
38	788
38	789
38	790
38	791
38	792
38	793
38	794
38	795
38	796
38	797
38	798
38	799
38	800
38	801
38	802
38	803
38	804
38	805
38	806
38	807
38	808
38	809
38	810
38	811
38	812
38	813
38	814
38	815
38	816
38	817
38	818
38	819
38	820
38	821
38	822
38	823
38	824
38	825
38	826
38	827
38	828
38	829
38	830
38	831
38	832
38	833
38	834
38	835
38	836
38	837
38	838
38	839
38	840
38	841
38	842
38	843
38	844
38	845
38	846
38	847
38	848
38	849
38	850
38	851
38	852
38	853
38	854
38	855
38	856
38	857
38	858
38	859
38	860
38	861
38	862
38	863
38	864
38	865
38	866
38	867
38	868
38	869
38	870
38	871
38	872
38	873
38	874
38	875
38	876
38	877
38	878
38	879
38	880
38	881
38	882
38	883
38	884
38	885
38	886
38	887
38	888
38	889
38	890
38	891
38	892
38	893
38	894
38	895
38	896
38	897
38	898
38	899
38	900
38	901
38	902
38	903
38	904
38	905
38	906
38	907
38	908
38	909
38	910
38	911
38	912
38	913
38	914
38	915
38	916
38	917
38	918
38	919
38	920
38	921
38	922
38	923
38	924
38	925
38	926
38	927
38	928
38	929
38	930
38	931
38	932
38	933
38	934
38	935
38	936
38	937
38	938
38	939
38	940
38	941
38	942
38	943
38	944
38	945
38	946
38	947
38	948
38	949
38	950
38	951
38	952
38	953
38	954
38	955
38	956
38	957
38	958
38	959
38	960
38	961
38	962
38	963
38	964
38	965
38	966
38	967
38	968
38	969
38	970
38	971
38	972
38	973
38	974
38	975
38	976
38	977
38	978
38	979
38	980
38	981
38	982
38	983
38	984
38	985
38	986
38	987
38	988
38	989
38	990
38	991
38	992
38	993
38	994
38	995
38	996
38	997
38	998
38	999
38	1000
38	1001
38	1002
38	1003
38	1004
38	1005
38	1006
38	1007
38	1008
38	1009
38	1010
38	1011
38	1012
38	1013
38	1014
38	1015
38	1016
38	1017
38	1018
38	1019
38	1020
38	1021
38	1022
38	1023
139	1216
139	1217
139	1218
139	1219
139	1220
139	1221
139	1222
139	1223
139	1200
139	1201
139	1202
139	1203
139	1204
139	1205
139	1206
139	1207
139	1208
139	1209
139	1210
139	1211
139	1212
139	1213
139	1214
139	1215
150	1224
150	1225
150	1226
150	1227
150	1228
150	1229
150	1230
150	1231
153	1232
153	1233
153	1234
153	1235
153	1236
153	1237
153	1238
153	1239
156	1240
156	1241
156	1242
156	1243
156	1244
156	1245
156	1246
156	1247
159	1024
159	1025
159	1026
159	1027
159	1028
159	1030
159	1031
159	1032
159	1033
159	1034
159	1035
159	1037
159	1038
159	1039
159	1040
159	1042
159	1043
159	1044
159	1045
159	1046
159	1047
159	1048
159	1049
159	1050
159	1051
159	1052
159	1053
159	1054
159	1055
159	1057
159	1058
159	1060
159	1061
159	1062
159	1063
159	1064
159	1065
159	1066
159	1067
159	1068
159	1069
159	1070
159	1071
159	1072
159	1073
159	1075
159	1076
159	1077
159	1081
159	1082
159	1083
159	1084
159	1085
159	1088
159	1090
159	1091
159	1092
159	1093
159	1094
159	1095
159	1096
159	1098
159	1099
159	1100
159	1103
159	1105
159	1106
159	1107
159	1108
159	1109
159	1110
159	1111
159	1112
159	1113
159	1114
159	1115
159	1117
159	1119
159	1122
159	1123
159	1124
159	1125
159	1126
159	1127
159	1129
159	1130
159	1131
159	1132
159	1133
159	1134
159	1135
159	1137
159	1138
159	1139
159	1140
159	1142
159	1143
159	1144
159	1145
159	1146
159	1147
159	1150
159	1151
159	1152
159	1154
159	1155
159	1156
159	1157
159	1158
159	1159
159	1160
159	1161
159	1163
159	1165
159	1166
159	1167
159	1168
159	1169
159	1170
159	1172
159	1173
159	1174
159	1175
159	1176
159	1177
159	1178
159	1179
159	1181
159	1183
159	1184
159	1185
159	1187
159	1189
159	1190
159	1191
159	1192
159	1193
159	1195
159	1196
159	1197
159	1199
159	1248
159	1249
159	1250
159	1251
159	1252
159	1253
159	1254
159	1255
159	1256
159	1257
159	1258
159	1259
159	1260
159	1261
159	1262
159	1263
159	1264
159	1265
159	1266
159	1267
159	1268
159	1269
159	1270
159	1271
159	1272
159	1273
159	1274
159	1275
159	1276
159	1277
159	1278
159	1279
159	1280
159	1281
159	1282
159	1283
159	1284
159	1285
159	1286
159	1287
159	1288
159	1289
159	1290
159	1291
159	1292
159	1293
159	1294
159	1295
159	1296
159	1297
159	1298
159	1299
159	1300
159	1301
159	1302
159	1303
159	1304
159	1305
159	1306
159	1307
159	1308
159	1309
159	1310
159	1311
159	1312
159	1313
159	1314
159	1315
159	1316
159	1317
159	1318
159	1319
159	1320
159	1321
159	1322
159	1323
159	1324
159	1325
159	1326
159	1327
159	1328
159	1329
159	1330
159	1331
159	1332
159	1333
159	1334
159	1335
159	1336
159	1337
159	1338
159	1339
159	1340
159	1341
159	1342
159	1343
159	1344
159	1345
159	1346
159	701
159	702
159	703
159	704
159	705
159	706
159	707
159	708
159	709
159	710
159	711
159	712
159	713
159	714
159	715
159	716
159	717
159	718
159	719
159	720
159	721
159	722
159	723
159	724
159	726
159	728
159	729
159	730
159	731
159	733
159	734
159	735
159	737
159	739
159	740
159	741
159	742
159	743
159	745
159	746
159	747
159	749
159	750
159	751
159	752
159	753
159	754
159	755
159	757
159	758
159	759
159	760
159	761
159	763
159	765
159	766
159	768
159	769
159	770
159	771
159	772
159	773
159	774
159	775
159	776
159	779
159	780
159	781
159	782
159	783
159	784
159	786
159	787
159	788
159	789
159	790
159	791
159	793
159	794
159	795
159	796
159	797
159	798
159	799
159	800
159	801
159	802
159	803
159	804
159	805
159	806
159	807
159	808
159	809
159	811
159	812
159	814
159	815
159	817
159	818
159	819
159	820
159	821
159	822
159	823
159	824
159	825
159	826
159	828
159	829
159	831
159	832
159	833
159	834
159	835
159	836
159	838
159	839
159	841
159	842
159	844
159	845
159	847
159	848
159	849
159	850
159	851
159	852
159	853
159	854
159	855
159	856
159	857
159	858
159	859
159	860
159	861
159	862
159	863
159	864
159	865
159	866
159	867
159	868
159	869
159	870
159	871
159	872
159	876
159	879
159	880
159	881
159	882
159	883
159	887
159	889
159	892
159	893
159	895
159	896
159	897
159	898
159	899
159	900
159	901
159	902
159	903
159	904
159	905
159	906
159	907
159	908
159	909
159	913
159	914
159	916
159	917
159	918
159	919
159	920
159	922
159	924
159	925
159	927
159	930
159	931
159	932
159	933
159	934
159	935
159	936
159	937
159	942
159	943
159	945
159	947
159	948
159	949
159	950
159	951
159	953
159	954
159	955
159	956
159	957
159	959
159	960
159	962
159	963
159	964
159	965
159	966
159	967
159	968
159	969
159	970
159	971
159	972
159	973
159	975
159	976
159	977
159	979
159	980
159	981
159	982
159	983
159	984
159	985
159	987
159	988
159	989
159	991
159	992
159	993
159	995
159	996
159	997
159	998
159	999
159	1000
159	1002
159	1004
159	1005
159	1006
159	1008
159	1009
159	1010
159	1011
159	1012
159	1013
159	1014
159	1015
159	1016
159	1017
159	1018
159	1019
159	1020
159	1022
159	1023
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
199	1376
199	1377
199	1378
199	1379
199	1380
199	1381
199	1382
199	1383
199	1384
199	1385
199	1386
199	1387
199	1388
199	1370
199	1371
199	1372
199	1373
199	1374
199	1375
201	1024
201	1025
201	1026
201	1027
201	1028
201	1030
201	1031
201	1033
201	1034
201	1035
201	1037
201	1038
201	1039
201	1040
201	1042
201	1043
201	1044
201	1045
201	1046
201	1047
201	1048
201	1049
201	1050
201	1051
201	1053
201	1054
201	1055
201	1057
201	1058
201	1059
201	1060
201	1061
201	1062
201	1063
201	1064
201	1065
201	1066
201	1067
201	1068
201	1069
201	1070
201	1071
201	1072
201	1073
201	1075
201	1076
201	1077
201	1078
201	1081
201	1082
201	1083
201	1084
201	1085
201	1091
201	1092
201	1093
201	1094
201	1095
201	1096
201	1097
201	1098
201	1099
201	1100
201	1101
201	1103
201	1104
201	1105
201	1106
201	1107
201	1108
201	1110
201	1111
201	1112
201	1113
201	1114
201	1115
201	1117
201	1118
201	1119
201	1121
201	1122
201	1123
201	1124
201	1125
201	1126
201	1127
201	1130
201	1131
201	1132
201	1133
201	1134
201	1135
201	1137
201	1138
201	1139
201	1140
201	1142
201	1143
201	1144
201	1145
201	1146
201	1147
201	1150
201	1151
201	1152
201	1154
201	1155
201	1156
201	1157
201	1158
201	1159
201	1160
201	1161
201	1162
201	1163
201	1165
201	1166
201	1167
201	1168
201	1169
201	1170
201	1172
201	1173
201	1174
201	1175
201	1176
201	1177
201	1178
201	1179
201	1181
201	1183
201	1184
201	1185
201	1187
201	1188
201	1189
201	1190
201	1191
201	1192
201	1193
201	1194
201	1195
201	1196
201	1197
201	1199
201	1258
201	1264
201	1265
201	1269
201	1271
201	1284
201	1289
201	1291
201	1297
201	1299
201	1305
201	1317
201	1321
201	1323
201	1325
201	1327
201	1336
201	1343
201	1345
201	1389
201	1390
201	1391
201	1392
201	1393
201	1394
201	1395
201	1396
201	1397
201	1398
201	1399
201	1400
201	1401
201	1402
201	1403
201	1404
201	1405
201	1406
201	1407
201	1408
201	1409
201	1410
201	1411
201	1412
201	1413
201	1414
201	1415
201	1416
201	1417
201	1418
201	1419
201	1420
201	1421
201	1422
201	1423
201	1424
201	1425
201	1426
201	1427
201	1428
201	1429
201	1430
201	1431
201	1432
201	1433
201	1434
201	1435
201	1436
201	1437
201	1438
201	1439
201	1440
201	1441
201	1442
201	1443
201	1444
201	1445
201	1446
201	1447
201	1448
201	1449
201	1450
201	1451
201	1452
201	1453
201	1454
201	1455
201	1456
201	1457
201	1458
201	1459
201	1460
201	1461
201	1462
201	1463
201	1464
201	1465
201	1466
201	1467
201	1468
201	1469
201	1470
201	1471
201	1472
201	701
201	702
201	703
201	704
201	705
201	706
201	707
201	709
201	710
201	711
201	712
201	713
201	714
201	715
201	716
201	717
201	719
201	720
201	721
201	722
201	723
201	724
201	726
201	728
201	729
201	730
201	731
201	733
201	735
201	737
201	739
201	740
201	741
201	742
201	743
201	745
201	746
201	747
201	749
201	750
201	751
201	752
201	753
201	755
201	757
201	758
201	760
201	761
201	763
201	765
201	766
201	768
201	769
201	770
201	771
201	772
201	773
201	774
201	775
201	776
201	779
201	780
201	781
201	782
201	783
201	784
201	786
201	787
201	788
201	789
201	790
201	793
201	794
201	795
201	796
201	797
201	799
201	800
201	801
201	802
201	803
201	804
201	805
201	807
201	808
201	809
201	811
201	812
201	814
201	815
201	817
201	818
201	819
201	820
201	821
201	822
201	823
201	824
201	825
201	826
201	828
201	829
201	831
201	832
201	833
201	834
201	835
201	836
201	838
201	839
201	841
201	842
201	844
201	845
201	847
201	848
201	849
201	850
201	851
201	852
201	853
201	854
201	855
201	856
201	858
201	859
201	860
201	861
201	862
201	863
201	864
201	865
201	866
201	867
201	868
201	870
201	871
201	872
201	873
201	874
201	877
201	879
201	880
201	881
201	882
201	883
201	887
201	889
201	893
201	895
201	896
201	897
201	898
201	899
201	900
201	901
201	902
201	903
201	904
201	905
201	906
201	908
201	912
201	913
201	914
201	916
201	917
201	919
201	920
201	922
201	923
201	924
201	925
201	927
201	928
201	929
201	930
201	931
201	932
201	933
201	934
201	935
201	936
201	937
201	940
201	942
201	945
201	947
201	948
201	949
201	950
201	951
201	953
201	954
201	955
201	956
201	957
201	959
201	960
201	962
201	963
201	964
201	965
201	966
201	967
201	968
201	969
201	970
201	971
201	972
201	973
201	974
201	975
201	976
201	977
201	979
201	980
201	981
201	982
201	983
201	984
201	985
201	987
201	988
201	989
201	991
201	992
201	993
201	995
201	997
201	998
201	999
201	1000
201	1001
201	1002
201	1004
201	1006
201	1008
201	1009
201	1010
201	1011
201	1012
201	1013
201	1014
201	1015
201	1016
201	1017
201	1018
201	1019
201	1020
201	1022
201	1023
240	1536
240	1537
240	1538
240	1539
240	1540
240	1541
240	1542
240	1543
240	1544
240	1545
240	1546
240	1547
240	1548
240	1549
240	1550
240	1551
240	1552
240	1553
240	1554
240	1555
240	1556
240	1557
240	1558
240	1559
240	1560
240	1561
240	1562
240	1563
240	1564
240	1565
240	1566
240	1567
240	1568
240	1569
240	1570
240	1571
240	1572
240	1573
240	1574
240	1575
240	1576
240	1577
240	1578
240	1579
240	1580
240	1581
240	1582
240	1583
240	1584
240	1585
240	1586
240	1587
240	1588
240	1589
240	1590
240	1591
240	1592
240	1593
240	1594
240	1595
240	1596
240	1597
240	1598
240	1599
240	1600
240	1601
240	1602
240	1603
240	1604
240	1605
240	1606
240	1607
240	1608
240	1609
240	1610
240	1611
240	1612
240	1613
240	1614
240	1615
240	1616
240	1617
240	1618
240	1619
240	1620
240	1621
240	1622
240	1623
240	1624
240	1625
240	1626
240	1627
240	1628
240	1629
240	1630
240	1631
240	1632
240	1633
240	1634
240	1635
240	1636
240	1637
240	1638
240	1639
240	1640
240	1641
240	1642
240	1643
240	1644
240	1645
240	1646
240	1647
240	1648
240	1649
240	1650
240	1651
240	1652
240	1653
240	1654
240	1655
240	1656
240	1657
240	1658
240	1659
240	1660
240	1661
240	1662
240	1663
240	1664
240	1665
240	1666
240	1667
240	1668
240	1669
240	1670
240	1671
240	1672
240	1673
240	1674
240	1675
240	1676
240	1677
240	1678
240	1679
240	1680
240	1681
240	1682
240	1683
240	1684
240	1685
240	1686
240	1687
240	1688
240	1689
240	1690
240	1691
240	1692
240	1693
240	1694
240	1695
240	1696
240	1697
240	1698
240	1699
240	1700
240	1701
240	1702
240	1703
240	1704
240	1705
240	1706
240	1707
240	1708
240	1709
240	1710
240	1711
240	1712
240	1713
240	1714
240	1715
240	1716
240	1717
240	1473
240	1474
240	1475
240	1476
240	1477
240	1478
240	1479
240	1480
240	1481
240	1482
240	1483
240	1484
240	1485
240	1486
240	1487
240	1488
240	1489
240	1490
240	1491
240	1492
240	1493
240	1494
240	1495
240	1496
240	1497
240	1498
240	1499
240	1500
240	1501
240	1502
240	1503
240	1504
240	1505
240	1506
240	1507
240	1508
240	1509
240	1510
240	1511
240	1512
240	1513
240	1514
240	1515
240	1516
240	1517
240	1518
240	1519
240	1520
240	1521
240	1522
240	1523
240	1524
240	1525
240	1526
240	1527
240	1528
240	1529
240	1530
240	1531
240	1532
240	1533
240	1534
240	1535
302	1728
302	1729
302	1718
302	1719
302	1720
302	1721
302	1722
302	1723
302	1724
302	1725
302	1726
302	1727
304	1760
304	614
304	617
304	618
304	588
304	1230
304	623
304	1231
304	692
304	1751
304	1240
304	1752
304	696
304	1753
304	1241
304	1754
304	1242
304	698
304	1755
304	1756
304	1757
304	1758
304	1759
304	607
307	1792
307	1793
307	1794
307	1795
307	1796
307	1797
307	1798
307	1774
307	1775
307	1776
307	1777
307	1778
307	1779
307	1780
307	1781
307	1782
307	1783
307	1784
307	1785
307	1786
307	1787
307	1788
307	1789
307	1790
307	1791
313	1799
313	1800
313	1801
313	1802
313	1803
313	1804
313	1805
313	1806
313	1807
313	1808
313	1809
313	1810
313	1811
313	1812
313	1813
313	1814
313	1815
313	1816
313	1817
313	1818
313	1819
313	1820
317	1824
317	1825
317	1826
317	1827
317	1828
317	1829
317	1830
317	1831
317	1832
317	1833
317	1834
317	1835
317	1836
317	1837
317	1838
317	1839
317	1840
317	1233
317	1841
317	1842
317	1821
317	1822
317	1823
325	1856
325	1857
325	1858
325	1859
325	1860
325	1861
325	1862
325	1863
325	1864
325	1865
325	1866
325	1843
325	1844
325	1845
325	1846
325	1847
325	1848
325	1849
325	1850
325	1851
325	1852
325	1853
325	1854
325	1855
332	1877
332	1878
332	1879
335	1872
335	1873
335	1874
335	1875
335	1876
335	1867
335	1868
335	1869
335	1870
335	1871
340	2048
340	2049
340	2050
340	2051
340	2052
340	2053
340	2054
340	2055
340	2056
340	2057
340	2058
340	2059
340	2060
340	2061
340	2062
340	2063
340	2064
340	2065
340	2066
340	2067
340	2068
340	2069
340	2070
340	2071
340	2072
340	2073
340	2074
340	2075
340	2076
340	2077
340	2078
340	2079
340	2080
340	2081
340	2082
340	2083
340	2084
340	2085
340	2086
340	2087
340	2088
340	2089
340	2090
340	2091
340	2092
340	2093
340	2094
340	2095
340	2096
340	2097
340	2098
340	2099
340	1880
340	1881
340	1882
340	1883
340	1884
340	1885
340	1886
340	1887
340	1888
340	1889
340	1890
340	1891
340	1892
340	1893
340	1894
340	1895
340	1896
340	1897
340	1898
340	1899
340	1900
340	1901
340	1902
340	1903
340	1904
340	1905
340	1906
340	1907
340	1908
340	1909
340	1910
340	1911
340	1912
340	1913
340	1914
340	1915
340	1916
340	1917
340	1918
340	1919
340	1920
340	1921
340	1922
340	1923
340	1924
340	1925
340	1926
340	1927
340	1928
340	1929
340	1930
340	1931
340	1932
340	1933
340	1934
340	1935
340	1936
340	1937
340	1938
340	1939
340	1940
340	1941
340	1942
340	1943
340	1944
340	1945
340	1946
340	1947
340	1948
340	1949
340	1950
340	1951
340	1952
340	1953
340	1954
340	1955
340	1956
340	1957
340	1958
340	1959
340	1960
340	1961
340	1962
340	1963
340	1964
340	1965
340	1966
340	1967
340	1968
340	1969
340	1970
340	1971
340	1972
340	1973
340	1974
340	1975
340	1976
340	1977
340	1978
340	1979
340	1980
340	1981
340	1982
340	1983
340	1984
340	1985
340	1986
340	1987
340	1988
340	1989
340	1990
340	1991
340	1992
340	1993
340	1994
340	1995
340	1996
340	1997
340	1998
340	1999
340	2000
340	2001
340	2002
340	2003
340	2004
340	2005
340	2006
340	2007
340	2008
340	2009
340	2010
340	2011
340	2012
340	2013
340	2014
340	2015
340	2016
340	2017
340	2018
340	2019
340	2020
340	2021
340	2022
340	2023
340	2024
340	2025
340	2026
340	2027
340	2028
340	2029
340	2030
340	2031
340	2032
340	2033
340	2034
340	2035
340	2036
340	2037
340	2038
340	2039
340	2040
340	2041
340	2042
340	2043
340	2044
340	2045
340	2046
340	2047
411	1025
411	1026
411	1027
411	1030
411	1033
411	1034
411	1035
411	1036
411	1037
411	1038
411	1039
411	1040
411	1042
411	1043
411	1045
411	1047
411	1048
411	1049
411	1051
411	1054
411	1055
411	1057
411	1058
411	1060
411	1061
411	1062
411	1063
411	1064
411	1065
411	1066
411	1067
411	1068
411	1069
411	1070
411	1071
411	1072
411	1073
411	2100
411	1076
411	2101
411	1077
411	2102
411	2103
411	2104
411	2105
411	1081
411	2106
411	2107
411	1083
411	2108
411	1084
411	2109
411	1085
411	2110
411	2111
411	2112
411	1088
411	2113
411	2114
411	2115
411	1091
411	2116
411	2117
411	1093
411	2118
411	1094
411	2119
411	1095
411	2120
411	1096
411	2121
411	2122
411	2123
411	1099
411	2124
411	1100
411	2125
411	2126
411	2127
411	1103
411	2128
411	2129
411	1105
411	2130
411	1106
411	2131
411	2132
411	1108
411	2133
411	2134
411	1110
411	2135
411	2136
411	1112
411	2137
411	1113
411	2138
411	1114
411	2139
411	2140
411	2141
411	1117
411	2142
411	2143
411	2144
411	2145
411	1121
411	2146
411	1122
411	2147
411	1123
411	2148
411	1124
411	2149
411	1125
411	2150
411	2151
411	1127
411	2152
411	2153
411	1129
411	2154
411	1130
411	2155
411	1131
411	2156
411	1132
411	2157
411	2158
411	1134
411	2159
411	1135
411	2160
411	2161
411	2162
411	2163
411	2164
411	2165
411	2166
411	1142
411	2167
411	2168
411	1144
411	2169
411	2170
411	1146
411	2171
411	1147
411	2172
411	2173
411	1149
411	2174
411	1150
411	2175
411	1151
411	2176
411	1152
411	2177
411	2178
411	2179
411	1155
411	2180
411	1156
411	2181
411	1157
411	2182
411	1158
411	2183
411	1159
411	2184
411	1160
411	2185
411	1161
411	2186
411	1162
411	2187
411	1163
411	2188
411	2189
411	2190
411	1166
411	2191
411	2192
411	1168
411	2193
411	2194
411	1170
411	2195
411	1171
411	2196
411	2197
411	1173
411	2198
411	1174
411	2199
411	1175
411	2200
411	1176
411	2201
411	2202
411	1178
411	2203
411	2204
411	1180
411	2205
411	1181
411	2206
411	1182
411	2207
411	1183
411	2208
411	1184
411	2209
411	2210
411	2211
411	1187
411	2212
411	2213
411	1189
411	2214
411	2215
411	1191
411	2216
411	2217
411	1193
411	2218
411	1194
411	2219
411	1195
411	2220
411	1196
411	2221
411	1197
411	2222
411	2223
411	1199
411	2224
411	2225
411	2226
411	2227
411	2228
411	2229
411	2230
411	2231
411	2232
411	2233
411	2234
411	2235
411	2236
411	2237
411	2238
411	2239
411	2240
411	2241
411	2242
411	2243
411	2244
411	2245
411	2246
411	2247
411	2248
411	2249
411	2250
411	2251
411	2252
411	2253
411	2254
411	2255
411	2256
411	2257
411	2258
411	2259
411	2260
411	2261
411	2262
411	2263
411	2264
411	2265
411	2266
411	2267
411	2268
411	2269
411	2270
411	2271
411	2272
411	2273
411	2274
411	2275
411	2276
411	1271
411	1275
411	1284
411	1291
411	1297
411	1321
411	1324
411	1325
411	1327
411	1345
411	1396
411	1398
411	1405
411	1414
411	1418
411	1422
411	1431
411	1435
411	1440
411	1443
411	1444
411	1445
411	1454
411	1468
411	701
411	703
411	705
411	706
411	707
411	709
411	710
411	715
411	716
411	717
411	719
411	720
411	721
411	722
411	723
411	726
411	728
411	729
411	730
411	731
411	733
411	734
411	737
411	739
411	740
411	741
411	743
411	745
411	748
411	749
411	750
411	751
411	752
411	753
411	755
411	757
411	758
411	760
411	761
411	765
411	766
411	769
411	770
411	771
411	773
411	774
411	775
411	776
411	779
411	780
411	781
411	782
411	783
411	784
411	787
411	790
411	793
411	794
411	795
411	796
411	797
411	799
411	800
411	801
411	802
411	803
411	805
411	807
411	808
411	809
411	811
411	814
411	815
411	817
411	819
411	820
411	821
411	824
411	828
411	829
411	831
411	832
411	833
411	835
411	836
411	839
411	841
411	842
411	844
411	845
411	848
411	849
411	850
411	851
411	852
411	853
411	854
411	855
411	856
411	858
411	859
411	860
411	861
411	862
411	864
411	865
411	866
411	867
411	868
411	871
411	872
411	873
411	874
411	879
411	880
411	881
411	882
411	883
411	887
411	889
411	895
411	896
411	897
411	899
411	900
411	904
411	906
411	913
411	914
411	917
411	918
411	919
411	920
411	922
411	924
411	925
411	927
411	930
411	931
411	933
411	934
411	935
411	936
411	940
411	942
411	945
411	948
411	950
411	951
411	953
411	954
411	955
411	956
411	957
411	959
411	960
411	962
411	963
411	965
411	966
411	968
411	969
411	970
411	971
411	977
411	979
411	980
411	981
411	983
411	984
411	985
411	988
411	989
411	991
411	992
411	993
411	995
411	997
411	998
411	999
411	1000
411	1002
411	1004
411	1006
411	1008
411	1009
411	1010
411	1011
411	1012
411	1014
411	1016
411	1017
411	1018
411	1019
411	1020
411	1022
411	1023
458	2288
458	2277
458	2278
458	2279
458	2280
458	2281
458	2282
458	2283
458	2284
458	2285
458	2286
458	2287
461	2100
461	2101
461	2103
461	2104
461	2105
461	2108
461	2109
461	2110
461	2112
461	2113
461	2114
461	2115
461	2116
461	2118
461	2119
461	2120
461	2121
461	2123
461	2124
461	2125
461	2127
461	2129
461	2130
461	2131
461	2132
461	2133
461	2136
461	2137
461	2139
461	2140
461	2141
461	2142
461	2143
461	2144
461	2146
461	2147
461	2148
461	2151
461	2152
461	2153
461	2154
461	2155
461	2156
461	2157
461	2158
461	2159
461	2160
461	2161
461	2162
461	2164
461	2165
461	2166
461	2169
461	2170
461	2171
461	2176
461	2177
461	2179
461	2180
461	2181
461	2183
461	2185
461	2187
461	2189
461	2190
461	2193
461	2196
461	2197
461	2198
461	2199
461	2203
461	2204
461	2206
461	2207
461	2208
461	2209
461	2212
461	2213
461	2215
461	2217
461	2219
461	2220
461	2224
461	2226
461	2229
461	2230
461	2231
461	2232
461	2233
461	2238
461	2239
461	2241
461	2242
461	2243
461	2245
461	2246
461	2247
461	2248
461	2249
461	2253
461	2256
461	2257
461	2258
461	2259
461	2261
461	2263
461	2265
461	2266
461	2268
461	2269
461	2270
461	2272
461	2273
461	2274
461	2275
461	2276
461	2289
461	2290
461	2291
461	2292
461	2293
461	2294
461	2295
461	2296
461	2297
461	2298
461	2299
461	2300
461	2301
461	2302
461	2303
461	2304
461	2305
461	2306
461	2307
461	2308
461	2309
461	2310
461	2311
461	2312
461	2313
461	2314
461	2315
461	2316
461	2317
461	2318
461	2319
461	2320
461	2321
461	2322
461	2323
461	2324
461	2325
461	2326
461	2327
461	2328
461	2329
461	2330
461	2331
461	2332
461	2333
461	2334
461	2335
461	2336
461	2337
461	2338
461	2339
461	2340
461	2341
461	2342
461	2343
461	2344
461	2345
461	2346
461	2347
461	2348
461	2349
461	2350
461	2351
461	2352
461	2353
461	2354
461	2355
461	2356
461	2357
461	2358
461	2359
461	2360
461	2361
461	2362
461	2363
461	2364
461	2365
461	2366
461	2367
461	2368
461	2369
461	2370
461	2371
461	2372
461	2373
461	2374
461	2375
461	2376
461	2377
461	2378
461	2379
461	2380
461	2381
461	2382
461	2383
461	2384
461	2385
461	2386
461	2387
461	2388
461	2389
461	2390
461	2391
461	2392
461	2393
461	2394
461	2395
461	2396
461	2397
461	2398
461	2399
461	2400
461	2401
461	2402
498	836
498	2418
498	1650
498	2419
498	2420
498	2421
498	2422
498	2423
498	2424
498	1400
498	2425
498	2426
498	2427
498	2428
498	2429
498	2430
507	2432
507	2433
507	2434
507	2435
507	2436
507	2437
507	2438
507	2439
507	2440
507	2441
507	2442
507	2443
507	2444
507	2445
507	2446
507	2431
516	2448
516	2449
516	2450
516	2451
516	2452
516	2453
516	2454
516	2455
516	2456
516	2457
516	2458
516	2447
519	1024
519	1025
519	1026
519	1027
519	1028
519	1030
519	1031
519	1033
519	1034
519	1035
519	1037
519	1038
519	1039
519	1040
519	1042
519	1043
519	1044
519	1045
519	1046
519	1047
519	1048
519	1049
519	1050
519	1051
519	1052
519	1053
519	1054
519	1055
519	1057
519	1058
519	1060
519	1061
519	1062
519	1063
519	1064
519	1065
519	1066
519	1067
519	1068
519	1069
519	1070
519	1071
519	1072
519	1073
519	1075
519	1076
519	1077
519	1078
519	1081
519	1082
519	1083
519	1084
519	1085
519	1091
519	1092
519	1093
519	1094
519	1095
519	1096
519	1097
519	1098
519	1099
519	1100
519	1101
519	1103
519	1104
519	1105
519	1106
519	1107
519	1108
519	1110
519	1111
519	1112
519	1113
519	1114
519	1115
519	1117
519	1118
519	1119
519	1121
519	1122
519	1123
519	1124
519	1125
519	1126
519	1127
519	1130
519	1131
519	1132
519	1133
519	1134
519	1135
519	1137
519	1138
519	1139
519	1140
519	1142
519	1143
519	1144
519	1145
519	1146
519	1147
519	1150
519	1151
519	1152
519	1154
519	1155
519	1156
519	1157
519	1158
519	1159
519	1160
519	1161
519	1162
519	1163
519	1165
519	1166
519	1167
519	1168
519	1169
519	1170
519	1171
519	1172
519	1173
519	1174
519	1175
519	1176
519	1177
519	1178
519	1179
519	1181
519	1183
519	1184
519	1185
519	1187
519	1188
519	1189
519	1190
519	1191
519	1192
519	1193
519	1194
519	1195
519	1196
519	1197
519	1199
519	1258
519	1264
519	1265
519	1269
519	1271
519	1284
519	1289
519	1291
519	1297
519	1299
519	1305
519	1317
519	1325
519	1327
519	1336
519	1343
519	1345
519	1389
519	1390
519	1391
519	1392
519	1396
519	1398
519	1399
519	1401
519	1403
519	1405
519	1406
519	1407
519	1408
519	1409
519	1411
519	1412
519	1414
519	1416
519	1417
519	1419
519	1420
519	1421
519	1425
519	1427
519	1428
519	1429
519	1430
519	1433
519	1434
519	2459
519	1435
519	2460
519	1436
519	2461
519	1437
519	2462
519	1438
519	2463
519	1439
519	2464
519	1440
519	2465
519	1441
519	2466
519	1442
519	2467
519	1443
519	2468
519	1444
519	2469
519	1445
519	2470
519	1446
519	2471
519	1447
519	2472
519	1448
519	2473
519	1449
519	1450
519	2474
519	1451
519	2475
519	1452
519	2476
519	1453
519	2477
519	1454
519	2478
519	1455
519	1456
519	1457
519	1459
519	1461
519	1462
519	1464
519	1465
519	1466
519	1467
519	1468
519	1469
519	1470
519	1471
519	701
519	702
519	703
519	704
519	705
519	706
519	707
519	709
519	710
519	711
519	712
519	713
519	714
519	715
519	716
519	717
519	719
519	720
519	721
519	722
519	723
519	724
519	726
519	728
519	729
519	730
519	731
519	733
519	735
519	737
519	739
519	740
519	741
519	742
519	743
519	745
519	746
519	747
519	749
519	750
519	751
519	752
519	753
519	755
519	757
519	758
519	760
519	761
519	763
519	765
519	766
519	768
519	769
519	770
519	771
519	772
519	773
519	774
519	775
519	776
519	779
519	780
519	781
519	782
519	783
519	784
519	786
519	787
519	788
519	789
519	790
519	793
519	794
519	795
519	796
519	797
519	798
519	799
519	800
519	801
519	802
519	803
519	805
519	807
519	808
519	809
519	811
519	812
519	814
519	815
519	817
519	818
519	819
519	820
519	821
519	822
519	823
519	824
519	825
519	826
519	828
519	829
519	831
519	832
519	833
519	834
519	835
519	836
519	838
519	839
519	841
519	842
519	844
519	845
519	847
519	848
519	849
519	850
519	851
519	852
519	853
519	854
519	855
519	856
519	858
519	859
519	860
519	861
519	862
519	863
519	864
519	865
519	866
519	867
519	868
519	869
519	870
519	871
519	872
519	873
519	874
519	877
519	879
519	880
519	881
519	882
519	883
519	887
519	889
519	893
519	895
519	896
519	897
519	898
519	899
519	900
519	901
519	902
519	903
519	904
519	905
519	906
519	908
519	912
519	913
519	914
519	916
519	917
519	919
519	920
519	922
519	923
519	924
519	925
519	927
519	928
519	929
519	930
519	931
519	932
519	933
519	934
519	935
519	936
519	940
519	942
519	945
519	947
519	948
519	949
519	950
519	951
519	952
519	953
519	954
519	955
519	956
519	957
519	958
519	959
519	960
519	962
519	963
519	964
519	965
519	966
519	967
519	968
519	969
519	970
519	971
519	972
519	973
519	974
519	975
519	976
519	977
519	979
519	980
519	981
519	982
519	983
519	984
519	985
519	987
519	988
519	989
519	991
519	992
519	993
519	995
519	997
519	998
519	999
519	1000
519	1001
519	1002
519	1004
519	1006
519	1008
519	1009
519	1010
519	1011
519	1012
519	1013
519	1014
519	1015
519	1016
519	1017
519	1018
519	1019
519	1020
519	1022
519	1023
541	2496
541	2497
541	2498
541	2499
541	2500
541	2501
541	2502
541	2503
541	2479
541	2480
541	2481
541	2482
541	2483
541	2484
541	2485
541	2486
541	2487
541	2488
541	2489
541	2490
541	2491
541	2492
541	2493
541	2494
541	2495
547	2504
547	2505
547	649
547	2506
547	2507
547	652
547	2508
547	653
547	2509
547	2510
547	2511
547	655
547	2512
547	656
547	2513
547	658
547	2514
547	2515
547	660
547	2516
547	661
547	2517
547	662
547	2518
547	2519
547	2520
547	664
547	2521
547	2522
547	2523
547	667
547	2524
547	2525
547	2526
547	2527
547	2528
547	2529
547	2530
547	2531
547	2532
547	2533
547	2534
547	2535
554	2560
554	2561
554	2536
554	2537
554	2538
554	2539
554	2540
554	2541
554	2542
554	2543
554	2544
554	2545
554	2546
554	2547
554	2548
554	2549
554	2550
554	2551
554	2552
554	2553
554	2554
554	2555
554	2556
554	2557
554	2558
554	2559
561	2562
561	2563
561	2564
561	2565
561	2566
561	2567
561	2568
561	2569
561	2570
561	2571
561	2572
561	2573
561	2574
561	2575
561	2576
561	2577
561	2578
561	2579
561	2580
561	2581
561	2582
561	2583
569	2584
575	2592
575	2593
575	2594
575	2595
575	2596
575	2597
575	2598
575	2599
575	2600
575	2601
575	2602
575	2603
575	2604
575	2605
575	2606
575	2607
575	2608
575	2585
575	2586
575	2587
575	2588
575	2589
575	2590
575	2591
582	2624
582	2625
582	2626
582	2627
582	2628
582	2629
582	2630
582	2631
582	2632
582	2609
582	2610
582	2611
582	2612
582	2613
582	2614
582	2615
582	2616
582	2617
582	2618
582	2619
582	2620
582	2621
582	2622
582	2623
1731	1730
1731	1732
1731	1733
1731	1734
1731	1735
1731	1736
1731	1737
1731	1738
1731	1739
1731	1740
1731	1741
1731	1742
1731	1743
1731	1744
1731	1745
1731	1746
1731	1747
1731	1748
1731	1749
1731	1750
1762	1761
1762	737
1762	1763
1762	1764
1762	1765
1762	1766
1762	1767
1762	1768
1762	1769
1762	1770
1762	1771
1762	1772
1762	1165
1762	1773
1762	887
2404	1760
2404	2403
2404	2405
2404	2406
2404	2407
2404	2408
2404	2409
2404	2410
2404	2411
2404	2412
2404	2413
2404	2414
2404	2415
2404	2416
2404	2417
2404	1751
2404	1752
2404	1753
2404	1756
2404	1757
2404	1758
2404	1759
\.


--
-- TOC entry 2193 (class 0 OID 17449)
-- Dependencies: 189
-- Data for Name: white_cards; Type: TABLE DATA; Schema: public; Owner: pyx
--

COPY white_cards (id, text, watermark) FROM stdin;
588	Tapping Serra Angel.	13PAX
589	The gravity gun.	13PAX
590	Never watching, discussing, or thinking about My Little Pony.	13PAX
591	Reading the comments.	13PAX
592	The Sarlacc.	13PAX
593	Unlocking a new sex position.	13PAX
594	Being an attractive elf trapped in an unattractive human's body.	13PAX
595	Bowser's aching heart.	13PAX
596	Charles Barkley Shut Up and Jam!	13PAX
597	A homemade, cum-stained Star Trek uniform.	13PAX
598	70,000 games sweating and farting inside an airtight steel dome.	13PAX
599	Legendary Creature -- Robert Khoo.	13PAX
600	Allowing nacho cheese to curdle in your beard while you creep in League of Legends.	13PAX
601	Winning the approval of Cooking Mama that you never got from actual mama.	13PAX
602	Temporary invincibility.	13PAX
603	Full HD.	13PAX
604	The boner hatch in the Iron Man suit.	13PAX
605	Buying virtual clothes for a Sim family instead of real clothes for a real family.	13PAX
606	An angry stone head that stomps on the floor every three seconds.	13PAX
607	Offering sexual favors for an ore and a sheep.	13PAX
608	Turn-of-the-century-sky racists.	13PAX
609	Getting into a situation with an owlbear.	13PAX
610	Grand Theft Auto: Fort Lauderdale.	13PAX
611	Achieving the manual dexterity and tactical brilliance of a 12-year-old Korean boy.	13PAX
612	The decade of legal inquests following a single hour of Grand Theft Auto.	13PAX
613	SNES cartridge cleaning fluid.	13PAX
614	Eating a pizza that's lying in the street to gain health.	13PAX
615	Mario Kart rage.	13PAX
616	Google Glass + e-cigarette: Ultimate Combo!	13PAX
617	Yoshi's huge egg-laying cloaca.	13PAX
618	A fully-dressed female videogame character.	13PAX
619	The collective wail of every Magic player suddenly realizing that they've spent hundreds of dollars on pieces of cardboard.	13PAX
620	Nude-modding Super Mario World.	13PAX
621	A madman who lives in a policebox and kidnaps women.	13PAX
622	Filling every pouch of a UtiliKilt&trade; with pizza.	13PAX
623	The Cock Ring of Alacrity.	13PAX
624	Rolling a D20 to save a failing marriage.	13PAX
625	Being replaced by a robot.	❄2014
626	The events depicted in James Cameron's <i>Avatar.</i>	❄2014
627	Blockbuster late fees up the wazoo.	❄2014
628	All the poop inside of my body.	❄2014
629	A protracted siege.	❄2014
630	The diminishing purity of the white race.	❄2014
631	Trying to feel something, anything.	❄2014
632	A cloud of ash that darkens the Earth for a thousand years.	❄2014
633	A vague fear of something called ISIS.	❄2014
634	200 years of slavery.	❄2014
635	The transience of all things.	❄2014
636	Ebola.	❄2014
637	Small-town cops with M4 assault rifles.	❄2014
638	Rising sea levels consistent with scientific predictions.	❄2014
639	What remains of my penis.	❄2014
640	Harnessing the miraculous power of the atom to slaughter 200,000 Japanese people.	❄2014
641	This groovy new thing called LSD.	❄2014
642	Building a ladder of hot dogs to the moon.	❄2014
643	Rock music and premarital sex.	❄2014
644	The Great Lizard Uprising of 2352.	❄2014
645	The dying breath of the last human.	❄2014
646	Reading an entire book.	❄2014
647	The 9,000 children who starved to death today.	❄2014
648	The Bowflex Revolution.	❄2014
649	My hot cousin.	❄
650	How many drinks Aunt Deborah has had.	❄
651	A snowman that contains the soul of my dead father.	❄
652	Elf cum.	❄
653	A toxic family environment.	❄
654	A choir of angels descending from the sky and jizzing all over dad's sweater.	❄
655	The shittier, Jewish version of Christmas.	❄
656	Pretending to be happy.	❄
657	Probably Grandma's last Christmas, kids.	❄
658	Gift-wrapping a live hamster.	❄
659	A frozen homeless man shattering on your doorstep.	❄
660	Socks.	❄
661	These low, low prices!	❄
662	Finding out that Santa isn't real.	❄
663	Snow falling gently on the frozen body of an orphan boy.	❄
664	Another shitty year.	❄
665	My uncle who voted for Trump.	❄
666	How great of a blowjob Jesus could give.	❄
667	Piece of shit Christmas cards with no money in them.	❄
668	Starting to see where ISIS is coming from.	❄
669	Fucking up <i>Silent Night</i> in front of 300 parents.	❄
670	How cool it is that I love Jesus and he loves me back.	❄
671	A fun, sexy time at the nude beach.	WWW
672	A complete inability to understand anyone else's perspective.	WWW
673	Three years of semen in a shoebox.	WWW
674	A respectful discussion of race and gender on the Internet.	WWW
675	Taking a shit while running at full speed.	WWW
676	A night of Taco Bell and anal sex.	WWW
677	Googling.	WWW
678	Smash Mouth.	WWW
679	A man from Craigslist.	WWW
680	My browser history.	WWW
681	Getting teabagged by a fifth grader in <i>Call of Duty.</i>	WWW
682	My privileged white penis.	WWW
683	Internet porn analysis paralysis.	WWW
684	YouTube comments.	WWW
685	Pretending to be black.	WWW
686	That thing on the Internet everyone's talking about.	WWW
687	Goats screaming like people.	WWW
688	Destroying Dick Cheney's last horcrux.	WWW
689	Game of Thrones spoilers.	WWW
690	Cat massage.	WWW
691	Matching with Mom on Tinder.	WWW
692	Charging up all the way.	PE13C
693	Vespene gas.	PE13C
694	Wil Wheaton crashing an actual spaceship.	PE13C
695	The Klobb.	PE13C
696	Achieving 500 actions per minute.	PE13C
697	Smashing all the pottery in a Pottery Barn in search of rupees.	PE13C
698	Forgetting to eat, and consequently dying.	PE13C
699	Judging elves by the color of their skin and not by the content of their character.	PE13C
700	Hooning.	AU
701	Throwing grapes at a man until he loses touch with reality.	AU
702	My Uber driver, Pavel.	AU
703	A stray pube.	AU
704	White privilege.	AU
705	Facebook.	AU
706	Pac-Man uncontrollably guzzling cum.	AU
707	An Oedipus complex.	AU
708	Sitting on my face.	AU
709	Scientology.	AU
710	My fat daughter.	AU
711	Vigorous jazz hands.	AU
712	An M. Night Shyamalan plot twist.	AU
713	The rhythms of Africa.	AU
714	The homosexual agenda.	AU
715	Having big dreams but no realistic way to achieve them.	AU
716	A time travel paradox.	AU
717	Lactation.	AU
718	Queen Elizabeth's immaculate anus.	AU
719	Dick fingers.	AU
720	Dying.	AU
721	My good bra.	AU
722	Me time.	AU
723	Seeing my father cry.	AU
724	Seppuku.	AU
725	Waking up half-naked in a Macca's car park.	AU
726	Hot people.	AU
727	Half a kilo of pure China White heroin.	AU
728	Dead babies.	AU
729	Not reciprocating oral sex.	AU
730	Flesh-eating bacteria.	AU
731	Itchy pussy.	AU
732	100% Pure New Zealand.	AU
733	Foreskin.	AU
734	Wanking into a pool of children's tears.	AU
735	Worshipping that pussy.	AU
736	Pauline Hanson.	AU
737	How far I can get my own penis up my butt.	AU
738	Skippy the Bush Kangaroo.	AU
739	World peace.	AU
740	Expecting a burp and vomiting on the floor.	AU
741	Kamikaze pilots.	AU
742	Anal beads.	AU
743	Being rich.	AU
744	A slab of VB and a pack of durries.	AU
745	Shapeshifters.	AU
746	Lockjaw.	AU
747	Child beauty pageants.	AU
748	Winking at old people.	AU
749	Breaking out into song and dance.	AU
750	Pretending to care.	AU
751	Waiting till marriage.	AU
752	The wifi password.	AU
753	Being a woman.	AU
754	Dirty nappies.	AU
755	The past.	AU
756	Getting married, having a few kids, buying some stuff, retiring to Queensland, and dying.	AU
757	A lifetime of sadness.	AU
758	Going an entire day without masturbating.	AU
759	Catapult.	AU
760	Dwayne "The Rock" Johnson.	AU
761	A saxophone solo.	AU
762	Fiery poos.	AU
763	The penny whistle solo from "My Heart Will Go On."	AU
764	Having a Golden Gaytime.	AU
765	A fart so powerful that it wakes the giants from their thousand-year slumber.	AU
766	My genitals.	AU
767	Getting naked and watching <i>Play School. </i>	AU
768	Little boy penises.	AU
769	BATMAN!	AU
770	Preteens.	AU
771	More elephant cock than I bargained for.	AU
772	Smegma.	AU
773	A micropenis.	AU
774	My ugly face and bad personality.	AU
775	A good sniff.	AU
776	Explaining how vaginas work.	AU
777	Total control of the media.	AU
778	All four prongs of an echidna's penis.	AU
779	Genuine human connection.	AU
780	An old guy who's almost dead.	AU
781	Being a motherfucking sorcerer.	AU
782	Holding down a child and farting all over him.	AU
783	Land mines.	AU
784	Centaurs.	AU
785	The White Australia Policy.	AU
786	Seven dead and three in critical condition.	AU
787	My relationship status.	AU
788	A mating display.	AU
789	Auschwitz.	AU
790	Alcoholism.	AU
791	A bleached arsehole.	AU
792	Making up for centuries of oppression with one day of apologising.	AU
793	Sexual peeing.	AU
794	A windmill full of corpses.	AU
795	Darth Vader.	AU
796	Daniel Radcliffe's delicious asshole.	AU
797	A good, strong gorilla.	AU
798	Oestrogen.	AU
799	Nipple blades.	AU
800	Being able to talk to elephants.	AU
801	Making a pouty face.	AU
802	Drowning the kids in the bathtub.	AU
803	Emerging from the sea and rampaging through Tokyo.	AU
804	Hospice care.	AU
805	Magnets.	AU
806	Kissing nan on the forehead and turning off her life support.	AU
807	Touching a pug right on his penis.	AU
808	Vladimir Putin.	AU
809	Spontaneous human combustion.	AU
810	Glassing a wanker.	AU
811	Leprosy.	AU
812	Seething with quiet resentment.	AU
813	Dropping a baby down the dunny.	AU
814	Explosions.	AU
815	Licking things to claim them as your own.	AU
816	A sick burnout.	AU
817	Consensual sex.	AU
818	Nickelback.	AU
819	Bananas.	AU
820	Masturbating.	AU
821	All the dues I've fucked.	AU
822	Famine.	AU
823	Executing a hostage every hour.	AU
824	Running out of semen.	AU
825	Jews, gypsies, and homosexuals.	AU
826	The arrival of the pizza.	AU
827	Rupert Murdoch.	AU
828	Goblins.	AU
829	Laying an egg.	AU
830	Women in yoghurt commercials.	AU
831	A bowl of mayonnaise and human teeth.	AU
832	A micropig wearing a tiny raincoat and booties.	AU
833	A bitch slap.	AU
834	Giving 110%.	AU
835	A man on the brink of orgasm.	AU
836	A much younger woman.	AU
837	Tony Abbott in budgie smugglers.	AU
838	10,000 Syrian refugees.	AU
839	A sad handjob.	AU
840	Contagious face cancer.	AU
841	Police brutality.	AU
842	Throwing a virgin into a volcano.	AU
843	Mr. Squiggle, the Man from the Moon.	AU
844	A sea of troubles.	AU
845	Multiple stab wounds.	AU
846	Taking a sheep-wife.	AU
847	Filling my briefcase with business stuff.	AU
848	A tiny horse.	AU
849	Grandma.	AU
850	A bag of magic beans.	AU
851	Doing the right thing.	AU
852	Emma Watson.	AU
853	Powerful thighs.	AU
854	Men.	AU
855	Farting and walking away.	AU
856	German Chancellor Angela Merkel.	AU
857	Being marginalised.	AU
858	Peeing a little bit.	AU
859	Viagra.&reg;	AU
860	Bisexuality.	AU
861	The clitoris.	AU
862	Soft, kissy missionary sex.	AU
863	A balanced breakfast.	AU
864	Puberty.	AU
865	Poor people.	AU
866	Harry Potter erotica.	AU
867	Penis breath.	AU
868	Agriculture.	AU
869	An endless stream of diarrhoea.	AU
870	Committing suicide.	AU
871	The heart of a child.	AU
872	Justin Bieber.	AU
873	Concealing a boner.	AU
874	Not vaccinating my children because I am stupid.	AU
875	Crazy hot cousin sex.	AU
876	Jehovah's Witnesses.	AU
877	Judge Judy.	AU
878	<i>The Bachelorette </i>season finale.	AU
879	Sex with animals.	AU
880	Men discussing their feelings in an emotionally healthy way.	AU
881	Dead birds everywhere.	AU
882	My bright pink fuckhole.	AU
883	Having sex for the first time.	AU
884	Getting so angry that you pop a stiffy.	AU
885	Nothing but sand.	AU
886	A cute, fuzzy koala with chlamydia.	AU
887	Getting drugs off the street and into my body.	AU
888	Profound respect and appreciation for indigenous culture.	AU
889	German dungeon porn.	AU
890	John Howard's eyebrows.	AU
891	Selling ice to children.	AU
892	The end of days.	AU
893	Kourtney, Kim, Khloe, Kendall, and Kylie.	AU
894	A sick wombat.	AU
895	Mouth herpes.	AU
896	Seeing what happens when you lock people in a room with hungry seagulls.	AU
897	72 virgins.	AU
898	Not giving a shit about the Third World.	AU
899	Getting cummed on.	AU
900	Poor life choices.	AU
901	Firing a rifle into the air while balls deep in a squealing hog.	AU
902	Opposable thumbs.	AU
903	Geese.	AU
904	Being fat and stupid.	AU
905	Serfdom.	AU
906	Teaching a robot to love.	AU
907	Forced sterilisation.	AU
908	A Super Soaker&trade; full of cat pee.	AU
909	Some bloody peace and quiet.	AU
910	A Halal Snack Pack.	AU
911	Braiding three penises into a licorice twist.	AU
912	NBA superstar LeBron James.	AU
913	Child abuse.	AU
914	Fucking my sister.	AU
915	The cool, refreshing taste of Coca-Cola.&reg;	AU
916	Natural male enhancement.	AU
917	Science.	AU
918	A brain tumour.	AU
919	The gays.	AU
920	Becoming a blueberry.	AU
921	Women's undies.	AU
922	Three dicks at the same time.	AU
923	The wonders of the Orient.	AU
924	Puppies!	AU
925	An unwanted pregnancy.	AU
926	Nippers.	AU
927	The Holy Bible.	AU
928	However much weed $20 can buy.	AU
929	A whole thing of butter.	AU
930	Having anuses for eyes.	AU
931	Silence.	AU
932	Lumberjack fantasies.	AU
933	My balls on your face.	AU
934	Dead parents.	AU
935	Barack Obama.	AU
936	A snapping turtle biting the tip of your penis.	AU
937	A salad for men that's made of metal.	AU
938	Summoning Harold Holt from the sea in a time of great need.	AU
939	A didgeridildo.	AU
940	African children.	AU
941	A five-litre goon bag.	AU
942	Fading away into nothingness.	AU
943	Paedophiles.	AU
944	Vegemite.&trade;	AU
945	Spaghetti? Again?	AU
946	Good-natured, fun-loving Aussie racism.	AU
947	Wizard music.	AU
948	The miracle of childbirth.	AU
949	Eating a hard boiled egg out of my husband's asshole.	AU
950	Menstrual rage.	AU
951	Still being a virgin.	AU
952	An M16 assault rifle.	AU
953	Shiny objects.	AU
954	Giving birth to the Antichrist.	AU
955	The placenta.	AU
956	Bees?	AU
957	Drinking alone.	AU
958	Punching an MP in the face.	AU
959	Telling a shitty story that goes nowhere.	AU
960	Sunshine and rainbows.	AU
961	A fair go.	AU
962	A little boy who won't shut the fuck up about dinosaurs.	AU
963	Finger painting.	AU
964	Hobos.	AU
965	Natural selection.	AU
966	An erection that lasts longer than four hours.	AU
967	Bubble butt bottom boys.	AU
968	My soul.	AU
969	A middle-aged man on roller skates.	AU
970	Being a dick to children.	AU
971	Mutually assured destruction.	AU
972	A mopey zoo lion.	AU
973	Extremely tight pants.	AU
974	Queefing.	AU
975	A live studio audience.	AU
976	An oversized lollipop.	AU
977	Nicolas Cage.	AU
978	Cashed-up bogans.	AU
979	Daddy issues.	AU
980	Accepting the way things are.	AU
981	The Big Bang.	AU
982	Women's suffrage.	AU
983	Inappropriate yodeling.	AU
984	An older woman who knows her way around the penis.	AU
985	Raptor attacks.	AU
986	Inserting a jam jar into my anus.	AU
987	Sex with Patrick Stewart.	AU
988	The Patriarchy.	AU
989	Free samples.	AU
990	Doin' it up the bum.	AU
991	My ex-wife.	AU
992	The Pope.	AU
993	Covering myself with Parmesan cheese and chili flakes because I am pizza.	AU
994	A stingray barb through the chest.	AU
995	White people.	AU
996	Drinking out of the toilet and eating rubbish.	AU
997	Unfathomable stupidity.	AU
998	A bird that shits human turds.	AU
999	Your weird brother.	AU
1000	Jobs.	AU
1001	Former President George W. Bush.	AU
1002	Donald J. Trump.	AU
1003	Pingers.	AU
1004	Casually suggesting a threesome.	AU
1005	A foetus.	AU
1006	David Bowie flying in on a tiger made of lightning.	AU
1007	The bush.	AU
1008	Memes.	AU
1009	A salty surprise.	AU
1010	Balls.	AU
1011	The Devil himself.	AU
1012	Fucking the weatherman on live television.	AU
1013	The female orgasm.	AU
1014	Necrophilia.	AU
1015	The magic of live theatre.	AU
1016	Vomiting seafood and bleeding anally.	AU
1017	Pulling out.	AU
1018	Spectacular abs.	AU
1019	Full frontal nudity.	AU
1020	A tiny, gay guitar called a ukulele.	AU
1021	Sorry, this content cannot be viewed in your region.	AU
1022	Poorly-timed Holocaust jokes.	AU
1023	Sweet, sweet vengeance.	AU
1024	Lance Armstrong's missing testicle.	AU
1025	Hope.	AU
1026	The screams... the terrible screams.	AU
1027	Gandhi.	AU
1028	Only dating Asian women.	AU
1029	A shark!	AU
1030	Getting fingered.	AU
1031	Yeast.	AU
1032	Perfunctory foreplay.	AU
1033	Emotions.	AU
1034	Wet dreams.	AU
1035	Dark and mysterious forces beyond our control.	AU
1036	Americanization.	AU
1037	Shaking a baby until it stops crying.	AU
1038	Being on fire.	AU
1039	Huge biceps.	AU
1040	My vagina.	AU
1041	Having a shag in the back of a ute.	AU
1042	My inner demons.	AU
1043	Pooping in a laptop and closing it.	AU
1044	Battlefield amputations.	AU
1045	Strong female characters.	AU
1046	Dry heaving.	AU
1047	Tentacle porn.	AU
1048	The Jews.	AU
1049	Teenage pregnancy.	AU
1050	A pangender octopus who roams the cosmos in search of love.	AU
1051	Saying "I love you."	AU
1052	A fuck-tonne of almonds.	AU
1053	Synergistic management solutions.	AU
1054	50,000 volts straight to the nipples.	AU
1055	Self-loathing.	AU
1056	Australia.	AU
1057	Erectile dysfunction.	AU
1058	Friction.	AU
1059	Liberals.	AU
1060	Oompa-Loompas.	AU
1061	Fragile masculinity.	AU
1062	The true meaning of Christmas.	AU
1063	A pyramid of severed heads.	AU
1064	Getting really high.	AU
1065	Hot cheese.	AU
1066	Incest.	AU
1067	Elderly Japanese men.	AU
1068	Announcing that I am about to cum.	AU
1069	Invading Poland.	AU
1070	RoboCop.	AU
1071	Flying sex snakes.	AU
1072	Slaughtering innocent civilians.	AU
1073	Establishing dominance.	AU
1074	Massive, widespread drought.	AU
1075	Some guy.	AU
1076	Girls.	AU
1077	Italians.	AU
1325	Diversity.	UK
1078	Shutting up so I can watch the game.	AU
1079	Millions of cane toads.	AU
1080	Alcohol poisoning.	AU
1081	Jennifer Lawrence.	AU
1082	Blowing my boyfriend so hard he shits.	AU
1083	Penis envy.	AU
1084	Repression.	AU
1085	Cards Against Humanity.	AU
1086	Xenophobia.	AU
1087	Ice.	AU
1088	Passive-aggressive Post-it notes.	AU
1089	A decent fucking Internet connection.	AU
1090	LYNX&reg; Body Spray.	AU
1091	Heartwarming orphans.	AU
1092	The Great Depression.	AU
1093	A falcon with a cap on its head.	AU
1094	Solving problems with violence.	AU
1095	Gloryholes.	AU
1096	A homoerotic volleyball montage.	AU
1097	This month's mass shooting.	AU
1098	Radical Islamic terrorism.	AU
1099	Flightless birds.	AU
1100	A disappointing birthday party.	AU
1101	Assless chaps.	AU
1102	What's left of the Great Barrier Reef.	AU
1103	Permanent Orgasm-Face Disorder.	AU
1104	Boogers.	AU
1105	The Blood of Christ.	AU
1106	Cuddling.	AU
1107	Looking in the mirror, applying lipstick, and whispering "tonight, you will have sex with Tom Cruise."	AU
1108	Pooping back and forth. Forever.	AU
1109	Crumbs all over the bloody carpet.	AU
1110	The Force.	AU
1111	Ethnic cleansing.	AU
1112	Exactly what you'd expect.	AU
1113	Getting crushed by a vending machine.	AU
1114	A ball of earwax, semen, and toenail clippings.	AU
1115	Brown people.	AU
1116	The Hemsworth brothers.	AU
1117	Pixelated bukkake.	AU
1118	Tearing that ass up like wrapping paper on Christmas morning.	AU
1119	Sideboob.	AU
1120	A literal tornado of fire.	AU
1121	Seeing Grandma naked.	AU
1122	Arnold Schwarzenegger.	AU
1123	The bombing of Nagasaki.	AU
1124	Chainsaws for hands.	AU
1125	Fear itself.	AU
1126	Swooping.	AU
1127	Ghosts.	AU
1128	The Great Emu War.	AU
1129	Sniffing glue.	AU
1130	My neck, my back, my pussy, and my crack.	AU
1131	God.	AU
1132	Nazis.	AU
1133	MechaHitler.	AU
1134	My collection of Japanese sex toys.	AU
1135	One titty hanging out.	AU
1136	Chundering into a kangaroo's pouch.	AU
1137	Crippling debt.	AU
1138	Whipping it out.	AU
1139	Academy Award winner Meryl Streep.	AU
1140	Funky fresh rhymes.	AU
1141	The big fucking hole in the ozone layer.	AU
1142	How bad my daughter fucked up her dance recital.	AU
1143	Fellowship in Christ.	AU
1144	The violation of our most basic human rights.	AU
1145	Coat hanger abortions.	AU
1146	Morgan Freeman's voice.	AU
1147	Stalin.	AU
1148	My cheating prick of a husband.	AU
1149	Denying climate change.	AU
1150	Old-people smell.	AU
1151	Fake tits.	AU
1152	Sexual tension.	AU
1153	Whiskas&reg; Catmilk.	AU
1154	Muhammad (Peace Be Upon Him).	AU
1155	A really cool hat.	AU
1156	An octopus giving seven handjobs and smoking a cigarette.	AU
1157	Listening to her problems without trying to solve them.	AU
1158	The Russians.	AU
1159	Murder.	AU
1160	A crucifixion.	AU
1161	Her Majesty, Queen Elizabeth II.	AU
1162	Not wearing pants.	AU
1163	Man meat.	AU
1164	Steve Irwin.	AU
1165	A gossamer stream of jizz that catches the light as it arcs through the morning air.	AU
1166	Many bats.	AU
1167	Gay conversion therapy.	AU
1168	Horse meat.	AU
1169	The glass ceiling.	AU
1170	Dick pics.	AU
1171	The only gay person in a hundred kilometers.	AU
1172	Completely unwarranted confidence.	AU
1173	One trillion dollars.	AU
1174	Sperm whales.	AU
1175	My sex life.	AU
1176	Chemical weapons.	AU
1177	A Fleshlight.&reg;	AU
1178	Pictures of boobs.	AU
1179	William Shatner.	AU
1180	Chunks of dead backpacker.	AU
1181	AIDS.	AU
1182	The inevitable heath death of the universe.	AU
1183	Autocannibalism.	AU
1184	A horde of Vikings.	AU
1185	Danny DeVito.	AU
1186	A six-point plan to stop the boats.	AU
1187	My abusive boyfriend who really isn't so bad once you get to know him.	AU
1188	A three-way with my wife and Shaquille O'Neal.	AU
1189	Soup that is too hot.	AU
1190	Tap dancing like there's no tomorrow.	AU
1191	Stephen Hawking talking dirty.	AU
1192	Object permanence.	AU
1193	The milkman.	AU
1194	Kanye West.	AU
1195	Poverty.	AU
1196	Judging everyone.	AU
1197	PTSD.	AU
1198	Whoever the Prime Minister is these days.	AU
1199	Bitches.	AU
1200	Sandwich.	RJCT2
1201	At least three ducks.	RJCT2
1202	Mushy tushy.	RJCT2
1203	Saving the Rainforest Cafe.	RJCT2
1204	Becoming engorged with social justice jelly and secreting a thinkpiece.	RJCT2
1205	That one leftover screw.	RJCT2
1206	Greg Kinnear's terrible lightning breath.	RJCT2
1207	Sir Thomas More's Fruitopia.&trade;	RJCT2
1208	Mr. and Mrs. Tambourine Man's jingle-jangle morning sex.	RJCT2
1209	The spooky skeleton under my skin.	RJCT2
1210	A double murder suicide barbeque.	RJCT2
1211	Sweating it out on the streets of a runaway American Dream.	RJCT2
1212	Disco Mussolini.	RJCT2
1213	That thing politicians do with their thumbs when they talk.	RJCT2
1214	These dolphins.	RJCT2
1215	A dick so big and so black that not even light can escape its pull.	RJCT2
1216	Being the absolute worst.	RJCT2
1217	A primordial soup and salad bar.	RJCT2
1218	Three hairs from the silver-golden head of Galadriel.	RJCT2
1219	A stack of bunnies in a trenchcoat.	RJCT2
1220	Mitt Romney's eight sons Kip, Sam, Trot, Fergis, Toolshed, Grisham, Hawkeye, and Thorp.	RJCT2
1221	Ringo Starr &amp; His All-Starr Band.	RJCT2
1222	The token lesbian.	RJCT2
1223	Water so cold it turned into a rock.	RJCT2
1224	An immediately regrettable $9 hot dog from the Boston Convention Center.	PE13A
1225	Paying the iron price.	PE13A
1226	Casting Magic Missile at a bully.	PE13A
1227	Rotating shapes in mid-air so that they fit into other shapes when they fall.	PE13A
1228	Firefly: Season 2.	PE13A
1229	Jiggle physics.	PE13A
1230	Getting bitch slapped by Dhalsim.	PE13A
1231	Running out of stamina.	PE13A
1232	Forgetting to convert pound-seconds into newton-seconds.	NASA
1233	Uranus.	NASA
1234	A zero-g cumshot.	NASA
1235	Seven minutes of terror.	NASA
1236	A slow, shitty car that drives around Mars for no reason.	NASA
1237	Discovering some bullshit microscopic life instead of anything cool.	NASA
1238	Achieving escape velocity.	NASA
1239	Dreaming of going to space, but being hopelessly fat.	NASA
1240	Sharpening a foam broadsword on a foam whetstone.	PE13B
1241	The depression that ensues after catching 'em all.	PE13B
1242	Loading from a previous save.	PE13B
1243	The rocket launcher.	PE13B
1244	Getting inside the Horadric Cube with a hot babe and pressing the transmute button.	PE13B
1245	Spending the year's insulin budget on Warhammer 40k figurines.	PE13B
1246	Punching a tree to gather wood.	PE13B
1247	Violating the First Law of Robotics.	PE13B
1248	Germans on holiday.	UK
1249	The Hillsborough Disaster.	UK
1250	Druids.	UK
1251	The way James Bond treats women.	UK
1252	Blowing up Parliament.	UK
1253	A white van man.	UK
1254	Benedict Cumberbatch.	UK
1255	Shitting out a perfect Cumberland sausage.	UK
1256	Shutting up so I can watch the match.	UK
1257	Faffing about.	UK
1258	Getting so angry that you pop a boner.	UK
1259	Blood, toil, tears, and sweat.	UK
1260	Your mum.	UK
1261	Dogging.	UK
1262	Concealing an erection.	UK
1263	Polish people.	UK
1264	My cheating son-of-a-bitch husband.	UK
1265	The KKK.	UK
1266	Waking up in Idris Elba's arms.	UK
1267	Braiding three penises into a Curly Wurly.	UK
1268	However much weed &pound;20 can buy.	UK
1269	Inserting a Mason jar into my anus.	UK
1270	A Chelsea smile.	UK
1271	Racism.	UK
1272	The EDL.	UK
1273	Ecstasy.	UK
1274	England.	UK
1275	The Black Death.	UK
1276	Egging an MP.	UK
1277	The Scouts.	UK
1278	The <i>Strictly Come Dancing </i>season finale.	UK
1279	The North.	UK
1280	Maureen of Blackpool, Reader's Wife of the Year 1988.	UK
1281	Spaniards.	UK
1282	Pikies.	UK
1283	An entrenched class system.	UK
1284	Doing crimes.	UK
1285	Just touching David Beckham's hair.	UK
1286	Used knickers.	UK
1287	A hen night in Slough.	UK
1288	Waking up half-naked in a Little Chef car park.	UK
1289	Illegal immigrants.	UK
1290	Haggis.	UK
1291	Selling crack to children.	UK
1292	Anything that comes out of Prince Philip's mouth.	UK
1293	The bloody Welsh.	UK
1294	Mad cow disease.	UK
1295	The sudden appearance of the Go Compare man.	UK
1296	The smell of Primark.	UK
1297	The cool, refreshing taste of Pepsi.&reg;	UK
1298	Theresa May.	UK
1299	Chunks of dead hitchhiker.	UK
1300	My mate Dave.	UK
1301	Cottaging.	UK
1302	Not wearing trousers.	UK
1303	A nice cup of tea.	UK
1304	Jimmy Savile.	UK
1305	The unstoppable tide of Islam.	UK
1306	A posh wank.	UK
1307	A foul mouth.	UK
1308	Trench foot.	UK
1309	An AK-47 assault rifle.	UK
1310	Cheeky bum sex.	UK
1311	Bogies.	UK
1312	The Daily Mail.	UK
1313	A fanny fart.	UK
1314	Tories.	UK
1315	Slapping Nigel Farage over and over.	UK
1316	Madeleine McCann.	UK
1317	A sassy black woman.	UK
1318	400 years of colonial atrocities.	UK
1319	Queuing.	UK
1320	9 oz. of sweet Mexican black-tar heroin.	UK
1321	The American Dream.	UK
1322	Chivalry.	UK
1323	The only gay person in a hundred miles.	UK
1324	Amputees.	UK
1326	A bit of slap and tickle.	UK
1327	Women in yogurt commercials.	UK
1328	Seeing Granny naked.	UK
1329	The petty troubles of the landed gentry.	UK
1330	Lads.	UK
1331	The French.	UK
1332	Ed Balls.	UK
1333	A vindaloo poo.	UK
1334	Scousers.	UK
1335	Getting naked and watching CBeebies.	UK
1336	The inevitable heat death of the universe.	UK
1337	Rubbing Boris Johnson's belly until he falls asleep.	UK
1338	A sober Irishman who doesn't care for potatoes.	UK
1339	Daddies&reg; Brown Sauce.	UK
1340	Brexit.	UK
1341	Knife crime.	UK
1342	Getting married, having a few kids, buying some stuff, retiring to the south of France, and dying.	UK
1343	Black people.	UK
1344	Africa children.	UK
1345	Meth.	UK
1346	Somali pirates.	UK
1347	Pamela Anderson's boobs running in slow motion.	90s
1348	A bus that will explode if it goes under 50 miles per hour.	90s
1349	Jerking off to a 10-second RealMedia clip.	90s
1350	Pizza in the morning, pizza in the evening, pizza at supper time.	90s
1351	Stabbing the shit out of a Capri Sun.	90s
1352	Angels interfering in an otherwise fair baseball game.	90s
1353	Sucking the President's dick.	90s
1354	Sunny D! Alright!	90s
1355	The Great Cornholio.	90s
1356	Painting with all the colors of the wind.	90s
1357	Cool 90s up-in-the-front hair.	90s
1358	The Y2K bug.	90s
1359	A mulatto, an albino, a mosquito, and my libido.	90s
1360	Liking big butts and not being able to lie about it.	90s
1361	Deregulating the mortgage market.	90s
1362	Kurt Cobain's death.	90s
1363	A threesome with 1996 Denise Richards and 1999 Denise Richards.	90s
1364	Freeing Willy.	90s
1365	Several Michael Keatons.	90s
1366	Patti Mayonnaise.	90s
1367	Wearing Nicolas Cage's face.	90s
1368	<i>Pure Moods</i>, Vol. 1.	90s
1369	Log.&trade;	90s
1370	A Pringles&reg; can full of screams.	RTPRD
1371	A framed photocopy of an oil painting of Paris, France.	RTPRD
1372	Buying the right toothbrush cup for my lifestyle.	RTPRD
1373	Shiny gadgets for sadness distraction.	RTPRD
1374	Saving 20% or more on khakis.	RTPRD
1375	How fun it is to eat Pringles&reg;.	RTPRD
1376	Refusing to go up a size.	RTPRD
1377	An exclusive partnership with Taylor Swift.	RTPRD
1378	An 800-foot-long pool noodle.	RTPRD
1379	Confusing possessions with accomplishments.	RTPRD
1380	Blood Pringles&reg;.	RTPRD
1381	Crunchy snacks for my big flappy mouth.	RTPRD
1382	A Pringle&reg;.	RTPRD
1383	Subsisting on tiny pizzas.	RTPRD
1384	Extracting the maximum amount of money from naive consumers.	RTPRD
1385	The obscene amount of money Cards Against Humanity is making by selling this game at Target.&reg;	RTPRD
1386	Gender-neutral toys that make children feel no emotions whatsoever.	RTPRD
1387	Getting eaten out in the family fitting room.	RTPRD
1388	Buying and returning clothes just to have someone to talk to.	RTPRD
1389	The Hamburglar.	US
1390	Forced sterilization.	US
1391	Active listening.	US
1392	Smallpox blankets.	US
1393	J.D. Power and his associates.	US
1394	Adderall.&reg;	US
1395	50 mg of Zoloft daily.	US
1396	A bleached asshole.	US
1397	The Three-Fifths Compromise.	US
1398	Catapults.	US
1399	Being marginalized.	US
1400	Punching a congressman in the face.	US
1401	Some god damn peace and quiet.	US
1402	Ruth Bader Ginsburg brutally gaveling your penis.	US
1403	Fox News.	US
1404	The Red Hot Chili Peppers.	US
1405	Used panties.	US
1406	Huffing spray paint.	US
1407	Half-assed foreplay.	US
1408	Getting married, having a few kids, buying some stuff, retiring to Florida, and dying.	US
1409	The Boy Scouts of America.	US
1410	Hillary Clinton's emails.	US
1411	The Kool-Aid Man.	US
1412	Pedophiles.	US
1413	Ronald Reagan.	US
1414	Sitting on my face and telling me I'm garbage.	US
1415	Aaron Burr.	US
1416	Republicans.	US
1417	All-you-can-eat shrimp for $8.99.	US
1418	An endless stream of diarrhea.	US
1419	Bingeing and purging.	US
1420	Fancy Feast.&reg;	US
1421	<i>The Bachelorette</i> season finale.	US
1422	Oprah.	US
1423	Racially-biased SAT questions.	US
1424	Women of color.	US
1425	The Amish.	US
1426	Mike Pence.	US
1427	The entire Mormon Tabernacle Choir.	US
1428	Count Chocula.	US
1429	Eating the last known bison.	US
1430	The Rapture.	US
1431	Estrogen.	US
1432	An AR-15 assault rifle.	US
1433	Some punk kid who stole my turkey sandwich.	US
1434	Mansplaining.	US
1435	How amazing it is to be on mushrooms.	US
1436	Switching to Geico.&reg;	US
1437	Crumbs all over the god damn carpet.	US
1438	A brain tumor.	US
1439	Bill Nye the Science Guy.	US
1440	A fetus.	US
1441	The South.	US
1442	Doin' it in the butt.	US
1443	Poopy diapers.	US
1444	Drinking out of the toilet and eating garbage.	US
1445	Kissing grandma on the forehead and turning off her life support.	US
1446	Rap music.	US
1447	GoGurt.&reg;	US
1448	A Mexican.	US
1449	The Underground Railroad.	US
1450	The Hustle.	US
1451	Jerking off into a pool of children's tears.	US
1452	Heteronormativity.	US
1453	A Bop It.&trade;	US
1454	AXE Body Spray.	US
1455	Prescription pain killers.	US
1456	Vehicular manslaughter.	US
1457	Authentic Mexican cuisine.	US
1458	Steve Bannon.	US
1459	Getting naked and watching Nickelodeon.	US
1460	The Trail of Tears.	US
1461	Passive aggressive Post-it notes.	US
1462	8 oz. of sweet Mexican black-tar heroin.	US
1463	A fuck-ton of almonds.	US
1464	These hoes.	US
1465	Waking up half-naked in a Denny's parking lot.	US
1466	Lena Dunham.	US
1467	Some of the best rappers in the game.	US
1468	Fiery poops.	US
1469	Lunchables.&trade;	US
1470	Braiding three penises into a Twizzler.	US
1471	My black ass.	US
1472	Wondering if it's possible to get some of that salsa to go.	US
1473	Finding a nice elevator to poop in.	GREEN
1474	An incurable homosexual.	GREEN
1475	The body of a 46-year-old man.	GREEN
1476	Mixing M&amp;Ms and Skittles like some kind of psychopath.	GREEN
1477	Grunting for ten minutes and then peeing sand.	GREEN
1478	Gay thoughts.	GREEN
1479	When the big truck goes "Toot! Toot!"	GREEN
1480	Water.	GREEN
1481	Becoming the President of the United States.	GREEN
1482	Hot lettuce.	GREEN
1483	Rock-hard tits and a huge vagina.	GREEN
1484	Meatloaf, the man.	GREEN
1485	Smashing my balls at the moment of climax.	GREEN
1486	A creature made of penises that must constantly arouse itself to survive.	GREEN
1487	My brother's hot friends.	GREEN
1488	You.	GREEN
1489	Getting high with mom.	GREEN
1490	Twisting my cock and balls into a balloon poodle.	GREEN
1491	Loud, scary thunder.	GREEN
1492	Whomsoever let the dogs out.	GREEN
1493	Having a vagina.	GREEN
1494	A man with the head of a goat and the body of a goat.	GREEN
1495	Taking the form of a falcon.	GREEN
1496	A hug.	GREEN
1497	Putting more black people in jail.	GREEN
1498	Trevor, the world's greatest boyfriend.	GREEN
1499	Anal.	GREEN
1500	Just now finding out about the Armenian Genocide.	GREEN
1501	Getting the Dorito crumbs out of my pubes.	GREEN
1502	A man in a suit with perfect hair who tells you beautiful lies.	GREEN
1503	Critical thinking.	GREEN
1504	Quacking like a duck in lieu of a cogent argument.	GREEN
1505	A long business meeting with no obvious purpose.	GREEN
1506	Facilitating dialogue and deconstructing binaries.	GREEN
1507	Getting killed and dragged up a tree by a leopard.	GREEN
1508	Brunch.	GREEN
1509	Child labor.	GREEN
1510	Esmeralda, my most beautiful daughter.	GREEN
1511	The feeling of going to McDonald's as a 6-year-old.	GREEN
1512	Eating people.	GREEN
1513	Art.	GREEN
1514	Having sex with your mom.	GREEN
1515	The hottest MILF in Dallas.	GREEN
1516	Getting trapped in a conversation about Ayn Rand.	GREEN
1517	Happy daddies with happy sandals.	GREEN
1518	A dolphin that learns to talk and becomes the Dead of Harvard Law School.	GREEN
1519	The graceful path of an autumn leaf as it falls to its earthen cradle.	GREEN
1520	Meatloaf, the food.	GREEN
1521	10,000 shrieking teenage girls.	GREEN
1522	Chris Hemsworth.	GREEN
1523	Straight blazin' 24/7.	GREEN
1524	Objectifying women.	GREEN
1525	The mysterious fog rolling into town.	GREEN
1526	Math.	GREEN
1527	Restoring Germany to its former glory.	GREEN
1528	Exploring each other's buttholes.	GREEN
1529	An old dog full of tumors.	GREEN
1530	Antidepressants.	GREEN
1531	Having an awesome time drinking and driving.	GREEN
1532	Jazz.	GREEN
1533	Dumpster juice.	GREEN
1534	Raising three kids on minimum wage.	GREEN
1535	Going to bed at a reasonable hour.	GREEN
1536	10 football players with erections barreling towards you at full speed.	GREEN
1537	Working so hard to have muscles and then having them.	GREEN
1538	Turning 32.	GREEN
1539	Albert Einstein but if he had a huge muscles and a rhinoceros cock.	GREEN
1540	Assassinating the president.	GREEN
1541	A woman's right to choose.	GREEN
1542	Eternal screaming madness.	GREEN
1543	Late-stage dementia.	GREEN
1544	Consensual, nonreproductive incest.	GREEN
1545	Swearing praise upon the Sultan's hideous daughters.	GREEN
1546	A cheerfulness that belies a deep-seated self-loathing.	GREEN
1547	An arrangement wherein I give a person money they have sex with me.	GREEN
1548	A genetic predisposition for alcoholism.	GREEN
1549	The wind.	GREEN
1550	Getting pegged.	GREEN
1551	Period poops.	GREEN
1552	The chicken from Popeyes. &reg;	GREEN
1553	A massive collection of child pornography.	GREEN
1554	A big, beautiful mouth packed to the brim with sparkling teeth.	GREEN
1555	Pooping in the potty.	GREEN
1556	Getting eaten out by a dog.	GREEN
1557	Munchin' puss.	GREEN
1558	It being too late to stop having sex with a horse.	GREEN
1559	One of those "blow jobs" I've been hearing so much about.	GREEN
1560	The lived experience of African Americans.	GREEN
1561	Prematurely ejaculating like a total loser.	GREEN
1562	Big, smart money boys tap-tapping on their keyboards.	GREEN
1563	Homework.	GREEN
1564	A finger up the butt.	GREEN
1565	Tiny, rancid girl farts.	GREEN
1566	The sweet, forbidden meat of the money.	GREEN
1567	Farting all over my face with your tight little asshole.	GREEN
1568	Doing a somersault and barfing.	GREEN
1569	The government.	GREEN
1570	How good lead paint taste.	GREEN
1571	Every man's ultimate fantasy: a perfectly cylindrical vagina.	GREEN
1572	Rubbing my bush all over your bald head.	GREEN
1573	Feeling the emotion of anger.	GREEN
1574	Gregor, my largest son.	GREEN
1575	A strong horse and enough rations for thirty days.	GREEN
1576	Getting aborted.	GREEN
1577	Systems and policies designed to preserve centuries-old power structures.	GREEN
1578	Overthrowing the democratically-elected government of Chile.	GREEN
1579	A weird guy who says weird stuff and weirds me out.	GREEN
1580	How strange it is to be anything at all.	GREEN
1581	Twenty cheerleaders laughing at your tiny penis.	GREEN
1582	Everything.	GREEN
1583	The flaming wreckage of the International Space Station.	GREEN
1584	A duffel bag full of lizards.	GREEN
1585	Beyonc&eacute;.	GREEN
1586	The fear and hatred in men's hearts.	GREEN
1587	One of them big-city Jew lawyers.	GREEN
1588	An empowered woman.	GREEN
1589	Tables.	GREEN
1590	The amount of baby carrots I can fit up my ass.	GREEN
1591	Farting a huge shit out of my pussy.	GREEN
1592	Being sexually attracted to children.	GREEN
1593	Participating.	GREEN
1594	Blossoming into a beautiful young woman.	GREEN
1595	Discovering that what I really want in life is to kill people and have sex with their corpses.	GREEN
1596	Breastfeeding in public like a radiant earth goddess.	GREEN
1597	ISIS.	GREEN
1598	All these people I've killed.	GREEN
1599	The full force of the American military.	GREEN
1600	Eating ass.	GREEN
1601	Who really did 9/11.	GREEN
1602	Condoleezza Rice.	GREEN
1603	Content.	GREEN
1604	Creamy slices of real, California avocado.	GREEN
1605	How sad it will be when Morgan Freeman dies.	GREEN
1606	A black friend.	GREEN
1607	Whooping your ass at Mario Kart.	GREEN
1608	Sudden and unwanted slam poetry.	GREEN
1609	A cold and indifferent universe.	GREEN
1610	The best, deepest quotes from The Dark Night.	GREEN
1611	Salsa Night at Dave's Cantina.	GREEN
1612	Dominating a man by peeing on his eldest son.	GREEN
1613	Two shitty kids and a garbage husband.	GREEN
1614	The Rwandan Genocide.	GREEN
1615	The LGBT community.	GREEN
1616	Founding a major world religion.	GREEN
1617	Rolling so hard.	GREEN
1618	My huge penis and substantial fortune.	GREEN
1619	Forty-five minutes of finger blasting.	GREEN
1620	How great my ass looks in these jeans.	GREEN
1621	Pooping in a leotard and hoping no one notices.	GREEN
1622	Guns.	GREEN
1623	Getting this party started!	GREEN
1624	Twenty bucks.	GREEN
1625	Getting laid like all the time.	GREEN
1626	A big ol' plate of fettuccine alfredo.	GREEN
1627	Showing all the boys my pussy.	GREEN
1628	Fucking me good and taking me to Red Lobster.&reg;	GREEN
1629	A terrified fat child who won't come out of the bushes.	GREEN
1630	Doritos and a Fruit Roll-Up.	GREEN
1631	Mommy and daddy fighting all the time.	GREEN
1632	Holding the proper political beliefs of my time to attract a mate.	GREEN
1633	Onions.	GREEN
1634	Self-identifying as a DJ.	GREEN
1635	Watching you die.	GREEN
1636	Some real spicy shrimps.	GREEN
1637	A burrito that's just sour cream.	GREEN
1638	The bond between a woman and her horse.	GREEN
1639	The secret to truly resilient hair.	GREEN
1640	Mental illness.	GREEN
1641	Gayle from HR.	GREEN
1642	Informing you that I am a registered sex offender.	GREEN
1643	A negative body image that is totally justified.	GREEN
1644	Political correctness.	GREEN
1645	The clown that followed me home from the grocery store.	GREEN
1646	That bitch, Stacy.	GREEN
1647	Ejaculating at the apex of a cartwheel.	GREEN
1648	Gazpacho.	GREEN
1649	Having sex with a man and then eating his head.	GREEN
1650	An older man.	GREEN
1651	An X-Man whose power is that he has sex with dogs and children.	GREEN
1652	Out-of-control teenage blowjob parties.	GREEN
1653	Tender chunks of all-white-meat chicken.	GREEN
1654	Crushing the patriarchy.	GREEN
1655	The full blown marginalization of ugly people.	GREEN
1656	Aborting the shit out of a fetus.	GREEN
1657	Film roles for actresses over 40.	GREEN
1658	Plowing that ass like a New England corn farmer.	GREEN
1659	Huge big balls full of jizz.	GREEN
1660	Some of that good dick.	GREEN
1661	Being turned into sausages.	GREEN
1662	Hating Jews.	GREEN
1663	Crazy anal orgasms.	GREEN
1664	Regurgitating a half-digested sparrow.	GREEN
1665	The ol' penis-in-the-popcorn surprise.	GREEN
1666	A tiny fireman who puts out tiny fires.	GREEN
1667	Dis bitch.	GREEN
1668	Trees.	GREEN
1669	Three hours of nonstop penetration.	GREEN
1670	Slamming a dunk.	GREEN
1671	Starting a shitty podcast.	GREEN
1672	Gary.	GREEN
1673	Feminism.	GREEN
1674	Our baby.	GREEN
1675	Falling into a pit of waffles.	GREEN
1676	A woman's perspective.	GREEN
1677	Chipotle.	GREEN
1678	Scissoring, if that's a thing.	GREEN
1679	Watching a hot person eat.	GREEN
1680	Defeating a gorilla in single combat.	GREEN
1681	Bad emotions I don't want.	GREEN
1682	A creepy child singing a nursery rhyme.	GREEN
1683	Comprehensive immigration reform.	GREEN
1684	Denying the Holocaust.	GREEN
1685	Two beautiful pig sisters.	GREEN
1686	Catching a live salmon in your mouth.	GREEN
1687	Daddy going away forever.	GREEN
1688	A medium horchata.	GREEN
1689	Libertarians.	GREEN
1690	Picking up a glass of water and taking a sip and being the president.	GREEN
1691	Waking up inside of a tornado.	GREEN
1692	Making out and stuff.	GREEN
1693	A slowly encroaching circle of wolves.	GREEN
1694	Opening your mouth to talk and a big penis fops out.	GREEN
1695	Eating too many Cinnabons and then vomiting and then eating the vomit.	GREEN
1696	Seizing control of the means of production.	GREEN
1697	Misogyny.	GREEN
1698	Thinking about what eating even is.	GREEN
1699	Dropping dead in a Sbarro's bathroom and not being found for 72 hours.	GREEN
1700	Sucking each other's penises for hours on end.	GREEN
1701	Awesome pictures of planets and stuff.	GREEN
1702	Microaggressions.	GREEN
1703	Pretending to be one of the guys but actually being the spider god.	GREEN
1704	Fucking my therapist.	GREEN
1705	Having sex with a beautiful person.	GREEN
1706	Moon people.	GREEN
1707	Jason, the teen mayor.	GREEN
1708	Quinoa.	GREEN
1709	China.	GREEN
1710	Menopause.	GREEN
1711	My dog dying.	GREEN
1712	A gun that shoots cobras.	GREEN
1713	Reaching an age where barbecue chips are better than sex.	GREEN
1714	Going around pulling people's tampons out.	GREEN
1715	Playing my asshole like a trumpet.	GREEN
1716	Getting blasted in the face by a t-shirt cannon.	GREEN
1717	Getting naked too soon.	GREEN
1718	Donald Trump holding his nose while he eats pussy.	V4HIL
1719	Black lives mattering.	V4HIL
1720	Kicking the middle class in the balls with a regressive tax code.	V4HIL
1721	Slapping Ted Cruz over and over.	V4HIL
1722	Eating the president's pussy.	V4HIL
1723	Keeping the government out of my vagina.	V4HIL
1724	The fact that Hillary Clinton is a woman.	V4HIL
1725	Increasing economic inequality and political polarization.	V4HIL
1726	The Bernie Sanders revolution.	V4HIL
1727	A beautiful, ever-expanding circle of inclusivity that will never include Republicans.	V4HIL
1728	Letting Bernie Sanders rest his world-weary head on your lap.	V4HIL
1729	The systemic disenfranchisement of black voters.	V4HIL
1730	Boxing up my feelings.	BOX
1732	An alternate universe in which boxes store things inside of people.	BOX
1733	Being a motherfucking box.	BOX
1734	The Boxcar Children.	BOX
1735	A box that is conscious and wishes it weren't a box.	BOX
1736	A box within a box.	BOX
1737	A man-shaped box.	BOX
1738	A world without boxes.	BOX
1739	A box of biscuits, a box of mixed biscuits, and a biscuit mixer.	BOX
1740	Former President George W. Box.	BOX
1741	A box without hinges, key, or lid, yet golden treasure inside is hid.	BOX
1742	A box-shaped man.	BOX
1743	The J15 Patriot Assault Box.	BOX
1744	A falcon with a box on its head.	BOX
1745	Two midgets shitting into a box.	BOX
1746	An outbreak of smallbox.	BOX
1747	Something that looks like a box but turns out to be a crate.	BOX
1748	Pandora's vagina.	BOX
1749	A boxing match with a giant box.	BOX
1750	A box.	BOX
1751	Getting bitten by a radioactive spider and then battling leukemia for 30 years.	GEEK
1752	Separate drinking fountains for dark elves.	GEEK
1753	Stuffing my balls into a Sega Genesis and pressing the power button.	GEEK
1754	The collective wail of every <i>Magic</i> player suddenly realizing that they've spent hundreds of dollars on pieces of cardboard.	GEEK
1755	A homemade, cum-stained <i>Star Trek</i> uniform.	GEEK
1756	Ser Jorah Mormont's cerulean-blue balls.	GEEK
1757	A grumpy old Harrison Ford who'd rather be doing anything else.	GEEK
1758	Taking 2d6 emotional damage.	GEEK
1759	KHAAAAAAAAAN!	GEEK
1760	Endless ninjas.	GEEK
1761	Eight beautiful men jerking each other off in front of a fountain.	HIDDN
1763	Ruth Bader Ginsberg brutally gaveling your penis.	HIDDN
1764	A blind, quadriplegic AIDS survivor with face cancer and diarrhea.	HIDDN
1765	Free ice cream forever, or getting fingered by Chris Hemsworth for five minutes.	HIDDN
1766	Digging up Heath Ledger's corpse to reenact the prom scene from Ten Things I Hate About You.	HIDDN
1767	Throwing your hands in the air and waving them despite caring deeply.	HIDDN
1768	Chugging a gallon of milk and then vomiting a gallon of milk.	HIDDN
1769	How wonderful it is when my master throws the ball and I go and get it for him.	HIDDN
1770	Giving ISIS whatever they want so they leave us alone.	HIDDN
1771	Throwing a baby dolphin back into the ocean with a perfect spiral.	HIDDN
1772	Sitting in a jar of vinegar all night because I am pickle.	HIDDN
1773	Hickory-fucked pork ribs smothered in hot garbage.	HIDDN
1774	How bright the sun is.	WEED
1775	Grinning like an idiot.	WEED
1776	Smoking a blunt butt-ass naked.	WEED
1777	Forgetting to breathe and then dying.	WEED
1778	Dank ass cancer weed.	WEED
1779	Snoop Dogg.	WEED
1780	A whole cheese pizza just for me.	WEED
1781	Dicking around on the guitar for an hour.	WEED
1782	Cheesy crunchies.	WEED
1783	Whatever the fuck I was just talking about.	WEED
1784	Ancient aliens.	WEED
1785	Huge popcorn nugs of hairy alien weed.	WEED
1786	Too much edibles.	WEED
1787	An eight-foot man smoking a six-foot bong.	WEED
1788	Unbelievably soft carpet.	WEED
1789	Dropping stuff and knocking everything over.	WEED
1790	My own fingers.	WEED
1791	The banks, the media, the entire system, man.	WEED
1792	A sandwich with Cheetos in it!	WEED
1793	A bong rip so massive it restores justice to the kingdom.	WEED
1794	Being too high for airplane.	WEED
1795	Hot tub.	WEED
1796	Getting high and watching<i> Planet Earth.</i>	WEED
1797	Eating all the skin off a rotisserie chicken.	WEED
1798	Smoking a joint with former President Barack Obama.	WEED
1799	Whipping lower-class white men into a xenophobic frenzy.	PST45
1800	Extra rations for my little girl.	PST45
1801	Roaming through a wasteland of windblown trash and deserted highways.	PST45
1802	Drinking urine to survive.	PST45
1803	A legitimate reason to commit suicide.	PST45
1804	Burying my only son.	PST45
1805	Desperately hurling insults at Donald Trump as he absorbs them into his rapidly expanding body.	PST45
1806	Trying to remember what music was.	PST45
1807	Casual dismissiveness.	PST45
1808	Finding out that democracy might not be such a great idea.	PST45
1809	A father and son fighting each other over the last scrap of bread.	PST45
1810	Mild amusement.	PST45
1811	A back-alley abortion from a Mexican cyborg doctor.	PST45
1812	Rage.	PST45
1813	World Wards 3 through 5.	PST45
1814	President Donald Trump.	PST45
1815	Making Islam illegal.	PST45
1816	Trying to wake up from this nightmare.	PST45
1817	The purging of the disloyal.	PST45
1818	Nuclear winter.	PST45
1819	Bringing millions of dangerous, low-paying manufacturing jobs back to America.	PST45
1820	A gnawing sense of dread.	PST45
1821	Being knowledgeable in a narrow domain that nobody understands or cares about.	SCI
1822	A supermassive black hole.	SCI
1823	A 0.7 waist-to-hip ratio.	SCI
1824	The quiet majesty of the sea turtle.	SCI
1825	Photosynthesis.	SCI
1826	Getting really worried about global warming for a few seconds.	SCI
1827	Infinity.	SCI
1828	Reconciling quantum theory with general relativity.	SCI
1829	Driving into a tornado to learn about tornadoes.	SCI
1830	Explosive decompression.	SCI
1831	Oxytocin release via manual stimulation of the nipples.	SCI
1832	Developing secondary sex characteristics.	SCI
1833	David Attenborough watching us mate.	SCI
1834	Achieving reproductive success.	SCI
1835	Electroejaculating a capuchin monkey.	SCI
1836	Insufficient serotonin.	SCI
1837	Slowly evaporating.	SCI
1838	Failing the Turing test.	SCI
1839	Evolving a labyrinthe vagina.	SCI
1840	Fun and interesting facts about rocks.	SCI
1841	The Sun engulfing the Earth.	SCI
1842	3.7 billion years of evolution.	SCI
1843	Kevin Bacon Bits.	FOOD
1844	Being emotionally and physically dominated by Gordon Ramsay.	FOOD
1845	A belly full of hard-boiled eggs.	FOOD
1846	Kale farts.	FOOD
1847	Clamping down on a gazelle's jugular and tasting its warm life waters.	FOOD
1848	A table for one at The Cheesecake Factory.	FOOD
1849	The hot dog I put in my vagina ten days ago.	FOOD
1850	The Dial-A-Slice Apple Divider from Williams-Sonoma.	FOOD
1851	Oreos for dinner.	FOOD
1852	A joyless vegan patty.	FOOD
1853	Soup that's better than pussy.	FOOD
1854	The Hellman's Mayonnaise Corporation.	FOOD
1855	Going vegetarian and feeling so great all the time.	FOOD
1856	Not knowing what to believe anymore about butter.	FOOD
1857	A sobering quantity of chili cheese fries.	FOOD
1858	Licking the cake batter off of grandma's fingers.	FOOD
1859	Real cheese flavor.	FOOD
1860	Swishing the wine around and sniffing it like a big fancy man.	FOOD
1861	Sucking down thousands of pounds of krill every day.	FOOD
1862	The inaudible screams of carrots.	FOOD
1863	Committing suicide at the Old Country Buffet.	FOOD
1864	What to do with all of this chocolate on my penis.	FOOD
1865	Father's forbidden chocolates.	FOOD
1866	Jizz Twinkies.	FOOD
1867	Falling in actual love with a video game character.	MSFX
1868	My complicated backstory that you will soon learn about.	MSFX
1869	The Genophage.	MSFX
1870	Totally fuckable aliens.	MSFX
2221	Being fabulous.	INTL
1871	Running a few errands before saving the galaxy.	MSFX
1872	Bone-shattering sex with a metal woman.	MSFX
1873	Space racism.	MSFX
1874	An emergency induction port.	MSFX
1875	An armored Krogan war-clitoris.	MSFX
1876	An extremely long elevator ride.	MSFX
1877	Feeding a man a pie made of his own children.	RTAIL
1878	Ironically buying a trucker hat and then ironically being a trucker for 38 years.	RTAIL
1879	A teenage boy gunning for a handjob.	RTAIL
1880	Khakis.	BLUE
1881	Bathing in moonsblood and dancing around the ancient oak.	BLUE
1882	The passage of time.	BLUE
1883	A one-way ticket to Gary, Indiana.	BLUE
1884	The power of the Dark Side.	BLUE
1885	A team of lawyers.	BLUE
1886	Getting eaten alive by Guy Fieri.	BLUE
1887	Figuring out how to have sex with a dolphin.	BLUE
1888	Some sort of Asian.	BLUE
1889	Vegetarian options.	BLUE
1890	An inability to form meaningful relationships.	BLUE
1891	One unforgettable night of passion.	BLUE
1892	Important news about Taylor Swift.	BLUE
1893	The all-new Nissan Pathfinder with 0.9% APR financing!	BLUE
1894	Free ice cream, yo.	BLUE
1895	My boyfriend's stupid penis.	BLUE
1896	A mouthful of potato salad.	BLUE
1897	Our new Buffalo Chicken Dippers&reg;!	BLUE
1898	Crying and shitting and eat spaghetti.	BLUE
1899	A fart.	BLUE
1900	Actual mutants with medical conditions and no superpowers.	BLUE
1901	Deez nuts.	BLUE
1902	Africa.	BLUE
1903	Finally finishing off the Indians.	BLUE
1904	Owls, the perfect predator.	BLUE
1905	A dance move that's just sex.	BLUE
1906	Ass to mouth.	BLUE
1907	Bouncing up and down.	BLUE
1908	Walking into a glass door.	BLUE
1909	Eating together like a god damn family for once.	BLUE
1910	No longer finding any Cards Against Humanity card funny.	BLUE
1911	Treasures beyond your wildest dreams.	BLUE
1912	Ejaculating live bees and the bees are angry.	BLUE
1913	Sucking all the milk out of a yak.	BLUE
1914	Falling into the toilet.	BLUE
1915	The color "puce."	BLUE
1916	An oppressed people with a vibrant culture.	BLUE
1917	Out-of-this-world bazongas.	BLUE
1918	Getting caught by the police and going to jail.	BLUE
1919	The sweet song of sword against sword and the braying of mighty war beasts.	BLUE
1920	A sex goblin with a carnival penis.	BLUE
1921	Genghis Khan's DNA.	BLUE
1922	A gender identity that can only be conveyed through slam poetry.	BLUE
1923	The ghost of Marlon Brando.	BLUE
1924	Immortality cream.	BLUE
1925	Butt stuff.	BLUE
1926	Getting offended.	BLUE
1927	My dad's dumb fucking face.	BLUE
1928	A bunch of idiots playing a card game instead of interacting like normal humans.	BLUE
1929	Neil Diamond's Greatest Hits.	BLUE
1930	Whatever a McRib&reg; is made of.	BLUE
1931	Total fucking chaos.	BLUE
1932	Whispering all sexy.	BLUE
1933	Calculating every mannerism so as not to suggest homosexuality.	BLUE
1934	Some shit-hot guitar licks.	BLUE
1935	No clothes on, penis in vagina.	BLUE
1936	Sports.	BLUE
1937	How awesome I am.	BLUE
1938	The white half of Barack Obama.	BLUE
1939	An overwhelming variety of cheeses.	BLUE
1940	Ejaculating inside another man's wife.	BLUE
1941	Getting shot by the police.	BLUE
1942	Beloved television star Bill Cosby.	BLUE
1943	The tiger that killed my father.	BLUE
1944	Changing a person's mind with logic and facts.	BLUE
1945	Child Protective Services.	BLUE
1946	A peyote-fueled vision quest.	BLUE
1947	Cute boys.	BLUE
1948	A hopeless amount of spiders.	BLUE
1949	The swim team, all at once.	BLUE
1950	Whatever you wish, mother.	BLUE
1951	A possible Muslim.	BLUE
1952	All the single ladies.	BLUE
1953	Letting out 20 years' worth of farts.	BLUE
1954	Being paralyzed from the neck down.	BLUE
1955	The eight gay warlocks who dictate the rules of fashion.	BLUE
1956	Shapes and colors.	BLUE
1957	Seeing my village burned and my family slaughtered before my eyes.	BLUE
1958	Filling a man's anus with concrete.	BLUE
1959	Peeing into a girl's butt to make a baby.	BLUE
1960	Meaningless sex.	BLUE
1961	Wearing glasses and sounding smart.	BLUE
1962	Setting my balls on fire and cartwheeling to Ohio.	BLUE
1963	Child support payments.	BLUE
1964	Being John Malkovich.	BLUE
1965	Throwing stones at a man until he dies.	BLUE
1966	A shiny rock that proves I love you.	BLUE
1967	Kale.	BLUE
1968	Stuffing a child's face with Fun Dip&reg; until he starts having fun.	BLUE
1969	A turd.	BLUE
1970	Party Mexicans.	BLUE
1971	Too much cocaine.	BLUE
1972	Like a million alligators.	BLUE
1973	Grammar nazis who are also regular Nazis.	BLUE
1974	A face full of horse cum.	BLUE
1975	Fresh dill from the patio.	BLUE
1976	Boring vaginal sex.	BLUE
1977	Crazy opium eyes.	BLUE
1978	AIDS monkeys.	BLUE
1979	Crippling social anxiety.	BLUE
1980	Not believing in giraffes.	BLUE
1981	An interracial handshake.	BLUE
2222	Homeless people.	INTL
1982	Irrefutable evidence that God is real.	BLUE
1983	A zero-risk way to make $2,000 from home.	BLUE
1984	My sex dungeon.	BLUE
1985	Being nine years old.	BLUE
1986	Daddy.	BLUE
1987	Unquestioning obedience.	BLUE
1988	A bass drop so huge it tears the starry vault asunder to reveal the face of God.	BLUE
1989	Sharks with legs.	BLUE
1990	Generally having no idea what's going on.	BLUE
1991	Bullets.	BLUE
1992	An unforgettable quincea&ntilde;era.	BLUE
1993	Two whales fucking the shit out of each other.	BLUE
1994	A whole lotta woman.	BLUE
1995	A self-microwaving burrito.	BLUE
1996	Snorting coke off a clown's boner.	BLUE
1997	A buttload of candy.	BLUE
1998	A thrilling chase over the rooftops of Rio de Janeiro.	BLUE
1999	Dem titties.	BLUE
2000	The amount of gay I am.	BLUE
2001	My first period.	BLUE
2002	Common-sense gun control legislation.	BLUE
2003	Being a terrible mother.	BLUE
2004	Being popular and good at sports.	BLUE
2005	Never having sex again.	BLUE
2006	A giant powdery manbaby.	BLUE
2007	A crazy little thing called love.	BLUE
2008	Stupid.	BLUE
2009	The best taquito in the galaxy.	BLUE
2010	Fucking a corpse back to life.	BLUE
2011	A pizza guy who fucked up.	BLUE
2012	Ennui.	BLUE
2013	Injecting speed into one arm and horse tranquilizer into the other.	BLUE
2014	Lots and lots of abortions.	BLUE
2015	Eggs.	BLUE
2016	My worthless son.	BLUE
2017	Blowjobs for everyone.	BLUE
2018	Shitting all over the floor like a bad, bad girl.	BLUE
2019	An uninterrupted history of imperialism and exploitation.	BLUE
2020	The unbelievable world of mushrooms.	BLUE
2021	A horse with no legs.	BLUE
2022	Having been dead for a while.	BLUE
2023	Drinking responsibly.	BLUE
2024	Breastfeeding a ten-year-old.	BLUE
2025	Going to a high school reunion on ketamine.	BLUE
2026	Backwards knees.	BLUE
2027	Gwyneth Paltrow's opinions.	BLUE
2028	The basic suffering that pervades all of existence.	BLUE
2029	Cutting off a flamingo's legs with garden shears.	BLUE
2030	The secret formula for ultimate female satisfaction.	BLUE
2031	Seeing things from Hitler's perspective.	BLUE
2032	A constant need for validation.	BLUE
2033	Jizz.	BLUE
2034	What Jesus would do.	BLUE
2035	A Ugandan warlord.	BLUE
2036	Slowly easing down onto a cucumber.	BLUE
2037	Smoking crack, for instance.	BLUE
2038	A kiss on the lips.	BLUE
2039	The haunting stare of an Iraqi child.	BLUE
2040	A sex comet from Neptune that plunges the Earth into eternal sexiness.	BLUE
2041	Giant sperm from outer space.	BLUE
2042	The euphoric rush of strangling a drifter.	BLUE
2043	Morpheus.	BLUE
2044	Mom's new boyfriend.	BLUE
2045	Blackface.	BLUE
2046	Every ounce of charisma left in Mick Jagger's tired body.	BLUE
2047	Sudden penis loss.	BLUE
2048	Daddy's credit card.	BLUE
2049	Ripping a dog in half.	BLUE
2050	Angelheaded hipsters burning for the ancient heavenly connection to the starry dynamo in the machinery of the night.	BLUE
2051	Interspecies marriage.	BLUE
2052	Cancer.	BLUE
2053	The male gaze.	BLUE
2054	Being worshipped as the one true God.	BLUE
2055	All these decorative pillows.	BLUE
2056	Unrelenting genital punishment.	BLUE
2057	Exploding pigeons.	BLUE
2058	A disappointing salad.	BLUE
2059	The dentist.	BLUE
2060	Moderate-to-severe joint pain.	BLUE
2061	Getting drive-by shot.	BLUE
2062	The black half of Barack Obama.	BLUE
2063	Western standards of beauty.	BLUE
2064	A reason not to commit suicide.	BLUE
2065	40 acres and a mule.	BLUE
2066	Such a big boy.	BLUE
2067	10 Incredible Facts About the Anus.	BLUE
2068	A manhole.	BLUE
2069	The size of my penis.	BLUE
2070	The complex geopolitical quagmire that is the Middle East.	BLUE
2071	My dead son's baseball glove.	BLUE
2072	Robots who just want to party.	BLUE
2073	A whole new kind of porn.	BLUE
2074	Ambiguous sarcasm.	BLUE
2075	Russian super-tuberculosis.	BLUE
2076	Prince Ali, fabulous he, Ali Ababwa.	BLUE
2077	Doing the right stuff to her nipples.	BLUE
2078	Ancient Athenian boy-fucking.	BLUE
2079	The eighth graders.	BLUE
2080	September 11th, 2001.	BLUE
2081	The safe word.	BLUE
2082	Doo-doo.	BLUE
2083	Blackula.	BLUE
2084	Anal fissures like you wouldn't believe.	BLUE
2085	Texas.	BLUE
2086	Going down on a woman, discovering that her vaginas is filled with eyeballs, and being totally into that.	BLUE
2087	P.F. Chang himself.	BLUE
2088	Almost giving money to a homeless person.	BLUE
2089	Depression.	BLUE
2090	Growing up chained to a radiator in perpetual darkness.	BLUE
2091	Three consecutive seconds of happiness.	BLUE
2092	Going inside at some point because of the mosquitoes.	BLUE
2093	Pussy.	BLUE
2094	Unsheathing my massive horse cock.	BLUE
2095	A woman.	BLUE
2096	Turning the rivers red with the blood of infidels.	BLUE
2097	A woman who is so cool that he rides on a motorcycle.	BLUE
2098	The peaceful and nonthreatening rise of China.	BLUE
2099	A chimpanzee in sunglasses fucking your wife.	BLUE
2100	An ass disaster.	INTL
2101	Disco fever.	INTL
2102	Words.	INTL
2103	Spending lots of money.	INTL
2104	Mooing.	INTL
2105	A cat video so cute that your eyes roll back and your spine slides out of your anus.	INTL
2106	Michael Jackson.	INTL
2107	Horrifying laser hair removal accidents.	INTL
2108	Dying alone and in pain.	INTL
2109	Shitting out a screaming face.	INTL
2110	Literally eating shit.	INTL
2111	A monkey smoking a cigar.	INTL
2112	Rich people.	INTL
2113	An evil man in evil clothes.	INTL
2114	A low standard of living.	INTL
2115	Wearing an octopus for a hat.	INTL
2116	Whining like a little bitch.	INTL
2117	Not having sex,	INTL
2118	A fat bald man from the Internet.	INTL
2119	Basic human decency.	INTL
2120	How awesome it is to be white.	INTL
2121	Nothing.	INTL
2122	Doing it in the butt.	INTL
2123	Moral ambiguity.	INTL
2124	Dining with cardboard cutouts of the cast of <i>Friends.</i>	INTL
2125	A big black dick.	INTL
2126	The arrival of pizza.	INTL
2127	An unstoppable wave of fire ants.	INTL
2128	Extremely tight jeans.	INTL
2129	A web of lies.	INTL
2130	Ominous background music.	INTL
2131	My machete.	INTL
2132	Multiple orgasms.	INTL
2133	Daddy's belt.	INTL
2134	Eating a hard boiled out of my husband's asshole.	INTL
2135	Friendly fire.	INTL
2136	The boners of the elderly.	INTL
2137	The hiccups.	INTL
2138	The crazy, ball-slapping sex your parents are having right now.	INTL
2139	Going around punching people.	INTL
2140	Letting everyone down.	INTL
2141	Nunchuck moves.	INTL
2142	The prunes I've been saving for you in my armpits.	INTL
2143	A PowerPoint presentation.	INTL
2144	The entire Internet.	INTL
2145	An AK-47.	INTL
2146	Walking in on Dad peeing into Mom's mouth.	INTL
2147	Dad's funny balls.	INTL
2148	Flying robots that kill people.	INTL
2149	Weapons-grade plutonium.	INTL
2150	Sexy pillow fights.	INTL
2151	Being white.	INTL
2152	A slightly shittier parallel universe.	INTL
2153	Having sex on top of a pizza.	INTL
2154	Power.	INTL
2155	Scrotum tickling.	INTL
2156	An army of skeletons.	INTL
2157	Actually getting shot, for real.	INTL
2158	A cop who is also a dog.	INTL
2159	A vagina that leads to another dimension.	INTL
2160	A man in yoga pants with a ponytail and feather earrings.	INTL
2161	Converting to Islam.	INTL
2162	Me.	INTL
2163	Tom Cruise.	INTL
2164	Intimacy problems.	INTL
2165	Leveling up.	INTL
2166	That ass.	INTL
2167	Kim Jong-un.	INTL
2168	The Dalai Lama.	INTL
2169	Ripping open a man's chest and pulling out his still-beating heart.	INTL
2170	A sad fat dragon with no friends.	INTL
2171	A surprising amount of hair.	INTL
2172	Some really fucked-up shit.	INTL
2173	Robert Downey Jr.	INTL
2174	Ryan Gosling riding in on a white horse.	INTL
2175	Sexual humiliation.	INTL
2176	Fisting.	INTL
2177	The human body.	INTL
2178	A defective condom.	INTL
2179	My father, who died when I was seven.	INTL
2180	The economy.	INTL
2181	Deflowering the princess.	INTL
2182	A Chinese tourist who wants something very badly but cannot communicate it.	INTL
2183	Graphic violence, adult language, and some sexual content.	INTL
2184	Self-flagellation.	INTL
2185	Shutting the fuck up.	INTL
2186	FIlling my son with spaghetti.	INTL
2187	The baby that ruined my pussy.	INTL
2188	Buying the right clothes to be cool.	INTL
2189	Being black.	INTL
2190	All of this blood.	INTL
2191	Edible underwear.	INTL
2192	An oversized lollipop,	INTL
2193	Stockholm Syndrome.	INTL
2194	The World of Warcraft.	INTL
2195	Grave robbing.	INTL
2196	Gandalf.	INTL
2197	Sneezing, farting, and cumming at the same time.	INTL
2198	Running naked through a mall, pissing and shitting everywhere.	INTL
2199	Blood farts.	INTL
2200	Panda sex.	INTL
2201	A thermonuclear detonation.	INTL
2202	Destroying the evidence.	INTL
2203	Vomiting mid-blowjob.	INTL
2204	A pi&ntilde;ata full of scorpions.	INTL
2205	Miley Cyrus.	INTL
2206	A Japanese toaster you can fuck.	INTL
2207	Suicidal thoughts.	INTL
2208	Grandpa's ashes.	INTL
2209	Reverse cowgirl.	INTL
2210	Keanu Reeves.	INTL
2211	LIving in a trashcan.	INTL
2212	My first kill.	INTL
2213	Mom.	INTL
2214	Children on leashes.	INTL
2215	Double penetration.	INTL
2216	Slave.	INTL
2217	White power.	INTL
2218	Indescribable loneliness.	INTL
2219	Tongue.	INTL
2220	Tiny nipples.	INTL
2223	My cheating-son-of-a-bitch-husband.	INTL
2224	Screaming like a maniac.	INTL
2225	Heroin.	INTL
2226	Existing.	INTL
2227	The pirate's life.	INTL
2228	One Ring to rule them all.	INTL
2229	The flute.	INTL
2230	Being a busy adult with many important things to do.	INTL
2231	Slapping a racist old lady.	INTL
2232	Genetically engineered super-soldiers.	INTL
2233	Pumping out a baby every nine months.	INTL
2234	A mime having a stroke.	INTL
2235	Women voting.	INTL
2236	Gladiatorial combat.	INTL
2237	Some kind of bird man.	INTL
2238	Taking a man's eyes and balls out and putting his eyes where his balls go and then his balls in the eye holes.	INTL
2239	Mild autism.	INTL
2240	Rising from the grave.	INTL
2241	Not contributing to society in any meaningful way.	INTL
2242	Cock.	INTL
2243	Some douche with an acoustic guitar.	INTL
2244	Terrorists.	INTL
2245	Overpowering your father.	INTL
2246	Being a hideous beast that no one could love.	INTL
2247	Samuel L. Jackson.	INTL
2248	Making the penises kiss.	INTL
2249	Being a dinosaur.	INTL
2250	Staring at a painting and going "hmmmmmmm..."	INTL
2251	A sweet spaceships.	INTL
2252	Lady Gaga.	INTL
2253	Tripping balls.	INTL
2254	Eating an albino.	INTL
2255	Our first chimpanzee Prime Minister.	INTL
2256	Sudden Poop Explosion Disease.	INTL
2257	The total collapse of the global financial system.	INTL
2258	Loki, the trickster god.	INTL
2259	Making a friend.	INTL
2260	The Gulags.	INTL
2261	Hipsters.	INTL
2262	Wiping her butt.	INTL
2263	All my friends dying.	INTL
2264	The land of chocolate.	INTL
2265	Jesus.	INTL
2266	Another shot of morphine.	INTL
2267	Bosnian chicken farmers.	INTL
2268	How wet my pussy is.	INTL
2269	Having shotguns for legs.	INTL
2270	Bullshit.	INTL
2271	Blowing my boyfriend so hard so he shits.	INTL
2272	Cumming deep inside my best bro.	INTL
2273	Being awesome at sex.	INTL
2274	Santa Claus.	INTL
2275	Having a penis.	INTL
2276	Gay aliens.	INTL
2277	SIX GOD DAMN HOURS OF FUCKING DIPLOMACY.	TBLTP
2278	Condensing centuries of economic exploitation into 90 minutes of gaming fun.	TBLTP
2279	A marriage-destroying game of <i>The Resistance</i>.	TBLTP
2280	Spending 8 years in the Himalayas becoming a master of dice-rolling and resource allocation.	TBLTP
2281	A disappointing season of Tabletop that's just about tables.	TBLTP
2282	A zombie with a tragic backstory.	TBLTP
2283	A Wesley Crusher blow-up doll.	TBLTP
2284	The porn set that Tabletop is filmed on.	TBLTP
2285	An owlbear.	TBLTP
2286	The pooping position.	TBLTP
2287	A German-style board game where you invade Poland.	TBLTP
2288	Victory points.	TBLTP
2289	Jafar.	RED
2290	Jumping out at people.	RED
2291	The mixing of the races.	RED
2292	The Harlem Globetrotters.	RED
2293	Scrotal frostbite.	RED
2294	Statistically validated stereotypes.	RED
2295	Pretty Pretty Princess Dress-Up Board Game.&reg;	RED
2296	Making shit up.	RED
2297	Mufasa's death scene.	RED
2298	Having $57 in the bank.	RED
2299	A sales team of clowns and pedophiles.	RED
2300	Survivor's guilt.	RED
2301	The mere concept of Applebees.&reg;	RED
2302	Boris the Soviet Love Hammer.	RED
2303	Not having sex.	RED
2304	Indescribably loneliness.	RED
2305	One thousand Slim Jims.	RED
2306	A nuanced critique.	RED
2307	A nautical theme.	RED
2308	The black Power Ranger.	RED
2309	Neil Patrick Harris.	RED
2310	Bill Clinton, naked on a bearskin rug with a saxophone.	RED
2311	The hose.	RED
2312	Finding Waldo.	RED
2313	Fuck Mountain.	RED
2314	Unlimited soup, salad, and breadsticks.	RED
2315	Syphilitic insanity.	RED
2316	Oncoming traffic.	RED
2317	Suicide bombers.	RED
2318	Some kind of bird-man.	RED
2319	Ryan Goslin riding in on a white horse.	RED
2320	Living in a trash can.	RED
2321	Historical revisionism.	RED
2322	A passionate Latino lover.	RED
2323	Roland the Farter, flatulist to the king.	RED
2324	Consent.	RED
2325	An unhinged Ferris wheel rolling toward the sea.	RED
2326	A plunger to the face.	RED
2327	Shaft.	RED
2328	Big Bird's crown, crusty asshole.	RED
2329	Filling every orifice with butterscotch pudding.	RED
2330	A fortuitous turnip harvest.	RED
2331	Buying the right pants to be cool.	RED
2332	Getting hilariously gang-banged by the Blue Man Group.	RED
2333	A phantasmagoria of anal delights.	RED
2334	The new Radiohead album.	RED
2335	24-hour media coverage.	RED
2336	Gargling jizz.	RED
2337	A dollop of sour cream.	RED
2338	Demonic possession.	RED
2339	Chugging a lava lamp.	RED
2340	Jeff Goldblum.	RED
2341	The day the birds attacked.	RED
2342	Subduing a grizzly bear and making her your wife.	RED
2343	A sofa that says "I have style, but I like to be comfortable."	RED
2344	Dorito breath.	RED
2345	The way white people is.	RED
2346	Fetal alcohol syndrome.	RED
2347	The Quesadilla Explosion Salad&trade; from Chili's.&reg;	RED
2348	Racial profiling.	RED
2349	Special musical guest, Cher.	RED
2350	A crappy little hand.	RED
2351	The systemic destruction of an entire people and their way of life.	RED
2352	Clenched butt cheeks.	RED
2353	Filing my son with spaghetti.	RED
2354	Blowing some dudes in an alley.	RED
2355	Words, words, words.	RED
2356	Clams.	RED
2357	Hot doooooooogs!	RED
2358	Andr&eacute; the Giant's enormous, leathery scrotum.	RED
2359	A greased-up Matthew McConaughey.	RED
2360	A pile of squirming bodies.	RED
2361	A bloody pacifier.	RED
2362	Medieval Times&reg; Dinner &amp; Tournament.	RED
2363	Just the tip.	RED
2364	One ring to rule them all.	RED
2365	The milk that comes out of a person.	RED
2366	A sweet spaceship.	RED
2367	Big ol' floppy titties.	RED
2368	A 55-gallon drum of lube.	RED
2369	Sorcery.	RED
2370	Getting your dick stuck in a Chinese finger trap with another dick.	RED
2371	Weapons grade plutonium.	RED
2372	Mad hacky-sack skills.	RED
2373	Emotional baggage.	RED
2374	Insatiable bloodlust.	RED
2375	Hillary Clinton.	RED
2376	Catastrophic urethral trauma.	RED
2377	Putting an entire peanut butter and jelly sandwich into the VCR.	RED
2378	Crying into the pages of Sylvia Plath.	RED
2379	A spontaneous conga line.	RED
2380	A Japanese tourist who wants something very badly but cannot communicate it.	RED
2381	A boo-boo.	RED
2382	A black-owned and operated business.	RED
2383	The moist, demanding chasm of his mouth.	RED
2384	Velcro.&trade;	RED
2385	The shambling corpse of Larry King.	RED
2386	Drinking my bro's pee-pee right out of his peen.	RED
2387	Quiche.	RED
2388	Some really fucked up shit.	RED
2389	Warm, velvety muppet sex.	RED
2390	The primal, ball-slapping sex your parents are having right now.	RED
2391	A bigger, blacker dick.	RED
2392	Crabapples all over the fucking sidewalk.	RED
2393	Bosnian chick farmers.	RED
2394	Sanding off a man's nose.	RED
2395	The harsh light of day.	RED
2396	Vietnam flashbacks.	RED
2397	Savagely beating a mascot.	RED
2398	Staring at a painting and going "hmmmmmm..."	RED
2399	Nubile slave boys.	RED
2400	Drinking ten 5-hour ENERGYs&reg; to get fifty continuous hours of energy.	RED
2401	A sweaty, panting leather daddy.	RED
2402	My manservant, Claude.	RED
2403	Demons and shit.	14PAX
2405	Collecting all seven power crystals.	14PAX
2406	Xena, Warrior Princess.	14PAX
2407	The old gods.	14PAX
2408	The Star Wars Universe.	14PAX
2409	The imagination of Peter Jackson.	14PAX
2410	Lagging out.	14PAX
2411	All of the good times and premium gaming entertainment available to you in the Kickstarter room.	14PAX
2412	Attacking from Kamchatka.	14PAX
2413	The pure, Zen-like state that exists between micro and macro.	14PAX
2414	Mistakenly hitting on a <i>League of Legends</i> statue.	14PAX
2415	A giant mechanical bird with a tragic backstory.	14PAX
2416	Whatever <i>Final Fantasy</i> bullshit happened this year.	14PAX
2417	Futuristic death sports.	14PAX
2418	A homoerotic subplot.	HCARD
2419	The sensitive European photographer who's fucking my wife.	HCARD
2420	An origami swan that's some kind of symbol?	HCARD
2421	Carbon monoxide poisoning.	HCARD
2422	A childless marriage.	HCARD
2423	Ribs so good they transcend race and class.	HCARD
2424	25 shitty jokes about <i>House of Cards.</i>	HCARD
2425	Making it look like a suicide.	HCARD
2426	Forcing a handjob on a dying man.	HCARD
2427	Getting eaten out while on the phone with Dad.	HCARD
2428	My constituents.	HCARD
2429	Strangling a dog to make a point to the audience.	HCARD
2430	Discharging a firearm in a residential area.	HCARD
2431	Caribbean Jesus.	RJECT
2432	Corn.	RJECT
2433	Super yoga.	RJECT
2434	A sexy naked interactive theater thing.	RJECT
2435	Actually believing that the Bible happened.	RJECT
2436	A giant squid in a wedding gown.	RJECT
2437	A heart that is two sizes too small and that therefore cannot pump an adequate amount of blood.	RJECT
2438	Ejaculating a pound of tinsel.	RJECT
2439	Crawling into a vagina.	RJECT
2440	Faking a jellyfish sting so someone will pee on you.	RJECT
2441	My dick in your mouth.	RJECT
2442	Asshole pomegranates that are hard to eat.	RJECT
2443	The John D. and Catherine T. MacArthur Foundation.	RJECT
2444	Dividing by zero.	RJECT
2445	Becoming so rich that you shed your body and turn into vapor.	RJECT
2446	Playing an ocarina to summon Ultra-Congress from the sea.	RJECT
2447	Actually voting for Donald Trump to be President of the actual United States.	V4 45
2448	Growing up and becoming a Republican.	V4 45
2449	A liberal bias.	V4 45
2450	Full-on socialism.	V4 45
2451	Hating Hillary Clinton.	V4 45
2452	Jeb!	V4 45
2453	Conservative talking points.	V4 45
2454	Courageously going ahead with that racist comment.	V4 45
2455	The good, hardworking people of Dubuque, Iowa.	V4 45
2456	Dispelling with this fiction that Barack Obama doesn't know what he's doing.	V4 45
2457	Shouting the loudest.	V4 45
2458	Sound fiscal policy.	V4 45
2459	An icy handjob from an Edmonton hooker.	CA
2460	An Evening with Michael Bubl&eacute;.	CA
2461	Getting a DUI on a Zamboni.	CA
2462	The Royal Canadian Mounted Police.	CA
2463	Heritage minutes.	CA
2464	A hairless little shitstain named Caillou.	CA
2465	A despondent Maple Leafs fan sitting all alone.	CA
2466	Apologizing.	CA
2467	Syrupy sex with a maple tree.	CA
2468	Canadian Netflix.	CA
2469	Burning down the White House.	CA
2470	Newfies.	CA
2471	A vastly superior healthcare system.	CA
2472	Women of colour.	CA
2473	Living in Yellowknife.	CA
2474	Clubbing baby seals.	CA
2475	The Official Languages Act. La Loi sur les langues officielles.	CA
2476	Terry Fox's prosthetic leg.	CA
2477	Mr. Dressup.	CA
2478	Justin Trudeau.	CA
2479	Resurrecting an army of six million Jews and conquering Germany.	JEW
2480	The part of Anne Frank's diary where she talks about her vagina.	JEW
2481	Sacrificing Isaac to the Lord.	JEW
2482	The ethical implications of enjoying a Woody Allen film in light of the allegations against him.	JEW
2483	Chopping off a bit of the penis.	JEW
2484	Some kind of concentrated encampment for people.	JEW
2485	Pork products.	JEW
2486	Wandering the desert for 40 years.	JEW
2487	What it means to be a Jewish woman in contemporary society.	JEW
2488	Suddenly remembering that the Holocaust happened.	JEW
2489	Thy neighbor's wife.	JEW
2490	Holding up the line at Walgreens by trying to use an expired coupon.	JEW
2491	Demolishing that ass like a Palestinian village.	JEW
2492	Being chosen by God to win a free iPod Nano.	JEW
2493	A little bit of schmutz right there.	JEW
2494	Torturing Jews until they say they're not Jews anymore.	JEW
2495	A lifetime of internalized guilt.	JEW
2496	A three-foot-tall corned beef sandwich.	JEW
2497	Usury.	JEW
2498	Hiding from the Nazis.	JEW
2499	Bags of money.	JEW
2500	The blood of Christian babies.	JEW
2501	A headache that's definitely cancer.	JEW
2502	A big brain full of facts and sadness.	JEW
2503	Whoopi Goldberg.	JEW
2504	Eating an entire snowman.	❄2013
2505	A Christmas stocking full of coleslaw.	❄2013
2506	Giving money and personal information to strangers on the Internet.	❄2013
2507	The royal afterbirth.	❄2013
2508	A magical tablet containing a world of unlimited pornography.	❄2013
2509	Breeding elves for their priceless semen.	❄2013
2510	Clearing a bloody path through Walmart with a scimitar.	❄2013
2511	Slicing a ham in icy silence.	❄2013
2512	A simultaneous nightmare and wet dream starring Sigourney Weaver.	❄2013
2513	A visually arresting turtleneck.	❄2013
2514	Moses gargling Jesus's balls while Shiva and the Buddha penetrate his divine hand holes.	❄2013
2515	The tiny, calloused hands of the Chinese children that made this card.	❄2013
2516	The Star Wars Holiday Special.	❄2013
2517	Rudolph's bright red balls.	❄2013
2518	Jizzing into Santa's beard.	❄2013
2519	Being blind and deaf and having no limbs.	❄2013
2520	Mall Santa.	❄2013
2521	The Hawaiian goddess Kapo and her flying detachable vagina.	❄2013
2522	Taking down Santa with a surface-to-air missile.	❄2013
2523	Fucking up "Silent Night" in front of 300 parents.	❄2013
2524	Krampus, the Austrian Christmas monster.	❄2013
2525	Several intertwining love stories featuring Hugh Grant.	❄2013
2526	Space Jam on VHS.	❄2013
2527	Swapping bodies with mom for a day.	❄2013
2528	Immaculate conception.	❄2013
2529	People with cake in their mouths talking about how good cake is.	❄2013
2530	Congress's flaccid penises withering away beneath their suit pants.	❄2013
2531	Having a strong opinion about Obamacare.	❄2013
2532	Whatever Kwanzaa is supposed to be about.	❄2013
2533	A Hungry-Man&trade; Frozen Christmas Dinner for One.	❄2013
2534	Making up for 10 years of shitty parenting with a PlayStation.	❄2013
2535	The Grinch's musty, cum-stained pelt.	❄2013
2536	Dinosaurs who wear armor and you ride them and they kick ass.	FNTSY
2537	Accidentally conjuring a legless horse that can't stop ejaculating.	FNTSY
2538	Shitting in a wizard's spell book and jizzing in his hat.	FNTSY
2539	A Hitachi Magic Wand.	FNTSY
2540	Reading <i>The Hobbit</i> under the covers while mom and dad scream at each other downstairs.	FNTSY
2541	How hot Orlando Bloom was in <i>Lord of the Rings.</i>	FNTSY
2542	A mysterious, floating orb.	FNTSY
2543	Shooting a wizard with a gun.	FNTSY
2544	Hodor.	FNTSY
2545	Make-believe stories for autistic white men.	FNTSY
2546	A magical kingdom with dragons and elves and no black people.	FNTSY
2547	The card Neil Gaiman wrote: "Three elves at a time."	FNTSY
2548	Gender equality.	FNTSY
2549	Going on an epic adventure and learning a valuable lesson about friendship.	FNTSY
2550	True love's kiss.	FNTSY
2551	Eternal darkness.	FNTSY
2552	The all-seeing Eye of Sauron.	FNTSY
2553	Bathing naked in a moonlit grove.	FNTSY
2554	Handcuffing a wizard to a radiator and dousing him with kerosene.	FNTSY
2555	Kneeing a wizard in the balls.	FNTSY
2556	A ghoul.	FNTSY
2557	A weed elemental who gets everyone high.	FNTSY
2558	A gay sorcerer who turns everyone gay.	FNTSY
2559	A CGI dragon.	FNTSY
2560	Freaky, pan-dimensional sex with a demigod.	FNTSY
2561	A dwarf who won't leave you alone until you compare penis sizes.	FNTSY
2562	Going too far with science and bad things happening.	SCIFI
2563	Frantically writing equations on a chalkboard.	SCIFI
2564	An alternate history where Hitler was gay but he still killed all those people.	SCIFI
2565	A hazmat suit full of farts.	SCIFI
2566	That girl from the Hungry Games.	SCIFI
2567	Funkified aliens from the planet Groovius.	SCIFI
2568	The ending of <i>Lost.</i>	SCIFI
2569	Vulcan sex-madness.	SCIFI
2570	Three boobs.	SCIFI
2571	A misty room full of glistening egg sacs.	SCIFI
2572	Cheerful blowjob robots.	SCIFI
2573	How great of a movie <i>Men in Black</i> was.	SCIFI
2574	A planet-devouring space worm named Rachel.	SCIFI
2575	Beep beep boop beep boop.	SCIFI
2576	Nine seasons of sexual tension with David Duchovny.	SCIFI
2577	Darmok and Jalad at Tanagra.	SCIFI
2578	A protagonist with no qualities.	SCIFI
2579	The dystopia we're living in right now.	SCIFI
2580	Cosmic bowling.	SCIFI
2581	Masturbating Yoda's leathery turtle-penis.	SCIFI
2582	Laying thousands of eggs in a man's colon.	SCIFI
2583	Trimming poop out of Chewbacca's butt hair.	SCIFI
2584	Santa's heavy sack.	❄2012
2585	Performative wokeness.	COLEG
2586	The sound of my roommate masturbating.	COLEG
2587	Rocking a 1.5 GPA.	COLEG
2588	Pretending to have done the reading.	COLEG
2589	Throw up.	COLEG
2590	Uggs, leggings, and a North Face.	COLEG
2591	Valuable leadership experience.	COLEG
2592	Whichever one of you took a shit in the shower.	COLEG
2593	Fucking the beat boxer from the a cappella group.	COLEG
2594	Five morons signing a lease together.	COLEG
2595	Googling how to eat pussy.	COLEG
2596	Sucking a flaccid penis for 20 minutes.	COLEG
2597	My high school boyfriend.	COLEG
2598	A bachelor's degree in communications.	COLEG
2599	Calling mom because it's just really hard and I miss her and I don't know anyone here.	COLEG
2600	Wandering the streets in search of a party.	COLEG
2601	Underage drinking.	COLEG
2602	Young Republicans.	COLEG
2603	A Yale man.	COLEG
2604	An emergency all-floor meeting of inclusion.	COLEG
2605	Going to college and becoming a new person, who has sex.	COLEG
2606	How many Asians there are.	COLEG
2607	A girl who is so interesting that she has blue hair.	COLEG
2608	Falling in love with poetry.	COLEG
2609	Period globs.	.
2610	Always&reg; Infinity Extra Heavy Overnight Pads with Wings.	.
2611	Wringing out a sopping wet maxi pad in Donald Trump's mouth.	.
2612	Playing with my pussy while I watch TV.	.
2613	An emotionally draining friendship.	.
2614	Post-partum depression.	.
2615	Full bush.	.
2616	Drinking Beyonce's DivaCup and becoming immortal.	.
2617	Feeling lots of feelings.	.
2618	Carrying a fetus to term.	.
2619	Eating three sleeves of Chips Ahoy!	.
2620	Destroying a pair of underwear.	.
2621	Masturbating with a Sonicare.	.
2622	How bloody that dick's about to be.	.
2623	The vagina hole.	.
2624	Dancing carefree in white linen pants.	.
2625	Pussy lips of all shapes and sizes.	.
2626	Using a Smucker's Uncrustable&trade; as a maxi pad.	.
2627	Pulling out a never-ending tampon.	.
2628	Catching a whiff of my vag.	.
2629	A diverse group of female friends casually discussing the side effects of birth control.	.
2630	A woman president.	.
2631	Driving my daughter to her abortion.	.
2632	Feeling bloaty and crampy.	.
\.


--
-- TOC entry 2202 (class 0 OID 0)
-- Dependencies: 190
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: pyx
--

SELECT pg_catalog.setval('hibernate_sequence', 2632, true);


--
-- TOC entry 2059 (class 2606 OID 17430)
-- Name: black_cards black_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: pyx
--

ALTER TABLE ONLY black_cards
    ADD CONSTRAINT black_cards_pkey PRIMARY KEY (id);


--
-- TOC entry 2063 (class 2606 OID 17443)
-- Name: card_set_black_card card_set_black_card_pkey; Type: CONSTRAINT; Schema: public; Owner: pyx
--

ALTER TABLE ONLY card_set_black_card
    ADD CONSTRAINT card_set_black_card_pkey PRIMARY KEY (card_set_id, black_card_id);


--
-- TOC entry 2061 (class 2606 OID 17438)
-- Name: card_set card_set_pkey; Type: CONSTRAINT; Schema: public; Owner: pyx
--

ALTER TABLE ONLY card_set
    ADD CONSTRAINT card_set_pkey PRIMARY KEY (id);


--
-- TOC entry 2065 (class 2606 OID 17448)
-- Name: card_set_white_card card_set_white_card_pkey; Type: CONSTRAINT; Schema: public; Owner: pyx
--

ALTER TABLE ONLY card_set_white_card
    ADD CONSTRAINT card_set_white_card_pkey PRIMARY KEY (card_set_id, white_card_id);


--
-- TOC entry 2067 (class 2606 OID 17456)
-- Name: white_cards white_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: pyx
--

ALTER TABLE ONLY white_cards
    ADD CONSTRAINT white_cards_pkey PRIMARY KEY (id);


--
-- TOC entry 2069 (class 2606 OID 17462)
-- Name: card_set_black_card fk513da45c3166b76a; Type: FK CONSTRAINT; Schema: public; Owner: pyx
--

ALTER TABLE ONLY card_set_black_card
    ADD CONSTRAINT fk513da45c3166b76a FOREIGN KEY (black_card_id) REFERENCES black_cards(id);


--
-- TOC entry 2068 (class 2606 OID 17457)
-- Name: card_set_black_card fk513da45c985dacea; Type: FK CONSTRAINT; Schema: public; Owner: pyx
--

ALTER TABLE ONLY card_set_black_card
    ADD CONSTRAINT fk513da45c985dacea FOREIGN KEY (card_set_id) REFERENCES card_set(id);


--
-- TOC entry 2071 (class 2606 OID 17472)
-- Name: card_set_white_card fkc248727257c340be; Type: FK CONSTRAINT; Schema: public; Owner: pyx
--

ALTER TABLE ONLY card_set_white_card
    ADD CONSTRAINT fkc248727257c340be FOREIGN KEY (white_card_id) REFERENCES white_cards(id);


--
-- TOC entry 2070 (class 2606 OID 17467)
-- Name: card_set_white_card fkc2487272985dacea; Type: FK CONSTRAINT; Schema: public; Owner: pyx
--

ALTER TABLE ONLY card_set_white_card
    ADD CONSTRAINT fkc2487272985dacea FOREIGN KEY (card_set_id) REFERENCES card_set(id);


-- Completed on 2018-02-25 13:58:24

--
-- PostgreSQL database dump complete
--

