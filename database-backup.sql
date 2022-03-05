--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.24
-- Dumped by pg_dump version 14.2 (Ubuntu 14.2-1.pgdg20.04+1)

-- Started on 2022-03-05 12:08:11 EAT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

--
-- TOC entry 186 (class 1259 OID 35456)
-- Name: apercue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apercue (
    fk_terrain integer NOT NULL,
    apercues character varying(255),
    image_url character varying(255)
);


ALTER TABLE public.apercue OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 35459)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    client_id integer NOT NULL,
    client_code_postal integer,
    client_lot character varying(255),
    client_ville character varying(255),
    client_cin character varying(255),
    client_nom character varying(255),
    client_photo character varying(255),
    client_prenom character varying(255)
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 35454)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 35467)
-- Name: telephone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telephone (
    fk_client integer NOT NULL,
    telephone_numero character varying(255)
);


ALTER TABLE public.telephone OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 35472)
-- Name: terrain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.terrain (
    id integer NOT NULL,
    adresse character varying(255),
    latitude real NOT NULL,
    longitude real NOT NULL,
    en_vente boolean,
    geolocated boolean NOT NULL,
    prix integer NOT NULL,
    relief character varying(255),
    surface real NOT NULL,
    proprietaire_client_id integer,
    terrain_en_vente boolean,
    terrain_localisation character varying(255),
    terrain_prix_par_metre_carre integer,
    terrain_relief character varying(255),
    terrain_surface real,
    terrain_proprietaire integer
);


ALTER TABLE public.terrain OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 35470)
-- Name: terrain_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.terrain_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.terrain_id_seq OWNER TO postgres;

--
-- TOC entry 2182 (class 0 OID 0)
-- Dependencies: 189
-- Name: terrain_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.terrain_id_seq OWNED BY public.terrain.id;


--
-- TOC entry 191 (class 1259 OID 35481)
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateur (
    user_name character varying(255) NOT NULL,
    user_email character varying(255),
    user_password character varying(255),
    user_photo character varying(255)
);


ALTER TABLE public.utilisateur OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 35491)
-- Name: vente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vente (
    vente_id integer NOT NULL,
    vente_operation timestamp without time zone,
    fk_client integer,
    fk_terrain integer
);


ALTER TABLE public.vente OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 35489)
-- Name: vente_vente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vente_vente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vente_vente_id_seq OWNER TO postgres;

--
-- TOC entry 2183 (class 0 OID 0)
-- Dependencies: 192
-- Name: vente_vente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vente_vente_id_seq OWNED BY public.vente.vente_id;


--
-- TOC entry 2033 (class 2604 OID 35475)
-- Name: terrain id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terrain ALTER COLUMN id SET DEFAULT nextval('public.terrain_id_seq'::regclass);


--
-- TOC entry 2034 (class 2604 OID 35494)
-- Name: vente vente_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente ALTER COLUMN vente_id SET DEFAULT nextval('public.vente_vente_id_seq'::regclass);


--
-- TOC entry 2169 (class 0 OID 35456)
-- Dependencies: 186
-- Data for Name: apercue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apercue (fk_terrain, apercues, image_url) FROM stdin;
1	terrain_img_2022_3_4at10_58_8_840.png	\N
1	terrain_img_2022_3_4at10_58_51_483.jpeg	\N
\.


--
-- TOC entry 2170 (class 0 OID 35459)
-- Dependencies: 187
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (client_id, client_code_postal, client_lot, client_ville, client_cin, client_nom, client_photo, client_prenom) FROM stdin;
1	301	Mitsinjosoa II Antsororokavo	Fianarantsoa	201051014168	Rijaniaina	1646456363381.png	Elie Fidèle
2	203	Mitsinjosoa	Fianarantsoa	201052123654	Raharisoa	1646456414470.png	Hanitriniaina Elise
\.


--
-- TOC entry 2171 (class 0 OID 35467)
-- Dependencies: 188
-- Data for Name: telephone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.telephone (fk_client, telephone_numero) FROM stdin;
1	0324572095
1	0343912565
2	0322612565
\.


--
-- TOC entry 2173 (class 0 OID 35472)
-- Dependencies: 190
-- Data for Name: terrain; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.terrain (id, adresse, latitude, longitude, en_vente, geolocated, prix, relief, surface, proprietaire_client_id, terrain_en_vente, terrain_localisation, terrain_prix_par_metre_carre, terrain_relief, terrain_surface, terrain_proprietaire) FROM stdin;
1	Emit Andrainjato Fianarantsoa	-21.4637814	47.1100426	t	t	50000	Coline	600	1	\N	\N	\N	\N	\N	\N
\.


--
-- TOC entry 2174 (class 0 OID 35481)
-- Dependencies: 191
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (user_name, user_email, user_password, user_photo) FROM stdin;
rinelfi	elierijaniaina@gmail.com	$2a$12$IihPOyT.1K.DD3vBgKaWSetJNmzbkhCerc0xMGFZVCIThJpf/ERkW	rinelfi.jpg
\.


--
-- TOC entry 2176 (class 0 OID 35491)
-- Dependencies: 193
-- Data for Name: vente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vente (vente_id, vente_operation, fk_client, fk_terrain) FROM stdin;
\.


--
-- TOC entry 2184 (class 0 OID 0)
-- Dependencies: 185
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hibernate_sequence', 2, true);


--
-- TOC entry 2185 (class 0 OID 0)
-- Dependencies: 189
-- Name: terrain_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.terrain_id_seq', 1, true);


--
-- TOC entry 2186 (class 0 OID 0)
-- Dependencies: 192
-- Name: vente_vente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vente_vente_id_seq', 1, false);


--
-- TOC entry 2036 (class 2606 OID 35466)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (client_id);


--
-- TOC entry 2040 (class 2606 OID 35480)
-- Name: terrain terrain_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terrain
    ADD CONSTRAINT terrain_pkey PRIMARY KEY (id);


--
-- TOC entry 2038 (class 2606 OID 35498)
-- Name: client uk_i5i48nydiyntg9yyr0q4to2ed; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_i5i48nydiyntg9yyr0q4to2ed UNIQUE (client_cin);


--
-- TOC entry 2042 (class 2606 OID 35488)
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (user_name);


--
-- TOC entry 2044 (class 2606 OID 35496)
-- Name: vente vente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente
    ADD CONSTRAINT vente_pkey PRIMARY KEY (vente_id);


--
-- TOC entry 2049 (class 2606 OID 35514)
-- Name: vente fk3kag5rthgwv0kff4r7pe4wobo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente
    ADD CONSTRAINT fk3kag5rthgwv0kff4r7pe4wobo FOREIGN KEY (fk_client) REFERENCES public.client(client_id);


--
-- TOC entry 2045 (class 2606 OID 35499)
-- Name: apercue fk566iyarml5rqu5jeig24blal3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apercue
    ADD CONSTRAINT fk566iyarml5rqu5jeig24blal3 FOREIGN KEY (fk_terrain) REFERENCES public.terrain(id);


--
-- TOC entry 2050 (class 2606 OID 35519)
-- Name: vente fketlspddjydjbi01oyncn3hgwi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente
    ADD CONSTRAINT fketlspddjydjbi01oyncn3hgwi FOREIGN KEY (fk_terrain) REFERENCES public.terrain(id);


--
-- TOC entry 2048 (class 2606 OID 43649)
-- Name: terrain fkht4ewxndmdoeridr6fonbteo7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terrain
    ADD CONSTRAINT fkht4ewxndmdoeridr6fonbteo7 FOREIGN KEY (terrain_proprietaire) REFERENCES public.client(client_id);


--
-- TOC entry 2046 (class 2606 OID 35504)
-- Name: telephone fkk5an49jti2ick4d451grry08p; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telephone
    ADD CONSTRAINT fkk5an49jti2ick4d451grry08p FOREIGN KEY (fk_client) REFERENCES public.client(client_id);


--
-- TOC entry 2047 (class 2606 OID 35509)
-- Name: terrain fkmhryncfdom7lpy25rb6ofsws2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terrain
    ADD CONSTRAINT fkmhryncfdom7lpy25rb6ofsws2 FOREIGN KEY (proprietaire_client_id) REFERENCES public.client(client_id);


-- Completed on 2022-03-05 12:08:11 EAT

--
-- PostgreSQL database dump complete
--

