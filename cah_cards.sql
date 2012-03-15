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
-- Name: black_cards; Type: TABLE; Schema: public; Owner: cah; Tablespace: 
--

CREATE TABLE black_cards (
    id integer NOT NULL,
    text character varying(255) NOT NULL,
    draw smallint DEFAULT 0,
    pick smallint DEFAULT 1,
    creator integer
);


ALTER TABLE public.black_cards OWNER TO cah;

--
-- Name: COLUMN black_cards.creator; Type: COMMENT; Schema: public; Owner: cah
--

COMMENT ON COLUMN black_cards.creator IS 'NULL for default card, non-NULL for user id';


--
-- Name: black_cards_id_seq; Type: SEQUENCE; Schema: public; Owner: cah
--

CREATE SEQUENCE black_cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.black_cards_id_seq OWNER TO cah;

--
-- Name: black_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cah
--

ALTER SEQUENCE black_cards_id_seq OWNED BY black_cards.id;


--
-- Name: black_cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cah
--

SELECT pg_catalog.setval('black_cards_id_seq', 90, true);

--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO postgres;

--
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hibernate_sequence', 3, true);


--
-- Name: white_cards; Type: TABLE; Schema: public; Owner: cah; Tablespace: 
--

CREATE TABLE white_cards (
    id integer NOT NULL,
    text character varying(255) NOT NULL,
    creator integer
);


ALTER TABLE public.white_cards OWNER TO cah;

--
-- Name: COLUMN white_cards.creator; Type: COMMENT; Schema: public; Owner: cah
--

COMMENT ON COLUMN white_cards.creator IS 'NULL for default, non-NULL for user id';


--
-- Name: white_cards_id_seq; Type: SEQUENCE; Schema: public; Owner: cah
--

CREATE SEQUENCE white_cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.white_cards_id_seq OWNER TO cah;

--
-- Name: white_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cah
--

ALTER SEQUENCE white_cards_id_seq OWNED BY white_cards.id;


--
-- Name: white_cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cah
--

SELECT pg_catalog.setval('white_cards_id_seq', 460, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cah
--

ALTER TABLE black_cards ALTER COLUMN id SET DEFAULT nextval('black_cards_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cah
--

ALTER TABLE white_cards ALTER COLUMN id SET DEFAULT nextval('white_cards_id_seq'::regclass);


--
-- Data for Name: black_cards; Type: TABLE DATA; Schema: public; Owner: cah
--

COPY black_cards (id, text, draw, pick, creator) FROM stdin;
1	Why can't I sleep at night?	0	1	\N
2	I got 99 problems but _____ ain't one	0	1	\N
3	What's a girl's best friend?	0	1	\N
4	What's that smell?	0	1	\N
5	_____? There's an app for that	0	1	\N
7	What is Batman's guilty pleasure?	0	1	\N
8	TSA guidelines now prohibit _____ on airplanes.	0	1	\N
9	What ended my last relationship?	0	1	\N
10	MTV's new reality show features eight washed-up celebrities living with _____	0	1	\N
11	I drink to forget _____	0	1	\N
12	I'm sorry, Professor, but I couldn't complete my homework because of _____.	0	1	\N
13	During Picasso's often-overlooked Brown Period, he produced hundreds of paintings of _____.	0	1	\N
14	Alternative medicine is now embracing the curative powers of _____.	0	1	\N
15	What's that sound?	0	1	\N
16	Who stole the cookies from the cookie jar?	0	1	\N
17	What's the next Happy Meal® toy?	0	1	\N
18	Anthropologists have recently discovered a primitive tribe that worships _____.	0	1	\N
19	It's a pity that kids these days are all getting involved with _____.	0	1	\N
20	_____. That's how I want to die.	0	1	\N
21	In the new Disney Channel Original Movie, Hannah Montana struggles with _____ for the first time.	0	1	\N
22	What does Dick Cheney prefer?	0	1	\N
23	I wish I hadn't lost the instruction manual for _____.	0	1	\N
24	Instead of coal, Santa now gives the bad children _____.	0	1	\N
25	What's the most emo?	0	1	\N
26	In 1,000 years, when paper money is but a distant memory, _____ will be our currency.	0	1	\N
27	What's the next superhero?	0	1	\N
28	A romantic, candlelit dinner would be incomplete without _____.	0	1	\N
29	Next from J.K. Rowling: Harry Potter and the Chamber of _____.	0	1	\N
30	_____. Betcha can't have just one!	0	1	\N
31	White people like _____.	0	1	\N
32	_____. High five, bro.	0	1	\N
33	During sex, I like to think about _____.	0	1	\N
34	War! What is it good for?	0	1	\N
35	BILLY MAYS HERE FOR _____.	0	1	\N
36	What will always get you laid?	0	1	\N
37	When I'm in prison, I'll have _____ smuggled in.	0	1	\N
38	What did I bring back from Mexico?	0	1	\N
39	What are my parents hiding from me?	0	1	\N
40	What helps Obama unwind?	0	1	\N
41	What's there a ton of in heaven?	0	1	\N
42	What would grandma find disturbing, yet oddly charming?	0	1	\N
43	The US has begun airdropping _____ to the children of Afghanistan.	0	1	\N
44	What's the new fad diet?	0	1	\N
45	When I am the President of the United States, I will create the Department of _____.	0	1	\N
46	Major League Baseball has banned _____ for giving players an unfair advantage.	0	1	\N
47	When I am a billionare, I shall erect a 50-foot statue to commemorate _____.	0	1	\N
48	What don't you want to find in your Chinese food?	0	1	\N
49	What will I bring back in time to convince people that I am a powerful wizard?	0	1	\N
50	How am I maintaining my relationship status?	0	1	\N
51	_____. It's a trap!	0	1	\N
52	Coming to Broadway this season, _____: The Musical.	0	1	\N
53	While the United States raced the Soviet Union to the moon, the Mexican government funneled millions of pesos into research on _____.	0	1	\N
54	After Hurricane Katrina, Sean Penn brought _____ to all the people of New Orleans.	0	1	\N
55	Due to a PR fiasco, Walmart no longer offers _____.	0	1	\N
56	What never fails to liven up the party?	0	1	\N
57	But before I kill you, Mr. Bond, I must show you _____.	0	1	\N
58	What gives me uncontrollable gas?	0	1	\N
59	What's my secret power?	0	1	\N
60	When Pharaoh remained unmoved, Moses called down a plague of _____.	0	1	\N
61	The class field trip was completely ruined by _____.	0	1	\N
62	What do old people smell like? 	0	1	\N
63	What am I giving up for lent?	0	1	\N
64	In Michael Jackson's final moments, he thought about _____.	0	1	\N
65	In an attempt to reach a wider audience, the Smithsonian Museum of Natural History has opened an interactive exhibit on _____.	0	1	\N
66	Why do I hurt all over?	0	1	\N
67	Studies show that lab rats navigate mazes 50% faster after being exposed to _____.	0	1	\N
68	I do not know with which weapons World War III will be fought, but World War IV will be fought with _____.	0	1	\N
69	Life was difficult for cavemen before _____.	0	1	\N
70	What's Teach for America using to inspire inner city students to succeed?	0	1	\N
71	What's the crustiest?	0	1	\N
72	_____: Good to the last drop.	0	1	\N
73	What did Vin Diesel eat for dinner?	0	1	\N
74	_____: Kid-tested, Mother-approved	0	1	\N
75	What gets better with age?	0	1	\N
76	Why am I sticky?	0	1	\N
77	What's my anti-drug?	0	1	\N
86	Make a haiku.	2	3	\N
78	And the Academy Award for _____ goes to _____.	0	2	\N
89	That's right, I killed _____. How, you ask? _____.	0	2	\N
79	For my next trick, I will pull _____ out of _____.	0	2	\N
80	_____ is a slippery slope that leads to _____.	0	2	\N
83	In his new summer comedy, Rob Scheider is _____ trapped in the body of _____.	0	2	\N
85	I never truly understood _____ until I encountered _____.	0	2	\N
87	Lifetime® presents _____, the story of _____.	0	2	\N
88	When I was tripping on acid, _____ turned into _____.	0	2	\N
6	This is the way the world ends / This is the way the world ends / This is the way the world ends / Not with a bang but with _____	0	1	\N
84	Rumor has it that Vladimir Putin's favorite dish is _____ stuffed with _____.	0	2	\N
82	In a world ravaged by _____, our only solace is _____.	0	2	\N
90	_____ + _____ = _____	2	3	\N
81	In M. Night Shyamalan's new movie, Bruce Willis discovers that _____ had really been _____ all along.	0	2	\N
\.


--
-- Data for Name: white_cards; Type: TABLE DATA; Schema: public; Owner: cah
--

COPY white_cards (id, text, creator) FROM stdin;
1	Coat hanger abortions.	\N
2	Man meat.	\N
3	Autocannibalism.	\N
4	Vigorous jazz hands.	\N
5	Flightless birds.	\N
6	Pictures of boobs.	\N
7	Doing the right thing.	\N
8	Hunting accidents.	\N
9	A cartoon camel enjoying the smooth, refreshing taste of a cigarette.	\N
10	The violation of our most basic human rights.	\N
11	Viagra®.	\N
12	Self-loathing.	\N
13	Spectacular abs.	\N
14	An honest cop with nothing left to lose.	\N
15	Abstinence.	\N
16	A balanced breakfast.	\N
17	Mountain Dew Code Red.	\N
18	Concealing a boner.	\N
19	Roofies.	\N
20	Glenn Beck convulsively vomiting as a brood of crab spiders hatches in his brain and erupts from his tear ducts.	\N
21	Tweeting.	\N
22	The Big Bang.	\N
23	Amputees.	\N
25	Former President George W. Bush.	\N
26	Being marginalized.	\N
27	Smegma.	\N
28	Laying an egg.	\N
29	Cuddling.	\N
30	Aaron Burr.	\N
31	The Pope.	\N
32	A bleached asshole.	\N
33	Horse meat.	\N
34	Genital piercings.	\N
35	Fingering.	\N
36	Elderly Japanese men.	\N
37	Stranger danger.	\N
38	Fear itself.	\N
39	Science.	\N
40	Praying the gay away.	\N
41	Same-sex ice dancing.	\N
42	The terrorists.	\N
43	Making sex at her.	\N
44	German dungeon porn.	\N
45	Bingeing and purging.	\N
46	Ethnic cleansing.	\N
47	Cheating in the Special Olympics.	\N
48	Nickelback.	\N
49	Heteronormativity.	\N
50	William Shatner.	\N
51	Making a pouty face.	\N
52	Chainsaws for hands.	\N
53	The placenta.	\N
54	The profoundly handicapped.	\N
55	Tom Cruise.	\N
56	Object permanence.	\N
57	Goblins.	\N
58	An icepick lobotomy.	\N
59	Arnold Schwarzenegger.	\N
60	Hormone injections.	\N
61	A falcon with a cap on its head.	\N
62	Foreskin.	\N
63	Dying.	\N
64	Stunt doubles.	\N
65	The invisible hand.	\N
66	Jew-fros.	\N
67	A really cool hat.	\N
68	Flash flooding.	\N
69	Flavored condoms.	\N
70	Dying of dysentery.	\N
71	Sexy pillow fights.	\N
72	The Three-Fifths compromise.	\N
73	A sad handjob.	\N
74	Men.	\N
75	Historically black colleges.	\N
76	Sean Penn.	\N
77	Heartwarming orphans.	\N
78	Waterboarding.	\N
79	The clitoris.	\N
80	Vikings.	\N
81	Friends who eat all the snacks.	\N
82	The Underground Railroad.	\N
83	Pretending to care.	\N
84	Raptor attacks.	\N
85	A micropenis.	\N
86	A Gypsy curse.	\N
87	Agriculture.	\N
88	Bling.	\N
89	A clandestine butt scratch.	\N
90	The South.	\N
91	Sniffing glue.	\N
92	Consultants.	\N
93	My humps.	\N
94	Geese.	\N
95	Being a dick to children.	\N
96	Party poopers.	\N
97	Sunshine and rainbows.	\N
98	YOU MUST CONSTRUCT ADDITIONAL PYLONS.	\N
99	Mutually-assured destruction.	\N
100	Heath Ledger.	\N
101	Sexting.	\N
102	An Oedipus complex.	\N
103	Eating all of the cookies before the AIDS bake-sale.	\N
104	A sausage festival.	\N
105	Michael Jackson.	\N
106	Skeletor.	\N
107	Chivalry.	\N
108	Sharing needles.	\N
109	Being rich.	\N
110	Muzzy.	\N
111	Count Chocula.	\N
112	Spontaneous human combustion.	\N
113	College.	\N
114	Necrophilia.	\N
115	The Chinese gymnastics team.	\N
116	Global warming.	\N
117	Farting and walking away.	\N
118	Emotions.	\N
119	Uppercuts.	\N
120	Cookie Monster devouring the Eucharist wafers.	\N
121	Stifling a giggle at the mention of Hutus and Tutsis.	\N
122	Penis envy.	\N
123	Letting yourself go.	\N
124	White people.	\N
125	Dick Cheney.	\N
126	Leaving an awkward voicemail.	\N
127	Yeast.	\N
128	Natural selection.	\N
130	Twinkies®.	\N
131	A LAN party.	\N
132	Opposable thumbs.	\N
133	A grande sugar-free iced soy caramel macchiato.	\N
134	Soiling oneself.	\N
135	A sassy black woman.	\N
136	Sperm whales.	\N
137	Teaching a robot to love.	\N
138	Scrubbing under the folds.	\N
139	A drive-by shooting.	\N
140	Whipping it out.	\N
141	Panda sex.	\N
142	Catapults.	\N
143	Will Smith.	\N
144	Toni Morrison's vagina.	\N
145	Five-Dollar Foot-longs™.	\N
146	Land mines.	\N
147	A sea of troubles.	\N
148	A zesty breakfast burrito.	\N
24	Dr. Martin Luther King, Jr.	\N
149	Christopher Walken.	\N
150	Friction.	\N
151	Balls.	\N
152	AIDS.	\N
153	The KKK.	\N
154	Figgy pudding.	\N
155	Seppuku.	\N
156	Marky Mark and the Funky Bunch.	\N
157	Gandhi.	\N
158	Dave Matthews Band.	\N
159	Preteens.	\N
160	The token minority.	\N
161	Friends with benefits.	\N
162	Re-gifting.	\N
163	Pixelated bukkake.	\N
164	Substitute teachers.	\N
165	Take-backsies.	\N
166	A thermonuclear detonation.	\N
167	The Tempur-Pedic® Swedish Sleep System™.	\N
168	Waiting 'til marriage.	\N
169	A tiny horse.	\N
170	A can of whoop-ass.	\N
171	Dental dams.	\N
172	Feeding Rosie O'Donnell.	\N
173	Old-people smell.	\N
174	Genghis Khan.	\N
175	Authentic Mexican cuisine.	\N
176	Oversized lollipops.	\N
177	Garth Brooks.	\N
178	Keanu Reeves.	\N
179	Drinking alone.	\N
180	The American Dream.	\N
181	Taking off your shirt.	\N
182	Giving 110%.	\N
183	Flesh-eating bacteria.	\N
184	Child abuse.	\N
185	A cooler full of organs.	\N
186	A moment of silence.	\N
187	The Rapture.	\N
188	Keeping Christ in Christmas.	\N
189	RoboCop.	\N
190	That one gay Teletubby.	\N
191	Sweet, sweet vengeance.	\N
192	Fancy Feast®.	\N
194	Being a motherfucking sorceror.	\N
195	Jewish fraternities.	\N
196	Edible underpants.	\N
197	Poor people.	\N
198	All-you-can-eat shrimp for $4.99.	\N
199	Britney Spears at 55.	\N
200	That thing that electrocutes your abs.	\N
201	The folly of man.	\N
202	Fiery poops.	\N
203	Cards Against Humanity.	\N
204	A murder most foul.	\N
205	Me time.	\N
206	The inevitable heat death of the universe.	\N
207	Nocturnal emissions.	\N
208	Daddy issues.	\N
209	The hardworking Mexican.	\N
210	Natalie Portman.	\N
211	Waking up half-naked in a Denny's parking lot.	\N
212	Nipple blades.	\N
213	Assless chaps.	\N
214	Full frontal nudity.	\N
215	Hulk Hogan.	\N
216	Passive-agression.	\N
217	Ronald Reagan.	\N
218	Vehicular manslaughter.	\N
219	Menstruation.	\N
220	Pulling out.	\N
221	Picking up girls at the abortion clinic.	\N
222	The homosexual agenda.	\N
223	The Holy Bible.	\N
224	World peace.	\N
225	Dropping a chandelier on your enemies and riding the rope up.	\N
226	Testicular torsion.	\N
227	The milk man.	\N
228	A time-travel paradox.	\N
229	Hot Pockets®.	\N
230	Guys who don't call.	\N
231	Eating the last known bison.	\N
232	Darth Vader.	\N
233	Scalping.	\N
234	Homeless people.	\N
235	The World of Warcraft.	\N
236	Gloryholes.	\N
237	Saxophone solos.	\N
238	Sean Connery.	\N
239	God.	\N
240	Intelligent design.	\N
241	The taint; the grundle; the fleshy fun-bridge.	\N
242	Friendly fire.	\N
243	Keg stands.	\N
244	Eugenics.	\N
245	A good sniff.	\N
246	Lockjaw.	\N
247	A neglected Tamagotchi™.	\N
248	The People's Elbow.	\N
250	The heart of a child.	\N
251	Seduction.	\N
252	Smallpox blankets.	\N
253	Licking things to claim them as your own.	\N
254	A salty surprise.	\N
255	Poorly-timed Holocaust jokes.	\N
256	My soul.	\N
257	My sex life.	\N
258	Pterodactyl eggs.	\N
259	Altar boys.	\N
260	Forgetting the Alamo.	\N
261	72 virgins.	\N
262	Raping and pillaging.	\N
263	Pedophiles.	\N
264	Eastern European Turbo-Folk music.	\N
265	A snapping turtle biting the tip of your penis.	\N
266	Pabst Blue Ribbon.	\N
267	Domino's™ Oreo™ Dessert Pizza.	\N
268	My collection of high-tech sex toys.	\N
269	A middle-aged man on roller skates.	\N
270	The Blood of Christ.	\N
271	Half-assed foreplay.	\N
272	Free samples.	\N
273	Douchebags on their iPhones.	\N
274	Hurricane Katrina.	\N
275	Wearing underwear inside-out to avoid doing laundry.	\N
276	Republicans.	\N
277	The glass ceiling.	\N
278	A foul mouth.	\N
279	Jerking off into a pool of children's tears.	\N
280	Getting really high.	\N
281	The deformed.	\N
282	Michelle Obama's arms.	\N
283	Explosions.	\N
284	The Übermensch.	\N
285	Donald Trump.	\N
286	Sarah Palin.	\N
287	Attitude.	\N
288	This answer is postmodern.	\N
289	Crumpets with the Queen.	\N
290	Frolicking.	\N
291	Team-building exercises.	\N
292	Repression.	\N
293	Road head.	\N
193	Pooping back and forth. Forever.	\N
294	A bag of magic beans.	\N
295	An asymmetric boob job.	\N
296	Dead parents.	\N
297	Public ridicule.	\N
298	A mating display.	\N
299	A mime having a stroke.	\N
300	Stephen Hawking talking dirty.	\N
301	African children.	\N
302	Mouth herpes.	\N
303	Overcompensation.	\N
304	Bill Nye the Science Guy.	\N
305	Bitches.	\N
306	Italians.	\N
307	Have some more kugel.	\N
308	A windmill full of corpses.	\N
309	Her Royal Highness, Queen Elizabeth II.	\N
310	Crippling debt.	\N
311	Adderall™.	\N
312	A stray pube.	\N
313	Shorties and blunts.	\N
314	Passing a kidney stone.	\N
315	Prancing.	\N
316	Leprosy.	\N
317	A brain tumor.	\N
318	Bees?	\N
319	Puppies!	\N
320	Cockfights.	\N
321	Kim Jong-il.	\N
322	Hope.	\N
323	8 oz. of sweet Mexican black-tar heroin.	\N
324	Incest.	\N
325	Grave robbing.	\N
326	Asians who aren't good at math.	\N
327	Alcoholism.	\N
328	(I am doing Kegels right now.)	\N
329	Justin Bieber.	\N
330	The Jews.	\N
331	Bestiality.	\N
332	Winking at old people.	\N
333	Drum circles.	\N
334	Kids with ass cancer.	\N
335	Loose lips.	\N
336	Auschwitz.	\N
337	Civilian casualties.	\N
338	Inappropriate yelling.	\N
339	Tangled Slinkys.	\N
340	Being on fire.	\N
341	The Thong Song.	\N
342	A vajazzled vagina.	\N
343	Riding off into the sunset.	\N
344	Exchanging pleasantries.	\N
345	My relationship status.	\N
346	Shaquille O'Neal's acting career.	\N
347	Being fabulous.	\N
348	Lactation.	\N
349	Not reciprocating oral sex.	\N
350	Sobbing into a Hungry-Man® Frozen Dinner.	\N
351	My genitals.	\N
352	Date rape.	\N
353	Ring Pops™.	\N
354	GoGurt.	\N
355	Judge Judy.	\N
356	Lumberjack fantasies.	\N
357	The gays.	\N
358	Scientology.	\N
359	Estrogen.	\N
360	Police brutality.	\N
361	Passable transvestites.	\N
362	The Virginia Tech Massacre.	\N
363	Tiger Woods.	\N
364	Dick fingers.	\N
365	Racism.	\N
366	Glenn Beck being harried by a swarm of buzzards.	\N
368	Classist undertones.	\N
369	Booby-trapping the house to foil burglars.	\N
370	New Age music.	\N
371	PCP.	\N
372	A lifetime of sadness.	\N
373	Doin' it in the butt.	\N
374	Swooping.	\N
375	The Hamburglar.	\N
376	Tentacle porn.	\N
377	A hot mess.	\N
378	Too much hair gel.	\N
379	A look-see.	\N
380	Not giving a shit about the Third World.	\N
381	American Gladiators.	\N
382	The Kool-Aid Man.	\N
383	Mr. Snuffleupagus.	\N
384	Barack Obama.	\N
385	Golden showers.	\N
386	Wiping her butt.	\N
387	Queefing.	\N
388	Getting drunk on mouthwash.	\N
389	An M. Night Shyamalan plot twist.	\N
390	A robust mongoloid.	\N
391	Nazis.	\N
392	White privilege.	\N
393	An erection that lasts longer than four hours.	\N
394	A disappointing birthday party.	\N
395	Puberty.	\N
396	Two midgets shitting into a bucket.	\N
397	Wifely duties.	\N
398	The forbidden fruit.	\N
399	Getting so angry that you pop a boner.	\N
400	Sexual tension.	\N
401	Third base.	\N
402	A gassy antelope.	\N
403	Those times when you get sand in your vagina.	\N
404	A Super Soaker™ full of cat pee.	\N
405	Muhammed (Praise Be Unto Him).	\N
406	Racially-biased SAT questions.	\N
407	Porn stars.	\N
408	A fetus.	\N
409	Obesity.	\N
410	When you fart and a little bit comes out.	\N
411	Oompa-Loompas.	\N
412	BATMAN!!!	\N
413	Black people.	\N
414	Tasteful sideboob.	\N
415	Hot people.	\N
416	Grandma.	\N
417	Copping a feel.	\N
418	The Trail of Tears.	\N
419	Famine.	\N
420	Finger painting.	\N
421	The miracle of childbirth.	\N
422	Goats eating coins.	\N
423	A monkey smoking a cigar.	\N
424	Faith healing.	\N
425	Parting the Red Sea.	\N
426	Dead babies.	\N
427	The Amish.	\N
428	Impotence.	\N
429	Child Beauty pageants.	\N
430	Centaurs.	\N
431	AXE Body Spray.	\N
432	Kanye West.	\N
433	Women's suffrage.	\N
434	Children on leashes.	\N
435	Harry Potter erotica.	\N
436	The Dance of the Sugar Plum Fairy.	\N
437	Lance Armstrong's missing testicle.	\N
438	Dwarf Tossing.	\N
439	Mathletes.	\N
440	Lunchables™.	\N
441	Women in yogurt commercials.	\N
442	John Wilkes Booth.	\N
443	Powerful thighs.	\N
444	Mr. Clean, right behind you.	\N
445	Multiple stab wounds.	\N
446	Cybernetic enhancements.	\N
447	Serfdom.	\N
448	Another goddamn vampire movie.	\N
450	A big hoopla about nothing.	\N
451	Peeing a little bit.	\N
452	The Hustle.	\N
453	Ghosts.	\N
454	Bananas in Pajamas.	\N
455	Active listening.	\N
456	Dry heaving.	\N
457	Kamikaze pilots.	\N
458	The Force.	\N
459	Anal beads.	\N
460	The Make-A-Wish® Foundation.	\N
449	Glenn Beck catching his scrotum on a curtain hook.	\N
129	Masturbation.	\N
367	Surprise sex!	\N
249	Robert Downey, Jr.	\N
\.


--
-- Name: black_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY black_cards
    ADD CONSTRAINT black_cards_pkey PRIMARY KEY (id);


--
-- Name: black_cards_text_key; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY black_cards
    ADD CONSTRAINT black_cards_text_key UNIQUE (text);


--
-- Name: white_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY white_cards
    ADD CONSTRAINT white_cards_pkey PRIMARY KEY (id);


--
-- Name: white_cards_text_key; Type: CONSTRAINT; Schema: public; Owner: cah; Tablespace: 
--

ALTER TABLE ONLY white_cards
    ADD CONSTRAINT white_cards_text_key UNIQUE (text);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;

--
-- Name: hibernate_sequence; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE hibernate_sequence FROM PUBLIC;
REVOKE ALL ON SEQUENCE hibernate_sequence FROM postgres;
GRANT ALL ON SEQUENCE hibernate_sequence TO postgres;
GRANT ALL ON SEQUENCE hibernate_sequence TO cah;


--
-- PostgreSQL database dump complete
--

