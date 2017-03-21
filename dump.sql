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
    response character varying(30)
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

INSERT INTO challenges (id, sender, recipient, dateofcreation, delivered, response) VALUES (21, 'javelin472@gmail.com', 'ognjen.bostjancic@outlook.com', '2017-03-21 12:21:05.170836', true, 'accept');


--
-- Name: challenges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('challenges_id_seq', 21, true);


--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO player (username, firstname, lastname, password, lat, lon, isonline) VALUES ('javelin33@hotmail.com', 'Ognjen', 'Bostjancic', 'f6689b2444cb5bffeb6bd3b636f97755c10214f0894bfa490152700322369b1f', 43.878006800000001, 18.4101918, false);
INSERT INTO player (username, firstname, lastname, password, lat, lon, isonline) VALUES ('javelin472@gmail.com', 'Ognjen', 'Bostjancic', 'f6689b2444cb5bffeb6bd3b636f97755c10214f0894bfa490152700322369b1f', 43.854870099999999, 18.398841600000001, true);
INSERT INTO player (username, firstname, lastname, password, lat, lon, isonline) VALUES ('ognjen.bostjancic@outlook.com', 'Ognjen', 'Bostjancic', 'f6689b2444cb5bffeb6bd3b636f97755c10214f0894bfa490152700322369b1f', 43.854852799999996, 18.3987999, true);


--
-- Data for Name: playerpokemon; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO playerpokemon (username, pokemontypeid, customname) VALUES ('ognjen.bostjancic@outlook.com', 11, '76');
INSERT INTO playerpokemon (username, pokemontypeid, customname) VALUES ('ognjen.bostjancic@outlook.com', 20, 'a');
INSERT INTO playerpokemon (username, pokemontypeid, customname) VALUES ('ognjen.bostjancic@outlook.com', 16, 'mjau');
INSERT INTO playerpokemon (username, pokemontypeid, customname) VALUES ('ognjen.bostjancic@outlook.com', 13, 'sdf');
INSERT INTO playerpokemon (username, pokemontypeid, customname) VALUES ('ognjen.bostjancic@outlook.com', 13, 'sdf');


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
-- Name: sentpokemons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sentpokemons_id_seq', 2196, true);


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

