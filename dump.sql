--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Bosnian (Latin)_Bosnia and Herzegovina.1250' LC_CTYPE = 'Bosnian (Latin)_Bosnia and Herzegovina.1250';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: challenges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE challenges (
    id integer NOT NULL,
    sender character varying(30) NOT NULL,
    recipient character varying(30) NOT NULL,
    dateofcreation timestamp without time zone NOT NULL,
    delivered boolean NOT NULL,
    response character varying(30),
    senderpokemontype integer,
    recipientpokemontype integer,
    winner character varying(30)
);


ALTER TABLE challenges OWNER TO postgres;

--
-- Name: challenges_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE challenges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE challenges_id_seq OWNER TO postgres;

--
-- Name: challenges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE challenges_id_seq OWNED BY challenges.id;


--
-- Name: player; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE player (
    username character varying(30) NOT NULL,
    firstname character varying(30) NOT NULL,
    lastname character varying(30) NOT NULL,
    password character varying(64) NOT NULL,
    lat double precision DEFAULT 0,
    lon double precision DEFAULT 0,
    isonline boolean DEFAULT false NOT NULL
);


ALTER TABLE player OWNER TO postgres;

--
-- Name: playerpokemon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE playerpokemon (
    username character varying(30) NOT NULL,
    pokemontypeid integer NOT NULL,
    customname character varying(30)
);


ALTER TABLE playerpokemon OWNER TO postgres;

--
-- Name: pokemontype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pokemontype (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    x integer,
    y integer,
    rarity integer DEFAULT 0 NOT NULL,
    catchchance double precision DEFAULT 0 NOT NULL,
    hp integer DEFAULT 0 NOT NULL,
    attack integer DEFAULT 0 NOT NULL,
    defense integer DEFAULT 0 NOT NULL
);


ALTER TABLE pokemontype OWNER TO postgres;

--
-- Name: sentpokemons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sentpokemons (
    id integer NOT NULL,
    pokemontypeid integer NOT NULL,
    lat double precision DEFAULT 0 NOT NULL,
    lon double precision DEFAULT 0 NOT NULL,
    expired boolean DEFAULT false NOT NULL,
    expiretimestamp timestamp without time zone NOT NULL
);


ALTER TABLE sentpokemons OWNER TO postgres;

--
-- Name: sentpokemons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sentpokemons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sentpokemons_id_seq OWNER TO postgres;

--
-- Name: sentpokemons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sentpokemons_id_seq OWNED BY sentpokemons.id;


--
-- Name: challenges id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY challenges ALTER COLUMN id SET DEFAULT nextval('challenges_id_seq'::regclass);


--
-- Name: sentpokemons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sentpokemons ALTER COLUMN id SET DEFAULT nextval('sentpokemons_id_seq'::regclass);


--
-- Data for Name: challenges; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO challenges (id, sender, recipient, dateofcreation, delivered, response, senderpokemontype, recipientpokemontype, winner) VALUES (86, 'javelin472@gmail.com', 'ognjen.bostjancic@outlook.com', '2017-03-22 21:56:00.878484', true, 'accept', NULL, 11, NULL);
INSERT INTO challenges (id, sender, recipient, dateofcreation, delivered, response, senderpokemontype, recipientpokemontype, winner) VALUES (87, 'javelin472@gmail.com', 'ognjen.bostjancic@outlook.com', '2017-03-22 21:57:39.427708', true, 'accept', NULL, 11, NULL);
INSERT INTO challenges (id, sender, recipient, dateofcreation, delivered, response, senderpokemontype, recipientpokemontype, winner) VALUES (88, 'javelin472@gmail.com', 'ognjen.bostjancic@outlook.com', '2017-03-22 21:58:01.987999', true, 'accept', NULL, 11, NULL);
INSERT INTO challenges (id, sender, recipient, dateofcreation, delivered, response, senderpokemontype, recipientpokemontype, winner) VALUES (90, 'ognjen.bostjancic@outlook.com', 'javelin472@gmail.com', '2017-03-22 21:58:29.387566', true, 'none', NULL, NULL, NULL);
INSERT INTO challenges (id, sender, recipient, dateofcreation, delivered, response, senderpokemontype, recipientpokemontype, winner) VALUES (89, 'javelin472@gmail.com', 'ognjen.bostjancic@outlook.com', '2017-03-22 21:58:24.600292', true, 'accept', NULL, NULL, NULL);
INSERT INTO challenges (id, sender, recipient, dateofcreation, delivered, response, senderpokemontype, recipientpokemontype, winner) VALUES (91, 'javelin472@gmail.com', 'ognjen.bostjancic@outlook.com', '2017-03-22 21:59:39.506145', true, 'accept', 19, 11, NULL);
INSERT INTO challenges (id, sender, recipient, dateofcreation, delivered, response, senderpokemontype, recipientpokemontype, winner) VALUES (92, 'javelin472@gmail.com', 'ognjen.bostjancic@outlook.com', '2017-03-22 22:01:17.971117', true, 'accept', 19, 11, NULL);


--
-- Name: challenges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('challenges_id_seq', 92, true);


--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO player (username, firstname, lastname, password, lat, lon, isonline) VALUES ('javelin33@hotmail.com', 'Ognjen', 'Bostjancic', 'f6689b2444cb5bffeb6bd3b636f97755c10214f0894bfa490152700322369b1f', 43.878006800000001, 18.4101918, false);
INSERT INTO player (username, firstname, lastname, password, lat, lon, isonline) VALUES ('javelin472@gmail.com', 'Ognjen', 'Bostjancic', 'f6689b2444cb5bffeb6bd3b636f97755c10214f0894bfa490152700322369b1f', 43.877991000000002, 18.410289499999998, true);
INSERT INTO player (username, firstname, lastname, password, lat, lon, isonline) VALUES ('ognjen.bostjancic@outlook.com', 'Ognjen', 'Bostjancic', 'f6689b2444cb5bffeb6bd3b636f97755c10214f0894bfa490152700322369b1f', 43.877978899999995, 18.4102815, true);


--
-- Data for Name: playerpokemon; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO playerpokemon (username, pokemontypeid, customname) VALUES ('ognjen.bostjancic@outlook.com', 11, '76');
INSERT INTO playerpokemon (username, pokemontypeid, customname) VALUES ('ognjen.bostjancic@outlook.com', 20, 'a');
INSERT INTO playerpokemon (username, pokemontypeid, customname) VALUES ('ognjen.bostjancic@outlook.com', 16, 'mjau');
INSERT INTO playerpokemon (username, pokemontypeid, customname) VALUES ('ognjen.bostjancic@outlook.com', 13, 'sdf');
INSERT INTO playerpokemon (username, pokemontypeid, customname) VALUES ('ognjen.bostjancic@outlook.com', 13, 'sdf');
INSERT INTO playerpokemon (username, pokemontypeid, customname) VALUES ('javelin472@gmail.com', 19, 'p');


--
-- Data for Name: pokemontype; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (2, 'Bulbasaur', 0, 0, 2, 0.16, 20, 3, 2);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (3, 'Charmander', 3, 0, 2, 0.16, 20, 3, 2);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (4, 'Gengar', 9, 3, 1, 0.80000000000000004, 30, 3, 3);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (5, 'Jigglypuff', 10, 1, 4, 0.40000000000000002, 50, 2, 1);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (6, 'Squirtle', 6, 0, 2, 0.16, 20, 3, 3);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (7, 'Caterpie', 9, 0, 5, 0.40000000000000002, 20, 2, 2);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (8, 'Weedle', 12, 0, 5, 0.40000000000000002, 20, 2, 2);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (9, 'Pidgey', 15, 0, 5, 0.40000000000000002, 20, 2, 2);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (10, 'Rattata', 18, 0, 5, 0.40000000000000002, 20, 3, 2);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (11, 'Sandshrew', 26, 0, 3, 0.40000000000000002, 20, 4, 4);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (12, 'Clefairy', 6, 1, 4, 0.23999999999999999, 30, 2, 2);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (13, 'Zubat', 12, 1, 5, 0.40000000000000002, 20, 2, 2);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (14, 'Oddish', 14, 1, 5, 0.47999999999999998, 20, 3, 3);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (15, 'Diglett', 21, 1, 1, 0.40000000000000002, 10, 3, 1);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (16, 'Meowth', 23, 1, 5, 0.40000000000000002, 20, 2, 2);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (17, 'Psyduck', 25, 1, 1, 0.40000000000000002, 20, 3, 2);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (18, 'Growlithe', 1, 2, 3, 0.23999999999999999, 20, 4, 2);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (19, 'Poliwag', 3, 2, 4, 0.40000000000000002, 20, 3, 2);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (20, 'Abra', 6, 2, 3, 0.40000000000000002, 10, 1, 1);
INSERT INTO pokemontype (id, name, x, y, rarity, catchchance, hp, attack, defense) VALUES (1, 'Pikachu', 24, 0, 2, 0.16, 20, 3, 2);


--
-- Data for Name: sentpokemons; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2975, 10, 43.87749368650811, 18.409909376073511, false, '2017-03-22 20:40:00.055603');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3004, 17, 43.877965704267304, 18.411117895226194, false, '2017-03-22 20:49:18.015873');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3037, 18, 43.878110948314593, 18.410694707285412, false, '2017-03-22 20:57:35.463326');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3038, 19, 43.8776432812477, 18.40989361216683, false, '2017-03-22 20:57:35.479327');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3070, 12, 43.877351935816151, 18.409952403494675, false, '2017-03-22 21:04:42.362743');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3102, 20, 43.878479988109468, 18.410323905100849, false, '2017-03-22 21:12:12.54586');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3103, 3, 43.877517833724816, 18.411073186848096, false, '2017-03-22 21:12:15.783045');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3104, 9, 43.878385821021006, 18.409651179031592, false, '2017-03-22 21:12:15.795046');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3136, 5, 43.877641650444254, 18.409493932914415, false, '2017-03-22 21:18:37.451466');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3167, 17, 43.878028573885217, 18.411279927954084, false, '2017-03-22 21:25:57.021785');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3168, 9, 43.87843829525081, 18.410646822052108, false, '2017-03-22 21:25:57.023785');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3170, 11, 43.87858348703729, 18.409721153579341, false, '2017-03-22 21:25:59.0359');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3205, 13, 43.877279814081717, 18.410365008438816, false, '2017-03-22 21:34:25.996625');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3236, 13, 43.878387366338238, 18.410510184710756, false, '2017-03-22 21:56:18.756392');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3266, 6, 43.878616446530515, 18.410509951501862, false, '2017-03-22 22:01:53.097157');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3301, 6, 43.878089475024765, 18.411334736317141, false, '2017-03-22 22:09:18.484374');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3302, 14, 43.877514333054719, 18.40958265551247, false, '2017-03-22 22:09:18.499375');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2976, 9, 43.877930796658326, 18.410606531410679, false, '2017-03-22 20:40:00.058603');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3005, 13, 43.878315808538524, 18.410445117593728, false, '2017-03-22 20:49:35.574878');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3006, 11, 43.877806403525035, 18.410933970970319, false, '2017-03-22 20:49:35.578878');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3039, 5, 43.877564262958941, 18.409464872054691, false, '2017-03-22 20:58:18.914811');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3040, 13, 43.877901279273274, 18.409918685236779, false, '2017-03-22 20:58:18.925812');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3071, 12, 43.877662518486503, 18.410099293180057, false, '2017-03-22 21:04:44.889887');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3105, 14, 43.877537166825853, 18.410035285209357, false, '2017-03-22 21:13:12.390283');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3106, 12, 43.878733767705086, 18.410539973421162, false, '2017-03-22 21:13:12.411284');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3137, 14, 43.878363831332408, 18.411145004715411, false, '2017-03-22 21:19:05.84409');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3169, 8, 43.877790559805518, 18.409420715417092, false, '2017-03-22 21:25:59.0349');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3206, 14, 43.877978655601858, 18.40927285876591, false, '2017-03-22 21:34:26.003625');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3237, 8, 43.87787885607267, 18.409745404797736, false, '2017-03-22 21:56:22.73962');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3238, 12, 43.878472917739103, 18.41043112971796, false, '2017-03-22 21:56:22.762621');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3267, 9, 43.878145867234991, 18.409258853825385, false, '2017-03-22 22:01:55.470293');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3268, 13, 43.877386018847304, 18.409742338026145, false, '2017-03-22 22:01:55.477293');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3303, 13, 43.878200880377229, 18.409802994440852, false, '2017-03-22 22:09:21.902569');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2977, 14, 43.878075453316491, 18.410001042997088, false, '2017-03-22 20:40:18.003206');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3007, 6, 43.877953915996599, 18.411213005913858, false, '2017-03-22 20:50:17.991304');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3041, 11, 43.878614282082928, 18.410462471939045, false, '2017-03-22 20:58:35.454757');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3042, 5, 43.878299744145345, 18.409188125426702, false, '2017-03-22 20:58:35.463758');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3072, 10, 43.877348882771877, 18.410039452682589, false, '2017-03-22 21:04:44.893888');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3107, 2, 43.878077739400084, 18.409415623853747, false, '2017-03-22 21:13:15.790478');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3138, 19, 43.878091816546075, 18.411047004391556, false, '2017-03-22 21:19:05.862091');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3171, 13, 43.878011413259806, 18.409884355799218, false, '2017-03-22 21:26:57.013216');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3207, 5, 43.87762844298409, 18.410640261260717, false, '2017-03-22 21:35:08.887078');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3208, 10, 43.877681474837246, 18.410320250689036, false, '2017-03-22 21:35:08.897079');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3239, 9, 43.87783438431309, 18.409254036870632, false, '2017-03-22 21:57:18.72411');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3269, 10, 43.877656565982569, 18.410730007355362, false, '2017-03-22 22:02:53.077588');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3304, 14, 43.878527244613522, 18.410521863027846, false, '2017-03-22 22:09:21.930571');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2978, 8, 43.878413033215395, 18.409897015514218, false, '2017-03-22 20:40:18.004206');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3008, 14, 43.878170537930238, 18.40951245156915, false, '2017-03-22 20:50:18.001304');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3043, 1, 43.878623100285665, 18.410733729421441, false, '2017-03-22 20:59:18.911243');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3073, 11, 43.877836190536527, 18.410406165487263, false, '2017-03-22 21:05:42.97295');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3075, 16, 43.878215729723259, 18.411025651509846, false, '2017-03-22 21:05:44.87508');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3108, 14, 43.87723266117591, 18.409852389727167, false, '2017-03-22 21:13:15.797478');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3139, 5, 43.878463479540038, 18.40950349684061, false, '2017-03-22 21:19:12.806488');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3172, 3, 43.877672249938207, 18.409956194313324, false, '2017-03-22 21:26:57.016216');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3173, 7, 43.877645681751325, 18.410229061654807, false, '2017-03-22 21:26:59.035332');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3174, 9, 43.877865020368709, 18.410687207203338, false, '2017-03-22 21:26:59.044332');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3209, 12, 43.877349551154701, 18.410217638994382, false, '2017-03-22 21:35:25.976056');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3240, 9, 43.877959918497311, 18.40950708108959, false, '2017-03-22 21:57:18.727111');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3270, 4, 43.878735028976152, 18.409949112792475, false, '2017-03-22 22:02:53.078588');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3305, 9, 43.877704402042589, 18.409770180775268, false, '2017-03-22 22:09:26.80485');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3306, 20, 43.877841324939688, 18.410240564301098, false, '2017-03-22 22:09:26.818851');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2979, 18, 43.878690542207345, 18.409826731269316, false, '2017-03-22 20:40:35.447204');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3009, 19, 43.877756628092349, 18.411068878624107, false, '2017-03-22 20:50:35.478304');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3044, 12, 43.878173228898618, 18.410439395991521, false, '2017-03-22 20:59:18.921243');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3074, 13, 43.877639587493071, 18.409758956307616, false, '2017-03-22 21:05:42.97295');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3109, 20, 43.877648731872583, 18.411185704485263, false, '2017-03-22 21:13:23.272906');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3110, 18, 43.877538453136594, 18.409496855349296, false, '2017-03-22 21:13:23.275906');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3140, 18, 43.878436436274555, 18.409847431160436, false, '2017-03-22 21:19:12.813489');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3175, 20, 43.877498737766956, 18.409572870836971, false, '2017-03-22 21:27:50.870296');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3176, 17, 43.877271527479408, 18.40993234609153, false, '2017-03-22 21:27:50.880297');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3210, 16, 43.878149005365366, 18.409107098086839, false, '2017-03-22 21:35:25.987056');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3241, 14, 43.878770357215132, 18.410546471971525, false, '2017-03-22 21:57:22.721339');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3271, 14, 43.878083071264129, 18.409777905284248, false, '2017-03-22 22:02:55.430722');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3307, 9, 43.877784927153705, 18.41034555043835, false, '2017-03-22 22:09:29.177986');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2980, 7, 43.877649156654414, 18.410021064911518, false, '2017-03-22 20:40:35.487206');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3010, 13, 43.878559873119855, 18.410980169269077, false, '2017-03-22 20:50:35.490305');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3045, 20, 43.877548403302669, 18.409596155233331, false, '2017-03-22 20:59:35.500191');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3076, 16, 43.878353578763054, 18.409481380217976, false, '2017-03-22 21:05:44.87408');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3111, 7, 43.878305974047464, 18.411013522925618, false, '2017-03-22 21:13:29.964879');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3112, 11, 43.877817939462204, 18.40994242138046, false, '2017-03-22 21:13:30.025882');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3141, 2, 43.878208796239484, 18.410500924123728, false, '2017-03-22 21:19:49.856607');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3142, 17, 43.878273108025958, 18.411120152489808, false, '2017-03-22 21:19:49.866608');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3177, 10, 43.878416012758088, 18.41066276310325, false, '2017-03-22 21:27:54.794719');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3211, 14, 43.876528832910303, 18.412460213736576, false, '2017-03-22 21:35:58.864937');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3242, 20, 43.877356635822025, 18.409709524150042, false, '2017-03-22 21:57:22.73134');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3272, 11, 43.877858909639961, 18.410349352970634, false, '2017-03-22 22:02:55.444723');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3308, 5, 43.878409172478875, 18.41088928824577, false, '2017-03-22 22:09:29.180986');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2981, 4, 43.877386358639001, 18.409758571107577, false, '2017-03-22 20:41:17.986637');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2982, 17, 43.878151031074012, 18.409189747707529, false, '2017-03-22 20:41:17.998638');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3011, 5, 43.877882116994542, 18.40918994454448, false, '2017-03-22 20:51:17.984735');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3012, 19, 43.877271592910191, 18.410567436049259, false, '2017-03-22 20:51:17.992736');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3046, 11, 43.877692682842053, 18.410875835003363, false, '2017-03-22 20:59:35.502192');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3077, 19, 43.87821902127407, 18.410550073926398, false, '2017-03-22 21:06:42.971735');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3078, 18, 43.87811033976628, 18.409481828417675, false, '2017-03-22 21:06:42.973735');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3113, 10, 43.878033228239175, 18.410146762299398, false, '2017-03-22 21:14:23.30493');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3143, 9, 43.877490287562743, 18.409814708430517, false, '2017-03-22 21:20:00.529601');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3178, 7, 43.878401655891167, 18.410986779492152, false, '2017-03-22 21:27:54.796719');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3212, 13, 43.876924236431144, 18.413339233384825, false, '2017-03-22 21:35:58.881938');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3243, 7, 43.878590424070367, 18.410235256125258, false, '2017-03-22 21:58:18.700541');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3244, 7, 43.877909832411341, 18.409697604050475, false, '2017-03-22 21:58:18.715542');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3273, 17, 43.877167242855244, 18.411855851771133, false, '2017-03-22 22:03:21.279201');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3274, 11, 43.876937352010501, 18.412194664960303, false, '2017-03-22 22:03:21.304202');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3309, 2, 43.878053319542921, 18.410178357891297, false, '2017-03-22 22:10:26.777849');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2983, 16, 43.878005574961328, 18.409311052656207, false, '2017-03-22 20:41:35.532641');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2984, 12, 43.877751232958524, 18.409712634173538, false, '2017-03-22 20:41:35.546641');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3013, 20, 43.878185504589034, 18.409987283320003, false, '2017-03-22 20:51:35.473735');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3047, 1, 43.878700100058296, 18.41035041450457, false, '2017-03-22 21:00:18.916675');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3079, 6, 43.878255891965168, 18.410059670358741, false, '2017-03-22 21:06:44.879844');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3114, 8, 43.878066966438482, 18.409559992943382, false, '2017-03-22 21:14:23.31893');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3144, 8, 43.877276665018208, 18.410383575207685, false, '2017-03-22 21:20:00.569604');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3179, 16, 43.877511224264786, 18.410445203621993, false, '2017-03-22 21:28:51.037936');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3180, 1, 43.877425311151761, 18.409957041594417, false, '2017-03-22 21:28:51.039936');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3213, 15, 43.876923649446944, 18.412354968846664, false, '2017-03-22 21:36:00.375023');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3245, 9, 43.877898124197408, 18.410899733299157, false, '2017-03-22 21:58:23.071791');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3275, 18, 43.876081106963454, 18.413473066183432, false, '2017-03-22 22:03:25.690703');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3276, 14, 43.876631220321116, 18.411589461127519, false, '2017-03-22 22:03:25.700703');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3310, 18, 43.877878244712072, 18.411124361121352, false, '2017-03-22 22:10:26.824852');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2985, 8, 43.877866405840038, 18.409568439874985, false, '2017-03-22 20:42:18.105076');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3014, 19, 43.877680441061784, 18.409648346896692, false, '2017-03-22 20:51:35.474736');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3048, 5, 43.878830152990616, 18.410433075457938, false, '2017-03-22 21:00:18.920675');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3080, 5, 43.878036891867886, 18.410479867441168, false, '2017-03-22 21:06:44.881844');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3115, 18, 43.878029130396499, 18.41083828305749, false, '2017-03-22 21:14:30.942367');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3116, 19, 43.878219664358397, 18.409665287112027, false, '2017-03-22 21:14:30.977369');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3145, 11, 43.878009872273417, 18.410731067031701, false, '2017-03-22 21:20:49.849215');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3146, 8, 43.877384602117964, 18.410231685316798, false, '2017-03-22 21:20:49.865216');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3181, 14, 43.878030090582627, 18.411279202037079, false, '2017-03-22 21:28:54.742148');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3182, 13, 43.878602013932458, 18.410099759019737, false, '2017-03-22 21:28:54.749148');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3214, 7, 43.876146432747859, 18.412599424948489, false, '2017-03-22 21:36:00.383023');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3246, 11, 43.877987972873456, 18.409283082139197, false, '2017-03-22 21:58:23.083792');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3277, 16, 43.877072895804105, 18.412466021264329, false, '2017-03-22 22:04:21.280969');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3278, 17, 43.875939673230093, 18.413130261138807, false, '2017-03-22 22:04:21.280969');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3311, 1, 43.877512453701399, 18.409736129243381, false, '2017-03-22 22:10:29.120983');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2986, 13, 43.877934763698377, 18.410594832155706, false, '2017-03-22 20:42:18.118076');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3015, 14, 43.878575233973947, 18.409574461905624, false, '2017-03-22 20:52:18.122175');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3016, 17, 43.878091896386032, 18.410206001755149, false, '2017-03-22 20:52:18.126175');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3049, 1, 43.877544376326114, 18.409801194108638, false, '2017-03-22 21:00:35.459621');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3050, 18, 43.87786509445047, 18.410531057920249, false, '2017-03-22 21:00:35.465621');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3081, 12, 43.877567283797774, 18.409279344704316, false, '2017-03-22 21:07:42.976167');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3084, 16, 43.877902417973708, 18.410390010980805, false, '2017-03-22 21:07:44.887276');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3117, 14, 43.878748899863666, 18.41010610835577, false, '2017-03-22 21:15:23.252358');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3147, 1, 43.878740109669288, 18.410720839321545, false, '2017-03-22 21:21:00.536827');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3148, 16, 43.877434247716572, 18.41083965475995, false, '2017-03-22 21:21:00.570829');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3183, 15, 43.877472844051589, 18.410693046502896, false, '2017-03-22 21:29:51.048369');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3215, 11, 43.876325313789607, 18.412243705221211, false, '2017-03-22 21:36:58.894052');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3247, 13, 43.878304303435293, 18.410498769830987, false, '2017-03-22 21:58:25.371923');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3248, 13, 43.877512414196048, 18.410939460277422, false, '2017-03-22 21:58:25.393924');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3279, 10, 43.876999475019765, 18.413606184154389, false, '2017-03-22 22:04:25.67822');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3280, 12, 43.875823806590802, 18.412582951421435, false, '2017-03-22 22:04:25.718223');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3312, 11, 43.877438823612181, 18.410974658371366, false, '2017-03-22 22:10:29.138984');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2987, 14, 43.877592112963995, 18.409752677416357, false, '2017-03-22 20:42:35.478069');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3017, 19, 43.87810753730357, 18.410713013834723, false, '2017-03-22 20:52:35.487168');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3051, 9, 43.878232200923982, 18.410772904676779, false, '2017-03-22 21:01:18.917107');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3082, 18, 43.877973961780455, 18.409589416489681, false, '2017-03-22 21:07:42.978167');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3118, 7, 43.877322991634315, 18.409888255064327, false, '2017-03-22 21:15:23.28036');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3149, 7, 43.877783345762658, 18.40991748369251, false, '2017-03-22 21:21:49.848647');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3150, 13, 43.87792048621332, 18.410393036762642, false, '2017-03-22 21:21:49.860648');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3184, 7, 43.87754338360773, 18.410468276272116, false, '2017-03-22 21:29:51.055369');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3216, 16, 43.876772411699015, 18.411296727434024, false, '2017-03-22 21:36:58.900052');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3249, 13, 43.878430547542578, 18.409971436167304, false, '2017-03-22 21:59:23.019599');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3281, 20, 43.876297123911677, 18.412431021349487, false, '2017-03-22 22:05:21.276401');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3282, 14, 43.877240606393926, 18.412592547409044, false, '2017-03-22 22:05:21.282401');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3313, 13, 43.878374965020008, 18.411007311705909, false, '2017-03-22 22:11:07.8792');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2988, 6, 43.87766564890272, 18.41074014452451, false, '2017-03-22 20:42:35.48107');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3018, 16, 43.877847827037918, 18.410512561445451, false, '2017-03-22 20:52:35.488168');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3052, 14, 43.878763950121446, 18.410038686888281, false, '2017-03-22 21:01:18.927107');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3083, 16, 43.878679854818799, 18.40982475221772, false, '2017-03-22 21:07:44.868275');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3119, 13, 43.877808048866903, 18.410888048057, false, '2017-03-22 21:15:30.940798');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3151, 7, 43.87874531938801, 18.410007420627977, false, '2017-03-22 21:22:00.542259');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3185, 13, 43.877349669632842, 18.410399804884491, false, '2017-03-22 21:29:54.74458');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3186, 7, 43.877860603525129, 18.409950951913427, false, '2017-03-22 21:29:54.75058');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3217, 10, 43.876657526938359, 18.413246736930727, false, '2017-03-22 21:37:00.371136');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3218, 14, 43.877339666405973, 18.41169973255672, false, '2017-03-22 21:37:00.379136');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3250, 12, 43.878339611720364, 18.410027988043979, false, '2017-03-22 21:59:23.025599');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3283, 15, 43.8766533969983, 18.413031815623636, false, '2017-03-22 22:05:26.101677');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3284, 10, 43.876266052538263, 18.411948962930353, false, '2017-03-22 22:05:26.103677');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3314, 10, 43.878460785538977, 18.409900622610667, false, '2017-03-22 22:11:07.894201');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2989, 16, 43.87836491072138, 18.409752960205498, false, '2017-03-22 20:43:18.884552');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2990, 19, 43.877533910250392, 18.411027818386565, false, '2017-03-22 20:43:18.892553');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3019, 9, 43.878232037218787, 18.410754581136413, false, '2017-03-22 20:53:18.896651');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3053, 9, 43.878373683759492, 18.40969729951609, false, '2017-03-22 21:01:35.462053');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3054, 10, 43.877659900250464, 18.41005760601233, false, '2017-03-22 21:01:35.479054');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3085, 13, 43.878284098092308, 18.409529709812567, false, '2017-03-22 21:08:43.038828');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3120, 20, 43.878146162511264, 18.410811454118633, false, '2017-03-22 21:15:30.980801');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3152, 16, 43.877773166332531, 18.410915611724874, false, '2017-03-22 21:22:00.583261');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3187, 9, 43.878431246898792, 18.410698918443661, false, '2017-03-22 21:30:40.123175');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3188, 6, 43.878264688471901, 18.409469067277929, false, '2017-03-22 21:30:40.134176');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3219, 20, 43.877780679837741, 18.410705843861791, false, '2017-03-22 21:53:29.369704');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3251, 1, 43.877927837978262, 18.41091784908453, false, '2017-03-22 21:59:25.377734');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3252, 7, 43.878343844988713, 18.409486676942723, false, '2017-03-22 21:59:25.395735');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3285, 11, 43.856077908083336, 18.412969813586283, false, '2017-03-22 22:05:47.415896');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3286, 9, 43.85679491358303, 18.412960878631193, false, '2017-03-22 22:05:47.452898');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3315, 18, 43.877777965538343, 18.41018169838884, false, '2017-03-22 22:11:10.102719');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3316, 12, 43.877979337005613, 18.411278886074509, false, '2017-03-22 22:11:10.11972');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2991, 10, 43.878444547140056, 18.41088750010973, false, '2017-03-22 20:43:35.432499');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2992, 15, 43.877441994968329, 18.410642870389431, false, '2017-03-22 20:43:35.4505');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3020, 9, 43.878344924623349, 18.410776720415125, false, '2017-03-22 20:53:18.901651');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3055, 10, 43.878322337943132, 18.411089100465684, false, '2017-03-22 21:02:18.908538');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3056, 10, 43.878341133965428, 18.410754641355311, false, '2017-03-22 21:02:18.918538');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3086, 5, 43.877910148312694, 18.409731762865068, false, '2017-03-22 21:08:43.043828');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3121, 1, 43.878609416541657, 18.410024647737728, false, '2017-03-22 21:16:23.260791');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3153, 9, 43.878064618357783, 18.411021411491568, false, '2017-03-22 21:22:49.86108');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2463, 16, 43.878118055191251, 18.409725125629997, false, '2017-03-21 21:29:25.832723');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2504, 8, 43.87829893617328, 18.410216656474379, false, '2017-03-22 10:40:50.643918');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2529, 8, 43.877853840385036, 18.411211293764364, false, '2017-03-22 10:46:35.193225');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2553, 2, 43.876527325212955, 18.41266405405803, false, '2017-03-22 10:55:46.724517');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2577, 10, 43.877965555105817, 18.413369776607727, false, '2017-03-22 11:08:29.967701');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2600, 7, 43.876273773316221, 18.412822340743634, false, '2017-03-22 11:13:00.175993');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2629, 8, 43.876761069287021, 18.412376222647531, false, '2017-03-22 11:22:40.018008');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2656, 13, 43.876171775567194, 18.411392715092937, false, '2017-03-22 11:29:37.598823');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2687, 8, 43.878040764881419, 18.409212794207765, false, '2017-03-22 11:37:22.736428');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2688, 17, 43.878640654941542, 18.409825615667099, false, '2017-03-22 11:37:22.746428');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2715, 14, 43.877618556738973, 18.415190158231233, false, '2017-03-22 11:42:56.075287');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2743, 14, 43.877042621261978, 18.41448919092625, false, '2017-03-22 11:49:56.631179');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2775, 6, 43.877731938194799, 18.414388497549005, false, '2017-03-22 11:57:56.625765');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2776, 3, 43.876902790190833, 18.413972412537642, false, '2017-03-22 11:57:56.625765');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2805, 5, 43.877973630340648, 18.40945455563859, false, '2017-03-22 12:08:15.617324');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2806, 2, 43.878737057546417, 18.409691158501893, false, '2017-03-22 12:08:15.619324');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3189, 11, 43.877937772261504, 18.410229140520656, false, '2017-03-22 21:30:43.598374');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2859, 9, 43.877066689519026, 18.412454043164374, false, '2017-03-22 14:56:12.920985');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2860, 3, 43.876298877281918, 18.41312023083761, false, '2017-03-22 14:56:12.928985');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2887, 11, 43.876198533527884, 18.4133303084019, false, '2017-03-22 15:03:12.928008');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2888, 16, 43.87683048134339, 18.413279948367158, false, '2017-03-22 15:03:12.936008');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2916, 19, 43.856604877268005, 18.413969541551872, false, '2017-03-22 15:08:30.714343');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2947, 14, 43.875862394384491, 18.412850171212941, false, '2017-03-22 15:20:26.08426');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2970, 10, 43.87688187505276, 18.412130361164234, false, '2017-03-22 15:25:32.831374');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3220, 10, 43.878173825093263, 18.409126039778002, false, '2017-03-22 21:53:29.375704');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3253, 19, 43.877489517738674, 18.410561107591192, false, '2017-03-22 21:59:44.415823');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3287, 18, 43.855492928445877, 18.412986585064086, false, '2017-03-22 22:05:51.584134');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3288, 10, 43.855914059348343, 18.412835614332916, false, '2017-03-22 22:05:51.617136');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2278, 9, 43.877559340348789, 18.409539247920716, false, '2017-03-21 21:26:19.828085');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2307, 11, 43.877903870347907, 18.409915898061112, false, '2017-03-21 21:26:49.8128');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2311, 1, 43.87819305225797, 18.409618820801906, false, '2017-03-21 21:26:53.830029');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2333, 10, 43.878259167309629, 18.409216042703672, false, '2017-03-21 21:27:15.861289');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2334, 11, 43.878064162929711, 18.40921489425136, false, '2017-03-21 21:27:15.86329');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2357, 5, 43.87814516151434, 18.410292734057716, false, '2017-03-21 21:27:39.82566');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2384, 16, 43.878597130784655, 18.410347318464208, false, '2017-03-21 21:28:05.87215');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2385, 19, 43.877395700625726, 18.410176778603233, false, '2017-03-21 21:28:07.822261');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2408, 11, 43.878171726219698, 18.410937677115719, false, '2017-03-21 21:28:29.850521');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2435, 15, 43.877803605236608, 18.409202346318342, false, '2017-03-21 21:28:57.826121');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2464, 11, 43.878433362414363, 18.409476984626689, false, '2017-03-21 21:29:25.842724');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2483, 2, 43.878526333031679, 18.410421258836394, false, '2017-03-22 10:37:13.10898');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2505, 17, 43.877851459473668, 18.410395491056459, false, '2017-03-22 10:41:40.961796');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2506, 7, 43.877749622329873, 18.411544097040579, false, '2017-03-22 10:41:40.969796');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2530, 18, 43.877906906826183, 18.411286168733, false, '2017-03-22 10:46:35.208825');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2554, 9, 43.876484728588714, 18.411094165828377, false, '2017-03-22 10:55:46.741518');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2578, 19, 43.87854722426404, 18.413298967875427, false, '2017-03-22 11:08:29.974702');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2601, 5, 43.876401053159682, 18.411659821689643, false, '2017-03-22 11:16:43.936623');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2602, 18, 43.875838965793122, 18.41213058152308, false, '2017-03-22 11:16:43.951624');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2630, 17, 43.87720851281302, 18.41142747579503, false, '2017-03-22 11:22:40.022009');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2657, 9, 43.876635850723545, 18.41232338714682, false, '2017-03-22 11:29:43.359153');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2658, 8, 43.876859402960228, 18.412422182747736, false, '2017-03-22 11:29:43.366153');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2689, 16, 43.876779774147366, 18.413296261152631, false, '2017-03-22 11:37:37.9883');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2690, 19, 43.877658313772216, 18.412833487943914, false, '2017-03-22 11:37:38.002301');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2716, 19, 43.877145386985624, 18.414066361301185, false, '2017-03-22 11:42:56.102288');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2744, 16, 43.877400011020399, 18.415122038145991, false, '2017-03-22 11:49:56.646779');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2777, 16, 43.87654953280019, 18.414051502171915, false, '2017-03-22 11:58:53.79034');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2778, 18, 43.87622170774857, 18.412833119640421, false, '2017-03-22 11:58:53.799341');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2807, 12, 43.878396149460201, 18.410106720868026, false, '2017-03-22 12:09:15.594754');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2811, 10, 43.856081030336121, 18.413210047610576, false, '2017-03-22 14:47:33.429191');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2993, 7, 43.877829171750044, 18.410290107448098, false, '2017-03-22 20:44:18.902985');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2861, 6, 43.877419594864314, 18.412101761414494, false, '2017-03-22 14:56:47.505963');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2889, 7, 43.876608749434574, 18.412360736580109, false, '2017-03-22 15:03:16.46121');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2917, 12, 43.876324081723276, 18.413354840542532, false, '2017-03-22 15:08:36.059649');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2948, 13, 43.876106253917264, 18.412628891940585, false, '2017-03-22 15:20:26.095261');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2971, 10, 43.855635373324596, 18.413044971775982, false, '2017-03-22 15:25:50.332375');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3021, 8, 43.878232637124206, 18.410261495485582, false, '2017-03-22 20:53:35.445597');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3022, 6, 43.878256424571369, 18.410589689143794, false, '2017-03-22 20:53:35.463599');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3057, 16, 43.87801205876211, 18.41043145492381, false, '2017-03-22 21:02:35.462485');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3058, 16, 43.877668180383665, 18.409560992001115, false, '2017-03-22 21:02:35.478486');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3087, 13, 43.87762341792503, 18.41068127901978, false, '2017-03-22 21:08:44.870933');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3122, 11, 43.87830353718396, 18.409578430250932, false, '2017-03-22 21:16:23.271791');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3154, 20, 43.87814904164118, 18.410988025528813, false, '2017-03-22 21:22:49.87508');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3190, 5, 43.877760373947865, 18.409574499597717, false, '2017-03-22 21:30:43.615375');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3221, 16, 43.878795191694259, 18.410427805658557, false, '2017-03-22 21:53:31.939851');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3254, 14, 43.878579771647644, 18.410649703237052, false, '2017-03-22 21:59:44.452825');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3289, 13, 43.855483998052705, 18.413187588308514, false, '2017-03-22 22:06:47.418146');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3290, 13, 43.855931195827424, 18.413171571332207, false, '2017-03-22 22:06:47.428146');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2279, 9, 43.878167333579675, 18.40973374331503, false, '2017-03-21 21:26:21.827199');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2308, 18, 43.87764202765473, 18.409236757856089, false, '2017-03-21 21:26:49.837801');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2335, 4, 43.878133738498434, 18.410673356041233, false, '2017-03-21 21:27:17.832402');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2359, 13, 43.87745970620351, 18.410391128652485, false, '2017-03-21 21:27:41.892778');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2386, 19, 43.877333671082205, 18.409588759050461, false, '2017-03-21 21:28:07.832262');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2409, 11, 43.87814754249974, 18.41074063769177, false, '2017-03-21 21:28:31.823634');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2436, 14, 43.877966511220286, 18.409420382029417, false, '2017-03-21 21:28:57.828122');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2465, 3, 43.87758666092563, 18.409888630603938, false, '2017-03-21 21:29:27.86584');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2484, 7, 43.878198191624207, 18.4111422790576, false, '2017-03-22 10:37:13.10598');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2507, 11, 43.877684119857356, 18.410746325262867, false, '2017-03-22 10:41:50.630349');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2508, 6, 43.877886247226009, 18.41139364741467, false, '2017-03-22 10:41:50.637349');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2531, 7, 43.876007981705477, 18.411951768314207, false, '2017-03-22 10:46:46.711723');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2555, 13, 43.876511485002858, 18.412579336346891, false, '2017-03-22 10:55:52.293417');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2579, 7, 43.856541393122328, 18.412132445059772, false, '2017-03-22 11:08:33.167884');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2603, 13, 43.876710774869828, 18.411603081876489, false, '2017-03-22 11:16:48.683895');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2604, 7, 43.876898285883819, 18.411259954600006, false, '2017-03-22 11:16:48.687895');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2631, 5, 43.876155811905321, 18.4127439226815, false, '2017-03-22 11:23:36.897192');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2632, 18, 43.877097855658462, 18.411675638000286, false, '2017-03-22 11:23:36.917194');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2659, 4, 43.876335045500632, 18.411580952989699, false, '2017-03-22 11:30:37.577254');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2691, 9, 43.87774249818694, 18.409463166999426, false, '2017-03-22 11:38:22.73886');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2692, 10, 43.877480816693712, 18.410152367216426, false, '2017-03-22 11:38:22.754861');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2717, 8, 43.876810317511747, 18.413617019341341, false, '2017-03-22 11:43:53.807589');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2745, 8, 43.877285069963463, 18.412620904332247, false, '2017-03-22 11:50:53.781005');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2746, 6, 43.877174409467429, 18.41321696751471, false, '2017-03-22 11:50:53.788005');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2779, 15, 43.87760883225117, 18.413336861251956, false, '2017-03-22 11:58:56.656783');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2808, 16, 43.877714150857493, 18.410626282661983, false, '2017-03-22 12:09:15.600754');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2994, 13, 43.878076498801001, 18.411053889606052, false, '2017-03-22 20:44:18.927986');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2834, 19, 43.877959172499473, 18.410359816480597, false, '2017-03-22 14:51:30.368824');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2862, 8, 43.877632383187304, 18.412560733431281, false, '2017-03-22 14:56:47.509963');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2890, 13, 43.877361458143191, 18.411422406545888, false, '2017-03-22 15:03:16.47021');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2918, 19, 43.876188023589179, 18.411736657917778, false, '2017-03-22 15:08:36.060649');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2949, 18, 43.876240990193232, 18.413094559865776, false, '2017-03-22 15:21:21.947046');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2950, 15, 43.876254025137392, 18.412369218314389, false, '2017-03-22 15:21:21.957046');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2972, 16, 43.856534969685718, 18.413451504716907, false, '2017-03-22 15:25:50.359376');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3023, 11, 43.878351342970632, 18.409835406568583, false, '2017-03-22 20:54:18.904083');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3024, 10, 43.878693378520772, 18.409730895008167, false, '2017-03-22 20:54:18.913084');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3059, 14, 43.87866049306497, 18.410177059296565, false, '2017-03-22 21:03:18.91597');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3088, 18, 43.878047085327786, 18.410258440768484, false, '2017-03-22 21:08:44.876933');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3123, 9, 43.878250589866383, 18.409521808348732, false, '2017-03-22 21:16:30.94423');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3124, 18, 43.877424657000951, 18.409903094686946, false, '2017-03-22 21:16:30.973232');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3155, 14, 43.87837220627533, 18.410753790986867, false, '2017-03-22 21:23:00.953714');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3191, 10, 43.878078868794297, 18.41079137657135, false, '2017-03-22 21:31:40.092601');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3192, 2, 43.877898732761146, 18.410236866085622, false, '2017-03-22 21:31:40.102602');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3222, 18, 43.878047054324561, 18.409819081778576, false, '2017-03-22 21:53:31.943851');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3255, 8, 43.877828039542734, 18.410528323840431, false, '2017-03-22 21:59:50.893978');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3291, 7, 43.856250011430376, 18.412244968318621, false, '2017-03-22 22:06:51.582384');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2280, 9, 43.878007539320734, 18.409458064380978, false, '2017-03-21 21:26:21.831199');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2309, 9, 43.877563735885403, 18.409419854633697, false, '2017-03-21 21:26:51.824915');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2336, 7, 43.877603766880441, 18.410535006761805, false, '2017-03-21 21:27:17.836402');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2360, 7, 43.878035124580833, 18.411130727510418, false, '2017-03-21 21:27:41.895779');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2387, 7, 43.878718095136691, 18.410517102613493, false, '2017-03-21 21:28:09.880379');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2410, 5, 43.878387039339763, 18.409311542390054, false, '2017-03-21 21:28:31.829635');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2437, 14, 43.87728629632835, 18.410483076923448, false, '2017-03-21 21:28:59.89624');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2438, 13, 43.87721451974349, 18.409961547728511, false, '2017-03-21 21:28:59.90324');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2466, 11, 43.877941888740452, 18.411143537399138, false, '2017-03-21 21:29:27.86684');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2468, 3, 43.877799819837513, 18.409475075563616, false, '2017-03-21 21:29:29.838953');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2485, 7, 43.878151663187111, 18.411551783070347, false, '2017-03-22 10:37:23.989313');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2509, 2, 43.878729860406857, 18.411085728726803, false, '2017-03-22 10:42:40.958227');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2510, 1, 43.877501134004881, 18.410634513538337, false, '2017-03-22 10:42:40.967228');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2532, 1, 43.876997428889382, 18.411802545742873, false, '2017-03-22 10:46:46.719723');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2556, 20, 43.877022175137633, 18.41321304438906, false, '2017-03-22 10:55:52.309418');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2580, 5, 43.856410815514884, 18.412119613322101, false, '2017-03-22 11:08:33.180885');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2605, 12, 43.876400592870887, 18.412911614735879, false, '2017-03-22 11:17:08.157913');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2606, 1, 43.877077736508333, 18.411670308986036, false, '2017-03-22 11:17:08.164913');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2633, 5, 43.876646263286773, 18.411703953834756, false, '2017-03-22 11:23:43.354562');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2660, 3, 43.876733312828222, 18.413035983829861, false, '2017-03-22 11:30:37.578254');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2693, 9, 43.877105128259288, 18.412664207076123, false, '2017-03-22 11:38:37.990732');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2718, 14, 43.876710640699663, 18.41427309041994, false, '2017-03-22 11:43:53.814589');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2747, 16, 43.877070351607685, 18.415059086300705, false, '2017-03-22 11:50:56.618447');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2780, 8, 43.877962816981224, 18.4137070221573, false, '2017-03-22 11:58:56.660784');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2809, 15, 43.876418941319237, 18.412941263596714, false, '2017-03-22 12:09:24.555047');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2813, 16, 43.878334605808249, 18.410411413026139, false, '2017-03-22 14:47:49.114169');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2835, 18, 43.87758908158208, 18.410928923700162, false, '2017-03-22 14:51:49.060893');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2863, 8, 43.876809956492941, 18.411566412793722, false, '2017-03-22 14:57:12.940418');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2864, 8, 43.87677498162715, 18.41281209954391, false, '2017-03-22 14:57:12.954418');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2891, 19, 43.876896265919008, 18.412503623478987, false, '2017-03-22 15:03:18.123305');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2919, 14, 43.876259329103924, 18.41341885573592, false, '2017-03-22 15:08:45.433185');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2920, 12, 43.876827255428438, 18.41257481931072, false, '2017-03-22 15:08:45.442186');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2951, 10, 43.875952174315948, 18.413228773656279, false, '2017-03-22 15:21:26.04428');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2973, 7, 43.856531995117152, 18.413232109392116, false, '2017-03-22 15:25:52.208482');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2995, 16, 43.878660528602786, 18.410763252265934, false, '2017-03-22 20:44:35.443931');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3025, 1, 43.878309466764541, 18.410721377280392, false, '2017-03-22 20:54:35.595038');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3026, 7, 43.878164651758141, 18.409989552969172, false, '2017-03-22 20:54:35.606038');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3060, 5, 43.878278400722969, 18.41029799616814, false, '2017-03-22 21:03:18.91697');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3089, 9, 43.877838041709303, 18.410374070051976, false, '2017-03-22 21:09:34.519822');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3090, 18, 43.878686097826943, 18.410485058846724, false, '2017-03-22 21:09:34.524822');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3125, 9, 43.878677650175533, 18.409730985915679, false, '2017-03-22 21:17:23.264223');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3156, 13, 43.878081112051333, 18.410868843120429, false, '2017-03-22 21:23:00.961715');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3193, 19, 43.877767899325065, 18.409270138938069, false, '2017-03-22 21:31:43.996824');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3194, 16, 43.878401846666847, 18.409797195216111, false, '2017-03-22 21:31:43.998825');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3223, 11, 43.878704107310575, 18.409909873248132, false, '2017-03-22 21:54:29.134122');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3224, 8, 43.877914523728272, 18.409392837972366, false, '2017-03-22 21:54:29.153123');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3256, 4, 43.87791093819628, 18.410298277143792, false, '2017-03-22 21:59:50.917979');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3292, 5, 43.855773925215537, 18.413833470789616, false, '2017-03-22 22:06:51.69839');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2281, 8, 43.878059563361916, 18.409467992775692, false, '2017-03-21 21:26:23.889317');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2310, 8, 43.877574271278057, 18.410207983283936, false, '2017-03-21 21:26:51.853916');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2312, 7, 43.878032118955105, 18.409517922978257, false, '2017-03-21 21:26:53.84003');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2337, 6, 43.878052176106642, 18.409970928246643, false, '2017-03-21 21:27:19.827516');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2361, 12, 43.878551710429669, 18.40999023006599, false, '2017-03-21 21:27:43.831889');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2388, 15, 43.87752497362645, 18.410512538273711, false, '2017-03-21 21:28:09.883379');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2411, 16, 43.877720600792536, 18.409296428185311, false, '2017-03-21 21:28:33.860751');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2413, 10, 43.877665355362304, 18.411018283200018, false, '2017-03-21 21:28:35.827863');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2439, 13, 43.877703158888266, 18.411131567182686, false, '2017-03-21 21:29:01.82635');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2440, 14, 43.877458764605059, 18.409926054201946, false, '2017-03-21 21:29:01.836351');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2467, 10, 43.87793652956438, 18.409867956773514, false, '2017-03-21 21:29:29.826952');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2486, 8, 43.878727139311074, 18.410827697757217, false, '2017-03-22 10:37:23.990313');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2511, 4, 43.877713420938008, 18.411058746337041, false, '2017-03-22 10:42:50.636781');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2533, 19, 43.877730994759297, 18.409630836536138, false, '2017-03-22 10:47:35.188702');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2557, 16, 43.877336015339338, 18.413381970084878, false, '2017-03-22 10:56:05.603316');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2581, 5, 43.878307539146881, 18.412341092498639, false, '2017-03-22 11:09:32.177259');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2607, 7, 43.876849680014338, 18.412257976165407, false, '2017-03-22 11:17:11.640896');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2634, 10, 43.877340466360465, 18.41216017683055, false, '2017-03-22 11:23:43.365562');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2661, 3, 43.876463527226193, 18.412195051024874, false, '2017-03-22 11:30:43.360585');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2694, 1, 43.877496895444139, 18.412690897225559, false, '2017-03-22 11:38:38.007733');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2719, 6, 43.877203765608179, 18.413422293461412, false, '2017-03-22 11:43:56.048717');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2748, 12, 43.877064972413621, 18.413868075291941, false, '2017-03-22 11:50:56.618447');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2781, 5, 43.877964070507517, 18.409790253846722, false, '2017-03-22 11:59:14.887773');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2782, 13, 43.878250621617511, 18.409629036019627, false, '2017-03-22 11:59:14.896773');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2810, 8, 43.876134653462245, 18.411593209245844, false, '2017-03-22 12:09:24.559047');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2814, 10, 43.877570957108816, 18.409349557981621, false, '2017-03-22 14:47:49.13917');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2836, 18, 43.878388280456612, 18.409241469559937, false, '2017-03-22 14:51:49.061893');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2865, 19, 43.877000202978401, 18.412397740564927, false, '2017-03-22 14:57:47.458392');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2866, 3, 43.877023963280038, 18.41297759748241, false, '2017-03-22 14:57:47.485393');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2892, 10, 43.876729806810609, 18.411224808250914, false, '2017-03-22 15:03:18.136306');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2921, 8, 43.856032621526388, 18.413333200247461, false, '2017-03-22 15:09:30.62877');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2952, 18, 43.876840995175051, 18.413809844761442, false, '2017-03-22 15:21:26.063281');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2974, 12, 43.855663032545408, 18.412689295657312, false, '2017-03-22 15:25:52.213483');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2996, 15, 43.877752615697375, 18.410121643347541, false, '2017-03-22 20:44:35.458932');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3027, 18, 43.877623648687958, 18.410238116369371, false, '2017-03-22 20:55:18.905515');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3028, 19, 43.877980792913377, 18.411198026623666, false, '2017-03-22 20:55:18.910515');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3061, 16, 43.878480476323112, 18.409598890985677, false, '2017-03-22 21:03:35.505919');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3091, 10, 43.878265794706934, 18.410737724187417, false, '2017-03-22 21:09:37.397986');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3092, 8, 43.877628199429815, 18.409814683134798, false, '2017-03-22 21:09:37.414987');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3126, 17, 43.877686427772979, 18.410316925932872, false, '2017-03-22 21:17:23.265223');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3157, 5, 43.878787404950074, 18.409808668290779, false, '2017-03-22 21:23:49.858511');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3158, 10, 43.878016488740691, 18.41014274090605, false, '2017-03-22 21:23:49.868512');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3195, 4, 43.878352009396693, 18.410684855972942, false, '2017-03-22 21:32:08.887041');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3196, 2, 43.878359995250996, 18.411076739867553, false, '2017-03-22 21:32:08.898042');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3225, 14, 43.877858816476461, 18.410117934401587, false, '2017-03-22 21:54:31.89528');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3226, 10, 43.877723301132264, 18.410898478137739, false, '2017-03-22 21:54:31.908281');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3257, 14, 43.87767048404951, 18.410476106438487, false, '2017-03-22 22:00:39.006527');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3258, 3, 43.878642896543504, 18.410346089737686, false, '2017-03-22 22:00:39.025528');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3293, 14, 43.877154235515476, 18.412463248381467, false, '2017-03-22 22:07:26.992409');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2282, 10, 43.878096835913674, 18.410124101077557, false, '2017-03-21 21:26:23.895317');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2313, 13, 43.877779095592636, 18.410545633010145, false, '2017-03-21 21:26:55.889147');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2338, 7, 43.877962885125584, 18.411255821728084, false, '2017-03-21 21:27:19.828516');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2362, 11, 43.87817962055545, 18.410400878034331, false, '2017-03-21 21:27:43.832889');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2389, 9, 43.877694874651397, 18.410351853969647, false, '2017-03-21 21:28:11.838491');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2412, 11, 43.877778249720663, 18.409401952212175, false, '2017-03-21 21:28:33.862751');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2441, 20, 43.878045100244144, 18.410819722110986, false, '2017-03-21 21:29:03.879468');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2469, 10, 43.87829419017924, 18.410242066480148, false, '2017-03-21 21:29:31.859068');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2487, 16, 43.878294521072512, 18.409908919587298, false, '2017-03-22 10:37:34.682925');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2512, 13, 43.878076013637738, 18.410108201199407, false, '2017-03-22 10:42:50.637781');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2534, 1, 43.877772352744074, 18.410583920512071, false, '2017-03-22 10:47:35.220903');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2558, 11, 43.877255220730802, 18.412715703432774, false, '2017-03-22 10:56:05.630318');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2582, 7, 43.878027671307443, 18.412763029406452, false, '2017-03-22 11:09:32.258264');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2608, 9, 43.87623673064266, 18.411614274755745, false, '2017-03-22 11:17:11.661898');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2635, 1, 43.87593779970863, 18.412733758725857, false, '2017-03-22 11:24:37.602665');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2662, 19, 43.87630125511123, 18.411920848663573, false, '2017-03-22 11:30:43.365585');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2695, 3, 43.878703626819075, 18.410194778925398, false, '2017-03-22 11:39:22.761293');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2696, 14, 43.878152493512673, 18.409487470540924, false, '2017-03-22 11:39:22.779294');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2720, 18, 43.877752145411399, 18.414167466605075, false, '2017-03-22 11:43:56.09472');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2749, 7, 43.876347724907568, 18.413030876286992, false, '2017-03-22 11:51:53.801979');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2750, 15, 43.877353955938688, 18.413766668683238, false, '2017-03-22 11:51:53.801979');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2783, 8, 43.877545545303434, 18.41335975547354, false, '2017-03-22 11:59:56.585464');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2815, 18, 43.856876091152834, 18.412786691636203, false, '2017-03-22 14:48:33.422703');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2837, 20, 43.87764541952874, 18.410092784376644, false, '2017-03-22 14:52:10.023092');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2867, 13, 43.877319614051103, 18.412084258291895, false, '2017-03-22 14:58:12.916848');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2868, 16, 43.876633337316257, 18.41143470351297, false, '2017-03-22 14:58:12.94385');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2893, 13, 43.877372999138835, 18.412760486557229, false, '2017-03-22 15:04:16.377425');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2922, 5, 43.856171687026418, 18.413975826665169, false, '2017-03-22 15:09:30.665772');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2953, 16, 43.876330781630656, 18.412841576390225, false, '2017-03-22 15:22:21.941477');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2954, 20, 43.876709039156957, 18.412049991674568, false, '2017-03-22 15:22:21.958478');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2997, 16, 43.877958776664528, 18.410113515223024, false, '2017-03-22 20:45:18.897416');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2998, 14, 43.877434096375076, 18.410634611343315, false, '2017-03-22 20:45:18.920418');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3029, 3, 43.878037698732129, 18.410695739544131, false, '2017-03-22 20:55:35.455462');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3030, 13, 43.877486282929553, 18.410382986306828, false, '2017-03-22 20:55:35.472463');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3062, 19, 43.878056959725853, 18.409166386802454, false, '2017-03-22 21:03:35.508919');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3093, 2, 43.877756403976036, 18.410530194545686, false, '2017-03-22 21:10:34.490252');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3094, 14, 43.877324649687544, 18.410085596794385, false, '2017-03-22 21:10:34.500252');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3127, 12, 43.878423649252611, 18.410731728792161, false, '2017-03-22 21:17:30.970664');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3159, 14, 43.87843866601046, 18.410076626021926, false, '2017-03-22 21:23:57.052923');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3197, 6, 43.878314905479392, 18.410410144764647, false, '2017-03-22 21:32:23.062594');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3227, 14, 43.878238394677382, 18.41086393042896, false, '2017-03-22 21:54:44.684011');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3228, 5, 43.877433256470226, 18.409860602579993, false, '2017-03-22 21:54:44.696012');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3259, 13, 43.877830904071899, 18.41007800511165, false, '2017-03-22 22:00:41.50367');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3260, 12, 43.878188337911901, 18.411172355278822, false, '2017-03-22 22:00:41.520671');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3294, 18, 43.876710738062599, 18.413218375411297, false, '2017-03-22 22:07:26.993409');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2283, 13, 43.878205788082312, 18.409499014992548, false, '2017-03-21 21:26:25.822427');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2314, 20, 43.878309566342011, 18.409634679516941, false, '2017-03-21 21:26:55.890147');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2339, 19, 43.877624243271889, 18.410894104457583, false, '2017-03-21 21:27:21.830631');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2363, 20, 43.878131882616515, 18.409764462558449, false, '2017-03-21 21:27:45.862005');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2365, 19, 43.877796301473396, 18.410928888642822, false, '2017-03-21 21:27:47.841119');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2390, 20, 43.878377403311006, 18.41109256016717, false, '2017-03-21 21:28:11.845492');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2414, 4, 43.877277545627699, 18.410377776392853, false, '2017-03-21 21:28:35.829863');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2442, 4, 43.878117046822958, 18.409282622066517, false, '2017-03-21 21:29:03.885468');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2470, 16, 43.877761169639854, 18.410603062126931, false, '2017-03-21 21:29:31.864068');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2488, 8, 43.87782904029681, 18.410805970744459, false, '2017-03-22 10:37:34.690925');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2513, 14, 43.878026453008395, 18.410347749350528, false, '2017-03-22 10:43:35.308336');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2535, 18, 43.87633527388941, 18.411674567039622, false, '2017-03-22 10:47:46.584926');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2559, 12, 43.876471790278892, 18.413704147162296, false, '2017-03-22 10:56:51.031902');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2560, 14, 43.876687404613108, 18.413212434764581, false, '2017-03-22 10:56:51.038902');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2583, 8, 43.876198146804981, 18.414301273774484, false, '2017-03-22 11:09:37.180545');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2609, 12, 43.877132867219331, 18.412000580858631, false, '2017-03-22 11:18:09.587813');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2636, 12, 43.876883309933561, 18.41115156237699, false, '2017-03-22 11:24:37.610665');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2663, 7, 43.876549465851298, 18.41142395951071, false, '2017-03-22 11:31:37.698693');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2664, 9, 43.877006196533543, 18.412268295120214, false, '2017-03-22 11:31:37.704693');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2697, 20, 43.876850934968566, 18.412524347256976, false, '2017-03-22 11:39:37.993164');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2698, 19, 43.87794092955675, 18.413558763229354, false, '2017-03-22 11:39:38.010165');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2721, 14, 43.876322561322986, 18.413420906191469, false, '2017-03-22 11:44:53.779019');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2722, 14, 43.876264912280853, 18.413178209374866, false, '2017-03-22 11:44:53.78902');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2751, 5, 43.876736435765963, 18.414743322453354, false, '2017-03-22 11:51:56.049086');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2752, 11, 43.877544324854291, 18.41465690407675, false, '2017-03-22 11:51:56.064087');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2784, 14, 43.877372589542219, 18.415152440826851, false, '2017-03-22 11:59:56.591464');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2999, 9, 43.87762857663737, 18.410516767658791, false, '2017-03-22 20:45:35.478365');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3031, 10, 43.877271189836257, 18.410234078961341, false, '2017-03-22 20:56:18.905947');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3032, 17, 43.878437864263425, 18.410690710206733, false, '2017-03-22 20:56:18.913947');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2869, 16, 43.876284507594541, 18.412850597419364, false, '2017-03-22 14:58:47.461824');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2870, 8, 43.877212072247794, 18.413301389391968, false, '2017-03-22 14:58:47.480825');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2894, 13, 43.877165630423157, 18.41124605769285, false, '2017-03-22 15:04:16.386426');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2895, 5, 43.876689846345961, 18.41254459659914, false, '2017-03-22 15:04:18.120525');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2896, 11, 43.876997661616471, 18.411151749521618, false, '2017-03-22 15:04:18.132526');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2923, 5, 43.877240850570907, 18.412472424337995, false, '2017-03-22 15:09:45.374614');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2955, 7, 43.875870463282993, 18.412992622310504, false, '2017-03-22 15:22:26.026711');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3063, 16, 43.877618148166398, 18.410550084419356, false, '2017-03-22 21:04:18.924402');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3064, 9, 43.87840814047432, 18.40939529976999, false, '2017-03-22 21:04:18.929403');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3095, 12, 43.878212840873033, 18.410852259870801, false, '2017-03-22 21:10:37.387417');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3096, 19, 43.877834653198455, 18.410755696830325, false, '2017-03-22 21:10:37.406419');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3128, 3, 43.877471394121621, 18.410956217575453, false, '2017-03-22 21:17:30.973664');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3160, 16, 43.877265742943941, 18.410152628867323, false, '2017-03-22 21:23:57.066924');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3198, 14, 43.878654387564502, 18.410661210229449, false, '2017-03-22 21:32:23.086595');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3229, 13, 43.878229706727545, 18.410957900444313, false, '2017-03-22 21:54:46.995143');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3261, 20, 43.878662543276775, 18.409587396719346, false, '2017-03-22 22:01:39.002355');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3295, 14, 43.876169380827015, 18.412165395626921, false, '2017-03-22 22:07:28.366488');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2284, 9, 43.878000443520904, 18.409953524827465, false, '2017-03-21 21:26:25.826428');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2315, 12, 43.878376351087837, 18.410909307236775, false, '2017-03-21 21:26:57.820258');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2340, 10, 43.878299517502136, 18.410919407553546, false, '2017-03-21 21:27:21.832631');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2364, 9, 43.877909087216686, 18.410596511296959, false, '2017-03-21 21:27:45.863005');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2366, 16, 43.877501136216942, 18.410172802584167, false, '2017-03-21 21:27:47.842119');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2391, 8, 43.878422107650422, 18.410605329097148, false, '2017-03-21 21:28:13.828605');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2415, 5, 43.878068276672096, 18.410160672380577, false, '2017-03-21 21:28:37.86598');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2418, 16, 43.878381685549392, 18.409341113316597, false, '2017-03-21 21:28:39.832092');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2443, 13, 43.878210012866987, 18.409362793915097, false, '2017-03-21 21:29:05.825579');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2471, 18, 43.878388056773296, 18.410879339933906, false, '2017-03-21 21:29:33.826181');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2489, 12, 43.878655035314878, 18.410807798519876, false, '2017-03-22 10:37:40.954878');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2514, 4, 43.878641885361311, 18.410852209503016, false, '2017-03-22 10:43:35.325337');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2536, 20, 43.875808236338905, 18.412245748431907, false, '2017-03-22 10:47:46.592926');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2561, 16, 43.877096924649244, 18.412317087203331, false, '2017-03-22 10:57:04.298483');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2584, 8, 43.876607844359448, 18.41511358109522, false, '2017-03-22 11:09:37.182546');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2610, 8, 43.877217691916172, 18.411998931340939, false, '2017-03-22 11:18:09.596814');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2637, 11, 43.876209027283664, 18.411374486543874, false, '2017-03-22 11:24:43.352994');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2638, 9, 43.87681647858021, 18.41255186961974, false, '2017-03-22 11:24:43.358994');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2665, 13, 43.876438921148363, 18.411347020130183, false, '2017-03-22 11:31:43.41602');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2666, 14, 43.877177928302217, 18.411507248223906, false, '2017-03-22 11:31:43.41802');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2699, 13, 43.87705389184876, 18.413052950016148, false, '2017-03-22 11:39:52.095971');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2701, 7, 43.876865638173783, 18.413057417474501, false, '2017-03-22 11:39:53.766066');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2723, 7, 43.876933501821526, 18.414261791302994, false, '2017-03-22 11:44:56.042148');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2753, 5, 43.87664463897476, 18.413800518927616, false, '2017-03-22 11:52:53.783388');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2754, 5, 43.877523118935912, 18.413531116906363, false, '2017-03-22 11:52:53.791388');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2785, 10, 43.877436753641625, 18.410383177383537, false, '2017-03-22 12:00:14.87351');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2786, 14, 43.878294517793258, 18.410500770168607, false, '2017-03-22 12:00:14.919512');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2817, 9, 43.877998978890837, 18.410976183964198, false, '2017-03-22 14:48:49.041596');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2839, 20, 43.878545828436565, 18.410615114636865, false, '2017-03-22 14:52:15.639413');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2871, 9, 43.876481655506282, 18.412158873206845, false, '2017-03-22 14:59:12.933281');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2872, 12, 43.877092870335318, 18.412708606754393, false, '2017-03-22 14:59:12.947282');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2897, 1, 43.877441467271765, 18.412391866400373, false, '2017-03-22 15:05:16.362856');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2899, 2, 43.877402536710967, 18.411634585650727, false, '2017-03-22 15:05:18.115957');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2924, 19, 43.876032187580378, 18.41229180684704, false, '2017-03-22 15:09:45.381614');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2956, 13, 43.876142347263922, 18.413267953871312, false, '2017-03-22 15:22:26.041712');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3000, 12, 43.878343047632477, 18.410758923277299, false, '2017-03-22 20:45:35.499366');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3033, 16, 43.877446616550621, 18.410977373407476, false, '2017-03-22 20:56:35.466894');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3065, 13, 43.877901132245675, 18.409885069517717, false, '2017-03-22 21:04:35.558354');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3066, 9, 43.877860864822622, 18.411214048262146, false, '2017-03-22 21:04:35.564354');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3097, 9, 43.878145931994666, 18.409882034321875, false, '2017-03-22 21:11:34.482683');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3098, 13, 43.877967379826217, 18.409421565171161, false, '2017-03-22 21:11:34.497684');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3129, 17, 43.878016047429831, 18.410813276891027, false, '2017-03-22 21:18:23.252654');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3130, 10, 43.87852951287605, 18.410039678075542, false, '2017-03-22 21:18:23.259654');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3161, 18, 43.877419084668105, 18.409510163914725, false, '2017-03-22 21:23:59.044037');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3162, 18, 43.878688578123473, 18.409839656306115, false, '2017-03-22 21:23:59.066038');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3199, 17, 43.877686917416874, 18.410409629333579, false, '2017-03-22 21:33:08.880214');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3200, 7, 43.877537388973209, 18.410959407885507, false, '2017-03-22 21:33:08.893215');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3230, 8, 43.878243687564407, 18.409748982965922, false, '2017-03-22 21:54:47.023145');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3262, 7, 43.878439893554898, 18.409429105296571, false, '2017-03-22 22:01:39.004355');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3296, 9, 43.876788464746284, 18.411577332606033, false, '2017-03-22 22:07:28.424491');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2285, 19, 43.878585063937436, 18.409618280944532, false, '2017-03-21 21:26:27.858544');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2287, 6, 43.87823909797239, 18.409342248366592, false, '2017-03-21 21:26:29.826656');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2316, 2, 43.877979646568136, 18.411286473648094, false, '2017-03-21 21:26:57.832258');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2341, 8, 43.87855653360657, 18.410475746834432, false, '2017-03-21 21:27:23.834745');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2367, 11, 43.878049534467749, 18.409122286165488, false, '2017-03-21 21:27:49.879235');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2370, 14, 43.878430071058972, 18.409879450968543, false, '2017-03-21 21:27:51.838347');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2392, 8, 43.87771112276338, 18.410072504774092, false, '2017-03-21 21:28:13.829605');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2416, 2, 43.878087274069166, 18.410654502374481, false, '2017-03-21 21:28:37.86698');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2444, 10, 43.87798375640967, 18.410253939050726, false, '2017-03-21 21:29:05.83958');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2472, 8, 43.878273803340974, 18.410889301591673, false, '2017-03-21 21:29:33.829181');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2490, 13, 43.87755382276918, 18.410764403195056, false, '2017-03-22 10:37:41.000881');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2515, 2, 43.878072135859718, 18.410818716772663, false, '2017-03-22 10:43:40.996661');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2537, 5, 43.87818299809485, 18.409666951158474, false, '2017-03-22 10:48:35.625515');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2562, 8, 43.877353902233644, 18.412951935689815, false, '2017-03-22 10:57:04.300483');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2585, 16, 43.878167976135188, 18.410458010503966, false, '2017-03-22 11:09:48.920217');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2611, 9, 43.877690405799335, 18.409862664407765, false, '2017-03-22 11:19:32.791572');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2639, 14, 43.876245786723331, 18.411981581315551, false, '2017-03-22 11:25:37.592096');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2667, 7, 43.876839058369086, 18.412857584533494, false, '2017-03-22 11:32:35.079975');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2668, 7, 43.877361012871916, 18.413129360305398, false, '2017-03-22 11:32:35.124977');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2700, 5, 43.876445691961642, 18.412922282333213, false, '2017-03-22 11:39:52.098971');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2724, 8, 43.876669975887353, 18.414113653571132, false, '2017-03-22 11:44:56.06615');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2755, 7, 43.877457478246043, 18.413378082645313, false, '2017-03-22 11:52:56.582548');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2787, 5, 43.877791364793978, 18.414130489662806, false, '2017-03-22 12:00:56.597949');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2788, 12, 43.876868550624273, 18.414887859823796, false, '2017-03-22 12:00:56.59995');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2818, 10, 43.877634173937523, 18.409166534786042, false, '2017-03-22 14:48:49.060597');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2841, 5, 43.878461362207183, 18.40939739884573, false, '2017-03-22 14:52:49.052324');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2873, 19, 43.877469119096951, 18.413103167443506, false, '2017-03-22 14:59:47.525259');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2898, 11, 43.877373381577819, 18.412264228291413, false, '2017-03-22 15:05:16.373857');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2925, 13, 43.855919990329184, 18.41388825137944, false, '2017-03-22 15:10:30.617201');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2926, 3, 43.856121799518526, 18.414122802832175, false, '2017-03-22 15:10:30.641203');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2957, 8, 43.877060119705291, 18.412894649346072, false, '2017-03-22 15:22:32.836286');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3001, 13, 43.87736989287653, 18.409953516115831, false, '2017-03-22 20:48:35.497441');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3034, 14, 43.878564871040183, 18.409722271053244, false, '2017-03-22 20:56:35.466894');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3067, 7, 43.878482406726334, 18.410292024166228, false, '2017-03-22 21:04:39.366572');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3099, 4, 43.877805887646119, 18.410834575250245, false, '2017-03-22 21:11:37.985884');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3131, 7, 43.877996428951526, 18.409634331649368, false, '2017-03-22 21:18:30.944094');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3132, 11, 43.877645512489622, 18.410304065154762, false, '2017-03-22 21:18:30.956095');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3163, 19, 43.878314087477882, 18.411188251374295, false, '2017-03-22 21:24:56.955349');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3164, 11, 43.877788303353341, 18.41064280981486, false, '2017-03-22 21:24:56.97235');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3201, 19, 43.877717270613729, 18.409706562536567, false, '2017-03-22 21:33:25.021137');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3231, 17, 43.877372693792232, 18.409718489076994, false, '2017-03-22 21:55:45.066465');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3233, 10, 43.877505947304009, 18.410048663002843, false, '2017-03-22 21:55:46.981574');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3263, 14, 43.878522997921458, 18.410724513409924, false, '2017-03-22 22:01:41.5335');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3297, 9, 43.877475380355307, 18.410488854531078, false, '2017-03-22 22:08:18.492943');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3298, 4, 43.877584065349311, 18.410461819932728, false, '2017-03-22 22:08:18.511944');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2286, 13, 43.877652562964229, 18.411030964784544, false, '2017-03-21 21:26:27.859544');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2288, 14, 43.877975926291995, 18.410847457237598, false, '2017-03-21 21:26:29.832657');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2317, 4, 43.878623862348157, 18.40976601388396, false, '2017-03-21 21:26:59.859374');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2320, 18, 43.877390813165007, 18.410957264583949, false, '2017-03-21 21:27:01.833487');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2342, 14, 43.877657025327601, 18.410534887045152, false, '2017-03-21 21:27:23.835746');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2368, 12, 43.878371499184269, 18.410621242012514, false, '2017-03-21 21:27:49.880235');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2393, 7, 43.87806127639378, 18.409669514946582, false, '2017-03-21 21:28:15.83272');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2417, 5, 43.877741599962746, 18.409524048588796, false, '2017-03-21 21:28:39.819092');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2445, 6, 43.877347247700094, 18.4103661411852, false, '2017-03-21 21:29:07.871696');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2447, 9, 43.877882764875139, 18.410323608243946, false, '2017-03-21 21:29:09.829808');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2473, 9, 43.878386926824525, 18.409469812913535, false, '2017-03-21 21:29:35.857297');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2474, 3, 43.877892050361943, 18.409413277602738, false, '2017-03-21 21:29:35.859297');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2491, 8, 43.877570619888544, 18.41159034360863, false, '2017-03-22 10:37:50.661623');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2516, 5, 43.878127232966648, 18.411297402896178, false, '2017-03-22 10:43:41.000661');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2538, 7, 43.878018347339662, 18.40911492948662, false, '2017-03-22 10:48:35.625515');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2563, 20, 43.877419051900318, 18.413801100749943, false, '2017-03-22 10:57:43.979753');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2586, 14, 43.878086042309853, 18.411172773207436, false, '2017-03-22 11:09:48.922217');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2612, 14, 43.877799724656768, 18.410480206216267, false, '2017-03-22 11:19:32.818574');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2640, 5, 43.876600086447411, 18.412187157636925, false, '2017-03-22 11:25:37.594096');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2669, 16, 43.877200396897997, 18.413980361559897, false, '2017-03-22 11:32:37.981141');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2670, 20, 43.877745466231623, 18.412430800307881, false, '2017-03-22 11:32:37.996142');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2702, 8, 43.876911777366317, 18.412690792631999, false, '2017-03-22 11:39:53.778067');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2725, 11, 43.876480727718722, 18.414157466503347, false, '2017-03-22 11:45:53.817453');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2726, 8, 43.876787808919204, 18.413324501148129, false, '2017-03-22 11:45:53.823453');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2756, 14, 43.877440577815925, 18.414008583641696, false, '2017-03-22 11:52:56.595549');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2789, 5, 43.877548725421903, 18.410680946580435, false, '2017-03-22 12:01:14.878821');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2819, 15, 43.878304043513097, 18.409901196534161, false, '2017-03-22 14:49:11.732894');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2842, 5, 43.878111604473119, 18.411120590912002, false, '2017-03-22 14:52:49.061325');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2874, 5, 43.877579860433073, 18.41339085983817, false, '2017-03-22 14:59:47.54326');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2900, 11, 43.877119844674759, 18.413109128152239, false, '2017-03-22 15:05:18.123957');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2927, 16, 43.87634601117913, 18.412204833411362, false, '2017-03-22 15:10:45.372045');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2928, 14, 43.876922701064274, 18.411600487126002, false, '2017-03-22 15:10:45.384046');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2958, 8, 43.877368408773414, 18.412891517388243, false, '2017-03-22 15:22:32.836286');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3002, 16, 43.878000063713031, 18.41058234868073, false, '2017-03-22 20:48:35.506442');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3035, 16, 43.877556552013779, 18.41105437869674, false, '2017-03-22 20:57:18.92538');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3068, 20, 43.87821127996358, 18.411204286995954, false, '2017-03-22 21:04:39.398573');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3100, 8, 43.877891215441771, 18.410022559870509, false, '2017-03-22 21:11:37.986884');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3133, 9, 43.878541350394826, 18.410509041476921, false, '2017-03-22 21:18:33.911264');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3134, 9, 43.877686191603445, 18.409938141327522, false, '2017-03-22 21:18:33.924264');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3165, 15, 43.878264165435027, 18.410273337653265, false, '2017-03-22 21:24:59.026468');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3202, 7, 43.87860404598505, 18.409420050304643, false, '2017-03-22 21:33:25.048139');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3232, 18, 43.878098532929528, 18.409195481019772, false, '2017-03-22 21:55:45.071465');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3234, 19, 43.877834824913009, 18.411279831728784, false, '2017-03-22 21:55:46.984575');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3264, 16, 43.877507605393312, 18.410904686355693, false, '2017-03-22 22:01:41.5355');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3299, 2, 43.877834446623481, 18.410719382962561, false, '2017-03-22 22:08:21.139094');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2262, 13, 43.877253791267734, 18.410491358638339, false, '2017-03-21 21:26:03.864171');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (2263, 2, 43.877831337293507, 18.410108745942139, false, '2017-03-21 21:26:05.833284');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3003, 8, 43.877612199441501, 18.411157939591774, false, '2017-03-22 20:49:17.988872');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3036, 9, 43.878523053463979, 18.410146304454678, false, '2017-03-22 20:57:18.92838');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3069, 9, 43.877389972819991, 18.41004331960665, false, '2017-03-22 21:04:42.322741');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3101, 16, 43.878297389640139, 18.409177626080005, false, '2017-03-22 21:12:12.54286');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3135, 16, 43.877167808941756, 18.410067099024705, false, '2017-03-22 21:18:37.442466');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3166, 8, 43.877849421411007, 18.409268037510362, false, '2017-03-22 21:24:59.026468');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3203, 6, 43.877796237684613, 18.409449521975461, false, '2017-03-22 21:34:08.891647');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3204, 8, 43.877368082118416, 18.4107154018904, false, '2017-03-22 21:34:08.900647');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3235, 12, 43.877813696008154, 18.410841850393862, false, '2017-03-22 21:56:18.752392');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3265, 8, 43.877420635535515, 18.410310601663927, false, '2017-03-22 22:01:53.079156');
INSERT INTO sentpokemons (id, pokemontypeid, lat, lon, expired, expiretimestamp) VALUES (3300, 3, 43.877426834871734, 18.411098376110697, false, '2017-03-22 22:08:21.162095');


--
-- Name: sentpokemons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sentpokemons_id_seq', 3316, true);


--
-- Name: challenges challenges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY challenges
    ADD CONSTRAINT challenges_pkey PRIMARY KEY (id);


--
-- Name: player player_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY player
    ADD CONSTRAINT player_pkey PRIMARY KEY (username);


--
-- Name: pokemontype pokemontype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pokemontype
    ADD CONSTRAINT pokemontype_pkey PRIMARY KEY (id);


--
-- Name: sentpokemons sentpokemons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sentpokemons
    ADD CONSTRAINT sentpokemons_pkey PRIMARY KEY (id);


--
-- Name: challenges challenges_recipient_player_username_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY challenges
    ADD CONSTRAINT challenges_recipient_player_username_fk FOREIGN KEY (recipient) REFERENCES player(username);


--
-- Name: challenges challenges_sender_player_username_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY challenges
    ADD CONSTRAINT challenges_sender_player_username_fk FOREIGN KEY (sender) REFERENCES player(username);


--
-- Name: playerpokemon playerpokemon_player_username_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY playerpokemon
    ADD CONSTRAINT playerpokemon_player_username_fk FOREIGN KEY (username) REFERENCES player(username);


--
-- Name: playerpokemon playerpokemon_pokemontype_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY playerpokemon
    ADD CONSTRAINT playerpokemon_pokemontype_id_fk FOREIGN KEY (pokemontypeid) REFERENCES pokemontype(id);


--
-- PostgreSQL database dump complete
--

