--
-- PostgreSQL database dump
--

\restrict IK5OEpr4whv2zjUgURzv8swx0CbkzZoJRoaSiunYiC7uYeebIsw8bvpNoaKcRn9

-- Dumped from database version 15.15 (Debian 15.15-1.pgdg13+1)
-- Dumped by pg_dump version 15.15 (Debian 15.15-1.pgdg13+1)

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

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: subgroup_type; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.subgroup_type AS ENUM (
    'A',
    'B'
);


ALTER TYPE public.subgroup_type OWNER TO "user";

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.user_role AS ENUM (
    'student',
    'editor',
    'admin'
);


ALTER TYPE public.user_role OWNER TO "user";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: goose_db_version; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.goose_db_version (
    id integer NOT NULL,
    version_id bigint NOT NULL,
    is_applied boolean NOT NULL,
    tstamp timestamp without time zone DEFAULT now()
);


ALTER TABLE public.goose_db_version OWNER TO "user";

--
-- Name: goose_db_version_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.goose_db_version_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goose_db_version_id_seq OWNER TO "user";

--
-- Name: goose_db_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.goose_db_version_id_seq OWNED BY public.goose_db_version.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.students (
    user_id uuid NOT NULL,
    group_name character varying(20) NOT NULL,
    subgroup_name public.subgroup_type NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.students OWNER TO "user";

--
-- Name: users; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    username character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    role public.user_role NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    email character varying(255),
    avatar_url character varying(255)
);


ALTER TABLE public.users OWNER TO "user";

--
-- Name: goose_db_version id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.goose_db_version ALTER COLUMN id SET DEFAULT nextval('public.goose_db_version_id_seq'::regclass);


--
-- Data for Name: goose_db_version; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.goose_db_version (id, version_id, is_applied, tstamp) FROM stdin;
1	0	t	2026-01-09 16:11:08.939645
2	1	t	2026-01-09 16:11:08.967487
3	2	t	2026-01-09 16:11:08.996923
4	3	t	2026-01-09 16:11:09.001477
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.students (user_id, group_name, subgroup_name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.users (id, username, password_hash, first_name, last_name, role, created_at, updated_at, email, avatar_url) FROM stdin;
2f38bcb1-4663-4563-bff1-2774e1b71ceb	admin	$2b$12$.31aqGBH2uhYB3VJ.BpN8eoxsUCusiBFf0/CWlClyWC1W31Ny3te.	Admin	Root	admin	2026-01-18 13:18:59.733135+00	2026-01-18 13:18:59.733135+00	admin@test.ru	https://minio.test.prof-stankin.ru/personal-images/avatar%2F2f38bcb1-4663-4563-bff1-2774e1b71ceb.png
8c49d61f-44a0-4594-aab5-be247e942379	test_editor	$2a$10$q4CFPdPE0cmPpFGXtzRn8.gmX4/9QrrMfyS8Q.X2Wk5GZnUYjL6Zi	Редактор	Тестовый	editor	2026-01-19 11:38:49.272283+00	2026-01-19 11:38:49.272332+00	\N	https://minio.test.prof-stankin.ru/personal-images/avatar%2F8c49d61f-44a0-4594-aab5-be247e942379.png
\.


--
-- Name: goose_db_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.goose_db_version_id_seq', 4, true);


--
-- Name: goose_db_version goose_db_version_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.goose_db_version
    ADD CONSTRAINT goose_db_version_pkey PRIMARY KEY (id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (user_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: idx_users_role; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_users_role ON public.users USING btree (role);


--
-- Name: idx_users_username; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_users_username ON public.users USING btree (username);


--
-- Name: students students_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict IK5OEpr4whv2zjUgURzv8swx0CbkzZoJRoaSiunYiC7uYeebIsw8bvpNoaKcRn9

