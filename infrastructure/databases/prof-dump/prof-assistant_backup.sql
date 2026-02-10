--
-- PostgreSQL database dump
--

\restrict KW0doN1zSjkNguNtXf7CqUJrf5Icut9Xu6HbpnHDGZoiU22geweTELpi2XCtoW1

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
-- Name: blocktypeenum; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.blocktypeenum AS ENUM (
    'TextBlock',
    'ImageCollectionBlock'
);


ALTER TYPE public.blocktypeenum OWNER TO "user";

--
-- Name: imagedisplaytypeenum; Type: TYPE; Schema: public; Owner: user
--

CREATE TYPE public.imagedisplaytypeenum AS ENUM (
    'Collage',
    'Carousel'
);


ALTER TYPE public.imagedisplaytypeenum OWNER TO "user";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: aerich; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.aerich (
    id integer NOT NULL,
    version character varying(255) NOT NULL,
    app character varying(100) NOT NULL,
    content jsonb NOT NULL
);


ALTER TABLE public.aerich OWNER TO "user";

--
-- Name: aerich_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.aerich_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.aerich_id_seq OWNER TO "user";

--
-- Name: aerich_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.aerich_id_seq OWNED BY public.aerich.id;


--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO "user";

--
-- Name: article_categories; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.article_categories (
    article_id uuid NOT NULL,
    category_id uuid NOT NULL
);


ALTER TABLE public.article_categories OWNER TO "user";

--
-- Name: article_views; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.article_views (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    article_id uuid NOT NULL,
    ip_address character varying(45) NOT NULL,
    user_agent character varying(255) NOT NULL
);


ALTER TABLE public.article_views OWNER TO "user";

--
-- Name: articles; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.articles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title character varying(255) NOT NULL,
    author character varying(100) NOT NULL,
    is_published boolean NOT NULL,
    publication_date timestamp with time zone NOT NULL,
    header character varying,
    cover character varying,
    unique_views integer NOT NULL,
    slug character varying(255) NOT NULL
);


ALTER TABLE public.articles OWNER TO "user";

--
-- Name: blocks; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.blocks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    article_id uuid NOT NULL,
    "order" double precision NOT NULL,
    type public.blocktypeenum NOT NULL
);


ALTER TABLE public.blocks OWNER TO "user";

--
-- Name: categories; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.categories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.categories OWNER TO "user";

--
-- Name: image_collection_blocks; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.image_collection_blocks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    block_id uuid NOT NULL,
    display_type public.imagedisplaytypeenum NOT NULL,
    images json NOT NULL,
    caption text
);


ALTER TABLE public.image_collection_blocks OWNER TO "user";

--
-- Name: text_blocks; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.text_blocks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    block_id uuid NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.text_blocks OWNER TO "user";

--
-- Name: users; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.users (
    user_id character varying(15) NOT NULL,
    "group" character varying(15),
    professor character varying(50),
    news_subscription boolean DEFAULT false NOT NULL,
    subgroup character varying(1)
);


ALTER TABLE public.users OWNER TO "user";

--
-- Name: aerich id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.aerich ALTER COLUMN id SET DEFAULT nextval('public.aerich_id_seq'::regclass);


--
-- Data for Name: aerich; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.aerich (id, version, app, content) FROM stdin;
1	4_20240204165234_None.py	default	{"default.User": {"app": "default", "name": "default.User", "table": "users", "indexes": [], "abstract": false, "pk_field": {"name": "user_id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "user_id", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 15}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(15)"}}, "docstring": null, "fk_fields": [], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "group", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "group", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 15}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(15)"}}, {"name": "subgroup", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "subgroup", "docstring": null, "generated": false, "field_type": "CharEnumFieldInstance", "constraints": {"max_length": 1}, "description": "A: А\\nB: Б", "python_type": "str", "db_field_types": {"": "VARCHAR(1)"}}, {"name": "professor", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "professor", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 50}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(50)"}}, {"name": "news_subscription", "unique": false, "default": false, "indexed": false, "nullable": false, "db_column": "news_subscription", "docstring": null, "generated": false, "field_type": "BooleanField", "constraints": {}, "description": null, "python_type": "bool", "db_field_types": {"": "BOOL", "mssql": "BIT", "oracle": "NUMBER(1)", "sqlite": "INT"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "default.Aerich": {"app": "default", "name": "default.Aerich", "table": "aerich", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "version", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "version", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 255}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(255)"}}, {"name": "app", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "app", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 100}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(100)"}}, {"name": "content", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "content", "docstring": null, "generated": false, "field_type": "JSONField", "constraints": {}, "description": null, "python_type": "Union[dict, list]", "db_field_types": {"": "JSON", "mssql": "NVARCHAR(MAX)", "oracle": "NCLOB", "postgres": "JSONB"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}}
2	6_20240205212010_update.py	default	{"default.User": {"app": "default", "name": "default.User", "table": "users", "indexes": [], "abstract": false, "pk_field": {"name": "user_id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "user_id", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 15}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(15)"}}, "docstring": null, "fk_fields": [], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "group", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "group", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 15}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(15)"}}, {"name": "subgroup", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "subgroup", "docstring": null, "generated": false, "field_type": "CharEnumFieldInstance", "constraints": {"max_length": 1}, "description": "A: А\\nB: Б", "python_type": "str", "db_field_types": {"": "VARCHAR(1)"}}, {"name": "professor", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "professor", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 50}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(50)"}}, {"name": "news_subscription", "unique": false, "default": false, "indexed": false, "nullable": false, "db_column": "news_subscription", "docstring": null, "generated": false, "field_type": "BooleanField", "constraints": {}, "description": null, "python_type": "bool", "db_field_types": {"": "BOOL", "mssql": "BIT", "oracle": "NUMBER(1)", "sqlite": "INT"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "default.Aerich": {"app": "default", "name": "default.Aerich", "table": "aerich", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "version", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "version", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 255}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(255)"}}, {"name": "app", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "app", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 100}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(100)"}}, {"name": "content", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "content", "docstring": null, "generated": false, "field_type": "JSONField", "constraints": {}, "description": null, "python_type": "Union[dict, list]", "db_field_types": {"": "JSON", "mssql": "NVARCHAR(MAX)", "oracle": "NCLOB", "postgres": "JSONB"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}}
3	7_20240210154840_update.py	default	{"default.User": {"app": "default", "name": "default.User", "table": "users", "indexes": [], "abstract": false, "pk_field": {"name": "user_id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "user_id", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 15}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(15)"}}, "docstring": null, "fk_fields": [], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "group", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "group", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 15}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(15)"}}, {"name": "subgroup", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "subgroup", "docstring": null, "generated": false, "field_type": "CharEnumFieldInstance", "constraints": {"max_length": 1}, "description": "A: А\\nB: Б", "python_type": "str", "db_field_types": {"": "VARCHAR(1)"}}, {"name": "professor", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "professor", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 50}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(50)"}}, {"name": "news_subscription", "unique": false, "default": false, "indexed": false, "nullable": false, "db_column": "news_subscription", "docstring": null, "generated": false, "field_type": "BooleanField", "constraints": {}, "description": null, "python_type": "bool", "db_field_types": {"": "BOOL", "mssql": "BIT", "oracle": "NUMBER(1)", "sqlite": "INT"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "default.Aerich": {"app": "default", "name": "default.Aerich", "table": "aerich", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "version", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "version", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 255}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(255)"}}, {"name": "app", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "app", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 100}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(100)"}}, {"name": "content", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "content", "docstring": null, "generated": false, "field_type": "JSONField", "constraints": {}, "description": null, "python_type": "Union[dict, list]", "db_field_types": {"": "JSON", "mssql": "NVARCHAR(MAX)", "oracle": "NCLOB", "postgres": "JSONB"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}}
4	8_20240315000000_add_subgroup.py	default	{"default.User": {"app": "default", "name": "default.User", "table": "users", "indexes": [], "abstract": false, "pk_field": {"name": "user_id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "user_id", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 15}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(15)"}}, "docstring": null, "fk_fields": [], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "group", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "group", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 15}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(15)"}}, {"name": "subgroup", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "subgroup", "docstring": null, "generated": false, "field_type": "CharEnumFieldInstance", "constraints": {"max_length": 1}, "description": "A: А\\nB: Б", "python_type": "str", "db_field_types": {"": "VARCHAR(1)"}}, {"name": "professor", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "professor", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 50}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(50)"}}, {"name": "news_subscription", "unique": false, "default": false, "indexed": false, "nullable": false, "db_column": "news_subscription", "docstring": null, "generated": false, "field_type": "BooleanField", "constraints": {}, "description": null, "python_type": "bool", "db_field_types": {"": "BOOL", "mssql": "BIT", "oracle": "NUMBER(1)", "sqlite": "INT"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "default.Aerich": {"app": "default", "name": "default.Aerich", "table": "aerich", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "version", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "version", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 255}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(255)"}}, {"name": "app", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "app", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 100}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(100)"}}, {"name": "content", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "content", "docstring": null, "generated": false, "field_type": "JSONField", "constraints": {}, "description": null, "python_type": "Union[dict, list]", "db_field_types": {"": "JSON", "mssql": "NVARCHAR(MAX)", "oracle": "NCLOB", "postgres": "JSONB"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}}
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.alembic_version (version_num) FROM stdin;
8666e61b5d01
\.


--
-- Data for Name: article_categories; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.article_categories (article_id, category_id) FROM stdin;
2f137f97-351a-4eeb-8344-44f4ee66f746	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
2f137f97-351a-4eeb-8344-44f4ee66f746	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
2361d234-e5a8-4647-923d-2d2df92cdd96	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
2361d234-e5a8-4647-923d-2d2df92cdd96	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
8d6e3509-d67a-4d5b-a751-4bb1d0aa870a	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
8d6e3509-d67a-4d5b-a751-4bb1d0aa870a	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
b2f0fd80-69aa-4e1c-b449-d7771ef7871f	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
62743e68-d2be-44f4-a3ed-27c9a715573c	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
62743e68-d2be-44f4-a3ed-27c9a715573c	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
05537852-dc37-46cb-940b-e2b82f859a58	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
05537852-dc37-46cb-940b-e2b82f859a58	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
5674b9e9-546b-4c13-be9a-07085261cd3e	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
5674b9e9-546b-4c13-be9a-07085261cd3e	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
a6126e9c-7ee9-4a86-b051-42ae9d9fea36	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
a6126e9c-7ee9-4a86-b051-42ae9d9fea36	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
caeb619e-ed13-463c-935a-c17aebf53f1f	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
caeb619e-ed13-463c-935a-c17aebf53f1f	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
511080a8-5de0-4435-b468-6f857534bc60	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
511080a8-5de0-4435-b468-6f857534bc60	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
ba29867b-8f30-4392-b2ec-02be36e38c3b	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
ba29867b-8f30-4392-b2ec-02be36e38c3b	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
e7967ae1-b97f-407b-842d-cf954c178242	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
e7967ae1-b97f-407b-842d-cf954c178242	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
8f1fd2a3-cfc8-42b0-a73a-f7e62442e291	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
8f1fd2a3-cfc8-42b0-a73a-f7e62442e291	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
efe994fe-c8d2-4b1b-90d0-7e65feab1f39	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
efe994fe-c8d2-4b1b-90d0-7e65feab1f39	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
e9596051-5e7f-4610-9cb2-429f65820557	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
e9596051-5e7f-4610-9cb2-429f65820557	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
acfee5c5-42c5-4bfb-8cb0-44da268b4e46	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
acfee5c5-42c5-4bfb-8cb0-44da268b4e46	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
991b2659-578e-468f-96d2-912c0510a0ad	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
991b2659-578e-468f-96d2-912c0510a0ad	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
55d18753-0062-46f3-b123-d9ccabcb0e11	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
55d18753-0062-46f3-b123-d9ccabcb0e11	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
c6dd0f3d-01bc-4447-89b0-6709c96cd25d	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
c6dd0f3d-01bc-4447-89b0-6709c96cd25d	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
3f6e8d01-0b1f-4b82-8979-05120329b730	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
f7a518a6-68ed-42fe-b043-ee412d003155	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
f7a518a6-68ed-42fe-b043-ee412d003155	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
75d165f1-7b1c-495a-b0e6-3137f5c62480	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
75d165f1-7b1c-495a-b0e6-3137f5c62480	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
a3e5c918-bd4c-437d-a881-c694cf50ddda	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
a3e5c918-bd4c-437d-a881-c694cf50ddda	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
733fec57-4749-4ff1-b3ad-9d220acb9f39	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
dc725529-a77e-4a4f-ab4c-cc1e1288fa9a	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
dc725529-a77e-4a4f-ab4c-cc1e1288fa9a	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
82f97d3c-2184-472b-aed8-0779d41a40de	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
82f97d3c-2184-472b-aed8-0779d41a40de	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
eec4b6b9-323e-4a55-900f-5f792ff7d4fb	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
eec4b6b9-323e-4a55-900f-5f792ff7d4fb	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
6cfc882c-fdda-4d2e-b391-323fc477938f	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
6cfc882c-fdda-4d2e-b391-323fc477938f	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
dfbefbd7-94c3-4c8a-ae06-17475691a9b4	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
dfbefbd7-94c3-4c8a-ae06-17475691a9b4	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
d9fcf459-21fb-4c3b-ad9d-2823d5a0d9b5	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
d9fcf459-21fb-4c3b-ad9d-2823d5a0d9b5	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
e567131b-80fb-4dbe-900f-313352e851d4	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
e567131b-80fb-4dbe-900f-313352e851d4	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
a5889b1b-3559-440a-a20b-df1aaf9b3ea6	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
a5889b1b-3559-440a-a20b-df1aaf9b3ea6	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
6c88625f-51b0-4073-ad22-e5bd957b5835	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
be62c475-da85-4b99-b907-b7995b529713	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
be62c475-da85-4b99-b907-b7995b529713	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
cef63d87-7067-4c8b-94fe-fdadb9380111	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
cef63d87-7067-4c8b-94fe-fdadb9380111	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
9d23018e-5d27-4f37-a8af-520180bea276	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
9d23018e-5d27-4f37-a8af-520180bea276	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
be27b1e3-3a28-4101-9dfb-76354cf4ab0c	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
be27b1e3-3a28-4101-9dfb-76354cf4ab0c	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
d0a84377-73b9-4549-825c-32273374606b	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
b8c77a18-dcac-41bd-93d9-474b1ee680c6	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
b8c77a18-dcac-41bd-93d9-474b1ee680c6	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
2f97bdc8-24e5-4531-8eb3-aca402ddcab1	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
2f97bdc8-24e5-4531-8eb3-aca402ddcab1	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
95ce7e87-31c5-4fd6-8bff-4230a124c825	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
95ce7e87-31c5-4fd6-8bff-4230a124c825	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
dce49be9-8b04-4f46-811a-e91ff1414afa	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
797fc8cd-5028-4c34-8d5a-6b3879638316	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
797fc8cd-5028-4c34-8d5a-6b3879638316	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
d422a67f-0c5e-4990-bdb3-45915d5bd200	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
be7c1f13-335c-43ba-8f55-88c9848cda93	6c47ec6d-169f-4a03-bb8f-a3f38ad81356
be7c1f13-335c-43ba-8f55-88c9848cda93	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
644bf45d-8b8e-4c9d-84ae-5219614bcb18	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
2a94109f-5702-45f5-a817-a85cf7dcde56	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
82f6e500-d40c-49e4-a8e5-db88e1378c47	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
6396bb3b-d41b-4e31-904e-11d9388093b0	1dd6d2d6-7e69-4e27-9bfc-918e5cadd180
\.


--
-- Data for Name: article_views; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.article_views (id, article_id, ip_address, user_agent) FROM stdin;
83fe7ca2-52bd-4764-a225-66af66299a88	2f137f97-351a-4eeb-8344-44f4ee66f746	10.42.0.1	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:147.0) Gecko/20100101 Firefox/147.0
943d917c-f376-429a-a8a8-fda5200f595a	62743e68-d2be-44f4-a3ed-27c9a715573c	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
a66986cb-03f5-4734-866d-6caa4f3cc57d	5674b9e9-546b-4c13-be9a-07085261cd3e	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
663afb1f-c630-4820-8042-18a256b09fc6	a6126e9c-7ee9-4a86-b051-42ae9d9fea36	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
a8c31a8c-9ba5-4e01-9118-ac5429b63146	ba29867b-8f30-4392-b2ec-02be36e38c3b	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
f3a86e09-3e28-4b08-93b5-bc15bca93544	e7967ae1-b97f-407b-842d-cf954c178242	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
feb6c7dc-37eb-4241-824a-d52a695dc919	2f137f97-351a-4eeb-8344-44f4ee66f746	10.42.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36
984fbacd-bc09-4cf2-880d-6c373a0a1ae5	55d18753-0062-46f3-b123-d9ccabcb0e11	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
1de187de-8e05-4470-a4d6-2656e378403c	c6dd0f3d-01bc-4447-89b0-6709c96cd25d	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
6c9a1750-d220-4927-9b62-7e25acca1a94	d0a84377-73b9-4549-825c-32273374606b	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 YaBrowser/25.12.0.0 Safari/537.36
611e0e8a-2bf0-4ede-a0dd-57113f97c42b	2f137f97-351a-4eeb-8344-44f4ee66f746	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
2d953f72-8f87-4ff4-ae7b-0d811c2cd2d5	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 YaBrowser/25.12.0.0 Safari/537.36
0b319301-5583-43a3-9b21-b7175b7a27f7	05537852-dc37-46cb-940b-e2b82f859a58	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 YaBrowser/25.12.0.0 Safari/537.36
3ad503a5-e088-4aa2-a455-f0f61f81c6b8	2361d234-e5a8-4647-923d-2d2df92cdd96	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
0c062acf-a3ce-433a-8b72-2dc05d71330b	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
b0d62250-d076-457e-98aa-ed48fdd2a1a6	511080a8-5de0-4435-b468-6f857534bc60	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 YaBrowser/25.12.0.0 Safari/537.36
9607a64d-72a9-434f-b544-667d78f13f58	eec4b6b9-323e-4a55-900f-5f792ff7d4fb	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
8484068d-2248-4eff-9ee6-7b5438f34532	6cfc882c-fdda-4d2e-b391-323fc477938f	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
8b524578-df75-49eb-b6cc-d791e652b51d	dfbefbd7-94c3-4c8a-ae06-17475691a9b4	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
d6347012-d73b-4659-8dc8-123f7adf3ec7	d9fcf459-21fb-4c3b-ad9d-2823d5a0d9b5	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
a980b5ed-fb7f-48fb-9f8b-8c5c9e00a4ae	a5889b1b-3559-440a-a20b-df1aaf9b3ea6	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
51521a65-9692-4d5e-9d52-b2605e0bf6c4	6c88625f-51b0-4073-ad22-e5bd957b5835	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
76bec200-823a-4f0c-ad4d-f38ced37bafd	be62c475-da85-4b99-b907-b7995b529713	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
b7eeeced-f14d-406b-b548-21620f4bb1ca	9d23018e-5d27-4f37-a8af-520180bea276	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
494eac19-0143-46ee-b421-4c36ddd99b44	be27b1e3-3a28-4101-9dfb-76354cf4ab0c	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
59dbe211-36e7-4953-a58b-5e94e6243eb1	b8c77a18-dcac-41bd-93d9-474b1ee680c6	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
8ea33efb-3abd-4286-aa60-f8290a2877c5	2f97bdc8-24e5-4531-8eb3-aca402ddcab1	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
d8a804d5-8a01-490c-8e69-632d804383ec	dce49be9-8b04-4f46-811a-e91ff1414afa	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
16e8f23f-340b-4226-9df3-17434fdc8860	6396bb3b-d41b-4e31-904e-11d9388093b0	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
3284ed26-3f63-4b68-8cdd-7cb25ce8d759	2f137f97-351a-4eeb-8344-44f4ee66f746	10.42.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/22F76 Safari/604.1
a9c92038-d342-4f9a-9b30-2e7bef85e7b8	05537852-dc37-46cb-940b-e2b82f859a58	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
36bcba85-93fe-4757-9792-90314ca4d9a0	a3e5c918-bd4c-437d-a881-c694cf50ddda	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
3b4055e4-d2bb-43fc-94cf-59676aa73f11	511080a8-5de0-4435-b468-6f857534bc60	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
3d17c1d5-deac-4ad9-9a96-f5da9155989f	2361d234-e5a8-4647-923d-2d2df92cdd96	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 YaBrowser/25.12.0.0 Safari/537.36
4e6db473-8779-410e-acb7-cee1feb50773	733fec57-4749-4ff1-b3ad-9d220acb9f39	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
ac8b442c-af17-4b35-9258-79b9799b511f	e567131b-80fb-4dbe-900f-313352e851d4	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
a33c94d9-2183-4ee6-a3db-8ab2ba1d0636	cef63d87-7067-4c8b-94fe-fdadb9380111	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
06047226-ad5e-4073-98e0-2c6802dd8b43	d0a84377-73b9-4549-825c-32273374606b	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
b289222e-bb64-4807-983a-3a01c1003b5a	95ce7e87-31c5-4fd6-8bff-4230a124c825	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
91c38e83-e543-49b2-aeaa-bf9e69496718	2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
e4be5612-a479-40f9-9dbf-5189821bdd6f	be7c1f13-335c-43ba-8f55-88c9848cda93	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
35633625-02a3-424e-af6f-b199fcd8e21c	644bf45d-8b8e-4c9d-84ae-5219614bcb18	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
4dac8d96-32cc-4b09-925a-a6645bd08470	2a94109f-5702-45f5-a817-a85cf7dcde56	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
4479d854-aa87-4060-8714-30ad9abf6580	82f6e500-d40c-49e4-a8e5-db88e1378c47	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
9a66935e-8517-42e8-a801-13ec1fa1fd43	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
499e4808-d2a3-42fe-807b-6d9ae76bcfde	f7a518a6-68ed-42fe-b043-ee412d003155	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
dd83990f-9795-4831-a56c-27335cb1ffc0	75d165f1-7b1c-495a-b0e6-3137f5c62480	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
4b0151c1-4e70-433a-a52c-1e96d5e56462	8d6e3509-d67a-4d5b-a751-4bb1d0aa870a	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
ed9d1cd4-3094-4754-8e22-38bf9a755203	caeb619e-ed13-463c-935a-c17aebf53f1f	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
929b8cc0-021d-4187-9dc6-bb89b9708e97	8f1fd2a3-cfc8-42b0-a73a-f7e62442e291	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
b4567462-a9e9-4c3f-9d5a-de81fe2bac4b	efe994fe-c8d2-4b1b-90d0-7e65feab1f39	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
1f987167-4459-47c7-b411-41ef9fd438f3	e9596051-5e7f-4610-9cb2-429f65820557	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
58ab7abc-4394-481e-9f54-80401591a56a	acfee5c5-42c5-4bfb-8cb0-44da268b4e46	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
62829f03-864d-47a8-a273-744cb52770e9	991b2659-578e-468f-96d2-912c0510a0ad	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
4bb2fd5b-73ec-4155-b5b2-58abf908cae5	3f6e8d01-0b1f-4b82-8979-05120329b730	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
76350fc8-0e18-4fa1-aefb-ad788b97dcb5	2f137f97-351a-4eeb-8344-44f4ee66f746	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 YaBrowser/25.12.0.0 Safari/537.36
d570701b-489c-4591-b078-2899abf063a8	8d6e3509-d67a-4d5b-a751-4bb1d0aa870a	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 YaBrowser/25.12.0.0 Safari/537.36
a6bfd8ee-17b8-4442-bac1-54394d60ad8e	62743e68-d2be-44f4-a3ed-27c9a715573c	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 YaBrowser/25.12.0.0 Safari/537.36
f6d34779-b89b-4966-b440-e328721849d5	dc725529-a77e-4a4f-ab4c-cc1e1288fa9a	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
e7d54b7a-3e1e-4fa9-a993-8b587e56f7e8	82f97d3c-2184-472b-aed8-0779d41a40de	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
1a0e578b-9caa-4273-afcf-0bb53e724bfd	797fc8cd-5028-4c34-8d5a-6b3879638316	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
00ecaa8e-0162-498c-8653-6cc675933ad4	d422a67f-0c5e-4990-bdb3-45915d5bd200	10.42.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36
\.


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.articles (id, title, author, is_published, publication_date, header, cover, unique_views, slug) FROM stdin;
f7a518a6-68ed-42fe-b043-ee412d003155	Подборка мероприятий с 7 по 13 июля	Полина Паничева	f	2025-07-07 08:14:21+00	Подборка мероприятий с 7 по 13 июля	https://minio.test.prof-stankin.ru/blog/b1b45426-40dc-43f9-ac4f-a10456f69405.jpg	509	podborka-meropriiatii-s-7-po-13-iiulia
6c88625f-51b0-4073-ad22-e5bd957b5835	Внимание, студент	Юлия Тиханова	f	2025-04-25 10:18:00+00	Внимание, студент	https://minio.test.prof-stankin.ru/blog/051a124f-7a6b-4217-a90d-665e67070388.png	397	vnimanie-student
05537852-dc37-46cb-940b-e2b82f859a58	Подборка мероприятий с 20 по 26 октября	Полина Паничева	t	2025-10-19 19:44:27+00	Подборка мероприятий с 20 по 26 октября	https://minio.test.prof-stankin.ru/blog/840ce7fb-81bf-4552-b2d3-566c5c278099.jpg	500	podborka-meropriiatii-s-20-po-26-oktiabria
b2f0fd80-69aa-4e1c-b449-d7771ef7871f	«Единое окно» по поддержке молодых семей	Юлия Тиханова	f	2025-10-29 07:00:00+00	«Единое окно» по поддержке молодых семей	https://minio.test.prof-stankin.ru/blog/101ff874-0b1f-4aed-8962-7c317c700070.png	28	edinoe-okno-po-podderzhke-molodykh-semei
2f137f97-351a-4eeb-8344-44f4ee66f746	Подборка мероприятий с 17 по 23 ноября	Полина Паничева	t	2025-11-17 10:15:04+00	Подборка мероприятий с 17 по 23 ноября	https://minio.test.prof-stankin.ru/blog/d6c0770a-395f-41e7-9ea1-c17350612e17.jpg	16	podborka-meropriiatii-s-17-po-23-noiabria
8d6e3509-d67a-4d5b-a751-4bb1d0aa870a	Подборка мероприятий с 3 по 9 ноября	Полина Паничева	t	2025-11-02 18:02:19+00	Подборка мероприятий с 3 по 9 ноября	https://minio.test.prof-stankin.ru/blog/4fdf33d6-cb90-4b75-b0f5-4e34ef879bcd.jpg	993	podborka-meropriiatii-s-3-po-9-noiabria
62743e68-d2be-44f4-a3ed-27c9a715573c	Подборка мероприятий с 27 октября по 2 ноября	Полина Паничева	t	2025-10-27 17:11:52+00	Подборка мероприятий с 27 октября по 2 ноября	https://minio.test.prof-stankin.ru/blog/657f5e9c-48ee-476e-a330-c1acba531d12.jpg	682	podborka-meropriiatii-s-27-oktiabria-po-2-noiabria
2361d234-e5a8-4647-923d-2d2df92cdd96	Подборка мероприятий с 10 по 16 ноября	Полина Паничева	t	2025-11-10 07:32:50+00	Подборка мероприятий с 10 по 16 ноября	https://minio.test.prof-stankin.ru/blog/91d2a953-7eaf-4698-8467-8ebf20990e42.jpg	495	podborka-meropriiatii-s-10-po-16-noiabria
c6dd0f3d-01bc-4447-89b0-6709c96cd25d	Подборка мероприятий с 21 по 27 июля	Полина Паничева	t	2025-07-21 14:58:59+00	Подборка мероприятий с 21 по 27 июля	https://minio.test.prof-stankin.ru/blog/97e82d44-a912-42dd-8ebb-ed1b23e0aee1.jpg	807	podborka-meropriiatii-s-21-po-27-iiulia
5674b9e9-546b-4c13-be9a-07085261cd3e	Подборка мероприятий с 13 по 19 октября	Полина Паничева	t	2025-10-13 06:35:49+00	Подборка мероприятий с 13 по 19 октября	https://minio.test.prof-stankin.ru/blog/e5b20297-e55f-4035-9aa6-bdda9e2a6a90.jpg	999	podborka-meropriiatii-s-13-po-19-oktiabria
a6126e9c-7ee9-4a86-b051-42ae9d9fea36	Подборка мероприятий с 6 по 12 октября	Полина Паничева	t	2025-10-05 20:37:07+00	Подборка мероприятий с 6 по 12 октября	https://minio.test.prof-stankin.ru/blog/f448c580-62b4-4746-bc37-a5757ef08ef3.jpg	746	podborka-meropriiatii-s-6-po-12-oktiabria
caeb619e-ed13-463c-935a-c17aebf53f1f	Подборка мероприятий с 29 сентября по 5 октября	Полина Паничева	t	2025-09-28 19:40:48+00	Подборка мероприятий с 29 сентября по 5 октября	https://minio.test.prof-stankin.ru/blog/8687106d-ce8a-4f64-9ff8-45431ac6294f.jpg	697	podborka-meropriiatii-s-29-sentiabria-po-5-oktiabria
511080a8-5de0-4435-b468-6f857534bc60	Подборка мероприятий с 22 по 28 сентября	Полина Паничева	t	2025-09-22 06:44:36+00	Подборка мероприятий с 22 по 28 сентября	https://minio.test.prof-stankin.ru/blog/2eb14d80-654b-4c28-a1f8-2b4d2148805f.jpg	579	podborka-meropriiatii-s-22-po-28-sentiabria
ba29867b-8f30-4392-b2ec-02be36e38c3b	Подборка мероприятий с 15 по 21 сентября	Полина Паничева	t	2025-09-14 22:11:23+00	Подборка мероприятий с 15 по 21 сентября	https://minio.test.prof-stankin.ru/blog/3b7629ce-87ea-4bcd-93c7-e8f102da11e6.jpg	736	podborka-meropriiatii-s-15-po-21-sentiabria
e7967ae1-b97f-407b-842d-cf954c178242	Подборка мероприятий с 8 по 14 сентября	Полина Паничева	t	2025-09-07 19:11:18+00	Подборка мероприятий с 8 по 14 сентября	https://minio.test.prof-stankin.ru/blog/d5d953f1-253e-4486-abac-b14da0d386e0.jpg	340	podborka-meropriiatii-s-8-po-14-sentiabria
efe994fe-c8d2-4b1b-90d0-7e65feab1f39	Подборка мероприятий с 25 по 31 августа	Полина Паничева	f	2025-08-25 07:57:48+00	Подборка мероприятий с 25 по 31 августа	https://minio.test.prof-stankin.ru/blog/038a2270-a571-405c-8dcb-4087539e8c4b.jpg	501	podborka-meropriiatii-s-25-po-31-avgusta
8f1fd2a3-cfc8-42b0-a73a-f7e62442e291	Подборка мероприятий с 1 по 7 сентября	Полина Паничева	f	2025-08-31 20:49:59+00	Подборка мероприятий с 1 по 7 сентября	https://minio.test.prof-stankin.ru/blog/cef9ea12-cd43-4df3-af8d-de943925bc65.jpg	719	podborka-meropriiatii-s-1-po-7-sentiabria
e9596051-5e7f-4610-9cb2-429f65820557	Подборка мероприятий с 18 по 24 августа	Полина Паничева	f	2025-08-18 05:25:39+00	Подборка мероприятий с 18 по 24 августа	https://minio.test.prof-stankin.ru/blog/13c8ac23-ed76-4f12-9689-72dee0776042.jpg	814	podborka-meropriiatii-s-18-po-24-avgusta
733fec57-4749-4ff1-b3ad-9d220acb9f39	Как началась Великая Отечественная война: хронология событий	Юлия Тиханова	t	2025-06-22 15:00:00+00	Как началась Великая Отечественная война: хронология событий	https://minio.test.prof-stankin.ru/blog/938e0dcb-755c-40fa-99a7-5c8dcd0e674a.webp	747	kak-nachalas-velikaia-otechestvennaia-voina-khronologiia-sobytii
a3e5c918-bd4c-437d-a881-c694cf50ddda	Подборка мероприятий с 23 по 29 июня	Полина Паничева	f	2025-06-23 06:37:53+00	Подборка мероприятий с 23 по 29 июня	https://minio.test.prof-stankin.ru/blog/78676b6f-8881-4cc3-acb3-bcf9009a7ecc.jpg	889	podborka-meropriiatii-s-23-po-29-iiunia
acfee5c5-42c5-4bfb-8cb0-44da268b4e46	Подборка мероприятий с 11 по 17 августа	Полина Паничева	t	2025-08-11 20:29:13+00	Подборка мероприятий с 11 по 17 августа	https://minio.test.prof-stankin.ru/blog/39197742-237c-494d-9398-06f2a6883c32.jpg	258	podborka-meropriiatii-s-11-po-17-avgusta
991b2659-578e-468f-96d2-912c0510a0ad	Подборка мероприятий с 4 по 10 августа	Полина Паничева	t	2025-08-04 06:53:37+00	Подборка мероприятий с 4 по 10 августа	https://minio.test.prof-stankin.ru/blog/bee25049-535f-41a2-a00c-0791d2d2f5ba.jpg	973	podborka-meropriiatii-s-4-po-10-avgusta
55d18753-0062-46f3-b123-d9ccabcb0e11	Подборка мероприятий с 28 июля по 3 августа	Полина Паничева	f	2025-07-28 07:00:00+00	Подборка мероприятий с 28 июля по 3 августа	https://minio.test.prof-stankin.ru/blog/e9c308e1-a402-44ba-a596-2d2f7ff8c465.jpg	385	podborka-meropriiatii-s-28-iiulia-po-3-avgusta
3f6e8d01-0b1f-4b82-8979-05120329b730	Подборка мероприятий с 14 по 20 июля	Юлия Тиханова	t	2025-07-14 07:00:00+00	Подборка мероприятий с 14 по 20 июля	https://minio.test.prof-stankin.ru/blog/563d9578-2e1b-4f04-9e1d-ac59f5ce2079.jpg	376	podborka-meropriiatii-s-14-po-20-iiulia
b8c77a18-dcac-41bd-93d9-474b1ee680c6	Подборка мероприятий с 24 по 30 марта	Полина Паничева	t	2025-03-23 19:52:29+00	Подборка мероприятий с 24 по 30 марта	https://minio.test.prof-stankin.ru/blog/653a2b38-e258-4b27-b03c-4ddab404539a.jpg	917	podborka-meropriiatii-s-24-po-30-marta
75d165f1-7b1c-495a-b0e6-3137f5c62480	Подборка мероприятий с 30 июня по 6 июля	Полина Паничева	t	2025-06-30 08:14:01+00	Подборка мероприятий с 30 июня по 6 июля	https://minio.test.prof-stankin.ru/blog/69db47d8-69f1-4d39-a077-a5143a83cd22.jpg	625	podborka-meropriiatii-s-30-iiunia-po-6-iiulia
dc725529-a77e-4a4f-ab4c-cc1e1288fa9a	Подборка мероприятий с 16 по 22 июня	Полина Паничева	f	2025-06-16 09:44:55+00	Подборка мероприятий с 16 по 22 июня	https://minio.test.prof-stankin.ru/blog/3ed11200-0184-41c7-8324-5986450fdee0.jpg	727	podborka-meropriiatii-s-16-po-22-iiunia
82f97d3c-2184-472b-aed8-0779d41a40de	Подборка мероприятий с 9 по 15 июня	Полина Паничева	t	2025-06-09 07:30:24+00	Подборка мероприятий с 9 по 15 июня	https://minio.test.prof-stankin.ru/blog/5d26cc66-ef88-4758-9674-733d8a69eb1f.jpg	628	podborka-meropriiatii-s-9-po-15-iiunia
eec4b6b9-323e-4a55-900f-5f792ff7d4fb	Подборка мероприятий со 2 по 8 июня	Полина Паничева	f	2025-06-02 05:24:25+00	Подборка мероприятий со 2 по 8 июня	https://minio.test.prof-stankin.ru/blog/16bb4922-2835-4ff7-aef4-60b60225103e.jpg	676	podborka-meropriiatii-so-2-po-8-iiunia
6cfc882c-fdda-4d2e-b391-323fc477938f	Подборка мероприятий с 26 мая по 1 июня	Полина Паничева	t	2025-05-26 06:58:21+00	Подборка мероприятий с 26 мая по 1 июня	https://minio.test.prof-stankin.ru/blog/9f0a26e0-9a67-4ae2-91ec-6074f54e65cd.jpg	12	podborka-meropriiatii-s-26-maia-po-1-iiunia
dfbefbd7-94c3-4c8a-ae06-17475691a9b4	Подборка мероприятий с 19 по 25 мая	Полина Паничева	f	2025-05-19 07:49:51+00	Подборка мероприятий с 19 по 25 мая	https://minio.test.prof-stankin.ru/blog/2d7464f7-2434-42f9-a1ce-beda8cb68930.jpg	16	podborka-meropriiatii-s-19-po-25-maia
d9fcf459-21fb-4c3b-ad9d-2823d5a0d9b5	Подборка мероприятий с 12 по 18 мая	Полина Паничева	t	2025-05-12 06:23:18+00	Подборка мероприятий с 12 по 18 мая	https://minio.test.prof-stankin.ru/blog/d726a3cf-c526-44ac-9bcd-ebabd7bcf645.jpg	12	podborka-meropriiatii-s-12-po-18-maia
e567131b-80fb-4dbe-900f-313352e851d4	Подборка мероприятий с 5 по 11 мая	Полина Паничева	f	2025-05-05 06:14:13+00	Подборка мероприятий с 5 по 11 мая	https://minio.test.prof-stankin.ru/blog/4cb84988-4943-43b5-ac2b-01bee130891c.jpg	671	podborka-meropriiatii-s-5-po-11-maia
a5889b1b-3559-440a-a20b-df1aaf9b3ea6	Подборка мероприятий с 28 апреля по 4 мая	Полина Паничева	t	2025-04-28 05:57:02+00	Подборка мероприятий с 28 апреля по 4 мая	https://minio.test.prof-stankin.ru/blog/3e31212b-7818-4f33-84ec-53ddcad7550b.jpg	215	podborka-meropriiatii-s-28-aprelia-po-4-maia
be62c475-da85-4b99-b907-b7995b529713	Подборка мероприятий с 21 по 27 апреля	Полина Паничева	t	2025-04-21 05:20:48+00	Подборка мероприятий с 21 по 27 апреля	https://minio.test.prof-stankin.ru/blog/b871be6f-1436-44a7-97a3-46e1b9349585.jpg	433	podborka-meropriiatii-s-21-po-27-aprelia
cef63d87-7067-4c8b-94fe-fdadb9380111	Подборка мероприятий с 14 по 20 апреля	Полина Паничева	t	2025-04-14 06:33:49+00	Подборка мероприятий с 14 по 20 апреля	https://minio.test.prof-stankin.ru/blog/2a1e63db-b7e9-4472-aa5a-7e18931e0bde.jpg	409	podborka-meropriiatii-s-14-po-20-aprelia
9d23018e-5d27-4f37-a8af-520180bea276	Подборка мероприятий с 7 по 13 апреля	Полина Паничева	t	2025-04-07 06:51:49+00	Подборка мероприятий с 7 по 13 апреля	https://minio.test.prof-stankin.ru/blog/1b9277e9-5fd3-4048-bd5e-cd76484ff4e6.jpg	709	podborka-meropriiatii-s-7-po-13-aprelia
d0a84377-73b9-4549-825c-32273374606b	Кто и что такое эти ваши пищевые привычки?	Полина Паничева	t	2025-03-26 05:17:15+00	Кто и что такое эти ваши пищевые привычки?	https://minio.test.prof-stankin.ru/blog/0a20167a-633a-494d-ae77-0ddd1ad9e738.webp	242	kto-i-chto-takoe-eti-vashi-pishchevye-privychki
be27b1e3-3a28-4101-9dfb-76354cf4ab0c	Подборка мероприятий с 31 марта по 6 апреля	Полина Паничева	f	2025-03-31 05:44:27+00	Подборка мероприятий с 31 марта по 6 апреля	https://minio.test.prof-stankin.ru/blog/3156be36-5109-467d-9958-d11fcdb41890.jpg	13	podborka-meropriiatii-s-31-marta-po-6-aprelia
2f97bdc8-24e5-4531-8eb3-aca402ddcab1	Подборка мероприятий с 10 по 16 марта	Полина Паничева	t	2025-03-10 07:16:14+00	Подборка мероприятий с 10 по 16 марта	https://minio.test.prof-stankin.ru/blog/fa6abd36-bb58-47e0-8748-1b674476cf8b.jpg	880	podborka-meropriiatii-s-10-po-16-marta
95ce7e87-31c5-4fd6-8bff-4230a124c825	Подборка мероприятий с 3 по 9 марта	Полина Паничева	f	2025-03-03 05:50:00+00	Подборка мероприятий с 3 по 9 марта	https://minio.test.prof-stankin.ru/blog/7eff70a1-e4da-474b-b556-a97119f993f5.jpg	319	podborka-meropriiatii-s-3-po-9-marta
82f6e500-d40c-49e4-a8e5-db88e1378c47	Главные новости из мира студентов к 24 января	Maria	f	2025-01-24 06:30:14+00	Главные новости из мира студентов к 24 января	\N	523	glavnye-novosti-iz-mira-studentov-k-24-ianvaria
d422a67f-0c5e-4990-bdb3-45915d5bd200	Главные новости из мира студентов к 14 февраля	Maria	f	2025-02-14 06:11:44+00	Главные новости из мира студентов к 14 февраля	\N	748	glavnye-novosti-iz-mira-studentov-k-14-fevralia
dce49be9-8b04-4f46-811a-e91ff1414afa	Главные новости из мира студентов к 21 февраля	Maria	f	2025-02-21 06:12:18+00	Главные новости из мира студентов к 21 февраля	\N	801	glavnye-novosti-iz-mira-studentov-k-21-fevralia
be7c1f13-335c-43ba-8f55-88c9848cda93	Подборка мероприятий с 10 по 16 февраля	Полина Паничева	t	2025-02-09 17:57:28+00	Подборка мероприятий с 10 по 16 февраля	https://minio.test.prof-stankin.ru/blog/34d46104-e439-4f3f-8422-6f753c282f4a.jpg	481	podborka-meropriiatii-s-10-po-16-fevralia
2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	Уникальные события для студентов: не пропусти	Юлия Тиханова	f	2025-02-19 08:27:08+00	Уникальные события для студентов: не пропусти	https://minio.test.prof-stankin.ru/blog/1badc2f0-cc79-410d-9db5-8ef2df645c6c.png	736	unikalnye-sobytiia-dlia-studentov-ne-propusti
797fc8cd-5028-4c34-8d5a-6b3879638316	Подборка мероприятий с 17 по 23 февраля	Полина Паничева	t	2025-02-17 02:28:13+00	Подборка мероприятий с 17 по 23 февраля	https://minio.test.prof-stankin.ru/blog/69176a13-7c1a-40ce-bee4-cf8eb2525277.jpg	532	podborka-meropriiatii-s-17-po-23-fevralia
644bf45d-8b8e-4c9d-84ae-5219614bcb18	Главные новости из мира студентов к 7 февраля	Maria	f	2025-02-07 06:07:00+00	Главные новости из мира студентов к 7 февраля	https://minio.test.prof-stankin.ru/blog/e9925b75-0a05-4b3f-9245-9e42c7ffeee2.jpg	436	glavnye-novosti-iz-mira-studentov-k-7-fevralia
587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	Главные новости из мира студентов к 17 января	Maria	f	2025-01-17 06:21:49+00	Главные новости из мира студентов к 17 января	\N	307	glavnye-novosti-iz-mira-studentov-k-17-ianvaria
2a94109f-5702-45f5-a817-a85cf7dcde56	Главные новости из мира студентов к 31 января	Maria	f	2025-01-31 06:33:48+00	Главные новости из мира студентов к 31 января	\N	334	glavnye-novosti-iz-mira-studentov-k-31-ianvaria
6396bb3b-d41b-4e31-904e-11d9388093b0	Главные новости из мира студентов к 10 января	Maria	f	2025-01-10 07:00:00+00	Главные новости из мира студентов к 10 января	https://minio.test.prof-stankin.ru/blog/215b8d9b-8abe-4bbb-8c91-9a050f873370.png	522	glavnye-novosti-iz-mira-studentov-k-10-ianvaria
\.


--
-- Data for Name: blocks; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.blocks (id, article_id, "order", type) FROM stdin;
79275d78-6612-45af-b116-4359840b8bab	2f137f97-351a-4eeb-8344-44f4ee66f746	1	TextBlock
32678488-9831-4e26-b7f5-4021460ee714	2f137f97-351a-4eeb-8344-44f4ee66f746	3	ImageCollectionBlock
084504d1-e959-4426-a325-7da654674c5f	2f137f97-351a-4eeb-8344-44f4ee66f746	4	TextBlock
79ed349f-8d9c-4b74-bad1-357a6d9ea7cb	2f137f97-351a-4eeb-8344-44f4ee66f746	5	ImageCollectionBlock
7b26ca13-38ac-41cf-98f7-7556ef491a56	2f137f97-351a-4eeb-8344-44f4ee66f746	7	TextBlock
bc552d13-460f-4926-bf6f-0110b6ed037c	2f137f97-351a-4eeb-8344-44f4ee66f746	8	ImageCollectionBlock
a67a00a3-510c-4cd0-99e8-eaed93effda4	2f137f97-351a-4eeb-8344-44f4ee66f746	10	TextBlock
4eb25399-95d9-43aa-811a-464c3aa00e4b	2f137f97-351a-4eeb-8344-44f4ee66f746	11	ImageCollectionBlock
3be170d2-17d9-43fc-8c3a-ed4abfe4bc08	2f137f97-351a-4eeb-8344-44f4ee66f746	13	TextBlock
57f6925b-0b02-4e6e-a09c-546c604aa30f	2f137f97-351a-4eeb-8344-44f4ee66f746	14	ImageCollectionBlock
2ce18cd4-d531-4bb9-8334-5eb5c8198fc2	2f137f97-351a-4eeb-8344-44f4ee66f746	16	TextBlock
3df8ef8a-6163-4320-acef-58a23e606256	2f137f97-351a-4eeb-8344-44f4ee66f746	17	ImageCollectionBlock
1ef89301-3501-44a3-86dc-697815a6ad9f	2361d234-e5a8-4647-923d-2d2df92cdd96	1	TextBlock
b474207e-ca57-4e03-9719-43751e2e6afa	2361d234-e5a8-4647-923d-2d2df92cdd96	2	ImageCollectionBlock
af4c8bfc-7b40-46cc-a600-702cfc1910b2	2361d234-e5a8-4647-923d-2d2df92cdd96	4	TextBlock
b82e95c8-5e0d-495c-953a-28ecf143149e	2361d234-e5a8-4647-923d-2d2df92cdd96	5	ImageCollectionBlock
cb318bbd-499f-4b07-a64c-efeca4b7f20c	2361d234-e5a8-4647-923d-2d2df92cdd96	7	TextBlock
bb3757d6-2c52-4588-b566-df9c460d47d1	2361d234-e5a8-4647-923d-2d2df92cdd96	9	ImageCollectionBlock
2959629e-e521-435f-a616-d4e445dc781f	2361d234-e5a8-4647-923d-2d2df92cdd96	10	TextBlock
b11ea526-d5b5-45e6-9177-a808025ac2a4	2361d234-e5a8-4647-923d-2d2df92cdd96	12	ImageCollectionBlock
a780429e-d82f-41f1-a3e9-2563948a06c9	2361d234-e5a8-4647-923d-2d2df92cdd96	13	TextBlock
78c06203-d973-4585-8b9f-eb48bc30cf5e	2361d234-e5a8-4647-923d-2d2df92cdd96	15	ImageCollectionBlock
e571ef2a-2113-4307-8d0b-7c24ec245a6b	2361d234-e5a8-4647-923d-2d2df92cdd96	16	TextBlock
45532852-eea5-4de2-a8d4-c5507ea36cb0	2361d234-e5a8-4647-923d-2d2df92cdd96	18	ImageCollectionBlock
537b14ee-8f94-4fea-af3d-d42740d14042	8d6e3509-d67a-4d5b-a751-4bb1d0aa870a	1	TextBlock
e3e52087-61ee-499f-8250-f9e2402b98a9	8d6e3509-d67a-4d5b-a751-4bb1d0aa870a	3	ImageCollectionBlock
05738d39-b98f-44b7-b40b-a599c4379139	8d6e3509-d67a-4d5b-a751-4bb1d0aa870a	4	TextBlock
784adf94-0409-4c43-96fc-48a619940c54	8d6e3509-d67a-4d5b-a751-4bb1d0aa870a	6	ImageCollectionBlock
f3836cab-3963-44f8-970f-597070903b90	8d6e3509-d67a-4d5b-a751-4bb1d0aa870a	7	TextBlock
e0611f3d-b4b1-43d1-9691-0f7476c0fbfb	8d6e3509-d67a-4d5b-a751-4bb1d0aa870a	9	ImageCollectionBlock
2a8063d9-7d68-49b4-ad9c-34b231d1e8c4	8d6e3509-d67a-4d5b-a751-4bb1d0aa870a	10	TextBlock
3d7e5b5f-e598-4d6e-a23f-b9efcc05c95c	8d6e3509-d67a-4d5b-a751-4bb1d0aa870a	12	ImageCollectionBlock
6c09b44a-9900-4b05-b9de-74f8a242d635	8d6e3509-d67a-4d5b-a751-4bb1d0aa870a	13	TextBlock
6077abc0-7a85-4397-9819-ef710a9b6fa7	8d6e3509-d67a-4d5b-a751-4bb1d0aa870a	15	ImageCollectionBlock
76fb2d20-2fd5-4916-8872-c8d7c4c65391	8d6e3509-d67a-4d5b-a751-4bb1d0aa870a	16	TextBlock
202a827c-3f40-4304-997a-1dd90bf373ff	8d6e3509-d67a-4d5b-a751-4bb1d0aa870a	18	ImageCollectionBlock
0e57e37c-de1e-4bad-8399-ae89e3844f88	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	1	TextBlock
09a050ac-f3c5-4914-9681-1c0c7beb36b6	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	2	TextBlock
18bb768b-0b1a-44f5-91e7-4881919e9478	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	3	TextBlock
02b61656-ff93-4e1c-9b60-5768cace5302	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	4	TextBlock
8ecd9e8d-f020-402c-a682-b47e14ba05fe	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	5	TextBlock
f40529c3-5c7f-4b9b-a2b6-1d25b8cf9635	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	6	TextBlock
d4b8dd80-e5a1-4c69-b17e-0462ebd598bf	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	7	TextBlock
9437d91b-ba99-400c-8943-eb8a46fa241b	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	8	TextBlock
2d8e50e3-28ec-4843-9521-817893829177	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	9	TextBlock
e83cf270-8ee3-47f0-ab43-9defc66bfad1	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	10	TextBlock
470a7c07-1d22-4d36-8796-5f6a0bfb6f2b	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	11	TextBlock
3c02a6e1-1154-4be4-9f10-7e90db77b19b	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	12	TextBlock
b8034131-8946-4bc0-9580-9e373c202e6f	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	13	TextBlock
6786c5a4-4610-4edd-9e3d-eee5a5093506	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	14	TextBlock
645cebda-241d-4634-a0ce-4d6e826b7701	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	15	TextBlock
22bc81ba-5d87-448d-8f41-693b24bc9101	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	16	TextBlock
67a00973-6f12-4329-a56b-332ee6342974	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	17	TextBlock
c2b3ddbf-946e-46fa-838d-eb30ec8978cb	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	18	TextBlock
5f36e782-6575-4905-ab0e-0209e72a724c	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	19	TextBlock
c51d9928-4510-4e51-ad68-aa3ee4409c2d	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	20	TextBlock
927f172c-804c-4bae-b282-dd1459639167	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	21	TextBlock
d87a0786-d9e4-4607-8fcc-9b7c62f03a52	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	22	TextBlock
8907fe54-7758-4ee1-903e-c3638707ef6f	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	23	TextBlock
629cce5c-3013-4dc9-869c-38fcabb9c462	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	24	TextBlock
7632fa12-69c5-4beb-ade5-8cd66a31a160	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	25	TextBlock
6a98b09d-3043-4c4b-89c3-234912ed8fa0	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	26	TextBlock
048efec2-bb61-45c5-9459-fe69f0adddd3	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	27	TextBlock
0ca3e3eb-033e-4f97-8c32-34129f90b8e8	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	28	TextBlock
5cf3a9ee-9a17-4caf-afbe-f0c660751266	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	29	TextBlock
e7bca950-feb6-4a69-ab3b-83f8303dea1b	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	30	TextBlock
00b38b9b-7d06-42ff-81f6-3cc51c01d1ee	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	31	TextBlock
736ec887-d720-4292-b00f-01cdd8e82cab	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	32	TextBlock
537fd683-9bfb-4ae7-b263-d83ca75053e7	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	33	TextBlock
4f5499f3-0291-468a-8d14-31916a55da72	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	34	TextBlock
2cb453bd-4a80-4bb2-ae19-76b7910c37de	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	35	TextBlock
16e73f62-191e-4306-bcf9-62ef13a2af47	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	36	TextBlock
8311730f-28cf-4ba2-bfea-4871eda99be7	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	37	TextBlock
47e91d2b-8f4d-4d00-a3ff-165edc03e23b	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	38	TextBlock
8974b02d-aba5-4f7d-966d-cbf520912698	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	39	TextBlock
d1f5ef06-b745-44df-9111-d92f20c01987	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	40	TextBlock
f7cfb5b4-d3b9-4b87-b7cd-bcf14201b430	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	41	TextBlock
06f8884c-c241-4901-8d5d-be5905eaf715	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	42	TextBlock
d8866746-b94e-4568-8e0a-f16e209a88ec	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	43	TextBlock
2c45a306-b6bc-4090-96e9-85bc868ecdfd	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	44	TextBlock
742a2599-3868-454b-bb03-18bb1b897031	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	45	TextBlock
32498358-a8de-4301-a98c-1b3864c16277	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	46	TextBlock
dd136a97-f8e0-4f9b-94a2-db5a58759dd6	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	47	TextBlock
f09315e5-9149-4fb8-8c28-ae6415e87393	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	48	TextBlock
8b823ccb-4d0f-49b1-986a-4e7164725557	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	49	TextBlock
a38ed5c7-bdbc-4710-ada7-a06d3c75f5f5	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	50	TextBlock
df5517f7-428d-451c-b41a-d4a8041ff8b1	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	51	TextBlock
c111e528-515d-4b6d-ad65-c1bc0ccdc848	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	52	TextBlock
a3a384c8-7f18-4814-8777-aac4e41d1f56	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	53	TextBlock
fc520f2c-f10b-4d56-8748-b2a2a4fdba84	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	54	TextBlock
9498ae7f-ac04-42b3-8a1a-0cd48ce9ff0b	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	55	TextBlock
11bc430e-7534-4672-abf6-32eb04e68669	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	56	TextBlock
9414c483-1278-4f96-90bc-614b57ee029e	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	57	TextBlock
d6b553e0-b27e-4fdf-8e11-1d0a2415f4a9	b2f0fd80-69aa-4e1c-b449-d7771ef7871f	58	TextBlock
eb64c301-d968-47af-abdf-d6f87d1eab7b	62743e68-d2be-44f4-a3ed-27c9a715573c	1	TextBlock
1bb27b3c-6806-4051-a3a6-4ef0e1e47094	62743e68-d2be-44f4-a3ed-27c9a715573c	3	ImageCollectionBlock
eaa2e8c9-abd8-49ca-90f3-d46253a23ae2	62743e68-d2be-44f4-a3ed-27c9a715573c	4	TextBlock
5ba16cf2-b0aa-4481-8536-e54c26f1e8f8	62743e68-d2be-44f4-a3ed-27c9a715573c	7	ImageCollectionBlock
f66dca2f-fa8b-4daa-ad02-055340f31bbe	62743e68-d2be-44f4-a3ed-27c9a715573c	8	TextBlock
0b478be0-e423-4f80-b4bc-2441faa10ed9	62743e68-d2be-44f4-a3ed-27c9a715573c	10	ImageCollectionBlock
f78cfb14-41ed-4dba-8129-e50035abd073	62743e68-d2be-44f4-a3ed-27c9a715573c	11	TextBlock
292d8bc8-3d6c-43ab-ac0d-d39259b95694	62743e68-d2be-44f4-a3ed-27c9a715573c	13	ImageCollectionBlock
9bf76aec-b7a2-4c23-91b4-588b73dcfa5d	62743e68-d2be-44f4-a3ed-27c9a715573c	14	TextBlock
314aee11-9e19-4edb-88f9-06a94891a6f2	62743e68-d2be-44f4-a3ed-27c9a715573c	16	ImageCollectionBlock
44f0a012-c986-4ee7-a1b4-e1904d80188a	62743e68-d2be-44f4-a3ed-27c9a715573c	17	TextBlock
afffe4f7-88e8-49e7-885a-2ef50b473cfc	62743e68-d2be-44f4-a3ed-27c9a715573c	19	ImageCollectionBlock
d2b79f88-53ea-47aa-a59f-5611523df807	05537852-dc37-46cb-940b-e2b82f859a58	1	TextBlock
0ec4ff00-c210-4260-b856-8936537fd3c1	05537852-dc37-46cb-940b-e2b82f859a58	2	TextBlock
a1c1e05c-769f-43c9-86c9-a00f20e0c13b	05537852-dc37-46cb-940b-e2b82f859a58	3	ImageCollectionBlock
d5ccf002-0856-4b92-84f5-1f1dfd6c8a53	05537852-dc37-46cb-940b-e2b82f859a58	5	TextBlock
4deeb957-91e0-4219-a2c5-f990354759de	05537852-dc37-46cb-940b-e2b82f859a58	7	ImageCollectionBlock
cacbf5d7-ac48-4867-8561-f9bb9f35091c	05537852-dc37-46cb-940b-e2b82f859a58	8	TextBlock
f4b6b322-5794-4db1-b560-1da20c0bd2ea	05537852-dc37-46cb-940b-e2b82f859a58	9	TextBlock
b1096569-7614-4027-b176-95ffd10511d0	05537852-dc37-46cb-940b-e2b82f859a58	11	ImageCollectionBlock
38232d3a-dd24-4047-abba-f421bc4a792a	05537852-dc37-46cb-940b-e2b82f859a58	12	TextBlock
7a842a2f-ee15-442c-b0ff-8a755f5eaa0e	05537852-dc37-46cb-940b-e2b82f859a58	13	TextBlock
0043d1b7-07f0-47ac-8594-3814b560f81d	05537852-dc37-46cb-940b-e2b82f859a58	15	ImageCollectionBlock
3d3d017a-7920-4e7a-9ccb-43f4411bfd8e	05537852-dc37-46cb-940b-e2b82f859a58	16	TextBlock
e18a1cdc-63ab-43a4-9b6f-07cce1b5648d	05537852-dc37-46cb-940b-e2b82f859a58	18	ImageCollectionBlock
f6c0bc58-e54f-48a7-a545-1531896c1b50	05537852-dc37-46cb-940b-e2b82f859a58	19	TextBlock
d24823f9-1174-436b-8a66-a7e007988e09	05537852-dc37-46cb-940b-e2b82f859a58	21	ImageCollectionBlock
25aeb9bf-227c-491a-9b52-1fd26323ce66	5674b9e9-546b-4c13-be9a-07085261cd3e	1	TextBlock
5bcfdba1-9329-402f-b221-d699df2435e0	5674b9e9-546b-4c13-be9a-07085261cd3e	3	ImageCollectionBlock
bdee6668-8951-4ecf-88e3-d7dd038e0e95	5674b9e9-546b-4c13-be9a-07085261cd3e	4	TextBlock
592cc23d-5ef1-422e-b9b9-e29b8e87582a	5674b9e9-546b-4c13-be9a-07085261cd3e	6	ImageCollectionBlock
463dc934-15d1-4466-bde2-edbf35676451	5674b9e9-546b-4c13-be9a-07085261cd3e	7	TextBlock
7e72be4c-ef74-4c4d-8637-75cb17956e1c	5674b9e9-546b-4c13-be9a-07085261cd3e	9	ImageCollectionBlock
4081a7e9-cc30-4c7b-9637-8a3f883b293d	5674b9e9-546b-4c13-be9a-07085261cd3e	10	TextBlock
d0096f3c-0d2c-4840-8692-e78ed38ceebd	5674b9e9-546b-4c13-be9a-07085261cd3e	11	TextBlock
073df1fa-4356-4141-9de7-7c10853a90bf	5674b9e9-546b-4c13-be9a-07085261cd3e	13	ImageCollectionBlock
e297bee8-1efa-4f07-bf4d-add1d532ed21	5674b9e9-546b-4c13-be9a-07085261cd3e	14	TextBlock
82da36eb-fedb-450e-8e4a-221dcbca05a1	5674b9e9-546b-4c13-be9a-07085261cd3e	16	ImageCollectionBlock
451b2bc7-0674-44ef-9628-f6c4ab262428	5674b9e9-546b-4c13-be9a-07085261cd3e	17	TextBlock
ec0092a3-c2e3-401c-b8a1-9a688158bcb7	5674b9e9-546b-4c13-be9a-07085261cd3e	19	ImageCollectionBlock
a0f95493-91fb-48f6-be80-20903a546bd0	a6126e9c-7ee9-4a86-b051-42ae9d9fea36	1	TextBlock
89827795-58ad-4354-9b97-4b5c79159dae	a6126e9c-7ee9-4a86-b051-42ae9d9fea36	3	ImageCollectionBlock
038c8635-6e2a-4068-9dc9-a457bf2c9ef3	a6126e9c-7ee9-4a86-b051-42ae9d9fea36	4	TextBlock
d55f1a67-aacb-46b3-86fd-44dd0d6c2210	a6126e9c-7ee9-4a86-b051-42ae9d9fea36	6	ImageCollectionBlock
11e40d4e-8d7e-4a91-b80b-262e39bcbf17	a6126e9c-7ee9-4a86-b051-42ae9d9fea36	7	TextBlock
e21b5296-8e8a-4f30-96e0-0fce3202ccd5	a6126e9c-7ee9-4a86-b051-42ae9d9fea36	9	ImageCollectionBlock
099b958a-00ca-4f2d-a48f-6a3afd97f0dc	a6126e9c-7ee9-4a86-b051-42ae9d9fea36	10	TextBlock
6aaa11ba-54d1-4ac7-852c-4cd71aa3bfce	a6126e9c-7ee9-4a86-b051-42ae9d9fea36	12	ImageCollectionBlock
ffd1cd62-319a-4842-8c2e-2eeeb5900975	a6126e9c-7ee9-4a86-b051-42ae9d9fea36	13	TextBlock
de2b4a93-781f-4572-a9c1-890744ab59d4	a6126e9c-7ee9-4a86-b051-42ae9d9fea36	15	ImageCollectionBlock
4281bd1a-c7f8-4ca5-8a36-9313d66ce3bb	a6126e9c-7ee9-4a86-b051-42ae9d9fea36	16	TextBlock
7ba4aef6-bbd9-4eda-8165-4eb10e4b363e	a6126e9c-7ee9-4a86-b051-42ae9d9fea36	18	ImageCollectionBlock
a45b1900-4d07-42fa-aead-ae70531405ef	caeb619e-ed13-463c-935a-c17aebf53f1f	1	TextBlock
667a10d1-f846-4965-b390-7c685ab96ae5	caeb619e-ed13-463c-935a-c17aebf53f1f	2	TextBlock
7f4c7fb0-9669-4591-a584-d0ce4265117a	caeb619e-ed13-463c-935a-c17aebf53f1f	4	ImageCollectionBlock
1e17c59f-fbac-48ea-93f5-42efe787c35a	caeb619e-ed13-463c-935a-c17aebf53f1f	5	TextBlock
a1f456a0-3028-4e82-98d8-d41a24253d84	caeb619e-ed13-463c-935a-c17aebf53f1f	7	ImageCollectionBlock
c88ec3a8-0150-47dd-9169-c09b15fb5673	caeb619e-ed13-463c-935a-c17aebf53f1f	8	TextBlock
b14906b7-5085-441a-9282-df76506b238f	caeb619e-ed13-463c-935a-c17aebf53f1f	10	ImageCollectionBlock
f92c0736-4dd4-4615-bf83-b7d484307c58	caeb619e-ed13-463c-935a-c17aebf53f1f	11	TextBlock
12090288-3559-479a-91c9-2d8a66791aff	caeb619e-ed13-463c-935a-c17aebf53f1f	13	ImageCollectionBlock
dfe22432-eed4-428a-988d-638e7f66557b	caeb619e-ed13-463c-935a-c17aebf53f1f	14	TextBlock
9661e2e6-ff53-4756-bb22-9aee0e6086b6	caeb619e-ed13-463c-935a-c17aebf53f1f	16	ImageCollectionBlock
ebbd5313-8347-458b-97a8-df06ef739782	caeb619e-ed13-463c-935a-c17aebf53f1f	17	TextBlock
3615b9f9-ff8d-4d6f-977e-93805aa8ad25	caeb619e-ed13-463c-935a-c17aebf53f1f	19	ImageCollectionBlock
32a08d0f-eab1-4f79-84de-052bf95b6100	511080a8-5de0-4435-b468-6f857534bc60	1	TextBlock
74dcea7a-0498-4ec8-9851-3c7bafc1fc02	511080a8-5de0-4435-b468-6f857534bc60	3	ImageCollectionBlock
4994d72a-e806-401b-9bf6-c40566dad5ce	511080a8-5de0-4435-b468-6f857534bc60	4	TextBlock
75ad1921-9ca7-4255-9227-6673d80a656d	511080a8-5de0-4435-b468-6f857534bc60	6	ImageCollectionBlock
920455d3-f463-459f-82a6-e45d2ba9b8c4	511080a8-5de0-4435-b468-6f857534bc60	7	TextBlock
eeca43ac-f58a-4f1c-a117-197664941400	511080a8-5de0-4435-b468-6f857534bc60	9	ImageCollectionBlock
e80f3ce3-d6dd-40e8-8361-217f18ff74ec	511080a8-5de0-4435-b468-6f857534bc60	10	TextBlock
50f3da85-e34c-40c2-b3fa-95967c304d1f	511080a8-5de0-4435-b468-6f857534bc60	12	ImageCollectionBlock
afa711b2-054b-4fd3-9719-d5da791ed790	511080a8-5de0-4435-b468-6f857534bc60	13	TextBlock
ec7d090b-bc58-4893-9f00-bed95a5b6f07	511080a8-5de0-4435-b468-6f857534bc60	15	ImageCollectionBlock
28cdf79e-6356-451a-a301-c3dee912cd58	511080a8-5de0-4435-b468-6f857534bc60	16	TextBlock
b3f48516-5997-4b5d-81fc-5e565b6d84e0	511080a8-5de0-4435-b468-6f857534bc60	18	ImageCollectionBlock
718d580f-4dc9-4241-900f-a6ac7078f23f	ba29867b-8f30-4392-b2ec-02be36e38c3b	1	TextBlock
5cbd54d9-8c0a-4856-ad92-dc9faa08c962	ba29867b-8f30-4392-b2ec-02be36e38c3b	3	ImageCollectionBlock
29009a03-e908-4f36-964f-e3849bb83c6f	ba29867b-8f30-4392-b2ec-02be36e38c3b	4	TextBlock
cdfad19b-6ce4-4061-9d4b-8d95cb008ba6	ba29867b-8f30-4392-b2ec-02be36e38c3b	6	ImageCollectionBlock
dbb298dd-d4c2-4d48-9cbd-e980c26b3f32	ba29867b-8f30-4392-b2ec-02be36e38c3b	7	TextBlock
4792d689-b099-47be-8eec-47d096bb70b3	ba29867b-8f30-4392-b2ec-02be36e38c3b	9	ImageCollectionBlock
fe0fc905-d363-4a7b-b38d-4a5fa3da1a54	ba29867b-8f30-4392-b2ec-02be36e38c3b	10	TextBlock
d0981c80-551b-4b46-a0db-6b2a70a789a2	ba29867b-8f30-4392-b2ec-02be36e38c3b	11	TextBlock
d97e9cac-505e-4205-8498-665252a9dd2b	ba29867b-8f30-4392-b2ec-02be36e38c3b	13	ImageCollectionBlock
754f4a77-073d-4f6a-83fd-f63c6595796e	ba29867b-8f30-4392-b2ec-02be36e38c3b	14	TextBlock
7a5559e2-5b66-47f8-885d-fe61a3a4b0ad	ba29867b-8f30-4392-b2ec-02be36e38c3b	16	ImageCollectionBlock
2d0b056f-1ede-42de-a752-a206502f3fa5	ba29867b-8f30-4392-b2ec-02be36e38c3b	17	TextBlock
e70ec373-31f6-4c4b-aaec-01be1692cbfd	ba29867b-8f30-4392-b2ec-02be36e38c3b	18	TextBlock
2e718230-e102-4b2e-939e-e15fdf92b93b	ba29867b-8f30-4392-b2ec-02be36e38c3b	20	ImageCollectionBlock
6ba0a1d7-3474-44c7-9c63-a2c6ff53f647	e7967ae1-b97f-407b-842d-cf954c178242	1	TextBlock
73a48740-e5fe-482d-98c8-778810787767	e7967ae1-b97f-407b-842d-cf954c178242	3	ImageCollectionBlock
e336b171-62f1-4aba-bf80-97f8735ae93c	e7967ae1-b97f-407b-842d-cf954c178242	4	TextBlock
2d157f58-f66c-41f6-ba98-bcba1f5dc316	e7967ae1-b97f-407b-842d-cf954c178242	6	ImageCollectionBlock
e49f3106-169f-4dbe-a689-f00c68f48ef7	e7967ae1-b97f-407b-842d-cf954c178242	7	TextBlock
91fd64b5-fe2f-4430-a258-f148c1fca04b	e7967ae1-b97f-407b-842d-cf954c178242	9	ImageCollectionBlock
daf3bba0-cc6c-4e81-91ad-76fb68e8bb83	e7967ae1-b97f-407b-842d-cf954c178242	10	TextBlock
517be2e2-7dc3-4967-86f6-870b65cd0d59	e7967ae1-b97f-407b-842d-cf954c178242	12	ImageCollectionBlock
319230ec-8ed8-474a-b52a-a38d39aa599b	e7967ae1-b97f-407b-842d-cf954c178242	13	TextBlock
5f1d217a-8804-46e8-9005-75f73ccc75ff	e7967ae1-b97f-407b-842d-cf954c178242	15	ImageCollectionBlock
1312ac9f-46e5-4a40-9598-c9d5e4be7d5c	e7967ae1-b97f-407b-842d-cf954c178242	16	TextBlock
587b0dc6-3302-4381-ab7a-e6ef4c944c67	e7967ae1-b97f-407b-842d-cf954c178242	18	ImageCollectionBlock
e0814989-f286-43a4-a8bf-cde76d471eba	8f1fd2a3-cfc8-42b0-a73a-f7e62442e291	1	TextBlock
c8bdfdc3-1487-4144-8a26-3ae2f11a1b37	8f1fd2a3-cfc8-42b0-a73a-f7e62442e291	3	ImageCollectionBlock
d92ec52c-b206-4b2a-b903-4eae43de10a5	8f1fd2a3-cfc8-42b0-a73a-f7e62442e291	4	TextBlock
82ab6573-e03b-4070-a612-0590fb9569e1	8f1fd2a3-cfc8-42b0-a73a-f7e62442e291	6	ImageCollectionBlock
eaceebf0-8485-4a04-9a7c-beb45ab4e2b8	8f1fd2a3-cfc8-42b0-a73a-f7e62442e291	7	TextBlock
5ae5c633-1b5f-4574-bd56-e33e86dbac05	8f1fd2a3-cfc8-42b0-a73a-f7e62442e291	8	TextBlock
cf564307-e6c9-4746-abd9-34fc46a8abde	8f1fd2a3-cfc8-42b0-a73a-f7e62442e291	10	ImageCollectionBlock
6679ef5b-2cf7-4435-80d7-737dcd7d65fb	8f1fd2a3-cfc8-42b0-a73a-f7e62442e291	11	TextBlock
97560425-b4e1-4671-b8b4-861fdac87dd0	8f1fd2a3-cfc8-42b0-a73a-f7e62442e291	13	ImageCollectionBlock
23fa02e6-6c28-4885-9813-7db164ff67fc	8f1fd2a3-cfc8-42b0-a73a-f7e62442e291	14	TextBlock
49293c4d-41a0-415b-a042-1c342b819905	8f1fd2a3-cfc8-42b0-a73a-f7e62442e291	16	ImageCollectionBlock
b10069d4-0b03-4fc5-8926-a9554ec598f3	8f1fd2a3-cfc8-42b0-a73a-f7e62442e291	17	TextBlock
b00a2e90-b02a-468d-a304-fd7f4b43d396	8f1fd2a3-cfc8-42b0-a73a-f7e62442e291	19	ImageCollectionBlock
e4fa1add-e687-460d-802f-02c13d44378f	efe994fe-c8d2-4b1b-90d0-7e65feab1f39	1	TextBlock
0a36729f-13d4-4988-9c5b-e423f061082f	efe994fe-c8d2-4b1b-90d0-7e65feab1f39	3	ImageCollectionBlock
d4dc6fea-2fb6-454e-a506-60e04734def8	efe994fe-c8d2-4b1b-90d0-7e65feab1f39	4	TextBlock
60bc0c45-b1e3-4b9a-8dcb-51be408efaac	efe994fe-c8d2-4b1b-90d0-7e65feab1f39	6	ImageCollectionBlock
0e15153c-1870-438b-a98d-d2be6e3f6992	efe994fe-c8d2-4b1b-90d0-7e65feab1f39	7	TextBlock
2dba9265-66ae-4a53-b9d0-b6887e133bd6	efe994fe-c8d2-4b1b-90d0-7e65feab1f39	9	ImageCollectionBlock
b7eb8f3f-4730-4842-9c51-53a2e59d69fd	efe994fe-c8d2-4b1b-90d0-7e65feab1f39	10	TextBlock
74000c5b-153e-49ca-b97c-f83648481525	efe994fe-c8d2-4b1b-90d0-7e65feab1f39	12	ImageCollectionBlock
dff73365-2f24-4fc2-b9c8-12166477c7a3	efe994fe-c8d2-4b1b-90d0-7e65feab1f39	13	TextBlock
d6726c67-0d7a-4b96-86f9-25254bf6a0e7	efe994fe-c8d2-4b1b-90d0-7e65feab1f39	14	TextBlock
0ebf785e-7d8c-4544-a4cb-5d57def53a6c	efe994fe-c8d2-4b1b-90d0-7e65feab1f39	16	ImageCollectionBlock
e833ce1a-1d52-4e64-afcb-e2daebee6f13	efe994fe-c8d2-4b1b-90d0-7e65feab1f39	17	TextBlock
751fadb1-29b4-429b-bd9e-262a30a891c8	efe994fe-c8d2-4b1b-90d0-7e65feab1f39	19	ImageCollectionBlock
ace4673b-a9a7-4f8b-baa0-5c6f80defa58	e9596051-5e7f-4610-9cb2-429f65820557	1	TextBlock
b2f0a138-a85c-43f3-983a-ea3ecb6fca54	e9596051-5e7f-4610-9cb2-429f65820557	3	ImageCollectionBlock
dc536111-1a6d-4657-9d66-79aa130a7f3e	e9596051-5e7f-4610-9cb2-429f65820557	4	TextBlock
8bfb166e-4223-4ebb-9de5-9b35d5757b99	e9596051-5e7f-4610-9cb2-429f65820557	6	ImageCollectionBlock
fa71fc24-d5de-48e3-a1b7-572beff3656e	e9596051-5e7f-4610-9cb2-429f65820557	7	TextBlock
6fee22c1-0c57-4671-b8d5-c37243e2216d	e9596051-5e7f-4610-9cb2-429f65820557	8	TextBlock
b04b7661-80fd-4a2e-8a52-1a02b353b950	e9596051-5e7f-4610-9cb2-429f65820557	10	ImageCollectionBlock
ccda0441-2b68-41f1-964d-3fd5f8a3639f	e9596051-5e7f-4610-9cb2-429f65820557	11	TextBlock
4a8731fa-24ca-406f-a1cc-dc02916660cf	e9596051-5e7f-4610-9cb2-429f65820557	12	TextBlock
31c48381-9b7d-4dbc-b01e-a156e8d73664	e9596051-5e7f-4610-9cb2-429f65820557	14	ImageCollectionBlock
b45497c1-013f-4344-9277-1036a1230087	e9596051-5e7f-4610-9cb2-429f65820557	15	TextBlock
1e1b507e-31be-4858-818d-9b41d28bb0d2	e9596051-5e7f-4610-9cb2-429f65820557	17	ImageCollectionBlock
657cdd04-aa2a-4069-9eee-cab5000953be	e9596051-5e7f-4610-9cb2-429f65820557	18	TextBlock
d8d16349-ab15-4c57-b50a-75845a9bfff3	e9596051-5e7f-4610-9cb2-429f65820557	19	TextBlock
8973180a-bbe4-487a-95d2-19aa02e0f6c3	e9596051-5e7f-4610-9cb2-429f65820557	21	ImageCollectionBlock
6d9b3c22-903c-4c00-ad59-80b8a80474d8	acfee5c5-42c5-4bfb-8cb0-44da268b4e46	1	TextBlock
35b8776f-de16-4069-bda5-ab5fa642ae63	acfee5c5-42c5-4bfb-8cb0-44da268b4e46	3	ImageCollectionBlock
3fc740ae-ff5f-46f9-9cec-77c5e0d95185	acfee5c5-42c5-4bfb-8cb0-44da268b4e46	4	TextBlock
0815999b-09b9-466b-9d35-5567ecf2a79c	acfee5c5-42c5-4bfb-8cb0-44da268b4e46	6	ImageCollectionBlock
745ba9b4-3e9b-4334-8f64-6133dff8ff05	acfee5c5-42c5-4bfb-8cb0-44da268b4e46	7	TextBlock
34b57cb9-2d72-4424-bb14-8935dcdcf4f9	acfee5c5-42c5-4bfb-8cb0-44da268b4e46	8	TextBlock
1aa80110-1f6a-4776-a6d5-44a43901f649	acfee5c5-42c5-4bfb-8cb0-44da268b4e46	10	ImageCollectionBlock
a1a9c443-fd65-446e-a554-5228d21030c8	acfee5c5-42c5-4bfb-8cb0-44da268b4e46	11	TextBlock
a1388310-85ed-49b7-9f37-38da1291c50e	acfee5c5-42c5-4bfb-8cb0-44da268b4e46	13	ImageCollectionBlock
b393e86e-c227-4238-8a6a-6cbd72b28d6a	acfee5c5-42c5-4bfb-8cb0-44da268b4e46	14	TextBlock
e6fadd27-dfaf-4989-9f51-21d535233933	acfee5c5-42c5-4bfb-8cb0-44da268b4e46	15	TextBlock
df3e0e8e-af0b-4c4b-ad76-cd51f9422c46	acfee5c5-42c5-4bfb-8cb0-44da268b4e46	17	ImageCollectionBlock
918b2c94-aac4-4461-8e0b-ffc019d91f17	acfee5c5-42c5-4bfb-8cb0-44da268b4e46	18	TextBlock
53083a50-5c36-4f15-969b-0839e5cac016	acfee5c5-42c5-4bfb-8cb0-44da268b4e46	20	ImageCollectionBlock
ab145ce9-5679-4818-a89a-c111c877a503	991b2659-578e-468f-96d2-912c0510a0ad	1	TextBlock
037a403d-2d3a-4bb0-90cd-de3ea8a9e2a0	991b2659-578e-468f-96d2-912c0510a0ad	3	ImageCollectionBlock
c995bb74-822d-4a82-b849-d8ba98278148	991b2659-578e-468f-96d2-912c0510a0ad	4	TextBlock
c1eb6879-ea58-460c-bb92-983070110cd3	991b2659-578e-468f-96d2-912c0510a0ad	6	ImageCollectionBlock
50c24df9-040a-4b83-99d3-00545a142b78	991b2659-578e-468f-96d2-912c0510a0ad	7	TextBlock
6b24d95a-9cdb-422f-b38e-8f87b183c4ab	991b2659-578e-468f-96d2-912c0510a0ad	8	TextBlock
84f6c2fb-47d4-4813-82e3-c70d8526e0a4	991b2659-578e-468f-96d2-912c0510a0ad	9	ImageCollectionBlock
60ed66e0-cb37-4419-bbd0-65b47a6bbf20	991b2659-578e-468f-96d2-912c0510a0ad	11	TextBlock
963ad1c6-ed05-4f51-b0dc-1e2a770da23f	991b2659-578e-468f-96d2-912c0510a0ad	13	ImageCollectionBlock
75f9d62d-6604-4d0e-9b4f-5731ce6485ac	991b2659-578e-468f-96d2-912c0510a0ad	14	TextBlock
aacccf52-0b95-496e-bbe8-627960fc87ca	991b2659-578e-468f-96d2-912c0510a0ad	16	ImageCollectionBlock
f3801b18-03ca-412b-972f-62677e687d1b	991b2659-578e-468f-96d2-912c0510a0ad	17	TextBlock
bfc81126-97e3-469f-92c0-ba3471796984	991b2659-578e-468f-96d2-912c0510a0ad	18	TextBlock
caacb723-ed00-4bee-9133-ee62bc671c6a	991b2659-578e-468f-96d2-912c0510a0ad	20	ImageCollectionBlock
e615bb55-a10f-45a8-a92e-474e5d399e69	55d18753-0062-46f3-b123-d9ccabcb0e11	1	TextBlock
35dfa643-6076-4c60-9706-c67e9f0abf41	55d18753-0062-46f3-b123-d9ccabcb0e11	3	ImageCollectionBlock
99d1aabc-14db-485b-aaf7-eee5046671ab	55d18753-0062-46f3-b123-d9ccabcb0e11	4	TextBlock
e5ddd32b-2027-4610-a133-d0ad15b83885	55d18753-0062-46f3-b123-d9ccabcb0e11	5	TextBlock
d2a37068-58f5-451d-a65a-b87361d1c726	55d18753-0062-46f3-b123-d9ccabcb0e11	7	ImageCollectionBlock
07c12652-c636-4eec-b7ae-c6d57d33b6c0	55d18753-0062-46f3-b123-d9ccabcb0e11	8	TextBlock
26fdcdae-431a-4fe1-b6d3-879cf27a2dc0	55d18753-0062-46f3-b123-d9ccabcb0e11	10	ImageCollectionBlock
4a916a9b-82d0-4c4e-aab7-f398b015c025	55d18753-0062-46f3-b123-d9ccabcb0e11	11	TextBlock
62474038-ec46-40d5-ba99-5038d127fa2c	55d18753-0062-46f3-b123-d9ccabcb0e11	13	ImageCollectionBlock
8c0d9446-d5c3-4b61-8789-1f6adcc632c9	55d18753-0062-46f3-b123-d9ccabcb0e11	14	TextBlock
3c0bfecf-5309-4d49-8cb6-59639baa7e8b	55d18753-0062-46f3-b123-d9ccabcb0e11	16	ImageCollectionBlock
5f64d1cf-f1cb-48f7-a491-d6ab03d488c5	55d18753-0062-46f3-b123-d9ccabcb0e11	17	TextBlock
166dc915-c9b9-476f-b975-e6769f47fc0f	55d18753-0062-46f3-b123-d9ccabcb0e11	19	ImageCollectionBlock
2b9e5c0a-0d22-410f-959f-629bdb84095e	c6dd0f3d-01bc-4447-89b0-6709c96cd25d	1	TextBlock
76a12569-4e9d-4b87-9807-4ccc19e6efa2	c6dd0f3d-01bc-4447-89b0-6709c96cd25d	3	ImageCollectionBlock
41ba50e0-1df1-41e4-a297-38916e095805	c6dd0f3d-01bc-4447-89b0-6709c96cd25d	4	TextBlock
040ce2ac-8f3b-4966-bcf3-d95f039a9ac7	c6dd0f3d-01bc-4447-89b0-6709c96cd25d	5	TextBlock
f3429ab1-891d-4d9a-8ccb-cd3006e87abd	c6dd0f3d-01bc-4447-89b0-6709c96cd25d	7	ImageCollectionBlock
25804377-4adb-45ce-bd19-d52110b1d6fc	c6dd0f3d-01bc-4447-89b0-6709c96cd25d	8	TextBlock
dc915d68-fe22-4faa-9363-517b446da9b0	c6dd0f3d-01bc-4447-89b0-6709c96cd25d	10	ImageCollectionBlock
e0f55865-6fc7-4cd0-8a30-a2c371da36cf	c6dd0f3d-01bc-4447-89b0-6709c96cd25d	11	TextBlock
efa34b03-a160-47f1-93ae-91177bdfae41	c6dd0f3d-01bc-4447-89b0-6709c96cd25d	13	ImageCollectionBlock
f4d5be75-45c4-4571-a2ef-07c56c4c5288	c6dd0f3d-01bc-4447-89b0-6709c96cd25d	14	TextBlock
f9b40e3d-dd5e-4d2e-b455-2b2a61cf9db2	c6dd0f3d-01bc-4447-89b0-6709c96cd25d	16	ImageCollectionBlock
a6b9d269-95c2-4a2c-9e0f-26660ea97858	c6dd0f3d-01bc-4447-89b0-6709c96cd25d	17	TextBlock
b2f7b9be-70c0-47e9-bb99-235fc52baabd	c6dd0f3d-01bc-4447-89b0-6709c96cd25d	18	TextBlock
52d6b995-ec97-4be5-ac03-3e079f634bec	c6dd0f3d-01bc-4447-89b0-6709c96cd25d	20	ImageCollectionBlock
2ce38fa6-bc7e-442c-ab38-acf8b61a10ea	3f6e8d01-0b1f-4b82-8979-05120329b730	1	TextBlock
2f736bbf-3c70-48fe-9962-2f75bd09dedc	3f6e8d01-0b1f-4b82-8979-05120329b730	3	ImageCollectionBlock
bda91c4b-e7f7-4f50-9812-aba30f48d7a3	3f6e8d01-0b1f-4b82-8979-05120329b730	4	TextBlock
1d3f5549-1bd6-4dba-a6be-d6332a4b6407	3f6e8d01-0b1f-4b82-8979-05120329b730	6	ImageCollectionBlock
cfaf63e5-e397-4597-8f64-90ad1f87965e	3f6e8d01-0b1f-4b82-8979-05120329b730	7	TextBlock
fae13cbb-23f5-43e8-a5d4-748eed002257	3f6e8d01-0b1f-4b82-8979-05120329b730	9	ImageCollectionBlock
53a8b306-b194-45b2-9d30-5cac69a4da04	3f6e8d01-0b1f-4b82-8979-05120329b730	10	TextBlock
d16782a7-8adc-40e6-b2b3-2340f4fa033b	3f6e8d01-0b1f-4b82-8979-05120329b730	12	ImageCollectionBlock
5ae2c3ea-a04b-4349-a267-293c33144029	3f6e8d01-0b1f-4b82-8979-05120329b730	13	TextBlock
9bcf78f2-4afc-4511-9db8-d1c43cb96968	3f6e8d01-0b1f-4b82-8979-05120329b730	15	ImageCollectionBlock
bd152967-3a71-41c9-bc5e-4dace1455b22	3f6e8d01-0b1f-4b82-8979-05120329b730	16	TextBlock
f4309f12-3f73-4579-8f0c-ea81d5bd4ba2	3f6e8d01-0b1f-4b82-8979-05120329b730	18	ImageCollectionBlock
a5201c1c-e705-466c-abac-0a27dc7e9d02	f7a518a6-68ed-42fe-b043-ee412d003155	1	TextBlock
2f47e4b0-a495-4903-bc23-adef7dd88f32	f7a518a6-68ed-42fe-b043-ee412d003155	3	ImageCollectionBlock
934eeaa5-9c09-45bc-8490-62c4ed65068b	f7a518a6-68ed-42fe-b043-ee412d003155	4	TextBlock
410c0060-05c2-4106-a3ad-8dab0db296aa	f7a518a6-68ed-42fe-b043-ee412d003155	5	TextBlock
4e316daf-02b5-4a32-be59-9b720c24c346	f7a518a6-68ed-42fe-b043-ee412d003155	7	ImageCollectionBlock
4f992d6b-f8c6-4d0f-b75b-0bd97dc33c96	f7a518a6-68ed-42fe-b043-ee412d003155	8	TextBlock
c17aa0cf-5aab-4847-8cdd-da90173b27f2	f7a518a6-68ed-42fe-b043-ee412d003155	10	ImageCollectionBlock
07ca308f-47a0-4856-b74c-a9127ba8bf06	f7a518a6-68ed-42fe-b043-ee412d003155	11	TextBlock
326459c6-5466-4b26-8e7d-d8ba78c1674d	f7a518a6-68ed-42fe-b043-ee412d003155	13	ImageCollectionBlock
9d774492-d16b-461a-88ed-d92c3d5034f4	f7a518a6-68ed-42fe-b043-ee412d003155	14	TextBlock
df5bd9c4-1cdb-45ff-91f0-c36c64a3dd10	f7a518a6-68ed-42fe-b043-ee412d003155	16	ImageCollectionBlock
c490949e-a9c9-45cf-8e10-79c81c33cb7a	f7a518a6-68ed-42fe-b043-ee412d003155	17	TextBlock
706d0c2d-a1d6-4e28-80da-fa0140d48d87	f7a518a6-68ed-42fe-b043-ee412d003155	19	ImageCollectionBlock
bcbf95db-f528-4f67-8fee-1862f52b1058	75d165f1-7b1c-495a-b0e6-3137f5c62480	1	TextBlock
bb92d241-5c58-449f-9948-4a593feab6fa	75d165f1-7b1c-495a-b0e6-3137f5c62480	4	TextBlock
65d2c1c0-bdc9-496a-8ec5-49963e44f232	75d165f1-7b1c-495a-b0e6-3137f5c62480	5	TextBlock
059d580b-5fdb-4d6c-8f0a-5ec78fc69d73	75d165f1-7b1c-495a-b0e6-3137f5c62480	7	ImageCollectionBlock
10423e5c-b839-4dae-8f74-6888470b947c	75d165f1-7b1c-495a-b0e6-3137f5c62480	8	TextBlock
2ba3ea99-d315-4a1e-b628-39362ba19813	75d165f1-7b1c-495a-b0e6-3137f5c62480	10	ImageCollectionBlock
14ffd52f-59bc-49c7-8d6e-e2874bc8cc22	75d165f1-7b1c-495a-b0e6-3137f5c62480	11	TextBlock
66e16639-d50c-4917-ac02-b9d6f8a84b9b	75d165f1-7b1c-495a-b0e6-3137f5c62480	13	ImageCollectionBlock
2a0f028b-1983-4c04-bf92-0ae488048567	75d165f1-7b1c-495a-b0e6-3137f5c62480	14	TextBlock
f4a921b8-d26f-4b64-98af-e9d1562d4742	75d165f1-7b1c-495a-b0e6-3137f5c62480	16	ImageCollectionBlock
f6bf9e15-8965-4a82-90b0-829c17b92212	75d165f1-7b1c-495a-b0e6-3137f5c62480	17	TextBlock
6cfe0b72-8465-4317-9e7a-3639eeda68d8	75d165f1-7b1c-495a-b0e6-3137f5c62480	19	ImageCollectionBlock
a1d5e218-f272-462f-80cd-ddc6733ddf0e	a3e5c918-bd4c-437d-a881-c694cf50ddda	1	TextBlock
ac25e90a-061f-40cb-9f5e-8c0dc15abc0d	a3e5c918-bd4c-437d-a881-c694cf50ddda	2	TextBlock
30e91f39-c449-4aab-938a-8a53b9d242c4	a3e5c918-bd4c-437d-a881-c694cf50ddda	4	ImageCollectionBlock
a4d3d0fa-f774-4df4-933a-afaa2595e915	a3e5c918-bd4c-437d-a881-c694cf50ddda	5	TextBlock
f7e094d2-38c3-4547-a3cd-a0c109a8f703	a3e5c918-bd4c-437d-a881-c694cf50ddda	7	ImageCollectionBlock
6220c8aa-aed2-4715-8106-6fabba65d4f7	a3e5c918-bd4c-437d-a881-c694cf50ddda	8	TextBlock
e2b13da3-083d-4398-9535-52aef710fe49	a3e5c918-bd4c-437d-a881-c694cf50ddda	10	ImageCollectionBlock
a8b77706-02a7-4393-b46f-9eff1fd5a835	a3e5c918-bd4c-437d-a881-c694cf50ddda	11	TextBlock
5b056835-1ae6-40ea-a4ae-914f029c0a92	a3e5c918-bd4c-437d-a881-c694cf50ddda	14	ImageCollectionBlock
fa2b0470-9b46-4a90-b02a-69a57f7f7e29	a3e5c918-bd4c-437d-a881-c694cf50ddda	15	TextBlock
66478b5c-06f1-4808-b4cf-deda2baf7179	a3e5c918-bd4c-437d-a881-c694cf50ddda	17	ImageCollectionBlock
e22c63ce-2fdf-4dfd-9a7d-72d36cfcf57b	a3e5c918-bd4c-437d-a881-c694cf50ddda	18	TextBlock
f04d5904-a70a-4696-9094-189c75569558	a3e5c918-bd4c-437d-a881-c694cf50ddda	20	ImageCollectionBlock
4d22fd3b-b1ed-4e00-b813-180a8499963e	733fec57-4749-4ff1-b3ad-9d220acb9f39	1	TextBlock
e4a96482-3d2c-4827-a21a-7d0d44267d35	733fec57-4749-4ff1-b3ad-9d220acb9f39	2	TextBlock
b433a7ab-fa50-4dba-9f92-65b59b2fd851	733fec57-4749-4ff1-b3ad-9d220acb9f39	3	TextBlock
03938940-77ae-4306-b5bf-7a438092f830	733fec57-4749-4ff1-b3ad-9d220acb9f39	4	TextBlock
79094a9a-d502-459d-9db5-120044a4be32	733fec57-4749-4ff1-b3ad-9d220acb9f39	5	TextBlock
89c77c69-55f0-4e21-9ac2-4163c607af58	733fec57-4749-4ff1-b3ad-9d220acb9f39	6	TextBlock
048dde84-e88d-41a3-b752-b146378fbc3f	733fec57-4749-4ff1-b3ad-9d220acb9f39	7	TextBlock
db130c56-46da-4a76-a754-edf048262d7b	733fec57-4749-4ff1-b3ad-9d220acb9f39	8	TextBlock
580a8f5d-9c2f-4c13-b847-aa81cdb59276	733fec57-4749-4ff1-b3ad-9d220acb9f39	9	TextBlock
e9fd50ca-f77a-4497-98ca-19f8564a53c2	733fec57-4749-4ff1-b3ad-9d220acb9f39	10	TextBlock
0e884a35-7ae3-41e2-bf3f-3fbe6d420701	733fec57-4749-4ff1-b3ad-9d220acb9f39	11	TextBlock
aa9e18f1-b934-4298-9677-4bb53d0d0819	733fec57-4749-4ff1-b3ad-9d220acb9f39	12	TextBlock
2fe47537-4f79-46fa-8f99-1066b121ffad	733fec57-4749-4ff1-b3ad-9d220acb9f39	13	TextBlock
06e3f30e-522f-4b76-9387-7b121c3a22ab	733fec57-4749-4ff1-b3ad-9d220acb9f39	14	TextBlock
52ae4c72-5190-4207-beb3-bf250a5b802b	733fec57-4749-4ff1-b3ad-9d220acb9f39	15	TextBlock
60c9ff8b-32b0-44a1-ac4d-497978346e20	733fec57-4749-4ff1-b3ad-9d220acb9f39	16	TextBlock
a1f910fe-f473-45eb-be79-a2a9400ef155	733fec57-4749-4ff1-b3ad-9d220acb9f39	17	TextBlock
bf2f75c4-dc20-41f3-bb00-5b48386d0bd6	733fec57-4749-4ff1-b3ad-9d220acb9f39	18	TextBlock
2b00d7b2-e3fc-4f5b-a025-fc6e3db9dacb	733fec57-4749-4ff1-b3ad-9d220acb9f39	19	TextBlock
9e072150-1494-48da-b691-ae39dba455d8	733fec57-4749-4ff1-b3ad-9d220acb9f39	20	TextBlock
fa394ba2-f1c1-451a-b9af-c1c6ff1ffd2d	733fec57-4749-4ff1-b3ad-9d220acb9f39	21	TextBlock
5a808087-490f-45f2-8582-233b9a6b0fd2	733fec57-4749-4ff1-b3ad-9d220acb9f39	22	TextBlock
19575260-e2d4-4b7f-aa55-9b3a93eb0afe	733fec57-4749-4ff1-b3ad-9d220acb9f39	23	TextBlock
e7d81190-bc69-49f6-83fb-24efada64002	733fec57-4749-4ff1-b3ad-9d220acb9f39	24	TextBlock
bc80a500-ec43-479c-b4e6-ed85e17bd18e	733fec57-4749-4ff1-b3ad-9d220acb9f39	25	TextBlock
abcf3aba-9745-4f5a-9148-95ee5db41e10	733fec57-4749-4ff1-b3ad-9d220acb9f39	26	TextBlock
57d65710-56f1-4cf8-9a11-892866921bca	733fec57-4749-4ff1-b3ad-9d220acb9f39	27	TextBlock
27012a82-c5c2-45da-9643-91b1b4b6d790	733fec57-4749-4ff1-b3ad-9d220acb9f39	28	TextBlock
5351bab9-1bb8-4642-8ae1-68890f5868b9	dc725529-a77e-4a4f-ab4c-cc1e1288fa9a	1	TextBlock
9933ac3b-53a5-4156-96c3-f1985a1248df	dc725529-a77e-4a4f-ab4c-cc1e1288fa9a	3	ImageCollectionBlock
4739cd9c-1905-476a-a757-8d2ccbb0490d	dc725529-a77e-4a4f-ab4c-cc1e1288fa9a	4	TextBlock
5230f99f-b9ed-476d-852e-461f9d0e1d46	dc725529-a77e-4a4f-ab4c-cc1e1288fa9a	6	ImageCollectionBlock
f5118af7-8779-4388-8bcf-43e9e3525ca3	dc725529-a77e-4a4f-ab4c-cc1e1288fa9a	7	TextBlock
48353f6e-5e51-4b6d-8fa5-b3e1cddfd403	dc725529-a77e-4a4f-ab4c-cc1e1288fa9a	9	ImageCollectionBlock
3a6ab826-5d5f-4ba3-8ce8-4d9dc2471670	dc725529-a77e-4a4f-ab4c-cc1e1288fa9a	10	TextBlock
803fd33c-12aa-43a2-a175-f3f540762ba5	dc725529-a77e-4a4f-ab4c-cc1e1288fa9a	12	ImageCollectionBlock
ae036ac0-9cfe-4648-9d98-ba22a8bc2bea	dc725529-a77e-4a4f-ab4c-cc1e1288fa9a	13	TextBlock
aff3df65-1f5f-43ba-9245-78bfe84d3ae1	dc725529-a77e-4a4f-ab4c-cc1e1288fa9a	15	ImageCollectionBlock
f5a82601-4915-4b99-a319-0e4720146144	dc725529-a77e-4a4f-ab4c-cc1e1288fa9a	16	TextBlock
aae1a1fd-fdb1-4796-b410-1384212f6325	dc725529-a77e-4a4f-ab4c-cc1e1288fa9a	18	ImageCollectionBlock
ec176922-f6c6-41fa-8023-33ee5f4fad09	82f97d3c-2184-472b-aed8-0779d41a40de	1	TextBlock
165f4663-86d7-470b-9339-149e4a953210	82f97d3c-2184-472b-aed8-0779d41a40de	3	ImageCollectionBlock
063d1ad7-09da-40c6-a75f-385d656bba6a	82f97d3c-2184-472b-aed8-0779d41a40de	4	TextBlock
5399c3a4-75fd-4c75-b970-3674c71631d9	82f97d3c-2184-472b-aed8-0779d41a40de	6	ImageCollectionBlock
6708c5fa-52cc-4dea-ac05-c996a36c1f68	82f97d3c-2184-472b-aed8-0779d41a40de	7	TextBlock
e7f0b372-40fa-4afe-9301-2d0518a9bfd8	82f97d3c-2184-472b-aed8-0779d41a40de	9	ImageCollectionBlock
af92dc1b-a285-4712-95c5-aae67b338b73	82f97d3c-2184-472b-aed8-0779d41a40de	10	TextBlock
afd1d9c8-9a36-435c-b4a7-f72cc55c9adc	82f97d3c-2184-472b-aed8-0779d41a40de	12	ImageCollectionBlock
f44e1619-32a3-42ca-ac1c-c262595698e1	82f97d3c-2184-472b-aed8-0779d41a40de	13	TextBlock
4880a1cd-4221-4f3d-be3f-4cc4cba3f91f	82f97d3c-2184-472b-aed8-0779d41a40de	14	TextBlock
32ec52d8-5c85-4cd0-a4de-d5d268bc3b9f	82f97d3c-2184-472b-aed8-0779d41a40de	16	ImageCollectionBlock
f2606a70-00fa-45ba-97fb-42b8960514bd	82f97d3c-2184-472b-aed8-0779d41a40de	17	TextBlock
6c0a9dca-9eb2-4206-9c91-77149429f199	82f97d3c-2184-472b-aed8-0779d41a40de	19	ImageCollectionBlock
56cba811-2fb2-4c61-910d-4000d9780178	eec4b6b9-323e-4a55-900f-5f792ff7d4fb	1	TextBlock
8b0463b4-5175-4d24-bfe6-e3a5cbda42fe	eec4b6b9-323e-4a55-900f-5f792ff7d4fb	3	ImageCollectionBlock
25493a3c-4d9f-4b8a-9f81-1f135ee39339	eec4b6b9-323e-4a55-900f-5f792ff7d4fb	4	TextBlock
e3ef668b-0dba-4e15-b12e-08c40415fe95	eec4b6b9-323e-4a55-900f-5f792ff7d4fb	6	ImageCollectionBlock
9f71635c-b7a3-4bce-adcd-ef9c66bd7cde	eec4b6b9-323e-4a55-900f-5f792ff7d4fb	7	TextBlock
3546ddf7-02c5-4500-95b9-dcb6bb24e4db	eec4b6b9-323e-4a55-900f-5f792ff7d4fb	9	ImageCollectionBlock
c8352c42-cd5b-400f-948b-86ec7badae87	eec4b6b9-323e-4a55-900f-5f792ff7d4fb	10	TextBlock
7564a5be-8144-4780-a6a8-be8a59af760e	eec4b6b9-323e-4a55-900f-5f792ff7d4fb	12	ImageCollectionBlock
1057f232-5c65-46d1-b690-810c37c1d4a8	eec4b6b9-323e-4a55-900f-5f792ff7d4fb	13	TextBlock
4cb1bd9b-4975-4612-a9e7-d14f5f2138d8	eec4b6b9-323e-4a55-900f-5f792ff7d4fb	15	ImageCollectionBlock
2cfdb598-92f1-4b09-8795-df0274d62643	eec4b6b9-323e-4a55-900f-5f792ff7d4fb	16	TextBlock
cb9b5993-9940-4f63-a20f-a160d7d00900	eec4b6b9-323e-4a55-900f-5f792ff7d4fb	17	TextBlock
44f801a8-0868-4bdc-bd27-ef5b04856366	eec4b6b9-323e-4a55-900f-5f792ff7d4fb	19	ImageCollectionBlock
26dd1d42-9ae2-43a0-9431-bc01e2290ad5	6cfc882c-fdda-4d2e-b391-323fc477938f	1	TextBlock
0cbf7032-c814-4703-9e48-bfdd030f792b	6cfc882c-fdda-4d2e-b391-323fc477938f	3	ImageCollectionBlock
09f9db36-90fa-4ee3-8fd1-27377ea82362	6cfc882c-fdda-4d2e-b391-323fc477938f	4	TextBlock
36e97dba-2957-492c-82ba-d7586a1ddb23	6cfc882c-fdda-4d2e-b391-323fc477938f	6	ImageCollectionBlock
c6bb4a60-99ed-4437-8c17-1ed3adcc6317	6cfc882c-fdda-4d2e-b391-323fc477938f	7	TextBlock
15b08e5e-6bf6-4c2f-b462-00318d29e3b7	6cfc882c-fdda-4d2e-b391-323fc477938f	9	ImageCollectionBlock
14d33695-a8f1-4a1a-9790-1599efaec8d1	6cfc882c-fdda-4d2e-b391-323fc477938f	10	TextBlock
d173d8b5-21d8-4261-bce2-d39a951efac2	6cfc882c-fdda-4d2e-b391-323fc477938f	12	ImageCollectionBlock
c322dda9-258e-4538-9719-0b37d8fb27b4	6cfc882c-fdda-4d2e-b391-323fc477938f	13	TextBlock
88e0479c-9f10-4007-b113-416190b4af9d	6cfc882c-fdda-4d2e-b391-323fc477938f	15	ImageCollectionBlock
dea14f92-f9fd-4efe-a8e7-227a9d134261	6cfc882c-fdda-4d2e-b391-323fc477938f	16	TextBlock
804d11eb-6f77-4a37-bbe6-47151b632993	6cfc882c-fdda-4d2e-b391-323fc477938f	17	TextBlock
2dd5cd1b-7586-4493-85da-50705f0bad03	6cfc882c-fdda-4d2e-b391-323fc477938f	19	ImageCollectionBlock
4b1afe05-34da-4e38-8a82-858687ed03fa	dfbefbd7-94c3-4c8a-ae06-17475691a9b4	1	TextBlock
b82fc686-80d9-4c15-b761-e2b5ab500358	dfbefbd7-94c3-4c8a-ae06-17475691a9b4	2	TextBlock
33039b4d-8553-44a8-be0b-7f9356515f34	dfbefbd7-94c3-4c8a-ae06-17475691a9b4	4	ImageCollectionBlock
40a54948-5931-478c-9f0e-dc7dc6a33a16	dfbefbd7-94c3-4c8a-ae06-17475691a9b4	5	TextBlock
d8bd7db2-e465-47f1-8061-d1a461878f6b	dfbefbd7-94c3-4c8a-ae06-17475691a9b4	7	ImageCollectionBlock
100fd5fa-66b3-4f8c-a7c6-36547838385b	dfbefbd7-94c3-4c8a-ae06-17475691a9b4	8	TextBlock
f92015cc-9621-4729-a65d-47c3973b8726	dfbefbd7-94c3-4c8a-ae06-17475691a9b4	10	ImageCollectionBlock
52d4b6f4-4722-4ece-8374-ec1b69abef23	dfbefbd7-94c3-4c8a-ae06-17475691a9b4	11	TextBlock
7cffb866-1791-4288-a566-cef8de991149	dfbefbd7-94c3-4c8a-ae06-17475691a9b4	12	TextBlock
1b3be1a9-5009-4c24-b04b-522c34cfd25d	dfbefbd7-94c3-4c8a-ae06-17475691a9b4	14	ImageCollectionBlock
2feadb86-399f-4122-985d-7aefa1cd4154	dfbefbd7-94c3-4c8a-ae06-17475691a9b4	15	TextBlock
a9236c6b-2158-4dd9-90a2-2b9c25d8a7ed	dfbefbd7-94c3-4c8a-ae06-17475691a9b4	17	ImageCollectionBlock
06aeefe9-f5de-4f44-86d4-0a0f951dc2ac	dfbefbd7-94c3-4c8a-ae06-17475691a9b4	18	TextBlock
b9e56bd1-8536-4211-aa4e-a98176a57cb5	dfbefbd7-94c3-4c8a-ae06-17475691a9b4	19	TextBlock
d4f43282-3e7d-4709-b260-1db2ca2cdf96	dfbefbd7-94c3-4c8a-ae06-17475691a9b4	21	ImageCollectionBlock
55264ef7-65d9-49bd-9da2-31f790df8bc9	d9fcf459-21fb-4c3b-ad9d-2823d5a0d9b5	1	TextBlock
e472e3a3-c145-480e-b613-feebc050d66c	d9fcf459-21fb-4c3b-ad9d-2823d5a0d9b5	3	ImageCollectionBlock
c3549fec-0fc6-43a4-b4e3-8626e3224987	d9fcf459-21fb-4c3b-ad9d-2823d5a0d9b5	4	TextBlock
633e2d15-d6ae-4b37-aa98-732db3a7c88d	d9fcf459-21fb-4c3b-ad9d-2823d5a0d9b5	6	ImageCollectionBlock
9782ccd5-2202-4125-8f0e-3965eabe9984	d9fcf459-21fb-4c3b-ad9d-2823d5a0d9b5	7	TextBlock
9e3eb3a1-8338-4bb7-a96b-b8a6af0f801e	d9fcf459-21fb-4c3b-ad9d-2823d5a0d9b5	9	ImageCollectionBlock
b86b43e2-171f-46a6-86dc-af1882d5b643	d9fcf459-21fb-4c3b-ad9d-2823d5a0d9b5	10	TextBlock
41f2ef81-c39c-472c-960a-6942201d3c8c	d9fcf459-21fb-4c3b-ad9d-2823d5a0d9b5	12	ImageCollectionBlock
9b61ae5e-208c-45aa-bf6f-33626ca85339	d9fcf459-21fb-4c3b-ad9d-2823d5a0d9b5	13	TextBlock
70b6847f-0b73-47d8-a716-ae94ea3c3275	d9fcf459-21fb-4c3b-ad9d-2823d5a0d9b5	15	ImageCollectionBlock
9492fcd2-f4ae-4de9-b44c-396f73f03f06	d9fcf459-21fb-4c3b-ad9d-2823d5a0d9b5	16	TextBlock
fee91af5-9865-4693-8357-447d89d0d12e	d9fcf459-21fb-4c3b-ad9d-2823d5a0d9b5	18	ImageCollectionBlock
4014c507-97c8-4658-9ca6-f5ef78422853	e567131b-80fb-4dbe-900f-313352e851d4	1	TextBlock
89b8088c-3ff8-4b59-9321-ace68d77afc2	e567131b-80fb-4dbe-900f-313352e851d4	3	ImageCollectionBlock
91e06404-1624-46d1-9981-d03025cc3b30	e567131b-80fb-4dbe-900f-313352e851d4	4	TextBlock
00b85b27-db42-42f3-9bf7-45b1616c88eb	e567131b-80fb-4dbe-900f-313352e851d4	5	TextBlock
cbce3dda-1175-46d4-893c-4aa5f3801c46	e567131b-80fb-4dbe-900f-313352e851d4	7	ImageCollectionBlock
293c47d5-217e-4746-833b-d9df5b670354	e567131b-80fb-4dbe-900f-313352e851d4	8	TextBlock
279cf539-9025-485e-9fbb-6eea6da0e02c	e567131b-80fb-4dbe-900f-313352e851d4	9	TextBlock
aabd5547-4297-42c3-afa5-4a10a5e3f9cd	e567131b-80fb-4dbe-900f-313352e851d4	11	ImageCollectionBlock
e785d551-f209-47ae-8e2b-9f9458e5e01f	e567131b-80fb-4dbe-900f-313352e851d4	12	TextBlock
0de0d8af-6289-4791-b1c4-5c1ad58eb847	e567131b-80fb-4dbe-900f-313352e851d4	14	ImageCollectionBlock
a94a9efd-a6e0-4d80-a3d2-8cf9e67aa9aa	e567131b-80fb-4dbe-900f-313352e851d4	15	TextBlock
882d56eb-5430-42e6-88b0-cc1a318d9325	e567131b-80fb-4dbe-900f-313352e851d4	17	ImageCollectionBlock
c3644d5f-75ed-4fb9-bbac-689bda91ce3d	e567131b-80fb-4dbe-900f-313352e851d4	18	TextBlock
2a6e5e46-c338-4297-8041-923d90123e70	e567131b-80fb-4dbe-900f-313352e851d4	20	ImageCollectionBlock
1930271f-eccc-48ef-a607-047b5ca95beb	a5889b1b-3559-440a-a20b-df1aaf9b3ea6	1	TextBlock
4821d252-f0c1-4e92-82fb-b2edeb5f3b27	a5889b1b-3559-440a-a20b-df1aaf9b3ea6	3	ImageCollectionBlock
e5edaae2-c55b-4833-8e55-5b2b33fc57b8	a5889b1b-3559-440a-a20b-df1aaf9b3ea6	4	TextBlock
7afc266a-6b36-467d-aacd-8dadbbc455a6	a5889b1b-3559-440a-a20b-df1aaf9b3ea6	5	TextBlock
a4fa2a01-9447-41f8-8567-eda4bcb02dbf	a5889b1b-3559-440a-a20b-df1aaf9b3ea6	7	ImageCollectionBlock
8c515158-2e44-4bbc-9fac-09e7a30cd55d	a5889b1b-3559-440a-a20b-df1aaf9b3ea6	8	TextBlock
717b8a55-b8e2-4bad-88a0-bd6bdcbdee37	a5889b1b-3559-440a-a20b-df1aaf9b3ea6	9	TextBlock
60ebfd14-65f9-4191-9fbe-104d5a3bdcb7	a5889b1b-3559-440a-a20b-df1aaf9b3ea6	11	ImageCollectionBlock
8cf3e826-5f33-4a7b-8f46-ca986bf422bc	a5889b1b-3559-440a-a20b-df1aaf9b3ea6	12	TextBlock
b1aca649-c862-42c3-a7c9-024d58414149	a5889b1b-3559-440a-a20b-df1aaf9b3ea6	14	ImageCollectionBlock
edb15b00-1c86-4e4b-be75-eeceb491b58b	a5889b1b-3559-440a-a20b-df1aaf9b3ea6	15	TextBlock
507469f3-5939-4c99-93f5-e8db727cae44	a5889b1b-3559-440a-a20b-df1aaf9b3ea6	17	ImageCollectionBlock
554765a0-48c6-4dd1-89aa-66767ddf6536	a5889b1b-3559-440a-a20b-df1aaf9b3ea6	18	TextBlock
ce43103b-dd08-46cb-b72f-f5ab323ff038	a5889b1b-3559-440a-a20b-df1aaf9b3ea6	20	ImageCollectionBlock
02f4d2cb-1e75-4441-b54e-427369ab2d1d	6c88625f-51b0-4073-ad22-e5bd957b5835	1	TextBlock
eed24f58-8fe7-41b6-b63a-9239b7eebc2f	6c88625f-51b0-4073-ad22-e5bd957b5835	2	TextBlock
7484d899-ae4d-4c64-808c-44d0a2a1f9df	6c88625f-51b0-4073-ad22-e5bd957b5835	3	TextBlock
c7fee522-155e-4da4-8730-4ef82b661777	6c88625f-51b0-4073-ad22-e5bd957b5835	4	TextBlock
82cf443e-cf94-43f2-8fb6-6ba21f5bc91b	6c88625f-51b0-4073-ad22-e5bd957b5835	5	TextBlock
51d3e63e-3aa6-4396-a703-c3dda58f0e17	be62c475-da85-4b99-b907-b7995b529713	1	TextBlock
f23195e1-1f3c-476c-a426-7aaa8f5734af	be62c475-da85-4b99-b907-b7995b529713	3	ImageCollectionBlock
e3d3ce13-b4b8-434c-846e-89828867896f	be62c475-da85-4b99-b907-b7995b529713	4	TextBlock
2a9d84ff-8aeb-4ed7-933c-ff29bfca6e16	be62c475-da85-4b99-b907-b7995b529713	6	ImageCollectionBlock
eff69031-8bdf-4ddc-ac70-75c8e9b753cf	be62c475-da85-4b99-b907-b7995b529713	7	TextBlock
1880d68b-5cd6-4631-8ef3-97044caf9775	be62c475-da85-4b99-b907-b7995b529713	9	ImageCollectionBlock
b4f90b42-e464-4878-9d82-c39196890b4f	be62c475-da85-4b99-b907-b7995b529713	10	TextBlock
4b441243-e3bf-4047-bff3-60acf4815943	be62c475-da85-4b99-b907-b7995b529713	11	TextBlock
3d0be395-1e80-4ea2-8ce3-e73cc0c1db1a	be62c475-da85-4b99-b907-b7995b529713	13	ImageCollectionBlock
aedceef4-4ef0-402d-921d-e73282dbf1c3	be62c475-da85-4b99-b907-b7995b529713	14	TextBlock
adb1e8e1-2f9c-48bd-b3cc-b85f5b215c68	be62c475-da85-4b99-b907-b7995b529713	16	ImageCollectionBlock
9a163b86-04e6-4d84-b4a7-892ecebbd0ef	be62c475-da85-4b99-b907-b7995b529713	17	TextBlock
390e4b6d-b9ba-4983-bc79-ed695566606d	be62c475-da85-4b99-b907-b7995b529713	19	ImageCollectionBlock
3210cd16-4cc9-4b98-8869-a59592e2d3cf	cef63d87-7067-4c8b-94fe-fdadb9380111	1	TextBlock
80dcd263-3f5f-433b-899a-50ffb470ba04	cef63d87-7067-4c8b-94fe-fdadb9380111	3	ImageCollectionBlock
e2bd8529-c271-48e9-ac21-4a94f31c9ce5	cef63d87-7067-4c8b-94fe-fdadb9380111	4	TextBlock
eab98fec-aadc-4ce3-a7e1-f9caba0c6d8b	cef63d87-7067-4c8b-94fe-fdadb9380111	6	ImageCollectionBlock
301d7977-225f-480f-8c6d-4ee4a5d67f41	cef63d87-7067-4c8b-94fe-fdadb9380111	7	TextBlock
80e2afb7-8f46-4180-93bd-3bae7b36d3ce	cef63d87-7067-4c8b-94fe-fdadb9380111	9	ImageCollectionBlock
0f73cc5f-9184-4450-899b-37509d7c9a73	cef63d87-7067-4c8b-94fe-fdadb9380111	10	TextBlock
50a6354d-179d-475e-a472-56553d726e5d	cef63d87-7067-4c8b-94fe-fdadb9380111	12	ImageCollectionBlock
a7fcb2c9-2f96-483f-8594-2f2477f5465c	cef63d87-7067-4c8b-94fe-fdadb9380111	13	TextBlock
d7e59bc1-458e-4fcf-ac56-7957c8b970d8	cef63d87-7067-4c8b-94fe-fdadb9380111	15	ImageCollectionBlock
c84ac6ab-1c91-4c52-b603-7666493b5e9c	cef63d87-7067-4c8b-94fe-fdadb9380111	16	TextBlock
dd0deea4-387b-4c67-95a0-0d70613308ec	cef63d87-7067-4c8b-94fe-fdadb9380111	18	ImageCollectionBlock
7a498406-74a4-47c1-baeb-fbf325e9aa81	9d23018e-5d27-4f37-a8af-520180bea276	1	TextBlock
f62dfae1-5831-4209-a6fa-fa7a79158e13	9d23018e-5d27-4f37-a8af-520180bea276	2	TextBlock
e9ea5126-395f-433a-8a75-d684fbcc4af0	9d23018e-5d27-4f37-a8af-520180bea276	4	ImageCollectionBlock
af081d23-44a2-4802-ae68-63e228e5ae1c	9d23018e-5d27-4f37-a8af-520180bea276	5	TextBlock
dce68be6-2ed8-45de-a7ac-3c5c96e6455b	9d23018e-5d27-4f37-a8af-520180bea276	7	ImageCollectionBlock
4314a7e5-c301-4c00-9ae1-36d604f4808b	9d23018e-5d27-4f37-a8af-520180bea276	8	TextBlock
48234def-7982-4096-8f45-a3d8fff445e3	9d23018e-5d27-4f37-a8af-520180bea276	10	ImageCollectionBlock
62de8c38-688a-4326-b372-e6bacada1c26	9d23018e-5d27-4f37-a8af-520180bea276	11	TextBlock
0e8eb5f4-1b14-477a-b0d1-e1551d81554b	9d23018e-5d27-4f37-a8af-520180bea276	13	ImageCollectionBlock
866f4467-9a87-4dc5-9b33-a7f0af042786	9d23018e-5d27-4f37-a8af-520180bea276	14	TextBlock
568a0153-97a1-4fe0-af8f-ab4b4f5ee4e3	9d23018e-5d27-4f37-a8af-520180bea276	16	ImageCollectionBlock
a520f5a0-bd18-4bab-975c-03a47181d273	9d23018e-5d27-4f37-a8af-520180bea276	17	TextBlock
b64c157c-141b-49b5-8a30-1e1c7f45fe9e	9d23018e-5d27-4f37-a8af-520180bea276	19	ImageCollectionBlock
a4711d7c-7d8e-441e-8456-d76f61628ac8	be27b1e3-3a28-4101-9dfb-76354cf4ab0c	1	TextBlock
0df6e27f-d920-40cd-aae6-4165b4d6d6f0	be27b1e3-3a28-4101-9dfb-76354cf4ab0c	3	ImageCollectionBlock
cbafcc6e-4fb5-4fb1-be63-3c36395d7baf	be27b1e3-3a28-4101-9dfb-76354cf4ab0c	4	TextBlock
49b4b633-c950-40b4-87fb-ef03c65a9055	be27b1e3-3a28-4101-9dfb-76354cf4ab0c	6	ImageCollectionBlock
a96d230c-be99-4ded-a68e-352270951fb5	be27b1e3-3a28-4101-9dfb-76354cf4ab0c	7	TextBlock
32b48018-260e-4a05-9565-e63f6c00dbb0	be27b1e3-3a28-4101-9dfb-76354cf4ab0c	9	ImageCollectionBlock
3ae23a8b-7a76-409b-8efc-293ec686eb54	be27b1e3-3a28-4101-9dfb-76354cf4ab0c	10	TextBlock
b7742340-934f-49f4-8b9b-2ac670acaaae	be27b1e3-3a28-4101-9dfb-76354cf4ab0c	12	ImageCollectionBlock
7f8de363-d3f5-40a8-b52d-a5ecdd326cdc	be27b1e3-3a28-4101-9dfb-76354cf4ab0c	13	TextBlock
38695da5-86aa-412d-acf9-2cd97d6b2b5f	be27b1e3-3a28-4101-9dfb-76354cf4ab0c	14	TextBlock
fb2d4ba2-34c8-4cf9-ae1b-38197a76f2bf	be27b1e3-3a28-4101-9dfb-76354cf4ab0c	16	ImageCollectionBlock
f1809388-adff-4a73-9e68-d24d2047ef40	be27b1e3-3a28-4101-9dfb-76354cf4ab0c	17	TextBlock
4d021bb5-f4b8-45b3-b4dc-7889abf5f60a	be27b1e3-3a28-4101-9dfb-76354cf4ab0c	18	TextBlock
f1844c1a-f1a2-420d-a101-2506213f0cff	be27b1e3-3a28-4101-9dfb-76354cf4ab0c	20	ImageCollectionBlock
003f43a3-b5fa-4593-84f5-cabd69b28d3c	d0a84377-73b9-4549-825c-32273374606b	1	TextBlock
16217dcf-51fd-49d1-9ee6-989198cdaf33	d0a84377-73b9-4549-825c-32273374606b	2	TextBlock
22c73cc5-8957-49e3-91cd-5537384943a4	d0a84377-73b9-4549-825c-32273374606b	3	TextBlock
fe705a6f-2ab9-40b0-956f-3209d0af32c0	d0a84377-73b9-4549-825c-32273374606b	4	TextBlock
fbfeb5f8-90bf-4f55-a802-01c031d72826	d0a84377-73b9-4549-825c-32273374606b	5	TextBlock
8c8a0014-23ec-42ac-863d-75b9de3cb8c8	d0a84377-73b9-4549-825c-32273374606b	6	TextBlock
268ff503-8150-4180-b7d4-6f518a3b5ad6	d0a84377-73b9-4549-825c-32273374606b	8	ImageCollectionBlock
329df443-2a4e-409d-b927-69798f495279	d0a84377-73b9-4549-825c-32273374606b	9	TextBlock
e2de178c-d27e-4f1b-a57e-875f3a895efc	d0a84377-73b9-4549-825c-32273374606b	10	TextBlock
ddee2aa5-2246-4eb8-aaaf-b266d29a9438	d0a84377-73b9-4549-825c-32273374606b	12	ImageCollectionBlock
f374cb9f-c03e-43bd-a006-900441f6a8f8	d0a84377-73b9-4549-825c-32273374606b	13	TextBlock
5622098a-0656-4375-b87e-68a73991b242	b8c77a18-dcac-41bd-93d9-474b1ee680c6	1	TextBlock
a59fc31c-8739-4dc5-a744-a1d80b595337	b8c77a18-dcac-41bd-93d9-474b1ee680c6	3	ImageCollectionBlock
14c0dbd4-c255-49aa-99d0-a75aa947400c	b8c77a18-dcac-41bd-93d9-474b1ee680c6	4	TextBlock
18d5bc53-9bf0-4319-8250-e654e72a63c2	b8c77a18-dcac-41bd-93d9-474b1ee680c6	6	ImageCollectionBlock
3dbede3f-86e6-47ec-8169-90837e3a1375	b8c77a18-dcac-41bd-93d9-474b1ee680c6	7	TextBlock
5431fa56-c6fc-444b-86ca-5edc12caa8ba	b8c77a18-dcac-41bd-93d9-474b1ee680c6	9	ImageCollectionBlock
498f644e-7df4-43c2-b4e9-4abd3aa88ee5	b8c77a18-dcac-41bd-93d9-474b1ee680c6	10	TextBlock
588ed0a0-f063-457f-b747-9917bd0e9d23	b8c77a18-dcac-41bd-93d9-474b1ee680c6	12	ImageCollectionBlock
e067fa6c-c088-41ea-b36a-a448bb4947b2	b8c77a18-dcac-41bd-93d9-474b1ee680c6	13	TextBlock
24a5749f-ab77-470f-b043-ce9531a4a0fc	b8c77a18-dcac-41bd-93d9-474b1ee680c6	15	ImageCollectionBlock
20bc6bc6-27e5-40e4-ae0d-bfb16336a54f	b8c77a18-dcac-41bd-93d9-474b1ee680c6	16	TextBlock
fac2f2a8-e838-46b4-aa48-b684e3e5a102	b8c77a18-dcac-41bd-93d9-474b1ee680c6	18	ImageCollectionBlock
964931e5-309d-455a-95a4-726e3afa8941	2f97bdc8-24e5-4531-8eb3-aca402ddcab1	1	TextBlock
d6504593-1f01-496d-a05c-a889b18d799c	2f97bdc8-24e5-4531-8eb3-aca402ddcab1	3	ImageCollectionBlock
36e49c2a-8f96-445f-9d78-a02d98f9d532	2f97bdc8-24e5-4531-8eb3-aca402ddcab1	4	TextBlock
5d82fbc2-b24a-498d-bce8-aa63c9a5ffb8	2f97bdc8-24e5-4531-8eb3-aca402ddcab1	6	ImageCollectionBlock
0be5e976-1bc3-475c-8cf2-2119bc902e4a	2f97bdc8-24e5-4531-8eb3-aca402ddcab1	7	TextBlock
216a2caf-988d-4bc7-9281-3ef4124d9276	2f97bdc8-24e5-4531-8eb3-aca402ddcab1	8	TextBlock
6158e4de-e192-4414-9978-5b4fa86c161b	2f97bdc8-24e5-4531-8eb3-aca402ddcab1	10	ImageCollectionBlock
f5ba8170-dccc-44aa-a199-14cb31af4ab9	2f97bdc8-24e5-4531-8eb3-aca402ddcab1	11	TextBlock
7d2bb3fa-319c-4be4-bdc3-706092c1446c	2f97bdc8-24e5-4531-8eb3-aca402ddcab1	13	ImageCollectionBlock
4600498c-606e-4a37-b598-eef5e29d06b0	2f97bdc8-24e5-4531-8eb3-aca402ddcab1	14	TextBlock
06d8bfb1-481e-4a26-907a-9128a6441bbd	2f97bdc8-24e5-4531-8eb3-aca402ddcab1	16	ImageCollectionBlock
d66f2f49-61b2-487b-b630-ecd6cb7331c1	2f97bdc8-24e5-4531-8eb3-aca402ddcab1	17	TextBlock
2c850be0-48b4-4088-b11e-7da4c6406bc1	2f97bdc8-24e5-4531-8eb3-aca402ddcab1	19	ImageCollectionBlock
aa87a760-34a5-4af3-80d7-7389aa2d19ba	95ce7e87-31c5-4fd6-8bff-4230a124c825	1	TextBlock
2dbf7a7e-b33b-48dd-82a2-3be2b772dbe7	95ce7e87-31c5-4fd6-8bff-4230a124c825	2	TextBlock
3804da53-36a7-4238-aa2a-958f54af92ae	95ce7e87-31c5-4fd6-8bff-4230a124c825	4	ImageCollectionBlock
9bcffb9a-3b1f-4819-874b-db61bec0fbc8	95ce7e87-31c5-4fd6-8bff-4230a124c825	5	TextBlock
f36eee19-fba4-49cc-8ba6-4b26d597fbf8	95ce7e87-31c5-4fd6-8bff-4230a124c825	6	TextBlock
802df78e-e1d8-4909-ba1c-cc3c08839da8	95ce7e87-31c5-4fd6-8bff-4230a124c825	8	ImageCollectionBlock
cf63a05b-2362-4493-8be9-b562b5450fd5	95ce7e87-31c5-4fd6-8bff-4230a124c825	9	TextBlock
3218ce10-3c5b-4a61-8b9b-42e957d69438	95ce7e87-31c5-4fd6-8bff-4230a124c825	10	TextBlock
b38c83ac-3351-47d3-b68d-5b69543f39f7	95ce7e87-31c5-4fd6-8bff-4230a124c825	12	ImageCollectionBlock
218f888f-6290-4ad4-a4ad-92296019a3c9	95ce7e87-31c5-4fd6-8bff-4230a124c825	13	TextBlock
77ae61c9-66c1-41db-b10c-8a6d236197c5	95ce7e87-31c5-4fd6-8bff-4230a124c825	15	ImageCollectionBlock
127ccd1b-8903-4823-ad32-8cf565131d1a	95ce7e87-31c5-4fd6-8bff-4230a124c825	16	TextBlock
6df1d347-85ab-4fa6-bd67-a7614f035f65	95ce7e87-31c5-4fd6-8bff-4230a124c825	18	ImageCollectionBlock
e30b315d-dc6a-4f95-abb1-5a8958e9f903	95ce7e87-31c5-4fd6-8bff-4230a124c825	19	TextBlock
0ba5f9d6-5f71-4d75-9874-4b97cb9e8f8b	95ce7e87-31c5-4fd6-8bff-4230a124c825	21	ImageCollectionBlock
8be2c278-3bc4-4a2f-a6ab-092876c4784d	dce49be9-8b04-4f46-811a-e91ff1414afa	1	ImageCollectionBlock
6bd2c327-9041-4c62-80d6-92fdc24a8634	dce49be9-8b04-4f46-811a-e91ff1414afa	3	TextBlock
3348bbba-8a09-4608-b601-9c3ac36999fa	dce49be9-8b04-4f46-811a-e91ff1414afa	4	TextBlock
3fd30232-6b67-4642-b119-709f109eac64	dce49be9-8b04-4f46-811a-e91ff1414afa	6	ImageCollectionBlock
a0befc30-6163-48fb-a66c-581e085269b3	dce49be9-8b04-4f46-811a-e91ff1414afa	7	TextBlock
7553d3a2-9084-4821-ae3e-637d7c47d0cd	dce49be9-8b04-4f46-811a-e91ff1414afa	8	TextBlock
0e6735fd-3add-40b5-9e5c-b9fd9e149b2c	dce49be9-8b04-4f46-811a-e91ff1414afa	10	ImageCollectionBlock
402babdb-9082-4e9d-8aad-23cbd62a43cd	dce49be9-8b04-4f46-811a-e91ff1414afa	11	TextBlock
2cdd6528-3d5e-4014-aa9b-17ee7e573b8a	dce49be9-8b04-4f46-811a-e91ff1414afa	12	TextBlock
58d914e0-4288-4cad-896d-cce067487061	dce49be9-8b04-4f46-811a-e91ff1414afa	14	ImageCollectionBlock
0ab7f45f-711f-4b38-b57c-b01e334bef48	dce49be9-8b04-4f46-811a-e91ff1414afa	15	TextBlock
bd90062f-db68-4ca9-ae91-f0050efa1a58	dce49be9-8b04-4f46-811a-e91ff1414afa	16	TextBlock
53e85388-8a2b-4af1-a55f-4598669a3845	dce49be9-8b04-4f46-811a-e91ff1414afa	18	ImageCollectionBlock
d7350a43-6f3d-48a9-9fe5-71ee83810740	dce49be9-8b04-4f46-811a-e91ff1414afa	19	TextBlock
3c887599-1971-4499-9f86-d127039633eb	dce49be9-8b04-4f46-811a-e91ff1414afa	20	TextBlock
f7dde8bb-2bea-4a77-8098-b5f35576979f	dce49be9-8b04-4f46-811a-e91ff1414afa	22	ImageCollectionBlock
49965b01-766f-40d6-9c3f-992445a61940	dce49be9-8b04-4f46-811a-e91ff1414afa	23	TextBlock
4be92717-c227-42f2-a95d-828e94d19482	dce49be9-8b04-4f46-811a-e91ff1414afa	24	TextBlock
39e651ca-7eb9-4cc0-8766-643bb21f3c7c	dce49be9-8b04-4f46-811a-e91ff1414afa	26	ImageCollectionBlock
b51f23df-e596-4485-8840-1ea9d9c4abb0	2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	1	TextBlock
6ac2d6e6-8dc5-40ed-8e94-d423a956eb4f	2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	2	TextBlock
6a408a54-48b0-4457-9b0a-c07e61d0beb6	2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	3	TextBlock
cac24fca-d6ab-47b4-83ec-b37ee5e32f25	2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	4	TextBlock
cbdc54eb-29de-4fb9-ac89-31761785520f	2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	5	TextBlock
4b826a2a-ec21-4b5b-802b-8c6104665599	2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	6	TextBlock
ba499f03-c5b7-4cc6-beac-45c1d6c04890	2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	7	TextBlock
dc6ab13c-41e6-43e0-b323-73bcd1bafe77	2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	8	TextBlock
1fc90b03-ca42-4f34-91c4-c6f14ee36566	2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	9	TextBlock
0539c6d4-065f-4866-909f-6fb7ba44b7a4	2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	10	TextBlock
c923f83b-efbb-4d97-a733-57bd7bff470c	2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	11	TextBlock
fb170f6e-8a69-4dbf-9e7e-8958152088f9	2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	12	TextBlock
f6c2ef6c-740c-4beb-bada-feacbd28e445	2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	13	TextBlock
968c6ec6-fc26-4e61-801b-e01e45f78df7	2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	14	TextBlock
25bf9fee-37c2-4eee-8938-3ed6382273a2	2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	15	TextBlock
6dbd6732-7e75-49b9-8c37-ebb383390e26	2a6bcd6e-61ac-4a61-8c12-2b64ab1acc7f	16	TextBlock
14d8e7cb-4acd-4874-84c6-db5eb5962d9e	797fc8cd-5028-4c34-8d5a-6b3879638316	1	TextBlock
ca4c585d-1361-4cb7-a0b2-403296b97e4d	797fc8cd-5028-4c34-8d5a-6b3879638316	3	ImageCollectionBlock
28f92b1d-cf6f-4091-aee6-b64488775f1a	797fc8cd-5028-4c34-8d5a-6b3879638316	4	TextBlock
7ab75b13-6155-45c7-8b67-52a0c1fad7e7	797fc8cd-5028-4c34-8d5a-6b3879638316	6	ImageCollectionBlock
4618fe8c-0015-4189-9f94-620b30db9339	797fc8cd-5028-4c34-8d5a-6b3879638316	7	TextBlock
6a05b5c3-3e56-4a3f-a4e9-23fc3658bbab	797fc8cd-5028-4c34-8d5a-6b3879638316	9	ImageCollectionBlock
b64333d8-1b60-4b31-9e55-00d15cf46a66	797fc8cd-5028-4c34-8d5a-6b3879638316	10	TextBlock
276de1d8-d249-4b8e-bfc6-68e009d255ce	797fc8cd-5028-4c34-8d5a-6b3879638316	12	ImageCollectionBlock
29b5cd4d-87ae-4223-b203-3d634d67afdb	797fc8cd-5028-4c34-8d5a-6b3879638316	13	TextBlock
71ad5148-c41c-4dbd-b6aa-0b05983051fc	797fc8cd-5028-4c34-8d5a-6b3879638316	15	ImageCollectionBlock
99834887-d951-418d-b2b7-292f84737418	797fc8cd-5028-4c34-8d5a-6b3879638316	16	TextBlock
bb782bd8-b4ad-4662-a87e-05c3a37fd39c	797fc8cd-5028-4c34-8d5a-6b3879638316	18	ImageCollectionBlock
b20dbb7e-c4e3-4a29-8729-3ba8e9511c7e	d422a67f-0c5e-4990-bdb3-45915d5bd200	2	ImageCollectionBlock
ed20d954-4df7-4037-8589-4fdb711a9a2a	d422a67f-0c5e-4990-bdb3-45915d5bd200	3	TextBlock
328d51ef-ea32-40ba-84ad-1881deccff63	d422a67f-0c5e-4990-bdb3-45915d5bd200	4	TextBlock
878f93a7-66a5-4aaf-ace1-0d9d08eb5211	d422a67f-0c5e-4990-bdb3-45915d5bd200	6	ImageCollectionBlock
ef3474ad-bfa4-4362-b74e-1f774cf75a48	d422a67f-0c5e-4990-bdb3-45915d5bd200	7	TextBlock
a2db8d41-19ed-4ae3-bd57-c94d75f89c6b	d422a67f-0c5e-4990-bdb3-45915d5bd200	8	TextBlock
53368335-a097-44cf-a9b1-9666cf440089	d422a67f-0c5e-4990-bdb3-45915d5bd200	10	ImageCollectionBlock
9bc3f9a9-c20a-4256-ac0c-d60f88cd4bba	d422a67f-0c5e-4990-bdb3-45915d5bd200	11	TextBlock
9c616ba1-acaa-46fc-bc82-443be536e331	d422a67f-0c5e-4990-bdb3-45915d5bd200	12	TextBlock
bb635b05-c105-4aa2-bfa8-e1c3bcbb5fc2	d422a67f-0c5e-4990-bdb3-45915d5bd200	14	ImageCollectionBlock
c806d07b-d120-47c3-ad02-635e6b01d526	d422a67f-0c5e-4990-bdb3-45915d5bd200	15	TextBlock
e648c329-94ec-46cf-a683-23d64c373351	d422a67f-0c5e-4990-bdb3-45915d5bd200	16	TextBlock
ae462ce4-2d4e-46fe-8a39-d4a4337393db	d422a67f-0c5e-4990-bdb3-45915d5bd200	18	ImageCollectionBlock
0edd8460-9292-4d57-9040-38dce3b2165d	d422a67f-0c5e-4990-bdb3-45915d5bd200	19	TextBlock
ac5c5206-3c65-410c-8690-8c0d1b64a20a	d422a67f-0c5e-4990-bdb3-45915d5bd200	20	TextBlock
ccdbf49b-4f5e-486e-96f9-c0b2ce5da4b9	d422a67f-0c5e-4990-bdb3-45915d5bd200	22	ImageCollectionBlock
9a6c8dcf-12de-46a1-be02-266602427a81	d422a67f-0c5e-4990-bdb3-45915d5bd200	23	TextBlock
ad1ce258-a38a-4bb9-8eb5-e51ea425f970	d422a67f-0c5e-4990-bdb3-45915d5bd200	24	TextBlock
0b18049c-3620-48ec-93ee-fded42a21310	d422a67f-0c5e-4990-bdb3-45915d5bd200	26	ImageCollectionBlock
f2e51b16-56c7-4ddf-83c5-e2f2c44d8078	be7c1f13-335c-43ba-8f55-88c9848cda93	1	TextBlock
0c2747d1-cc59-41f3-b398-6daf46818470	be7c1f13-335c-43ba-8f55-88c9848cda93	3	ImageCollectionBlock
79323578-8d7f-4268-b418-d06bd5d1ad38	be7c1f13-335c-43ba-8f55-88c9848cda93	4	TextBlock
86bac2fa-a645-45df-bbbc-19358dc41a56	be7c1f13-335c-43ba-8f55-88c9848cda93	5	TextBlock
9f0aae23-c84f-4f3d-b48f-9f439f7ad0a2	be7c1f13-335c-43ba-8f55-88c9848cda93	7	ImageCollectionBlock
342099ce-0ad3-40dd-81be-796cfcffcc36	be7c1f13-335c-43ba-8f55-88c9848cda93	8	TextBlock
8502d424-6b91-42fe-b0d8-3252802493ea	be7c1f13-335c-43ba-8f55-88c9848cda93	10	ImageCollectionBlock
e5387349-4873-427b-a9e8-7e2f831604c1	be7c1f13-335c-43ba-8f55-88c9848cda93	11	TextBlock
52bec5a4-01a1-450c-a1b8-8e0791c2d31e	be7c1f13-335c-43ba-8f55-88c9848cda93	13	ImageCollectionBlock
d5f17caa-434e-4335-9e89-74da9d1cbe98	be7c1f13-335c-43ba-8f55-88c9848cda93	14	TextBlock
ed10bcd5-b8f9-414c-a298-1c614c49b442	be7c1f13-335c-43ba-8f55-88c9848cda93	16	ImageCollectionBlock
e653dbe3-a4d7-472b-be78-0deafabfaccf	be7c1f13-335c-43ba-8f55-88c9848cda93	17	TextBlock
7a2bd66a-1d09-4e0b-a689-dbca8e6930a9	be7c1f13-335c-43ba-8f55-88c9848cda93	18	TextBlock
ebdd3a3c-af06-44e6-a17c-38f0429df727	be7c1f13-335c-43ba-8f55-88c9848cda93	20	ImageCollectionBlock
b6635c0d-53bc-4f6c-a85c-b0e375606254	644bf45d-8b8e-4c9d-84ae-5219614bcb18	1	TextBlock
ee3fc711-9d08-485f-81fe-cfc5bb8cc44e	644bf45d-8b8e-4c9d-84ae-5219614bcb18	2	TextBlock
974acc21-59aa-4f28-967d-4e08b4cc996c	644bf45d-8b8e-4c9d-84ae-5219614bcb18	4	ImageCollectionBlock
ef592911-e3b6-41f1-8374-0c66687502d5	644bf45d-8b8e-4c9d-84ae-5219614bcb18	5	TextBlock
194c8466-6c27-4008-ba8f-80f7346a7a49	644bf45d-8b8e-4c9d-84ae-5219614bcb18	6	TextBlock
f8a32873-a5d1-4fb7-8ecd-08a85f609efd	644bf45d-8b8e-4c9d-84ae-5219614bcb18	8	ImageCollectionBlock
0895043a-9ff0-4a3f-bc32-d004ec0a0c50	644bf45d-8b8e-4c9d-84ae-5219614bcb18	9	TextBlock
e8462911-acb1-463c-96ba-3ee2597b496a	644bf45d-8b8e-4c9d-84ae-5219614bcb18	10	TextBlock
7355badc-beb7-4a11-b82a-84254e5df691	644bf45d-8b8e-4c9d-84ae-5219614bcb18	12	ImageCollectionBlock
d9b29393-e572-4c61-a96a-5ec8ca477138	644bf45d-8b8e-4c9d-84ae-5219614bcb18	13	TextBlock
d4751c5a-02d6-44bd-a5d0-4f14201cabc2	644bf45d-8b8e-4c9d-84ae-5219614bcb18	14	TextBlock
f80eb656-f8bc-42bf-a017-9854d852a355	644bf45d-8b8e-4c9d-84ae-5219614bcb18	16	ImageCollectionBlock
bdc64880-99d6-40ba-9bcc-8f2957c955c1	644bf45d-8b8e-4c9d-84ae-5219614bcb18	17	TextBlock
7ba4fd77-6df2-4c60-9a86-ab0aba0c7e56	644bf45d-8b8e-4c9d-84ae-5219614bcb18	18	TextBlock
b64d89b0-8377-4c8f-8b4a-0ea4b5908215	644bf45d-8b8e-4c9d-84ae-5219614bcb18	20	ImageCollectionBlock
aa0f2023-e985-4cec-be0b-65efba8bdf4d	644bf45d-8b8e-4c9d-84ae-5219614bcb18	21	TextBlock
73203e57-f1ac-4ce3-afd9-3f9028a584eb	644bf45d-8b8e-4c9d-84ae-5219614bcb18	22	TextBlock
ba4e9adf-2969-4397-9f75-17b3b40c65ed	644bf45d-8b8e-4c9d-84ae-5219614bcb18	24	ImageCollectionBlock
ffe64e3b-3271-426c-9860-9acc39f0b96e	2a94109f-5702-45f5-a817-a85cf7dcde56	2	ImageCollectionBlock
97a0179c-14ee-4e57-917f-7ecde2871a5b	2a94109f-5702-45f5-a817-a85cf7dcde56	3	TextBlock
fa59892c-5ddf-4a3e-b672-7869b1185ae6	2a94109f-5702-45f5-a817-a85cf7dcde56	4	TextBlock
b8bb3ba3-e0c7-4f5a-995b-eb74f8e4a066	2a94109f-5702-45f5-a817-a85cf7dcde56	6	ImageCollectionBlock
484e1fe6-5145-49dc-9e6b-b4b9007221e7	2a94109f-5702-45f5-a817-a85cf7dcde56	7	TextBlock
b73a61cb-971d-4c87-b073-e6ebf1201638	2a94109f-5702-45f5-a817-a85cf7dcde56	8	TextBlock
884ec068-85c4-41a6-a575-95df380be6d8	2a94109f-5702-45f5-a817-a85cf7dcde56	10	ImageCollectionBlock
67f10820-17ad-4408-bcac-5c4c0a0b2398	2a94109f-5702-45f5-a817-a85cf7dcde56	11	TextBlock
54d0e709-94d0-4c31-8ba8-cd40eeac2dbd	2a94109f-5702-45f5-a817-a85cf7dcde56	12	TextBlock
afda61aa-f958-4718-af50-922fb6c7febd	2a94109f-5702-45f5-a817-a85cf7dcde56	14	ImageCollectionBlock
b1c2fd24-d3f3-4d95-9f22-59a1dd154801	2a94109f-5702-45f5-a817-a85cf7dcde56	15	TextBlock
db2f4c7a-90d4-434f-9273-f15b7ed1612a	2a94109f-5702-45f5-a817-a85cf7dcde56	16	TextBlock
aa32fff5-c676-4653-8db5-a65b379b64b5	2a94109f-5702-45f5-a817-a85cf7dcde56	18	ImageCollectionBlock
c93fb6be-9715-4d54-a658-b80066e9d355	2a94109f-5702-45f5-a817-a85cf7dcde56	19	TextBlock
959dad8c-cebb-44ae-994a-6d19cc74bd56	2a94109f-5702-45f5-a817-a85cf7dcde56	20	TextBlock
062ef0d1-8691-40ee-964e-f7ec820ad7d6	2a94109f-5702-45f5-a817-a85cf7dcde56	22	ImageCollectionBlock
f8375cae-3f76-40eb-a1d1-493736254b0f	2a94109f-5702-45f5-a817-a85cf7dcde56	23	TextBlock
777f71e6-bf4f-4d3f-8f54-36bf64b9b88e	2a94109f-5702-45f5-a817-a85cf7dcde56	24	TextBlock
d1aeff36-213f-462b-9d10-02b78799579b	2a94109f-5702-45f5-a817-a85cf7dcde56	26	ImageCollectionBlock
8b2e399f-9960-46df-b773-6b497ceb2939	82f6e500-d40c-49e4-a8e5-db88e1378c47	2	ImageCollectionBlock
c89d9b8d-b15a-41f3-a9dd-084be47d0b80	82f6e500-d40c-49e4-a8e5-db88e1378c47	3	TextBlock
8bff5951-b46f-4159-8eb7-19cff0a313f0	82f6e500-d40c-49e4-a8e5-db88e1378c47	4	TextBlock
be895418-203b-4b83-a752-378e1f2f6bd1	82f6e500-d40c-49e4-a8e5-db88e1378c47	6	ImageCollectionBlock
61c72c42-e0d4-4c52-96fd-8ce98b60abc7	82f6e500-d40c-49e4-a8e5-db88e1378c47	7	TextBlock
10ac19e0-1743-4493-bd90-8fbd3192b186	82f6e500-d40c-49e4-a8e5-db88e1378c47	8	TextBlock
8bdc3c3d-e18a-437c-a922-3794a23cdc21	82f6e500-d40c-49e4-a8e5-db88e1378c47	10	ImageCollectionBlock
8010f6d0-7318-4656-9c8c-0cca1037d897	82f6e500-d40c-49e4-a8e5-db88e1378c47	11	TextBlock
e3d70d59-91b9-4fe0-9f3b-09fa30ca2b2f	82f6e500-d40c-49e4-a8e5-db88e1378c47	12	TextBlock
6328060c-9278-49b9-b028-15f7bfa5ff2d	82f6e500-d40c-49e4-a8e5-db88e1378c47	14	ImageCollectionBlock
b2025e8c-f983-4bed-a7b6-4cda637e7006	82f6e500-d40c-49e4-a8e5-db88e1378c47	15	TextBlock
1692d6d1-0d59-4457-a87a-fc3dd711668d	82f6e500-d40c-49e4-a8e5-db88e1378c47	16	TextBlock
5af747eb-15c0-410f-8d9e-24d0bb52294d	82f6e500-d40c-49e4-a8e5-db88e1378c47	18	ImageCollectionBlock
3c4e8720-d2ec-41aa-983b-104acd06aae4	82f6e500-d40c-49e4-a8e5-db88e1378c47	19	TextBlock
8e3c64bb-1885-44cd-9bf4-fe123c71cf27	82f6e500-d40c-49e4-a8e5-db88e1378c47	20	TextBlock
6eb7b160-48b0-4d0c-92e6-7e51358d51a3	82f6e500-d40c-49e4-a8e5-db88e1378c47	22	ImageCollectionBlock
a457cbcf-05e8-4f48-a32a-1650b7b5a1fe	82f6e500-d40c-49e4-a8e5-db88e1378c47	23	TextBlock
7c96c2b7-500b-48be-850a-bc809d222ce9	82f6e500-d40c-49e4-a8e5-db88e1378c47	24	TextBlock
153f49b2-b858-4d2c-8696-27e6585cedbf	82f6e500-d40c-49e4-a8e5-db88e1378c47	26	ImageCollectionBlock
8582ff25-4035-44c1-8cd3-6ee5ea147be4	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	2	ImageCollectionBlock
cad5f9c2-3d61-4fdb-869c-635ee0880fbb	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	3	TextBlock
60dfbfdd-4de9-4aa3-936e-ad207efcac0e	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	4	TextBlock
1ac501b8-1c6a-4dd1-be1f-ca376fe5e649	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	6	ImageCollectionBlock
9737db2f-9be4-4e8c-b023-e4192dd4383f	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	7	TextBlock
af6d625f-f5f8-43f7-b046-167f4d6c388a	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	8	TextBlock
d90e7367-30a4-4854-b2f7-886b87c44588	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	10	ImageCollectionBlock
f96171cd-072d-41e3-9aa5-2ea2ab709589	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	11	TextBlock
4f39e0e1-c244-4993-b322-02312c4f879a	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	12	TextBlock
c92a3cb9-6698-4752-9db8-52e2725c3a2b	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	14	ImageCollectionBlock
d743716a-9e64-4212-888c-01b180b87982	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	15	TextBlock
25acecb6-1ee5-4181-8667-7a01a1cd68d5	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	16	TextBlock
1770c140-37ba-4a59-9242-759bc78149cf	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	18	ImageCollectionBlock
7e4942a9-2369-4007-a2b3-86df14a25408	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	19	TextBlock
33bb9529-279b-4a9c-b3d9-0cc1cbd6b0cd	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	20	TextBlock
75502ec4-210a-47c2-b686-92c175799740	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	22	ImageCollectionBlock
3dd10df2-2217-4e81-b1c5-3e036cf2ee1c	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	23	TextBlock
ca416956-7a54-419c-8865-c5ab67828718	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	24	TextBlock
935f93d5-2a94-4435-8986-c56443e2aba4	587ceb67-7dc2-4e45-b0dd-b2f51340ba8e	26	ImageCollectionBlock
61ec1b40-b71c-4ef1-b357-26eda69a3416	6396bb3b-d41b-4e31-904e-11d9388093b0	1	TextBlock
abc44ec4-9a06-4586-9c62-673ce7ecf735	6396bb3b-d41b-4e31-904e-11d9388093b0	2	TextBlock
cb9af3a4-64bb-4f28-9b52-c74924e9d32c	6396bb3b-d41b-4e31-904e-11d9388093b0	4	ImageCollectionBlock
e1fbf264-819b-4086-acf9-19af36051b01	6396bb3b-d41b-4e31-904e-11d9388093b0	5	TextBlock
bff53c7d-fd09-481f-8475-951251804ed6	6396bb3b-d41b-4e31-904e-11d9388093b0	6	TextBlock
3c1d08fb-ad29-419e-8c7b-21ed44dbcf13	6396bb3b-d41b-4e31-904e-11d9388093b0	8	ImageCollectionBlock
916aa74e-0568-4c02-bda2-04f2de817b77	6396bb3b-d41b-4e31-904e-11d9388093b0	9	TextBlock
791b86c4-d876-4f55-b933-f4d889d070bb	6396bb3b-d41b-4e31-904e-11d9388093b0	10	TextBlock
081f843a-7302-4535-89d6-01e0fbcefb80	6396bb3b-d41b-4e31-904e-11d9388093b0	12	ImageCollectionBlock
d7085001-9ff0-49a6-8013-eef8f9ca51a5	6396bb3b-d41b-4e31-904e-11d9388093b0	13	TextBlock
48491e10-5542-4b13-b0f7-68a3345b7fce	6396bb3b-d41b-4e31-904e-11d9388093b0	14	TextBlock
822e1903-cf7f-4726-b3c4-7a1a84db613b	6396bb3b-d41b-4e31-904e-11d9388093b0	16	ImageCollectionBlock
05ed4d23-1d75-4113-8253-ede3493ba3eb	75d165f1-7b1c-495a-b0e6-3137f5c62480	2.5	ImageCollectionBlock
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.categories (id, name) FROM stdin;
6c47ec6d-169f-4a03-bb8f-a3f38ad81356	Ивенты
1dd6d2d6-7e69-4e27-9bfc-918e5cadd180	Новости
\.


--
-- Data for Name: image_collection_blocks; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.image_collection_blocks (id, block_id, display_type, images, caption) FROM stdin;
6cb5c2fe-976b-4b53-aa81-bc918e69d662	05ed4d23-1d75-4113-8253-ede3493ba3eb	Carousel	["https://minio.test.prof-stankin.ru/blog-images/b2ba7289-9b92-4f90-bdc8-02e4f03a5657.jpg"]	
04529c2a-0aa6-4ae4-851b-481c9623f329	32678488-9831-4e26-b7f5-4021460ee714	Carousel	["https://minio.test.prof-stankin.ru/blog/454904c9-3e28-48b8-9358-ef8faefa3342.jpg"]	
9acabe1a-32e8-41b9-8fb0-f69c07ff5b61	79ed349f-8d9c-4b74-bad1-357a6d9ea7cb	Carousel	["https://minio.test.prof-stankin.ru/blog/d23c1ba9-dee4-4ed7-b234-5de62b64512c.jpg"]	
975dc30b-aa5a-43c3-8b29-b5085506d0f8	bc552d13-460f-4926-bf6f-0110b6ed037c	Carousel	["https://minio.test.prof-stankin.ru/blog/88e8b10f-c4b3-4786-8cc8-a2eccf4de036.jpg"]	
4938e4a5-2b9d-4771-b880-c50eeb90cabc	4eb25399-95d9-43aa-811a-464c3aa00e4b	Carousel	["https://minio.test.prof-stankin.ru/blog/d51e880e-9f86-4ac3-8d41-27fdfc599335.jpg"]	
5ae8aecb-1456-4a7a-bc11-7b208cd4ef83	57f6925b-0b02-4e6e-a09c-546c604aa30f	Carousel	["https://minio.test.prof-stankin.ru/blog/bcc905a4-9b4f-4a56-a6b7-52cc1649e6bf.jpg"]	
dd2061d5-0fe9-4217-a559-96b67cb28ee0	3df8ef8a-6163-4320-acef-58a23e606256	Carousel	["https://minio.test.prof-stankin.ru/blog/8d5b5515-9a14-45a3-8608-6b35383826bb.jpg"]	
b83136bf-3922-4641-b8fd-91a4ce11cf1c	b474207e-ca57-4e03-9719-43751e2e6afa	Carousel	["https://minio.test.prof-stankin.ru/blog/e6deb1ad-5c77-4015-847c-228f6f55099c.jpg"]	
9cba7e8b-174e-4aa8-8c50-31f06f331a96	b82e95c8-5e0d-495c-953a-28ecf143149e	Carousel	["https://minio.test.prof-stankin.ru/blog/2a7ceb4d-3b79-4189-8deb-e4c067936cb2.jpg"]	
a3083666-629a-4dbb-8ca1-1e64fd5565d9	bb3757d6-2c52-4588-b566-df9c460d47d1	Carousel	["https://minio.test.prof-stankin.ru/blog/7ee9c811-0bc3-4423-8869-c1271113be3d.webp"]	
58ed3e1b-8f35-4b84-9e04-4fb0e952633c	b11ea526-d5b5-45e6-9177-a808025ac2a4	Carousel	["https://minio.test.prof-stankin.ru/blog/1b68af40-709a-4d8c-858f-e0c23162fb5a.webp"]	
ba940382-0250-4e17-8730-89019c08d09a	78c06203-d973-4585-8b9f-eb48bc30cf5e	Carousel	["https://minio.test.prof-stankin.ru/blog/84c934ef-89cd-43e1-b76f-c2ef9ec544c8.jpg"]	
8c28002f-0a28-443d-8c30-a4782e196f8d	45532852-eea5-4de2-a8d4-c5507ea36cb0	Carousel	["https://minio.test.prof-stankin.ru/blog/b4f804ce-ff9c-426e-bbea-9834c6de9b9a.jpg"]	
d1581013-d242-4024-8c39-a0ae6e05d169	e3e52087-61ee-499f-8250-f9e2402b98a9	Carousel	["https://minio.test.prof-stankin.ru/blog/7c9da528-e602-4c0d-91d8-275646f1c493.jpg"]	
5216b758-49f2-4ae1-8595-18faad0541a3	784adf94-0409-4c43-96fc-48a619940c54	Carousel	["https://minio.test.prof-stankin.ru/blog/f04dff01-05a2-44f3-bb75-60647a1c54bd.jpg"]	
93b044bf-6f00-4f08-a752-72882e6e1803	e0611f3d-b4b1-43d1-9691-0f7476c0fbfb	Carousel	["https://minio.test.prof-stankin.ru/blog/3562cb1a-bec4-4bda-b205-52edf63fdcc6.jpg"]	
4d75d724-f6ee-45e2-b20f-2dbd655dd7fc	3d7e5b5f-e598-4d6e-a23f-b9efcc05c95c	Carousel	["https://minio.test.prof-stankin.ru/blog/f5508281-f44e-4d35-8240-77d59edfde8d.webp"]	
cf48b8b0-74fa-496d-ab84-4861e66c209c	6077abc0-7a85-4397-9819-ef710a9b6fa7	Carousel	["https://minio.test.prof-stankin.ru/blog/969dbf53-470c-499a-befe-6fe96ce5ea3d.jpg"]	
34412b05-c0b6-4843-8c27-e36185492295	202a827c-3f40-4304-997a-1dd90bf373ff	Carousel	["https://minio.test.prof-stankin.ru/blog/27dfeebd-930f-46d3-8db4-6648e05636f5.webp"]	
93152671-b87a-40cd-a474-cd8538caeddf	1bb27b3c-6806-4051-a3a6-4ef0e1e47094	Carousel	["https://minio.test.prof-stankin.ru/blog/4fdd1123-e530-41bb-8aa0-3ec3f9e31f14.jpg"]	
ec9a963a-5bc4-45e9-8b47-266494e73ba1	5ba16cf2-b0aa-4481-8536-e54c26f1e8f8	Carousel	["https://minio.test.prof-stankin.ru/blog/da3d5b14-ef25-4c39-bf57-047f39d16e99.jpg"]	
9c82470e-97bd-4f5b-bbee-22ddabccd92c	0b478be0-e423-4f80-b4bc-2441faa10ed9	Carousel	["https://minio.test.prof-stankin.ru/blog/1f242491-939c-4d54-a940-61030b3bb933.jpg"]	
7010b557-f503-4c7b-925c-e15330419340	292d8bc8-3d6c-43ab-ac0d-d39259b95694	Carousel	["https://minio.test.prof-stankin.ru/blog/285647f9-ac30-4747-869b-ddb4e5f836ed.jpg"]	
a2ced8ec-bc8e-47f6-8b2a-f850b802fa12	314aee11-9e19-4edb-88f9-06a94891a6f2	Carousel	["https://minio.test.prof-stankin.ru/blog/f22c8132-7983-4e39-a646-71d77c64c93d.jpg"]	
168e4c09-f373-4cd3-9dc1-e4ca8384d530	afffe4f7-88e8-49e7-885a-2ef50b473cfc	Carousel	["https://minio.test.prof-stankin.ru/blog/3869639e-b5d0-40d5-b94b-ec8a224b0398.jpg"]	
d6d45f83-31ce-40b1-8160-931ddd6d2027	a1c1e05c-769f-43c9-86c9-a00f20e0c13b	Carousel	["https://minio.test.prof-stankin.ru/blog/c82b0230-7901-4ae8-94a1-ad0096d29bdc.jpg"]	
45fb95e5-a8c9-4e11-b629-0813c7452810	4deeb957-91e0-4219-a2c5-f990354759de	Carousel	["https://minio.test.prof-stankin.ru/blog/3cc0c387-d751-47af-ae6a-b7cac3747613.jpg"]	
f600eb18-6530-4caa-97e3-b847f9786de7	b1096569-7614-4027-b176-95ffd10511d0	Carousel	["https://minio.test.prof-stankin.ru/blog/b2cdfc13-d0c5-4bb3-a47c-0409278b278a.jpg"]	
06b84eb5-c185-4671-ad25-b8b7362fd65c	0043d1b7-07f0-47ac-8594-3814b560f81d	Carousel	["https://minio.test.prof-stankin.ru/blog/6caaff88-823e-4226-86a9-300a513416f3.jpg"]	
a715e0eb-08b0-4d4f-a011-17b3eb1d00be	e18a1cdc-63ab-43a4-9b6f-07cce1b5648d	Carousel	["https://minio.test.prof-stankin.ru/blog/92a9fb0e-542c-45f6-8fba-9a6196c40f4a.jpg"]	
cd5221cf-785b-4a7d-b587-6c657cad785d	d24823f9-1174-436b-8a66-a7e007988e09	Carousel	["https://minio.test.prof-stankin.ru/blog/8241f666-829d-4271-bdc3-2e9c5a8b44bb.jpg"]	
d970bcd4-efe4-4f16-8ab7-6ba9fbf217a5	5bcfdba1-9329-402f-b221-d699df2435e0	Carousel	["https://minio.test.prof-stankin.ru/blog/1cde1d4b-2223-45d2-904b-f0d7b2995cc7.jpg"]	
d29e00c8-deb7-48cc-8f7f-6ebc6d93a44c	592cc23d-5ef1-422e-b9b9-e29b8e87582a	Carousel	["https://minio.test.prof-stankin.ru/blog/155e48e0-f50f-409f-92bd-db0f6cd28db5.jpg"]	
d2843b44-ccbe-43b0-b740-a67c585a1159	7e72be4c-ef74-4c4d-8637-75cb17956e1c	Carousel	["https://minio.test.prof-stankin.ru/blog/5bac9bf1-3f0a-4177-ba10-665446410359.jpg"]	
d19ae74f-d40f-409e-9ecb-1e2cee1df814	073df1fa-4356-4141-9de7-7c10853a90bf	Carousel	["https://minio.test.prof-stankin.ru/blog/d7059f49-4abd-41ab-aead-33ece6e6bf2c.jpg"]	
a74117c8-e4bd-4917-b94b-dca81d65dff3	82da36eb-fedb-450e-8e4a-221dcbca05a1	Carousel	["https://minio.test.prof-stankin.ru/blog/c4cf3e60-876f-41a8-8316-ca5374ee411b.webp"]	
5c5a996d-4467-4552-8dbd-3896cbf96001	ec0092a3-c2e3-401c-b8a1-9a688158bcb7	Carousel	["https://minio.test.prof-stankin.ru/blog/79c7f37e-bbdb-4a4e-92ce-9889be2cf133.jpg"]	
5266d04a-30ad-498f-957c-79249222dd78	89827795-58ad-4354-9b97-4b5c79159dae	Carousel	["https://minio.test.prof-stankin.ru/blog/31b7ff3a-efd9-45d4-9338-657af9e54f76.jpg"]	
d4f131c6-9ff5-4f82-8b74-5aee0e943191	d55f1a67-aacb-46b3-86fd-44dd0d6c2210	Carousel	["https://minio.test.prof-stankin.ru/blog/c063b0a5-6478-49ed-bd06-944cbaded1ab.jpg"]	
e3ad069a-1f67-48f7-810e-71b7d8a446a3	e21b5296-8e8a-4f30-96e0-0fce3202ccd5	Carousel	["https://minio.test.prof-stankin.ru/blog/f287f9c2-bcfa-42fa-a324-81a6a40ff7a9.jpg"]	
d540145a-34ca-4f27-b8cb-b2d10d2727cd	6aaa11ba-54d1-4ac7-852c-4cd71aa3bfce	Carousel	["https://minio.test.prof-stankin.ru/blog/21a3d974-4a9b-49df-87ed-a844a6dfa024.jpg"]	
b73376b5-618b-4701-a541-886c8f52ea2e	de2b4a93-781f-4572-a9c1-890744ab59d4	Carousel	["https://minio.test.prof-stankin.ru/blog/24e0a744-66af-42ce-b0ed-b20ad3dd6e36.jpg"]	
4164c254-5401-4ae3-b2e4-19fb1a34922c	7ba4aef6-bbd9-4eda-8165-4eb10e4b363e	Carousel	["https://minio.test.prof-stankin.ru/blog/e6b2bfa1-a51e-41e2-98b6-929c27e71a4a.webp"]	
6b1e7b94-2066-44c6-8ea2-525d2eb13c22	7f4c7fb0-9669-4591-a584-d0ce4265117a	Carousel	["https://minio.test.prof-stankin.ru/blog/722615ff-1bdf-4158-83bb-6830d5c64764.jpg"]	
e177d600-e2e7-4e4e-a9ad-d2ad2ec6c2d6	a1f456a0-3028-4e82-98d8-d41a24253d84	Carousel	["https://minio.test.prof-stankin.ru/blog/c08ae15f-80f9-417c-a253-640a9fb29024.jpg"]	
e2522735-27ec-47d7-b5b2-c49bfa3b670e	b14906b7-5085-441a-9282-df76506b238f	Carousel	["https://minio.test.prof-stankin.ru/blog/6b96575a-0040-4cb7-86ee-94ebf70d5ee0.webp"]	
a1eb3047-c44a-4a97-89d9-6bcd5dd8719b	12090288-3559-479a-91c9-2d8a66791aff	Carousel	["https://minio.test.prof-stankin.ru/blog/db953ebb-e9eb-4eef-8573-a231c93491d8.jpg"]	
3dcdf7a5-0099-426f-a5b2-680f64008b46	9661e2e6-ff53-4756-bb22-9aee0e6086b6	Carousel	["https://minio.test.prof-stankin.ru/blog/85cc693f-1099-4a1f-b543-1f56b8298d24.jpg"]	
b522e15a-19e6-483a-a60f-20959bc171d2	3615b9f9-ff8d-4d6f-977e-93805aa8ad25	Carousel	["https://minio.test.prof-stankin.ru/blog/34a9f4a3-c2b7-4979-ba12-7d609ba89e85.jpg"]	
d0f89ba7-0be1-4c23-b2d8-871b3cf0a914	74dcea7a-0498-4ec8-9851-3c7bafc1fc02	Carousel	["https://minio.test.prof-stankin.ru/blog/9f7f6c51-56e5-4059-bab4-4e3c78ad1791.jpg"]	
bc9b9e57-a99c-4f27-9179-a6fec2b44e7a	75ad1921-9ca7-4255-9227-6673d80a656d	Carousel	["https://minio.test.prof-stankin.ru/blog/27487023-110e-4372-b3a6-26e0d48ad24f.jpg"]	
41ff0173-47c3-49c0-a3e2-90b93e02b8a1	eeca43ac-f58a-4f1c-a117-197664941400	Carousel	["https://minio.test.prof-stankin.ru/blog/ef3f88bb-0a74-45dd-b261-e5a456f2a669.jpg"]	
738846f7-4a14-4f68-bb5f-0e66ac464207	50f3da85-e34c-40c2-b3fa-95967c304d1f	Carousel	["https://minio.test.prof-stankin.ru/blog/2df6cf24-95bd-4064-9242-1c340212458e.jpg"]	
2a299a39-46d9-4584-8c0c-a61f533da63e	ec7d090b-bc58-4893-9f00-bed95a5b6f07	Carousel	["https://minio.test.prof-stankin.ru/blog/c7de5feb-6d1e-45f2-808b-4116316d5a11.jpg"]	
f0a4c73c-0f26-4376-ad9c-971b287e2aeb	b3f48516-5997-4b5d-81fc-5e565b6d84e0	Carousel	["https://minio.test.prof-stankin.ru/blog/8ee32817-dd3b-4f75-8860-9ed00e9b008b.jpg"]	
8b50247a-97a6-49f7-a8c7-41eafb523007	5cbd54d9-8c0a-4856-ad92-dc9faa08c962	Carousel	["https://minio.test.prof-stankin.ru/blog/00107895-565b-4571-8fee-183a98a84a7a.jpg"]	
d7266a10-41f6-4259-8ab2-095e0bb1f7a3	cdfad19b-6ce4-4061-9d4b-8d95cb008ba6	Carousel	["https://minio.test.prof-stankin.ru/blog/7b1390df-008e-4652-87f1-5f3b0eadea43.webp"]	
288c4351-0bf1-488f-95f2-c81a4a8f12b5	4792d689-b099-47be-8eec-47d096bb70b3	Carousel	["https://minio.test.prof-stankin.ru/blog/375bc9c3-6ba2-478c-997b-d4af91915ea3.jpg"]	
24b4c6f4-c8a5-4c45-810f-dbe054e715bf	d97e9cac-505e-4205-8498-665252a9dd2b	Carousel	["https://minio.test.prof-stankin.ru/blog/f805964d-85f1-4ab5-933d-78c55e96aadc.jpg"]	
b24828bb-b911-4c73-bbdb-1d44af4ac5d6	7a5559e2-5b66-47f8-885d-fe61a3a4b0ad	Carousel	["https://minio.test.prof-stankin.ru/blog/5c8610fc-4339-46f4-9c43-561556cdb351.jpg"]	
7944bb65-532d-43e4-85dd-aac8441e2b77	2e718230-e102-4b2e-939e-e15fdf92b93b	Carousel	["https://minio.test.prof-stankin.ru/blog/c83a0835-3ed4-4c16-bed7-0851f397dda4.jpg"]	
7512116a-0a0d-405e-8376-44c5c45be156	73a48740-e5fe-482d-98c8-778810787767	Carousel	["https://minio.test.prof-stankin.ru/blog/6caef073-08db-4e8b-85c0-7e823c2871ce.jpg"]	
bbc47db8-159b-4f28-be3f-26f192289658	2d157f58-f66c-41f6-ba98-bcba1f5dc316	Carousel	["https://minio.test.prof-stankin.ru/blog/4ccc40b8-1427-46fe-a73e-f7817aa1ebb0.jpg"]	
b14862c6-74b3-4e11-8529-0a9ff8250d8c	91fd64b5-fe2f-4430-a258-f148c1fca04b	Carousel	["https://minio.test.prof-stankin.ru/blog/76668d18-accb-48ce-b4d2-0a238997678d.jpg"]	
c4e66799-c7c7-434d-ad44-d1560c4ff5a4	517be2e2-7dc3-4967-86f6-870b65cd0d59	Carousel	["https://minio.test.prof-stankin.ru/blog/e216bf95-811e-47ce-9e26-6d40098c17bf.jpg"]	
f7c3e0a5-575e-49f1-a214-0acb898db265	5f1d217a-8804-46e8-9005-75f73ccc75ff	Carousel	["https://minio.test.prof-stankin.ru/blog/a60209e8-3c91-43b5-9f30-ae4061a2f890.jpg"]	
11d0fd4e-3ce3-41ba-877e-6f10833f3768	587b0dc6-3302-4381-ab7a-e6ef4c944c67	Carousel	["https://minio.test.prof-stankin.ru/blog/1c39e762-d7cd-48ba-ae38-50c0e97cd232.jpg"]	
ac7f9f1a-5347-4be9-abc0-731b885864e3	c8bdfdc3-1487-4144-8a26-3ae2f11a1b37	Carousel	["https://minio.test.prof-stankin.ru/blog/f74fad95-1b59-4345-8e62-201a85d9d9e4.jpg"]	
dfbb4af1-3d8c-4223-bac4-c123e2986972	82ab6573-e03b-4070-a612-0590fb9569e1	Carousel	["https://minio.test.prof-stankin.ru/blog/4731e5f2-a283-4472-99b3-19f76373c211.png"]	
72e30ccf-62b7-487d-95cf-7825579befdb	cf564307-e6c9-4746-abd9-34fc46a8abde	Carousel	["https://minio.test.prof-stankin.ru/blog/3729723f-a547-4dcf-9772-7a774fac8358.jpg"]	
6d01aab8-4ce6-42d2-aa56-7c1f6195eda8	97560425-b4e1-4671-b8b4-861fdac87dd0	Carousel	["https://minio.test.prof-stankin.ru/blog/475dfa2e-5eab-489f-877d-74b6c893b514.jpg"]	
34856165-dbc9-4756-bee8-305cfa476add	49293c4d-41a0-415b-a042-1c342b819905	Carousel	["https://minio.test.prof-stankin.ru/blog/a25a281e-7276-45b8-a21d-209cfef5b088.jpg"]	
8893db4d-a09b-4900-8f3b-950b28398866	b00a2e90-b02a-468d-a304-fd7f4b43d396	Carousel	["https://minio.test.prof-stankin.ru/blog/29219a6d-ec71-4b72-9410-fc1650fcb033.jpg"]	
38b443c8-be2f-4c83-b0f7-14f0b3332ff0	0a36729f-13d4-4988-9c5b-e423f061082f	Carousel	["https://minio.test.prof-stankin.ru/blog/3a79f85b-6cfb-4f84-ac33-2f42c901ec50.jpg"]	
65f2d7f1-2d71-471f-a3e5-cfcb55f78391	60bc0c45-b1e3-4b9a-8dcb-51be408efaac	Carousel	["https://minio.test.prof-stankin.ru/blog/2b45b8f2-ec4c-46a2-94ff-57df81f55241.jpg"]	
10264df3-e03a-49bf-9532-add4be7c35e0	2dba9265-66ae-4a53-b9d0-b6887e133bd6	Carousel	["https://minio.test.prof-stankin.ru/blog/bb92687a-9f50-44ac-ba3b-3d3c9a3c2d7d.jpg"]	
a2e1d396-8f0f-4790-878f-563a48ba08d2	74000c5b-153e-49ca-b97c-f83648481525	Carousel	["https://minio.test.prof-stankin.ru/blog/ab41be07-9eef-4a27-b654-062bb5084cfe.png"]	
5d44b077-b75d-4d5b-a0f0-d4e48c4deaa9	0ebf785e-7d8c-4544-a4cb-5d57def53a6c	Carousel	["https://minio.test.prof-stankin.ru/blog/a2bdead0-8d61-4eb2-8c05-63ac14247439.jpg"]	
326c36bc-7263-4f14-bda2-14b2b989cf8f	751fadb1-29b4-429b-bd9e-262a30a891c8	Carousel	["https://minio.test.prof-stankin.ru/blog/d16aeff2-3b49-422f-b52f-78109ba3c819.jpg"]	
2dd1a36d-40f2-41d4-9cf1-b0ea555dfb8d	b2f0a138-a85c-43f3-983a-ea3ecb6fca54	Carousel	["https://minio.test.prof-stankin.ru/blog/5f2a2247-2cba-44d3-b46e-e81aa55dd52a.jpg"]	
c052297b-eca5-44ab-8a45-32882f1a1295	8bfb166e-4223-4ebb-9de5-9b35d5757b99	Carousel	["https://minio.test.prof-stankin.ru/blog/e5991fc3-f46e-48bb-9900-6f04958ecd93.webp"]	
0f0ae439-be44-4054-9fe1-4c4b79682e2a	b04b7661-80fd-4a2e-8a52-1a02b353b950	Carousel	["https://minio.test.prof-stankin.ru/blog/c61528a4-65d0-4d7a-acac-e092d5826833.png"]	
c28f5945-c67a-44ef-a281-089973ebd7fd	31c48381-9b7d-4dbc-b01e-a156e8d73664	Carousel	["https://minio.test.prof-stankin.ru/blog/af0673d7-fb48-42b9-b78a-2a43ba314e03.png"]	
129d9817-f877-450f-b9d4-520d92b7242d	1e1b507e-31be-4858-818d-9b41d28bb0d2	Carousel	["https://minio.test.prof-stankin.ru/blog/250dd572-47f7-42fe-b439-2e09003f4556.jpg"]	
74ee3a0b-62a7-4b6b-98bd-296fc7e1a415	8973180a-bbe4-487a-95d2-19aa02e0f6c3	Carousel	["https://minio.test.prof-stankin.ru/blog/8dee5b2b-519a-4639-8d00-45f453e855e7.jpg"]	
7036c53f-7b2a-4c68-afbe-dd368bbc9d22	35b8776f-de16-4069-bda5-ab5fa642ae63	Carousel	["https://minio.test.prof-stankin.ru/blog/5b8d85ca-1e64-4648-93d4-9b87e7a813ee.jpg"]	
60879e02-1939-44f2-a72f-b09d776180d2	0815999b-09b9-466b-9d35-5567ecf2a79c	Carousel	["https://minio.test.prof-stankin.ru/blog/114281aa-d52b-41ae-bce8-42a8208c1fb1.jpg"]	
e81061c3-c824-4ef7-87dc-57e4ef0c55cf	1aa80110-1f6a-4776-a6d5-44a43901f649	Carousel	["https://minio.test.prof-stankin.ru/blog/1cfef762-6614-46e9-bd92-50057c7f7d4d.jpg"]	
13040d81-e974-4cc9-b516-7b4e737e001d	a1388310-85ed-49b7-9f37-38da1291c50e	Carousel	["https://minio.test.prof-stankin.ru/blog/e164d527-d8f3-4bef-ab8a-7d5c5786a8d4.jpg"]	
2a66bae1-3401-4af6-8808-3c996d86ea3f	df3e0e8e-af0b-4c4b-ad76-cd51f9422c46	Carousel	["https://minio.test.prof-stankin.ru/blog/0de66c73-9946-43cb-98a8-4080ada0989a.jpg"]	
a61c5caa-538e-4e7c-9abf-89acf1665c63	53083a50-5c36-4f15-969b-0839e5cac016	Carousel	["https://minio.test.prof-stankin.ru/blog/43a01b06-4d59-4fe3-899a-b80f617d0f0b.webp"]	
eec0f938-9330-4120-bd27-4692dde09975	037a403d-2d3a-4bb0-90cd-de3ea8a9e2a0	Carousel	["https://minio.test.prof-stankin.ru/blog/1a849f5e-b6bd-49c5-a582-947a563968b8.webp"]	
f2763543-94da-488e-bf39-5772a5e1d7a7	c1eb6879-ea58-460c-bb92-983070110cd3	Carousel	["https://minio.test.prof-stankin.ru/blog/da575c9d-312d-49f5-ae5a-00f00fb6e9e8.webp"]	
ddbcf656-5347-418c-b247-9f69a1738518	84f6c2fb-47d4-4813-82e3-c70d8526e0a4	Carousel	["https://minio.test.prof-stankin.ru/blog/37f301b5-12b0-4c02-97ea-c270a6dc9b34.jpg"]	
96a1c0ba-3348-4d5a-a993-64513110282a	963ad1c6-ed05-4f51-b0dc-1e2a770da23f	Carousel	["https://minio.test.prof-stankin.ru/blog/b88920c0-8bb2-48c5-af1f-7e0be3c0f313.jpg"]	
67da3ba7-947b-48a1-9ea2-07fa6279f736	aacccf52-0b95-496e-bbe8-627960fc87ca	Carousel	["https://minio.test.prof-stankin.ru/blog/92742be3-1dcb-4368-9317-229d05d9e04d.jpg"]	
c9814e17-6025-4dde-a369-d532cbd0bb1e	caacb723-ed00-4bee-9133-ee62bc671c6a	Carousel	["https://minio.test.prof-stankin.ru/blog/f5886a22-8e0a-4b75-bd0c-c783e3a5a784.jpg"]	
59b5279b-f776-48a9-b813-9919851ac961	35dfa643-6076-4c60-9706-c67e9f0abf41	Carousel	["https://minio.test.prof-stankin.ru/blog/84d15af4-b427-4f45-9985-b3842abc80f7.png"]	
7a9cd931-d12b-46fe-afa1-943c046c5210	d2a37068-58f5-451d-a65a-b87361d1c726	Carousel	["https://minio.test.prof-stankin.ru/blog/fc85bef9-dca5-4409-8056-1e38673ee926.jpg"]	
f0ee84ba-a9bd-4195-9450-6921b05a68e3	26fdcdae-431a-4fe1-b6d3-879cf27a2dc0	Carousel	["https://minio.test.prof-stankin.ru/blog/483f410b-3474-4cb6-ade4-74b70327aaa5.webp"]	
c58bfb15-09a7-478c-84cd-4f947f80ec84	62474038-ec46-40d5-ba99-5038d127fa2c	Carousel	["https://minio.test.prof-stankin.ru/blog/69b6a2d7-d4ab-4c56-9e39-4faaa4f6b683.png"]	
786470d2-ed06-4c00-be51-2438cfeda938	3c0bfecf-5309-4d49-8cb6-59639baa7e8b	Carousel	["https://minio.test.prof-stankin.ru/blog/cafc112f-ad35-4d13-84ea-dd5be5e6d499.webp"]	
ff441b65-b1fd-44b6-84cc-f0eb0f8c0eae	166dc915-c9b9-476f-b975-e6769f47fc0f	Carousel	["https://minio.test.prof-stankin.ru/blog/18d3bdd8-458e-4744-8391-f8a19007b3bd.jpg"]	
9eeb942b-65d0-4508-a59f-cc144f2dbc6f	76a12569-4e9d-4b87-9807-4ccc19e6efa2	Carousel	["https://minio.test.prof-stankin.ru/blog/eaf17f7d-4b94-4094-86cd-5233795cf734.jpg"]	
12c950b5-4fcb-41f8-9eed-ee880fb0fea4	f3429ab1-891d-4d9a-8ccb-cd3006e87abd	Carousel	["https://minio.test.prof-stankin.ru/blog/4f264a9a-3b2f-485e-802b-1f2e8c8a957d.jpg"]	
b0cb4ba6-d60d-48b1-9ab0-ef9ea56f54ba	dc915d68-fe22-4faa-9363-517b446da9b0	Carousel	["https://minio.test.prof-stankin.ru/blog/b8956f72-c120-4282-ba70-d51f3c7dbc48.jpg"]	
f367989d-6c48-45a0-9e92-4ccc196ce825	efa34b03-a160-47f1-93ae-91177bdfae41	Carousel	["https://minio.test.prof-stankin.ru/blog/6f907eb5-941f-42c7-bdb6-7ba43bdaaa65.jpg"]	
313f7fbf-b358-4dfa-be87-f2df1a4ebd3b	f9b40e3d-dd5e-4d2e-b455-2b2a61cf9db2	Carousel	["https://minio.test.prof-stankin.ru/blog/d6636694-4505-4189-8aca-10ff0d62290d.jpg"]	
04294ccb-7643-46a8-abc4-2def0461e46d	52d6b995-ec97-4be5-ac03-3e079f634bec	Carousel	["https://minio.test.prof-stankin.ru/blog/095a0d99-3d36-41b9-b70b-b87ffecffbed.jpg"]	
ce611265-1053-4d39-ab8e-db7a9a54dbe8	2f736bbf-3c70-48fe-9962-2f75bd09dedc	Carousel	["https://minio.test.prof-stankin.ru/blog/6fdd9525-1271-4aa3-9c3c-abcf91eeafff.jpg"]	
a57f2dca-5738-434f-a8ec-4d1d71772082	1d3f5549-1bd6-4dba-a6be-d6332a4b6407	Carousel	["https://minio.test.prof-stankin.ru/blog/521fe628-c279-460b-b99c-bdf9b5b00aba.jpg"]	
71f6fb8c-0d92-4be1-8902-dd8af32775a6	fae13cbb-23f5-43e8-a5d4-748eed002257	Carousel	["https://minio.test.prof-stankin.ru/blog/fe99b044-b56b-4827-9a80-087fdf4e24b7.jpg"]	
9e0db4de-0cd7-4810-a301-fa525a818710	d16782a7-8adc-40e6-b2b3-2340f4fa033b	Carousel	["https://minio.test.prof-stankin.ru/blog/bb5c8e4c-195d-41ee-a037-d339e99d38d3.jpg"]	
2c6c30d2-2d51-4504-add6-317e6fbe2a9d	9bcf78f2-4afc-4511-9db8-d1c43cb96968	Carousel	["https://minio.test.prof-stankin.ru/blog/12f81efa-c4fa-45f8-882d-df8a69e10ee9.jpg"]	
3dcaa5ca-2f6e-492d-8edf-671cae09d149	f4309f12-3f73-4579-8f0c-ea81d5bd4ba2	Carousel	["https://minio.test.prof-stankin.ru/blog/d50c8bb4-0b47-4af3-aed2-37b578a7589f.webp"]	
e363927c-13d2-4bb7-b99a-607f4bf03bad	2f47e4b0-a495-4903-bc23-adef7dd88f32	Carousel	["https://minio.test.prof-stankin.ru/blog/89bfd349-c037-41e0-a260-9607eb8f51e1.jpg"]	
fc13e64a-8d44-4434-81ab-76f318e2dd49	4e316daf-02b5-4a32-be59-9b720c24c346	Carousel	["https://minio.test.prof-stankin.ru/blog/5cd5309e-7167-403d-a28f-966191bffbcf.png"]	
fd6f64e9-13ac-4d32-a333-dc62db07e19b	c17aa0cf-5aab-4847-8cdd-da90173b27f2	Carousel	["https://minio.test.prof-stankin.ru/blog/4ef754c4-c9c8-4e24-bce1-3f99e12676d7.jpg"]	
3c554088-770f-4153-97e3-67c9331e28f7	326459c6-5466-4b26-8e7d-d8ba78c1674d	Carousel	["https://minio.test.prof-stankin.ru/blog/85ebf2fe-6390-48fd-9121-94231be96cfd.jpg"]	
c17fbf3e-3519-44f3-9cbc-4754c74853ee	df5bd9c4-1cdb-45ff-91f0-c36c64a3dd10	Carousel	["https://minio.test.prof-stankin.ru/blog/39d88517-20d0-41bb-a6e4-6d1763811d0e.jpg"]	
5d87863c-34ac-43ce-a305-96e30b3bc223	706d0c2d-a1d6-4e28-80da-fa0140d48d87	Carousel	["https://minio.test.prof-stankin.ru/blog/6d83fa73-8ace-4cd3-ae42-8a8d181c5e7a.jpg"]	
61567313-c0af-4509-9f1e-5c708571fd57	059d580b-5fdb-4d6c-8f0a-5ec78fc69d73	Carousel	["https://minio.test.prof-stankin.ru/blog/450e2172-13e3-4151-959a-906df4d4eb65.jpg"]	
9b5cf14c-2612-495b-87e1-ce91c29b66a7	2ba3ea99-d315-4a1e-b628-39362ba19813	Carousel	["https://minio.test.prof-stankin.ru/blog/60516e76-aaad-465d-b946-2f95d4b261ed.jpg"]	
b47b79cf-4994-491a-a9e1-df0e827b3b79	66e16639-d50c-4917-ac02-b9d6f8a84b9b	Carousel	["https://minio.test.prof-stankin.ru/blog/9ef9dc86-80fd-4ac7-80fa-a1b8576fe20a.jpg"]	
0ddd798f-94e0-4048-8465-a240cb5e4f02	f4a921b8-d26f-4b64-98af-e9d1562d4742	Carousel	["https://minio.test.prof-stankin.ru/blog/3c0442af-5faa-4b1f-a7f9-a30420efc41b.jpg"]	
dc3491cc-a684-4a62-8e31-5d1b4a16b305	6cfe0b72-8465-4317-9e7a-3639eeda68d8	Carousel	["https://minio.test.prof-stankin.ru/blog/d1c0ec05-9996-475e-a4ac-ad40aed52611.jpg"]	
d1d26b89-e472-497c-a57a-1e34b196b792	30e91f39-c449-4aab-938a-8a53b9d242c4	Carousel	["https://minio.test.prof-stankin.ru/blog/4a711809-f638-4441-a568-40f927efb58f.jpg"]	
f9fad997-fcd9-4c51-89a8-3c5f792c0775	f7e094d2-38c3-4547-a3cd-a0c109a8f703	Carousel	["https://minio.test.prof-stankin.ru/blog/8d252743-5980-4b94-a40f-88f05552b4d8.png"]	
617f8d16-e887-4e44-8162-995eda661bdc	e2b13da3-083d-4398-9535-52aef710fe49	Carousel	["https://minio.test.prof-stankin.ru/blog/9ccc3e11-9f97-45a0-9c99-436d4d504752.webp"]	
496eb237-308a-4a12-88da-33abfcc5d9f6	5b056835-1ae6-40ea-a4ae-914f029c0a92	Carousel	["https://minio.test.prof-stankin.ru/blog/6b5ff42a-e03c-4aae-91f4-8f573478da4f.webp"]	
773d4afb-d256-46d9-aab1-2a6ca502c59e	66478b5c-06f1-4808-b4cf-deda2baf7179	Carousel	["https://minio.test.prof-stankin.ru/blog/35156da3-33d3-43a3-8136-6b43873ff5a5.jpg"]	
154ae003-5a0d-46bd-999b-b0c3ff6614fa	f04d5904-a70a-4696-9094-189c75569558	Carousel	["https://minio.test.prof-stankin.ru/blog/d2d8fa95-f0a3-4f65-a3d0-2a9f70dcab2c.jpg"]	
f4206220-3eb2-4c03-a2ad-ef47bba0e2b9	9933ac3b-53a5-4156-96c3-f1985a1248df	Carousel	["https://minio.test.prof-stankin.ru/blog/6e878935-037d-41b0-8ff6-f357cead68cd.jpg"]	
10641aa4-0311-438d-99f3-8d973ddb0232	5230f99f-b9ed-476d-852e-461f9d0e1d46	Carousel	["https://minio.test.prof-stankin.ru/blog/3ce3790c-f6ff-4d6f-9713-e0142d29ac66.jpg"]	
cd4b213a-082b-4576-a5e7-a92011e73b9d	48353f6e-5e51-4b6d-8fa5-b3e1cddfd403	Carousel	["https://minio.test.prof-stankin.ru/blog/0991f660-aa4d-4a59-8469-42c3e62c22b0.jpg"]	
b4d04850-98bb-4bbd-b3a2-e11a1df2bc01	803fd33c-12aa-43a2-a175-f3f540762ba5	Carousel	["https://minio.test.prof-stankin.ru/blog/041a2827-7ab7-46f9-b7a2-894e3c2e657f.png"]	
47baa41c-4687-4b91-bcb0-fe81a3ae2306	aff3df65-1f5f-43ba-9245-78bfe84d3ae1	Carousel	["https://minio.test.prof-stankin.ru/blog/2fbcbce9-91cd-4b63-9b48-bb71d3a851e6.jpg"]	
10b0bf66-3672-4e86-821d-e366ec749510	aae1a1fd-fdb1-4796-b410-1384212f6325	Carousel	["https://minio.test.prof-stankin.ru/blog/fa29fd34-125f-4e01-afae-6eec56daa2ba.jpg"]	
6a7d81a8-0487-44b0-9384-014a13d0505c	165f4663-86d7-470b-9339-149e4a953210	Carousel	["https://minio.test.prof-stankin.ru/blog/53a4b2d4-050d-4705-9ef8-50dcdd883b5e.jpg"]	
fd8cb097-bb6e-4fc4-93c6-982171f024cb	5399c3a4-75fd-4c75-b970-3674c71631d9	Carousel	["https://minio.test.prof-stankin.ru/blog/6c724eb8-3e18-4557-ac11-44858a882c8e.jpg"]	
6e724d58-9fc5-4313-bc08-afb8fc07d8e1	e7f0b372-40fa-4afe-9301-2d0518a9bfd8	Carousel	["https://minio.test.prof-stankin.ru/blog/a4156211-2010-4179-99f7-24af1c0827d4.jpg"]	
dc9e260b-f520-431c-883e-02bd9445947c	afd1d9c8-9a36-435c-b4a7-f72cc55c9adc	Carousel	["https://minio.test.prof-stankin.ru/blog/56569522-5dcc-4bbb-91b2-1c326269da89.jpg"]	
55369d39-62a2-4263-9bd3-74cd0ac94d62	32ec52d8-5c85-4cd0-a4de-d5d268bc3b9f	Carousel	["https://minio.test.prof-stankin.ru/blog/8d9c2b89-f0e5-416c-bea1-d8f177b309fd.jpg"]	
dd2f2f74-c37b-4c27-82ff-5682f42a5034	6c0a9dca-9eb2-4206-9c91-77149429f199	Carousel	["https://minio.test.prof-stankin.ru/blog/3dd2d8e6-5aaa-4f7a-ab8b-14ca645c6604.jpg"]	
6668df31-1079-4afa-b921-b645e2056499	8b0463b4-5175-4d24-bfe6-e3a5cbda42fe	Carousel	["https://minio.test.prof-stankin.ru/blog/8d83ff04-b2f2-4c1d-a16c-c93dc927d16a.webp"]	
75783e0f-5435-4f16-9a67-a270f30836aa	e3ef668b-0dba-4e15-b12e-08c40415fe95	Carousel	["https://minio.test.prof-stankin.ru/blog/16d951c4-d539-4a7d-b97c-2e9e5934784e.jpg"]	
e6c243e9-a9ed-4752-b150-df5a67167ad3	3546ddf7-02c5-4500-95b9-dcb6bb24e4db	Carousel	["https://minio.test.prof-stankin.ru/blog/f363d112-2a31-43c0-a34a-6070149f0304.jpg"]	
7188fd22-8884-4651-8f15-b721a047383b	7564a5be-8144-4780-a6a8-be8a59af760e	Carousel	["https://minio.test.prof-stankin.ru/blog/433cc860-1902-42f5-b1a4-588d18ccc587.jpg"]	
5020d9bf-1436-45ec-b1e7-f4ee6b822239	4cb1bd9b-4975-4612-a9e7-d14f5f2138d8	Carousel	["https://minio.test.prof-stankin.ru/blog/01e753f2-a12c-4c03-b9c7-b5a0d8c1c7d7.png"]	
e517af7f-571c-4029-a1ac-f0c0380aab72	44f801a8-0868-4bdc-bd27-ef5b04856366	Carousel	["https://minio.test.prof-stankin.ru/blog/db5b1a36-d600-4b7e-8421-fe9233b22722.webp"]	
1d7ec43e-ff9f-4c27-ad66-6f624a74b3e7	0cbf7032-c814-4703-9e48-bfdd030f792b	Carousel	["https://minio.test.prof-stankin.ru/blog/d74a8a6e-f519-4fdc-bfeb-ad5fca44e148.jpg"]	
beb3d564-1154-4fed-8691-010bd511b370	36e97dba-2957-492c-82ba-d7586a1ddb23	Carousel	["https://minio.test.prof-stankin.ru/blog/226c8a92-6082-455c-aebe-1fc50e02b36f.jpg"]	
ef6d00cb-e9c0-4297-81f9-7192eda9c44b	15b08e5e-6bf6-4c2f-b462-00318d29e3b7	Carousel	["https://minio.test.prof-stankin.ru/blog/3404d07a-314e-4478-8ec1-6fbca5f12593.jpg"]	
3660b8b0-6f37-41a2-b24b-10f889cb6124	d173d8b5-21d8-4261-bce2-d39a951efac2	Carousel	["https://minio.test.prof-stankin.ru/blog/7773efcc-be72-4deb-b497-33f0d10e2b7d.jpg"]	
950f23f5-24ba-477d-9d03-9710ee8e9ce5	88e0479c-9f10-4007-b113-416190b4af9d	Carousel	["https://minio.test.prof-stankin.ru/blog/cffc1018-dd3c-492b-bfbb-3fd95d40574a.jpg"]	
5ebd79dc-b717-4d91-a920-e157e0b1a230	2dd5cd1b-7586-4493-85da-50705f0bad03	Carousel	["https://minio.test.prof-stankin.ru/blog/f761e1a0-2385-4137-8bb6-921dce1eafe3.jpg"]	
4b5e9a70-95e4-463f-8503-3b45306e8d36	33039b4d-8553-44a8-be0b-7f9356515f34	Carousel	["https://minio.test.prof-stankin.ru/blog/1461f7e6-ee68-4d4e-bc9e-d1be9de2c6c3.png"]	
a6a3e980-73b9-420b-9538-d84f3d93d50f	d8bd7db2-e465-47f1-8061-d1a461878f6b	Carousel	["https://minio.test.prof-stankin.ru/blog/348c6b1d-7f80-43e1-a9e1-62227b96450c.jpg"]	
c469743a-2183-4a09-aa54-bcfcc58dc9c3	f92015cc-9621-4729-a65d-47c3973b8726	Carousel	["https://minio.test.prof-stankin.ru/blog/21ae5783-b12f-46aa-88c9-58dc790497aa.jpg"]	
5f1bc259-2850-4503-a84b-e04099184a3a	1b3be1a9-5009-4c24-b04b-522c34cfd25d	Carousel	["https://minio.test.prof-stankin.ru/blog/2bdecce5-5204-4022-9f26-fc1ef0a12075.jpg"]	
d9ba41bf-456d-494e-b534-2f70211ddf54	a9236c6b-2158-4dd9-90a2-2b9c25d8a7ed	Carousel	["https://minio.test.prof-stankin.ru/blog/11659131-a495-4b4b-a5da-f99a639e598b.jpg"]	
15ef2bf2-2a66-4a6d-8012-465c33bf1176	d4f43282-3e7d-4709-b260-1db2ca2cdf96	Carousel	["https://minio.test.prof-stankin.ru/blog/deb9ea84-5268-4d7c-a3b0-7518134c8662.jpg"]	
01832beb-5ee1-41a1-8919-f3bb78450388	e472e3a3-c145-480e-b613-feebc050d66c	Carousel	["https://minio.test.prof-stankin.ru/blog/0c83dbb9-ae38-4c98-846d-f5d3b37b75fd.webp"]	
501b31b8-afa8-4f16-9445-b2c6183db10a	633e2d15-d6ae-4b37-aa98-732db3a7c88d	Carousel	["https://minio.test.prof-stankin.ru/blog/97ce007a-7125-4cf5-9724-b7cde354ca3a.jpg"]	
99463a4f-3d87-4332-9ea9-dd8b2e6b0e2e	9e3eb3a1-8338-4bb7-a96b-b8a6af0f801e	Carousel	["https://minio.test.prof-stankin.ru/blog/eec5f798-5aa4-4678-b5a8-df1e50eae2f9.webp"]	
72feaf1b-cc90-4cc6-aa02-dac1c1af0d75	41f2ef81-c39c-472c-960a-6942201d3c8c	Carousel	["https://minio.test.prof-stankin.ru/blog/a61cb913-4f88-4c53-a014-3794aabf8290.jpg"]	
43db84ed-db6b-4a0f-b6eb-e140b6b183b6	70b6847f-0b73-47d8-a716-ae94ea3c3275	Carousel	["https://minio.test.prof-stankin.ru/blog/6605ea47-442c-439a-9cfd-cd5c44899ca9.jpg"]	
5726eb60-34dc-4887-979c-469330b8d07d	fee91af5-9865-4693-8357-447d89d0d12e	Carousel	["https://minio.test.prof-stankin.ru/blog/f1056df2-c347-43fb-b3d2-1c7c464eade6.jpg"]	
c608d140-fe92-40eb-abdf-9dd890232b59	89b8088c-3ff8-4b59-9321-ace68d77afc2	Carousel	["https://minio.test.prof-stankin.ru/blog/306995a4-3771-4ab2-a02f-fd1adf1811a2.jpg"]	
b0291b03-86dc-4cb7-8561-eea3547be26c	cbce3dda-1175-46d4-893c-4aa5f3801c46	Carousel	["https://minio.test.prof-stankin.ru/blog/ee1e5b32-e165-4f53-8bdf-8251cdd701af.jpg"]	
5b3209db-7245-40be-a272-a72626f736f4	aabd5547-4297-42c3-afa5-4a10a5e3f9cd	Carousel	["https://minio.test.prof-stankin.ru/blog/cdc18211-1b18-4eb2-a356-5385746cda2e.jpg"]	
b0c6f88d-641e-47ac-a4aa-980e97ec4c73	0de0d8af-6289-4791-b1c4-5c1ad58eb847	Carousel	["https://minio.test.prof-stankin.ru/blog/39c9163b-25db-44f0-b97c-2a8f04aac99b.jpg"]	
fd1390e9-7475-469d-b067-3bc01a232564	882d56eb-5430-42e6-88b0-cc1a318d9325	Carousel	["https://minio.test.prof-stankin.ru/blog/c326263e-2e1f-4481-9269-eb482ad9bb49.jpg"]	
6f4d4274-1f81-49aa-98b6-738dad47b7fb	2a6e5e46-c338-4297-8041-923d90123e70	Carousel	["https://minio.test.prof-stankin.ru/blog/27278399-d8bb-4af2-8dc2-02d6b0cf26a3.jpg"]	
f2f11571-4bf7-4539-a90e-e882ec934e3e	4821d252-f0c1-4e92-82fb-b2edeb5f3b27	Carousel	["https://minio.test.prof-stankin.ru/blog/f41f8624-f8d3-4a4d-8ca4-cc7c86ee89eb.jpg"]	
4de53601-c06f-472d-9bda-2d7611b4618b	a4fa2a01-9447-41f8-8567-eda4bcb02dbf	Carousel	["https://minio.test.prof-stankin.ru/blog/ee09ea4f-d854-44df-b53b-b90fb8965da2.jpg"]	
15a4073d-0798-4bca-9945-0bacad5400be	60ebfd14-65f9-4191-9fbe-104d5a3bdcb7	Carousel	["https://minio.test.prof-stankin.ru/blog/857f6ef2-4b70-4aaf-9fe7-ed164f52154c.jpg"]	
1a0cb717-635c-44d9-b145-119e01eebd60	b1aca649-c862-42c3-a7c9-024d58414149	Carousel	["https://minio.test.prof-stankin.ru/blog/25c34db3-2b65-434c-93d5-4b43ac1cf1a7.jpg"]	
53efce0b-dfd4-4777-8f78-ec79bd84e2f6	507469f3-5939-4c99-93f5-e8db727cae44	Carousel	["https://minio.test.prof-stankin.ru/blog/40739b56-17f3-4fee-868d-e2bcf5a28d89.jpg"]	
71a6732e-1c80-4473-93bb-6942acb13247	ce43103b-dd08-46cb-b72f-f5ab323ff038	Carousel	["https://minio.test.prof-stankin.ru/blog/35d5c322-1187-4df9-97bc-c070aeed172f.jpg"]	
40f76666-df00-44f8-93f1-ff0b1f731303	f23195e1-1f3c-476c-a426-7aaa8f5734af	Carousel	["https://minio.test.prof-stankin.ru/blog/edcd6d9e-f30a-4f0b-87c0-a0628488dbdd.webp"]	
3c131a24-2091-435e-996f-224d9ef1d4e1	2a9d84ff-8aeb-4ed7-933c-ff29bfca6e16	Carousel	["https://minio.test.prof-stankin.ru/blog/b090848c-7dab-4448-b596-faeccdea91dc.jpg"]	
fc69e406-e048-4546-9350-bc431096abc5	1880d68b-5cd6-4631-8ef3-97044caf9775	Carousel	["https://minio.test.prof-stankin.ru/blog/d12b5888-1a68-4dee-9564-8f875d04e421.jpg"]	
98586ac1-422f-427a-928b-41f3595111a2	3d0be395-1e80-4ea2-8ce3-e73cc0c1db1a	Carousel	["https://minio.test.prof-stankin.ru/blog/1a514b1f-a62c-4674-bada-ba6d6856ad29.jpg"]	
c899bc74-a8cb-4126-a523-4716e329ce5f	adb1e8e1-2f9c-48bd-b3cc-b85f5b215c68	Carousel	["https://minio.test.prof-stankin.ru/blog/9acad7be-97d0-45bb-9469-387ca6490855.webp"]	
31fa54bc-d2dc-4de0-97d5-f008aa9857f1	390e4b6d-b9ba-4983-bc79-ed695566606d	Carousel	["https://minio.test.prof-stankin.ru/blog/e9ed9ace-d104-4a1d-b3bb-109491862878.jpg"]	
3ba8315e-2c9a-4613-8620-1357481a8fe2	80dcd263-3f5f-433b-899a-50ffb470ba04	Carousel	["https://minio.test.prof-stankin.ru/blog/16f3e9ea-b3ca-4ced-ac64-ba26cd6b2f4b.jpg"]	
574f8add-8b5b-476e-b1df-17f92c6d3f89	eab98fec-aadc-4ce3-a7e1-f9caba0c6d8b	Carousel	["https://minio.test.prof-stankin.ru/blog/94fb56b5-196a-4d28-ac68-ddf9c95895f5.jpg"]	
54aba499-d826-4917-8cc1-e3a37c96b57e	80e2afb7-8f46-4180-93bd-3bae7b36d3ce	Carousel	["https://minio.test.prof-stankin.ru/blog/7d4918c8-96b6-4cf1-b54c-ffdc82a2a686.jpg"]	
193440ff-843a-4416-81cc-f69e4470b546	50a6354d-179d-475e-a472-56553d726e5d	Carousel	["https://minio.test.prof-stankin.ru/blog/3999aa43-50d0-4532-811e-275baba330fa.webp"]	
e433ecda-d8dc-4dc9-b0f9-c61335aca0f0	d7e59bc1-458e-4fcf-ac56-7957c8b970d8	Carousel	["https://minio.test.prof-stankin.ru/blog/e44af5d6-d4bd-43e6-bd3e-0e7dcfc80231.jpg"]	
0dcdc241-a8b4-49bb-ad11-e731e61537bd	dd0deea4-387b-4c67-95a0-0d70613308ec	Carousel	["https://minio.test.prof-stankin.ru/blog/b8c74898-7a2f-42bd-873e-728530e909b3.jpg"]	
4e1d4ef2-a3e5-4165-a5f4-58ed358b508d	e9ea5126-395f-433a-8a75-d684fbcc4af0	Carousel	["https://minio.test.prof-stankin.ru/blog/fbfca6ff-5c13-4c92-82fe-49200f988659.jpg"]	
05c9ec22-1801-4230-9df1-cf6fb121ee5d	dce68be6-2ed8-45de-a7ac-3c5c96e6455b	Carousel	["https://minio.test.prof-stankin.ru/blog/266487f0-d8b6-4cbf-9af2-0688f88810cf.jpg"]	
a714b07f-2f8d-4d06-98fb-e45895bbf327	48234def-7982-4096-8f45-a3d8fff445e3	Carousel	["https://minio.test.prof-stankin.ru/blog/1bad3258-86a7-4c74-a945-8ba0f0daa8cd.jpg"]	
c88b8ef2-5c8b-4d7f-a664-e221049fd3ec	0e8eb5f4-1b14-477a-b0d1-e1551d81554b	Carousel	["https://minio.test.prof-stankin.ru/blog/7323a43e-b0e9-400f-a96f-3bd2b5c093e2.webp"]	
134d79a6-48a5-4084-a4aa-c2fbc7c1bf22	568a0153-97a1-4fe0-af8f-ab4b4f5ee4e3	Carousel	["https://minio.test.prof-stankin.ru/blog/51b7592d-3e0c-40e6-ab2f-5a0d10f54808.jpg"]	
21250462-ac04-4b0b-bb41-ee600d84945d	b64c157c-141b-49b5-8a30-1e1c7f45fe9e	Carousel	["https://minio.test.prof-stankin.ru/blog/896b7c81-6281-407b-ba70-ec1e8319f5db.jpg"]	
ede7ef37-a48f-4209-9e29-a9c007e5c121	0df6e27f-d920-40cd-aae6-4165b4d6d6f0	Carousel	["https://minio.test.prof-stankin.ru/blog/ccf2914e-d6f6-4929-9ae8-2e46e13dfc7b.jpg"]	
f68f56f0-8c6e-48f5-a85b-fa61f30b95ea	49b4b633-c950-40b4-87fb-ef03c65a9055	Carousel	["https://minio.test.prof-stankin.ru/blog/1e41c7e9-857b-4673-a50b-ca1b10844245.jpg"]	
04424351-09cf-4cf8-b84d-19a7224515d6	32b48018-260e-4a05-9565-e63f6c00dbb0	Carousel	["https://minio.test.prof-stankin.ru/blog/807336da-e493-4832-a360-cc0ed7e71e01.jpg"]	
d2177221-0844-49ee-bc2e-3b0a420dc18a	b7742340-934f-49f4-8b9b-2ac670acaaae	Carousel	["https://minio.test.prof-stankin.ru/blog/075891cb-d7bc-4b93-9bf9-2eef36001295.jpg"]	
b511e56c-2e31-4f86-9e37-067e18eaaa92	fb2d4ba2-34c8-4cf9-ae1b-38197a76f2bf	Carousel	["https://minio.test.prof-stankin.ru/blog/f6f294d9-53d1-46f5-ac64-b588a6309fa2.jpg"]	
3dcb20f4-beb2-42f7-8e60-56522fe486c9	f1844c1a-f1a2-420d-a101-2506213f0cff	Carousel	["https://minio.test.prof-stankin.ru/blog/83338c6a-d5e0-4a2c-9431-a41a8f188b58.png"]	
14e9a2b2-0cc1-44ea-8ff8-d22f43e56c8b	268ff503-8150-4180-b7d4-6f518a3b5ad6	Carousel	["https://minio.test.prof-stankin.ru/blog/fe1d5cdf-6674-4629-8f97-7f20068e4495.jpg"]	
5555591f-3de1-44d4-87a9-899db287da12	ddee2aa5-2246-4eb8-aaaf-b266d29a9438	Carousel	["https://minio.test.prof-stankin.ru/blog/8286eaf9-c617-4b9b-b82b-2ce7ec9b1903.jpg"]	
b52a8f05-5bdb-462c-8770-a29d117cbdea	a59fc31c-8739-4dc5-a744-a1d80b595337	Carousel	["https://minio.test.prof-stankin.ru/blog/3d4c3e97-e648-4a41-b5ae-05ed93a84567.jpg"]	
25b96c54-9473-4d6c-93fa-e4b80a34dcf4	18d5bc53-9bf0-4319-8250-e654e72a63c2	Carousel	["https://minio.test.prof-stankin.ru/blog/0143e637-6d54-4ef6-9507-764f65dcf752.jpg"]	
e077f1ea-4137-4f44-a43c-fc75a2a8509d	5431fa56-c6fc-444b-86ca-5edc12caa8ba	Carousel	["https://minio.test.prof-stankin.ru/blog/6f622d86-a455-4135-ac15-7ef5effa8731.jpg"]	
eaed49dc-0e9d-4aea-b526-aa08078a3bec	588ed0a0-f063-457f-b747-9917bd0e9d23	Carousel	["https://minio.test.prof-stankin.ru/blog/76c75a11-abb2-4e8e-9acf-5e6d5d76e3b8.jpg"]	
4131c91f-dea0-41fc-b3d7-b95f6024d145	24a5749f-ab77-470f-b043-ce9531a4a0fc	Carousel	["https://minio.test.prof-stankin.ru/blog/e1063721-6e4b-443a-8795-04325e301529.jpg"]	
7259164c-bca0-4c6d-931f-39bed528d044	fac2f2a8-e838-46b4-aa48-b684e3e5a102	Carousel	["https://minio.test.prof-stankin.ru/blog/1b44308b-b387-4123-a055-a967b77623a1.jpg"]	
b0aa8893-4503-4d76-8e7c-89f1c0129987	d6504593-1f01-496d-a05c-a889b18d799c	Carousel	["https://minio.test.prof-stankin.ru/blog/a84ef0d8-443c-41dd-b0ba-edf9e3fe5dca.jpg"]	
835c279c-e2de-47d2-bfdd-a96c795db0a7	5d82fbc2-b24a-498d-bce8-aa63c9a5ffb8	Carousel	["https://minio.test.prof-stankin.ru/blog/e06840c2-6fda-4b71-ae18-7bb6e5fe9c48.webp"]	
87c16fe8-2a24-40b7-8a79-4dc604c70365	6158e4de-e192-4414-9978-5b4fa86c161b	Carousel	["https://minio.test.prof-stankin.ru/blog/c92b891f-df92-4bbc-b8bf-e02128c649b4.jpg"]	
7f144420-4203-46bb-8653-4445b2676e7f	7d2bb3fa-319c-4be4-bdc3-706092c1446c	Carousel	["https://minio.test.prof-stankin.ru/blog/89b32ec8-7b7d-4402-b499-bb9479dfd309.jpg"]	
77b55050-2161-4ed0-b30e-173938d6fc74	06d8bfb1-481e-4a26-907a-9128a6441bbd	Carousel	["https://minio.test.prof-stankin.ru/blog/cdfc75d5-0e06-43dc-8cdf-6ebc4ebcc84a.jpg"]	
e60e28ae-2868-4c4b-b102-18d3ff678f51	2c850be0-48b4-4088-b11e-7da4c6406bc1	Carousel	["https://minio.test.prof-stankin.ru/blog/68daaec6-96e6-4be4-87fd-af0668389b71.jpg"]	
3f30af2b-9f2e-4083-92ab-addb3a34b64f	3804da53-36a7-4238-aa2a-958f54af92ae	Carousel	["https://minio.test.prof-stankin.ru/blog/a2e2923b-c004-41cd-a87e-690c6e49868b.png"]	
4675be76-1a90-407f-999b-81f41b3171f3	802df78e-e1d8-4909-ba1c-cc3c08839da8	Carousel	["https://minio.test.prof-stankin.ru/blog/c6a882de-8f11-4410-9e55-3187cabd651f.png"]	
ba6f0c9e-6282-4eb9-af1c-6fb03def6836	b38c83ac-3351-47d3-b68d-5b69543f39f7	Carousel	["https://minio.test.prof-stankin.ru/blog/20b8b7bd-5abc-49d3-9b71-0828c5dfcf11.jpg"]	
2022e6c7-45ad-4b2c-8885-e71906751ea2	77ae61c9-66c1-41db-b10c-8a6d236197c5	Carousel	["https://minio.test.prof-stankin.ru/blog/5f9be1c6-eb74-48fb-9eb2-98a20f48722e.jpg"]	
4f9f30a2-f056-469a-845e-9764ba0de3fe	6df1d347-85ab-4fa6-bd67-a7614f035f65	Carousel	["https://minio.test.prof-stankin.ru/blog/03370ddf-01f8-46df-8dca-57003f8d8eb1.jpg"]	
84f26e00-b0d5-4880-bdc5-2fe26947e62d	0ba5f9d6-5f71-4d75-9874-4b97cb9e8f8b	Carousel	["https://minio.test.prof-stankin.ru/blog/0267c3bf-5bce-4f51-acb0-e9f88d1ef1a9.jpg"]	
105911c5-6077-40e7-a1af-0711499fc5a0	8be2c278-3bc4-4a2f-a6ab-092876c4784d	Carousel	["https://minio.test.prof-stankin.ru/blog/8fa76d63-09d3-4d9e-b4e4-c0548420e960.jpg"]	
077503aa-4909-4efd-affa-cfa6f1f9e7ef	3fd30232-6b67-4642-b119-709f109eac64	Carousel	["https://minio.test.prof-stankin.ru/blog/17249fc6-8171-44ab-a506-4515138b70fe.jpg"]	
8875ac8f-fddf-4bd6-b788-f4d168a6bb4b	0e6735fd-3add-40b5-9e5c-b9fd9e149b2c	Carousel	["https://minio.test.prof-stankin.ru/blog/8c812fcc-524b-4eed-8fda-713f0f87a112.jpg"]	
590b57d5-0dcf-4d7a-84cb-3c72811ed6a1	58d914e0-4288-4cad-896d-cce067487061	Carousel	["https://minio.test.prof-stankin.ru/blog/bf3432a1-76be-451d-9edc-711f73ca43e2.png"]	
0b17d277-7b22-42c4-9f72-b8d9d93474d4	53e85388-8a2b-4af1-a55f-4598669a3845	Carousel	["https://minio.test.prof-stankin.ru/blog/c8d2e436-e791-465b-b558-191b108ff0dd.jpg"]	
57af41d0-cb4c-4f85-864d-abef0137acdb	f7dde8bb-2bea-4a77-8098-b5f35576979f	Carousel	["https://minio.test.prof-stankin.ru/blog/badeaccc-4521-4e39-935f-6e8b5711d16b.jpg"]	
998d0b33-2fa2-431c-b5d9-0b7fbbecc8ae	39e651ca-7eb9-4cc0-8766-643bb21f3c7c	Carousel	["https://minio.test.prof-stankin.ru/blog/c62d7f15-04c9-45d0-b578-10c5bc6df2f2.jpg"]	
62d83bc1-9673-4fa2-a48a-94ebc459d537	ca4c585d-1361-4cb7-a0b2-403296b97e4d	Carousel	["https://minio.test.prof-stankin.ru/blog/a1b66204-9329-4a81-8a22-c8d0c42dc6a3.webp"]	
e26db3a4-3317-46e5-9d21-01b91755495a	7ab75b13-6155-45c7-8b67-52a0c1fad7e7	Carousel	["https://minio.test.prof-stankin.ru/blog/010502a2-dc5b-4d2b-9774-c9c311591a3d.jpg"]	
979abe50-1b84-4fff-8797-12acb4fed1f1	6a05b5c3-3e56-4a3f-a4e9-23fc3658bbab	Carousel	["https://minio.test.prof-stankin.ru/blog/ba42e316-e3bd-41c7-ac4a-fb2dbef7d8e4.jpg"]	
4f30509c-fcf1-40ac-9bf8-061247fd7761	276de1d8-d249-4b8e-bfc6-68e009d255ce	Carousel	["https://minio.test.prof-stankin.ru/blog/bf829cd4-50bb-436d-9588-8b69cb826c7a.jpg"]	
d2b602eb-1468-4895-91c4-1d06ddab0ef1	71ad5148-c41c-4dbd-b6aa-0b05983051fc	Carousel	["https://minio.test.prof-stankin.ru/blog/ed43f0b6-22c1-4799-bd7c-0cf785194fe9.jpg"]	
17f33d5b-1078-4f61-9b50-ce3d6d5299fe	bb782bd8-b4ad-4662-a87e-05c3a37fd39c	Carousel	["https://minio.test.prof-stankin.ru/blog/7d7976d4-f3a3-4436-a0d7-3bd2b1a16794.jpg"]	
96e6e0b5-454a-48b2-ab3d-831d73d4df4f	b20dbb7e-c4e3-4a29-8729-3ba8e9511c7e	Carousel	["https://minio.test.prof-stankin.ru/blog/dfeeefdb-53b3-4929-88d8-16560abad642.jpg"]	
c7620f2f-ba97-4afe-a2b4-ee4d7174eb00	878f93a7-66a5-4aaf-ace1-0d9d08eb5211	Carousel	["https://minio.test.prof-stankin.ru/blog/0077314e-0d08-43e4-8b88-b08e284dfb1e.jpg"]	
579fe5e7-8554-4751-8966-963342d924f2	53368335-a097-44cf-a9b1-9666cf440089	Carousel	["https://minio.test.prof-stankin.ru/blog/e01ab736-3806-4fb4-9ecd-ae786bc4922d.jpg"]	
c2472d21-e8b5-423c-8ba3-3083e3582119	bb635b05-c105-4aa2-bfa8-e1c3bcbb5fc2	Carousel	["https://minio.test.prof-stankin.ru/blog/f2fa411c-e645-47e8-b94d-0f3300192e02.jpg"]	
dd237f95-9591-4e08-914f-ea437e3becd0	ae462ce4-2d4e-46fe-8a39-d4a4337393db	Carousel	["https://minio.test.prof-stankin.ru/blog/9b57f017-4d7f-48c9-9e57-1db93061a0e4.jpg"]	
feaabe28-c647-4bd3-9a70-7dccd19640a5	ccdbf49b-4f5e-486e-96f9-c0b2ce5da4b9	Carousel	["https://minio.test.prof-stankin.ru/blog/c711dc14-40f7-4ce4-a94a-6f25acc04fa5.png"]	
a8ec5b64-89ef-4738-a821-8602b5095f37	0b18049c-3620-48ec-93ee-fded42a21310	Carousel	["https://minio.test.prof-stankin.ru/blog/d97ab540-fd60-4285-bbd8-809388987bd0.jpg"]	
aed23d0c-f81c-4751-abb0-ec6ea77c7c27	0c2747d1-cc59-41f3-b398-6daf46818470	Carousel	["https://minio.test.prof-stankin.ru/blog/b77097a1-68d1-484c-bb63-c9b0b7a693f3.jpg"]	
9ff7833a-0d16-48a2-9903-c49f29bc00d8	9f0aae23-c84f-4f3d-b48f-9f439f7ad0a2	Carousel	["https://minio.test.prof-stankin.ru/blog/28db2d0b-4631-4aba-8281-1004d8aeb684.jpg"]	
29dbbbb1-734f-48d4-90ad-151fa25fae31	8502d424-6b91-42fe-b0d8-3252802493ea	Carousel	["https://minio.test.prof-stankin.ru/blog/3ba2947f-c72e-4292-ace0-f3a447cfb6c4.jpg"]	
10b0ec9d-8609-4772-94bb-e70731507ff2	52bec5a4-01a1-450c-a1b8-8e0791c2d31e	Carousel	["https://minio.test.prof-stankin.ru/blog/f3a74a41-5694-46f1-b8f5-33e08c4670da.jpg"]	
1bf68e78-deb7-4448-9d8f-ccf23d09da30	ed10bcd5-b8f9-414c-a298-1c614c49b442	Carousel	["https://minio.test.prof-stankin.ru/blog/686733d5-ddcc-4b19-b7dd-fc2ab70c528c.jpg"]	
9845b96d-2e38-4d6a-9928-dba1ebd88fa0	ebdd3a3c-af06-44e6-a17c-38f0429df727	Carousel	["https://minio.test.prof-stankin.ru/blog/f4ef71d1-6281-407c-9c84-be601fdb9baf.jpg"]	
042f7cc4-7699-40b1-8a7d-b95a9f517d28	974acc21-59aa-4f28-967d-4e08b4cc996c	Carousel	["https://minio.test.prof-stankin.ru/blog/97bb98b9-f62e-4873-b220-00ac5bc9463b.png"]	
eb48dfe4-ffbc-48aa-91bb-eb69e2c6eb27	f8a32873-a5d1-4fb7-8ecd-08a85f609efd	Carousel	["https://minio.test.prof-stankin.ru/blog/7aca76ae-146c-4e88-9a5c-b1c60143fe98.png"]	
0ab6af00-94ad-4f8b-9d09-9d53129f0e25	7355badc-beb7-4a11-b82a-84254e5df691	Carousel	["https://minio.test.prof-stankin.ru/blog/da158231-41f5-4a26-bcd6-8d432a6320da.png"]	
8a0a51cb-be41-483e-83f5-3adef456ae5a	f80eb656-f8bc-42bf-a017-9854d852a355	Carousel	["https://minio.test.prof-stankin.ru/blog/ef7d8913-cc33-454f-8e56-6d683c3424c0.png"]	
af904271-a126-4498-a4cb-0bdecec44521	b64d89b0-8377-4c8f-8b4a-0ea4b5908215	Carousel	["https://minio.test.prof-stankin.ru/blog/cf9047e9-d832-43c7-b855-6e63dfae5146.png"]	
4818b8e5-27a8-42ed-b70a-87ed1b2b3fa4	ba4e9adf-2969-4397-9f75-17b3b40c65ed	Carousel	["https://minio.test.prof-stankin.ru/blog/d6dcc553-5dcd-47d3-92a6-26809d9b6373.jpg"]	
d8638d43-5780-4e50-a143-48ebab21b20f	ffe64e3b-3271-426c-9860-9acc39f0b96e	Carousel	["https://minio.test.prof-stankin.ru/blog/9410838e-fc79-424a-b221-f87f2f9b82ae.jpg"]	
54817ce4-0059-4ade-b5da-19345278b05f	b8bb3ba3-e0c7-4f5a-995b-eb74f8e4a066	Carousel	["https://minio.test.prof-stankin.ru/blog/cfa4da7f-b2b5-4286-b864-a02b80cab4d5.jpg"]	
bc054cb6-af9f-4b2d-8fda-0359969465d6	884ec068-85c4-41a6-a575-95df380be6d8	Carousel	["https://minio.test.prof-stankin.ru/blog/6c95e7eb-affa-4a6c-b8bf-d9e59379af6c.jpg"]	
d70e8e62-7cfc-4b08-8e3f-72cf7e5fca76	afda61aa-f958-4718-af50-922fb6c7febd	Carousel	["https://minio.test.prof-stankin.ru/blog/4952c13c-950d-44ee-9960-bff462169a67.png"]	
efddb9a5-a34f-4ff3-8a46-92dec9193ef7	aa32fff5-c676-4653-8db5-a65b379b64b5	Carousel	["https://minio.test.prof-stankin.ru/blog/8a83c29e-de22-4e27-bb88-4a785fe8ffcc.png"]	
ef724ee9-3420-4248-875e-dbaf41abc626	062ef0d1-8691-40ee-964e-f7ec820ad7d6	Carousel	["https://minio.test.prof-stankin.ru/blog/39ee971b-b59c-4d9b-a66c-268db77b322f.jpg"]	
11b80d5a-1458-40ff-bc5b-1b4e65dee1e0	d1aeff36-213f-462b-9d10-02b78799579b	Carousel	["https://minio.test.prof-stankin.ru/blog/c02bccde-081f-41ba-8a32-3207aebcfdb0.jpg"]	
292ff030-f87b-4878-a8f1-38967c3ef64f	8b2e399f-9960-46df-b773-6b497ceb2939	Carousel	["https://minio.test.prof-stankin.ru/blog/a47da0b3-3388-4402-801e-75a76103b1a4.png"]	
44553e5b-be3d-415d-b906-2e04516ae0f2	be895418-203b-4b83-a752-378e1f2f6bd1	Carousel	["https://minio.test.prof-stankin.ru/blog/ca040ae5-311c-4adb-98f7-ac035085ac18.jpg"]	
93aa6bde-b83c-4f91-a10e-a51e03760bc6	8bdc3c3d-e18a-437c-a922-3794a23cdc21	Carousel	["https://minio.test.prof-stankin.ru/blog/08c6f3e3-e0b0-4726-b842-8259864c9bc6.jpg"]	
77915905-b766-47cf-9eca-5937627e49b4	6328060c-9278-49b9-b028-15f7bfa5ff2d	Carousel	["https://minio.test.prof-stankin.ru/blog/1bd1d7c7-f6c5-4aa7-b28c-d3720049d47d.jpg"]	
8fff8e7c-3a92-42ef-87a1-f2ea81293b07	5af747eb-15c0-410f-8d9e-24d0bb52294d	Carousel	["https://minio.test.prof-stankin.ru/blog/3ffde658-5d34-44f8-adee-cc2d6beb9d76.jpg"]	
635679c3-f437-4f48-adf5-44a5cceef744	6eb7b160-48b0-4d0c-92e6-7e51358d51a3	Carousel	["https://minio.test.prof-stankin.ru/blog/f7bff547-f6d2-458e-8a96-18c0b2d45382.jpg"]	
917151ae-3858-4ab6-a39d-321f1f06a7c2	153f49b2-b858-4d2c-8696-27e6585cedbf	Carousel	["https://minio.test.prof-stankin.ru/blog/591dee98-a042-42ba-9dd8-8f52dedfd49c.png"]	
8ef17865-ac75-45c6-ace7-48d005432c36	8582ff25-4035-44c1-8cd3-6ee5ea147be4	Carousel	["https://minio.test.prof-stankin.ru/blog/423536a8-03d3-42b6-a693-83915ace5850.jpg"]	
4c48e4d1-84be-4801-b852-5da08b2fb704	1ac501b8-1c6a-4dd1-be1f-ca376fe5e649	Carousel	["https://minio.test.prof-stankin.ru/blog/f27f974e-0438-4e3d-a00d-bec5307dfc8a.jpg"]	
30edff34-2e94-4e9a-ae9c-88f003d6d4ce	d90e7367-30a4-4854-b2f7-886b87c44588	Carousel	["https://minio.test.prof-stankin.ru/blog/f56e9c0a-4a00-4dd3-b50c-9eeaa53a053d.jpg"]	
7d2faf4a-ddf5-45ac-8bbd-4ec0d6492d5e	c92a3cb9-6698-4752-9db8-52e2725c3a2b	Carousel	["https://minio.test.prof-stankin.ru/blog/e1963ebd-6fa5-4295-a920-09dd81fc0f20.jpg"]	
6f59bb66-8ad7-4e8e-8098-7352f2761a6b	1770c140-37ba-4a59-9242-759bc78149cf	Carousel	["https://minio.test.prof-stankin.ru/blog/bf5e0b37-7695-45b8-8bf3-7849a33ce368.jpg"]	
1a5c12e1-06b3-4f76-b3ec-a77b1938402b	75502ec4-210a-47c2-b686-92c175799740	Carousel	["https://minio.test.prof-stankin.ru/blog/4f947769-0ae6-4577-86fb-ddb8a538c789.jpg"]	
2a1b3fd2-03fb-43a2-a52a-4a59e29cbc68	935f93d5-2a94-4435-8986-c56443e2aba4	Carousel	["https://minio.test.prof-stankin.ru/blog/64ee7843-f309-4885-9394-2724f8b3893e.jpg"]	
1fa9eb0d-0740-4710-a92d-f553bca12daf	cb9af3a4-64bb-4f28-9b52-c74924e9d32c	Carousel	["https://minio.test.prof-stankin.ru/blog/44403b1c-43c5-44a1-a96f-7d287ecaab1c.png"]	
0174ce5c-699b-4145-9cd1-c2a8b28e2c04	3c1d08fb-ad29-419e-8c7b-21ed44dbcf13	Carousel	["https://minio.test.prof-stankin.ru/blog/c67baf6d-5c9f-4ca3-be4a-cca26a3bc7e9.jpg"]	
61a0b75f-9966-453d-9e96-f5bc30e2c3f7	081f843a-7302-4535-89d6-01e0fbcefb80	Carousel	["https://minio.test.prof-stankin.ru/blog/6c5ff342-52b7-49fc-bd93-78d8c50d0b02.jpg"]	
9ee6f687-8c23-4deb-a6f0-52a1af253d13	822e1903-cf7f-4726-b3c4-7a1a84db613b	Carousel	["https://minio.test.prof-stankin.ru/blog/d648ba73-4a0a-4b13-b533-d48b3347d6f9.png"]	
\.


--
-- Data for Name: text_blocks; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.text_blocks (id, block_id, content) FROM stdin;
53f778e0-6782-4267-a84c-67b65e89026e	084504d1-e959-4426-a325-7da654674c5f	<p>StandUp Msk представляет масштабные концерты «Главный стендап»! Вас ждут выступления самых популярных комиков телеканала ТНТ и лейбла Labelcom, которые подарят незабываемый вечер и море положительных эмоций<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>дату и время конкретного концерта уточняй на сайте<br/><em><strong>Где:</strong></em> место проведения конкретного концерта уточняй на сайте<br/><strong><em>Стоимость: </em></strong>от 990 рублей<br/><a href="https://vk.cc/cR938T">https://vk.cc/cR938T</a></p>
1b75be45-e85f-473f-a3d2-4431cfcf76c1	7b26ca13-38ac-41cf-98f7-7556ef491a56	<p>В галерее a—s—t—r—a открылась выставка Михаила Крунова, представителя редкого направления сайнс-арт. Его работы — это не просто объекты искусства, а целостный исследовательский метод, где научные достижения, описывающие вселенную, обретают философскую глубину и художественную выразительность.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 12:00-20:00<br/><em><strong>Где:</strong></em> 4-й Сыромятнический переулок, 1/8<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cRmcbf">https://vk.cc/cRmcbf</a></p>
f1e65731-e1af-4b8c-b9f2-c7a4dee516b9	a67a00a3-510c-4cd0-99e8-eaed93effda4	<p>Тебя ждет экскурсия по Александровскому саду с гидом: вместе вы расшифруете тайные символы Кремля, узнаете скрытые смыслы в архитектуре и скульптурах, откроете историю Москвы через ее древние знаки. А еще увидите башни с необычными прозвищами, разгадаете загадки Исторического музея и даже встретите мифическое существо на его стенах.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>22 ноября, 14:00<em><strong><br/>Место встречи:</strong></em> станция метро «Александровский сад», выход №5<br/><em><strong>Стоимость:</strong></em> от 680 рублей<br/><a href="https://vk.cc/cRmj1x">https://vk.cc/cRmj1x</a></p>
b03d0946-31e0-41d2-90d5-e66e98b98183	3be170d2-17d9-43fc-8c3a-ed4abfe4bc08	<p>Ты сможешь узнать, как личностные качества могут влиять на чувство обоняния, а также разобраться, какие ароматы способствуют сосредоточенности и какие расслаблению. В качестве подарка на память о музее у тебя останется арома-амулет.<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда</strong></em></strong></em></strong>:</em></strong> пн-вс, 12:00-18:00<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>Пятницкая, 76<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>800 рублей<br/><a href="https://vk.cc/cRmjKj">https://vk.cc/cRmjKj</a></p>
f3846a91-db02-4f9e-ba8c-a5ba8293adc2	2ce18cd4-d531-4bb9-8334-5eb5c8198fc2	<p>Два года в мире зомби-апокалипсиса. Чтобы выжить, вы стали мародером. Ваша первая задача — с главарем Майклом обыскать дом таинственного Билла, продержавшегося два года, но теперь бесследно исчезнувшего. Нужно найти припасы и разгадать тайну его исчезновения.<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда</strong></em></strong></em></strong>:</em></strong> дату и время конкретного квеста уточняй на сайте<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>Вернисажная, 6<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>6300 рублей для команды до 4 человек<br/><a href="https://vk.cc/cRmkOF">https://vk.cc/cRmkOF</a></p>
0521245f-4b74-4cbd-b395-d8adfe7e22d3	1ef89301-3501-44a3-86dc-697815a6ad9f	<p>Выставка объединяет графику и керамику Алексея Веселовского и саунд-арт Ивана Шелоболина. Оба художника исследуют линию как основной элемент искусства — Веселовский в визуальной форме, а Шелоболин — в музыкальной, представив для проекта композицию из семи полифонических фрагментов.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 12:00-20:00<br/><em><strong>Где:</strong></em> 4-й Сыромятнический переулок, 1/8<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cR938T">https://vk.cc/cR938T</a></p>
8a4a0caf-4bb0-4c4f-b990-a5838473fd54	af4c8bfc-7b40-46cc-a600-702cfc1910b2	<p>Мемориальная квартира Булгакова на Большой Пироговской открыта для посетителей. В этой квартире писатель прожил почти семь лет, в течение которых создал ключевые произведения, включая пьесы «Бег», «Адам и Ева» и биографию Мольера. Здесь же в 1930 году он сжег в печке черновик будущего романа «Мастер и Маргарита».<br/> <br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, время работы музея  уточняй на сайте<br/><em><strong>Где:</strong></em> Большая Пироговская, 35Ас1<br/><strong><em>Стоимость: </em></strong>225 рублей для студентов<br/><a href="https://vk.cc/cQrKul">https://vk.cc/cQrKul</a></p>
befae829-b8b9-4175-932e-d678c4f0fa15	cb318bbd-499f-4b07-a64c-efeca4b7f20c	<p>Два странствующих актера — трагик Несчастливцев и комик Счастливцев — попадают в имение своей тети. Там царит хаос: тетя хочет выйти за юного возлюбленного, племянница в отчаянии собирается утопиться, а гимназист готов жениться ради выгоды. Лишь бродячие актеры сохраняют искреннее сочувствие к людям.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>12 ноября, 19:00<br/><em><strong>Где: </strong></em>Триумфальная площадь, 2<em><strong><br/>Стоимость:</strong></em> от 800 рублей<br/><a href="https://vk.cc/cP7boz">https://vk.cc/cP7boz</a></p>
2cfccf9c-bda0-49b6-88f0-c0ec07630310	2959629e-e521-435f-a616-d4e445dc781f	<p>В новой петербургской квартире зеркало показывает Алисе параллельный мир, где живет тусовщик Иван. Молодым людям предстоит понять свои чувства и найти способ преодолеть границу между мирами, чтобы встретиться в реальности.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>дату и время конкретного сеанса уточняй на сайте<br/><em><strong>Где: </strong></em>адрес конкретного кинотеатра уточняй на сайте<em><strong><br/>Стоимость:</strong></em> от 200 рублей<br/><strong><em>Мероприятие можно посетить по Пушкинской карте</em></strong><br/><a href="https://vk.cc/cR96MD">https://vk.cc/cR96MD</a></p>
b487fb1a-a3be-4283-ae0e-ca8e06a27fad	a780429e-d82f-41f1-a3e9-2563948a06c9	<p>Квест — отличный способ весело провести время с друзьями. По сюжету, вы – отряд специального назначения, которому предстоит проникнуть в секретный бункер времен холодной войны и предотвратить ядерную катастрофу.<br/><br/><strong><em><strong><em>Когда:</em></strong> </em></strong>дату и время конкретного квеста уточняй на сайте<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Большая Новодмитровская, 36с3<strong><em><br/><strong><em>Стоимость:</em></strong> </em></strong>от 4500 рублей для команды из 2-5 человек<strong><em><br/></em></strong><a href="https://vk.com/away.php?to=http%3A%2F%2Fcubiculum.ru%2Fknopka_quest_02%2F&amp;cc_key=cizlCY" rel="noreferrer noopener" target="_blank">https://vk.cc/cizlCY</a></p>
def03217-6280-443f-987b-c436aa8fa47f	e571ef2a-2113-4307-8d0b-7c24ec245a6b	<p>Каждый автомобиль, находящийся здесь, — итог огромного труда коллекционеров и реставраторов. Старейшим экспонатам музея больше ста лет: это американский Studebaker EMF-30 и немецкий 8/20 Sport Benz, оба 1912 года выпуска. А благодаря интерактивным экспонатам и инсталляциям можно узнать много интересного, например, как устроены автомобильные механизмы.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн-вс, 10:00-21:00<br/><em><strong>Где:</strong></em> Самокатная, 4с34<br/><strong><em><strong><em>Стоимость: </em></strong></em></strong>900 рублей для студентов<br/><a href="https://vk.com/away.php?to=https%3A%2F%2Fautomuseum.ru%2F&amp;cc_key=crYv3K" rel="noreferrer noopener" target="_blank">https://vk.cc/crYv3K</a></p>
41aa77f6-16cc-44fc-907b-8a3d1a60f25d	537b14ee-8f94-4fea-af3d-d42740d14042	<p>Свой путь к вершинам чартов и большим концертным залам певица Просто Лера начала в 2019 году, выложив первые песни. Ее творчество сразу нашло отклик у слушателей, что в итоге привело к контракту с лейблом Kaufman Label.<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>8 ноября, 17:00<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Шмитовский пр-д, 32Ас1<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 1911 рублей<br/><a href="https://vk.cc/cQUD1L">https://vk.cc/cQUD1L</a></p>
b91a15ab-d1cc-4dd4-adc9-0a1b83125f68	05738d39-b98f-44b7-b40b-a599c4379139	<p>Новый проект «Студии 30» предлагает пройти по следам героя известной песни, который пытается сбежать от Рима, существующего в его воображении. Художники исследуют, можно ли уйти от навязанных образов, а «Вечный город» предстает здесь как хаотичный набор воспоминаний и клише.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 12:00-20:00<br/><em><strong>Где:</strong></em> 4-й Сыромятнический переулок, 1/8<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cQUFtd">https://vk.cc/cQUFtd</a></p>
0d8a1e67-7124-45ed-b8f6-bdcc74aaafdf	f3836cab-3963-44f8-970f-597070903b90	<p>В музее собраны уникальные исторические коллекции шифровальной техники, средства передачи информации и архивные документы.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 11:00-20:00<br/><em><strong>Где:</strong></em> Ботаническая, 25с4<br/><strong><em>Стоимость: </em></strong>500 рублей для студентов<br/><a href="https://vk.cc/cl6IsG">https://vk.cc/cl6IsG</a></p>
e5580156-689a-47e6-9099-d0701780a1b5	2a8063d9-7d68-49b4-ad9c-34b231d1e8c4	<p>Выставка изучает жизнь Ямала через местные сувениры, которые отражают его историю и культуру. Это наглядный пример «хронотопа» — неразрывной связи между суровой географией Севера и социальными процессами, где жизнь людей определяется приспособлением к среде или борьбой с ней.<br/><br/><strong><em>Когда:</em></strong> пн–вс, 11:00-22:00<br/><strong><em>Где:</em></strong> Болотная набережная, 15<br/><strong><em>Вход св</em></strong><em><strong>ободный, нужна предварительная регистрация</strong></em><br/><a href="https://vk.cc/cQV0JQ">https://vk.cc/cQV0JQ</a></p>
d2634401-91b8-4e57-aac1-578de23a1d6b	f7cfb5b4-d3b9-4b87-b7cd-bcf14201b430	<ul><li>Если есть право на пособие по уходу и единое пособие на детей и беременных женщин, получать можно только одно</li><li>Если заявитель ухаживает за двумя и более детьми, пособие выплачивают на каждого ребёнка</li></ul>
c3e9e38b-a0b9-4cc7-bcfd-ac5843d9790a	6c09b44a-9900-4b05-b9de-74f8a242d635	<p>Музей предлагает погрузиться в историю компании Apple, основанной Стивом Джобсом. Здесь ты ощутишь значимость впечатляющего стартапа XX века и узнаешь то, как настойчивость одного человека может преобразить весь мир.<br/><br/><strong><em>Когда:</em></strong> ср, 17:00–21:00,<br/>сб, вс 12:00–18:00<br/><strong><em>Где:</em></strong> Складочная, 3с1<br/><strong><em>Стоимость:</em></strong> 500 рублей для студентов<br/><a href="https://vk.cc/c8sbbF">https://vk.cc/c8sbbF</a></p>
c13da668-0b35-488a-b98c-55baab3c5cee	76fb2d20-2fd5-4916-8872-c8d7c4c65391	<p>В центре Москвы работают два уютных котокафе, где посетители могут расслабиться за чашкой кофе или чая, пообщаться с пушистыми котиками, поиграть в настольные игры или просто поработать. Все коты прошли социализацию и готовы к переезду в новые семьи — уже более 300 животных нашли свое счастье!<br/><br/><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>пн-пт, 11:00-22:00,<br/>сб, вс, 10:00-22:00<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>адрес конкретного кафе уточняй на сайте<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 630 рублей<br/><a href="https://vk.cc/cIRhTs" rel="noreferrer noopener" target="_blank">https://vk.cc/cIRhTs</a></p>
f9c7944c-960a-4bc1-9616-d5343a8ff945	0e57e37c-de1e-4bad-8399-ae89e3844f88	<p>В рамках исполнения поручений Президента Российской Федерации и Правительства Российской Федерации проведена работа по запуску в МГТУ «СТАНКИН» в 2024 году формата «единого окна» по поддержке молодых семей</p>
ee12c944-4fac-4604-b17c-1867fdd65131	09a050ac-f3c5-4914-9681-1c0c7beb36b6	<p>Формат единого окна направлен на формирование единой и комплексной системы поддержки молодых студенческих семей и семей молодых преподавателей (сотрудников) вузов и информирование о действующих мерах поддержки и механизмах их получения</p>
12f3be83-8ba9-4954-9ba6-6837ab891950	18bb768b-0b1a-44f5-91e7-4881919e9478	<p><strong>«Молодая семья</strong>» — категория молодой семьи, в которой оба лица, состоящие в заключенном в установленном законодательством Российской Федерации порядке браке, в том числе воспитывающие ребенка (детей), либо в которой лицо, являющееся единственным родителем (усыновителем) ребенка (детей), в возрасте до 35 лет включительно, являются обучающимися по образовательным программам среднего профессионального и (или) образовательным программам высшего образования</p>
ce116d05-48a8-43bb-8d7c-13e7a38b0e87	02b61656-ff93-4e1c-9b60-5768cace5302	<p><strong>Меры поддержки</strong><strong>, реализуемые в МГТУ «СТАНКИН»,</strong><strong> предусмотрены для семьи</strong>: </p>
c35f96d0-da7e-4cd2-a0e9-08fc84eb813f	8ecd9e8d-f020-402c-a682-b47e14ba05fe	<ul><li>где оба супруга являются обучающимися университета </li><li>где один из супругов является обучающимися университета, а второй — обучающимся иной образовательной организации </li><li> где единственный или оба родителя воспитывают одного или более детей в возрасте до 18 лет</li></ul>
f28e65a9-51ce-4de2-be23-78620f3dc1a9	f40529c3-5c7f-4b9b-a2b6-1d25b8cf9635	<p><strong>Меры поддержки</strong><strong>, реализуемые в МГТУ «СТАНКИН»</strong></p>
c35fb730-7dbf-4d85-b0bd-85bdf8f5fa4c	d4b8dd80-e5a1-4c69-b17e-0462ebd598bf	<p><strong>Материальная поддержка</strong></p>
c45f2ccd-01b3-40d0-b8fc-06afd927d5a4	9437d91b-ba99-400c-8943-eb8a46fa241b	<ul><li>Единовременная материальная помощь студентам в связи с рождением ребенка в период обучения </li><li>Материальная помощь студентам в связи с рождением ребенка в период обучения раз в семестр </li><li>Единовременная материальная помощь студентам, вступившим в брак в период обучения</li><li>Материальная помощь студентам, вступившим в брак в период обучения, раз в семестр </li></ul>
69552fc8-91a9-42ef-b09f-439d0de85d71	2d8e50e3-28ec-4843-9521-817893829177	<p><strong>Инфраструктурная поддержка </strong></p>
91c8bceb-3bfd-446e-af8b-1026130d9183	e83cf270-8ee3-47f0-ab43-9defc66bfad1	<ul><li>Предоставление комнат в общежитии студенческим семьям, где оба члена семьи являются студентами МГТУ «СТАНКИН»</li><li>Предоставление мест в общежитиях обучающимся, состоящим в браке (в том числе имеющим общих детей до 18 лет), в случае если родители ребенка являются обучающимися разных вузов (при наличии мест в общежитиях)</li></ul>
1e6d72e9-fcea-458c-abec-58e2460672af	470a7c07-1d22-4d36-8796-5f6a0bfb6f2b	<p><strong>Информационная поддержка </strong></p>
710db0f4-a2e7-4d7b-9b50-114d4997e8fd	3c02a6e1-1154-4be4-9f10-7e90db77b19b	<ul><li>Психологическая поддержка: консультации штатных педагогов-психологов в случае обращения</li><li>Юридическая поддержка, оказываемая работниками Центра социальной политики и воспитательной деятельности Университета в случае обращения </li></ul>
6dff9b26-dd83-498b-bcad-68c28ca00998	b8034131-8946-4bc0-9580-9e373c202e6f	<p><strong>Иная поддержка </strong></p>
3cbe2df9-7196-44c3-8246-c5f98417356e	06f8884c-c241-4901-8d5d-be5905eaf715	<p>Правила для работающих:</p>
0c61fa57-7ee2-4a00-b71a-76d76a6ad796	6786c5a4-4610-4edd-9e3d-eee5a5093506	<ul><li>Возможность перевода с платной формы обучения на бесплатную при заключении брака и рождении ребенка </li><li>Возможность проходить обучение по индивидуальному учебному плану при рождении ребенка в период обучения</li><li>Участие детей работников и обучающихся в Новогодних мероприятиях, выдача бесплатных билетов на Новогодние мероприятия в ведущих организациях подведомственных Департаменту культуры Москвы </li><li>Выдача Новогодних сладких подарков для детей работников и обучающихся </li><li>Выдача канцелярских наборов для первоклассников для детей работников</li></ul>
7e84c33c-8647-467e-b1cf-c1fe30eff91b	645cebda-241d-4634-a0ce-4d6e826b7701	<p><strong>Федеральные меры поддержки </strong></p>
f6223890-ac12-4163-a111-1205df28422b	22bc81ba-5d87-448d-8f41-693b24bc9101	<p><strong>Материнский капитал</strong></p>
061d05c4-5cd5-43c1-9f5f-2a1c550510ff	67a00973-6f12-4329-a56b-332ee6342974	<p>Маткапитал государство предоставляет семьям при рождении или усыновлении ребёнка</p>
21fb651c-177b-4b55-9f0c-5bc9e0b55a99	c2b3ddbf-946e-46fa-838d-eb30ec8978cb	<p>Маткапитал можно получить, если на момент рождения или усыновления ребёнка мать является гражданкой РФ, а он сам — гражданин РФ по рождению. Исключение — жители новых регионов РФ. Жителям ДНР, ЛНР, Запорожской и Херсонской областей достаточно иметь гражданство РФ на момент оформления маткапитала</p>
1dab829d-a55a-49fd-b79f-aa671aebff43	5f36e782-6575-4905-ab0e-0209e72a724c	<p><strong>Кто имеет право на получение:</strong></p>
b87f673a-b41f-4f39-af4b-e0847597738a	c51d9928-4510-4e51-ad68-aa3ee4409c2d	<ul><li>женщина, родившая или усыновившая:</li></ul>
f980b3e1-4d55-4536-a2be-33adbf333c3b	927f172c-804c-4bae-b282-dd1459639167	<p>первого ребёнка с 1 января 2020 г.</p>
16e6c5c0-d721-4c26-9faf-20d1777db924	d87a0786-d9e4-4607-8fcc-9b7c62f03a52	<p>второго или последующего ребёнка с 1 января 2007 г.</p>
556a0815-d264-4eab-9ca5-e7d0fcb076b7	8907fe54-7758-4ee1-903e-c3638707ef6f	<ul><li>мужчина — единственный усыновитель:</li></ul>
75784e6b-9bac-49c5-aa9d-e0979b383019	629cce5c-3013-4dc9-869c-38fcabb9c462	<p>первого ребёнка по решению суда с 1 января 2020 г.</p>
f41eab82-db55-4344-bd71-6429a890cc50	7632fa12-69c5-4beb-ade5-8cd66a31a160	<p>второго или последующего ребёнка по решению суда с 1 января 2007 г.</p>
cd2dd256-386f-456e-bb55-864a20f01e15	6a98b09d-3043-4c4b-89c3-234912ed8fa0	<ul><li>отец — независимо от наличия у него гражданства РФ, если мать ребёнка умерла или была лишена родительских прав</li></ul>
7cd4b3c0-8b73-465f-88c4-8d0795e408e4	048efec2-bb61-45c5-9459-fe69f0adddd3	<p><strong>Семейная ипотека </strong></p>
356cabbc-ef29-44c3-a280-ec8b3466f795	0ca3e3eb-033e-4f97-8c32-34129f90b8e8	<p>Семейная ипотека — специальная программа жилищного кредитования для поддержки семей с детьми, которая позволяет приобрести жилье по льготной ставке до 6 % годовых</p>
41171216-599a-4a70-b43e-11725a7c3501	5cf3a9ee-9a17-4caf-afbe-f0c660751266	<p>Участвовать в программе могут граждане России, у которых есть несовершеннолетние дети-граждане России: </p>
565d4711-e1a5-4aff-b97a-0a73ac37f376	e7bca950-feb6-4a69-ab3b-83f8303dea1b	<ul><li>в возрасте до 6 лет включительно</li><li>двое и более несовершеннолетних детей</li><li>ребенок с инвалидностью</li></ul>
6c88ea7b-d92f-45b7-a31c-ad1e51f5fd71	00b38b9b-7d06-42ff-81f6-3cc51c01d1ee	<p><strong>Пособие при рождении ребенка</strong></p>
612bf2ad-465d-4f71-83bb-61b149c21207	736ec887-d720-4292-b00f-01cdd8e82cab	<p>Пособие при рождении ребёнка положено всем российским семьям, постоянно проживающим на территории страны, независимо от уровня дохода и количества детей. Родители могут работать по трудовому договору или быть фрилансерами, безработными, ИП — на размер пособия это не влияет</p>
f10ef84e-0eaa-461b-b412-425bcd0a7d30	537fd683-9bfb-4ae7-b263-d83ca75053e7	<p><strong>Пособия для беременных женщин </strong></p>
6811fd4b-83b4-472d-9dcc-118867a1e46f	4f5499f3-0291-468a-8d14-31916a55da72	<ul><li>Единое пособие для беременных женщин, вставших на учёт в ранние сроки беременности. Назначается женщине, вставшей на учёт в медорганизации на сроке до 12 недель беременности. При этом среднедушевой доход членов её семьи не должен превышать один прожиточный минимум</li><li>Пособие беременной жене военнослужащего. Назначается жене призывника или учащегося первого курса военной образовательной организации. Пособие можно оформить с 180 дня беременности</li><li>Пособие по беременности и родам. Оформляется с 30 недели беременности. Пособие может получить женщина, которая официально ушла в отпуск по беременности и родам</li></ul>
da45ff82-cbe4-4d08-86af-60e92cf4d8a6	2cb453bd-4a80-4bb2-ae19-76b7910c37de	<p><strong>Пособие по уходу за ребенком до 1,5 лет </strong></p>
4bb5a7df-9125-47b3-9626-b8eece2e883b	16e73f62-191e-4306-bcf9-62ef13a2af47	<p>Пособие может получать работающий или неработающий родитель, опекун, усыновитель или любой родственник, который ухаживает за ребёнком, — только кто-то один</p>
78d76e47-b78d-45ed-86bd-f4da5b3977a6	8311730f-28cf-4ba2-bfea-4871eda99be7	<p>У неработающего должно быть право на получение пособия</p>
f0d6eebe-39d5-4059-aaec-659b0ddeb6e3	47e91d2b-8f4d-4d00-a3ff-165edc03e23b	<p>Условия для неработающих:</p>
bfe34000-8199-45f0-9784-daa9cdd0c485	8974b02d-aba5-4f7d-966d-cbf520912698	<ul><li>Доход на каждого члена семьи ниже регионального прожиточного минимума</li><li>Имущество семьи не больше установленного перечня</li><li>Есть уважительная причина отсутствия дохода</li></ul>
dc418f82-3b21-47c8-92b9-920ae8124c27	d1f5ef06-b745-44df-9111-d92f20c01987	<p>К кому не относятся эти условия:</p>
74183fe8-fedf-49a2-b246-b5dd6bdb0ee3	d8866746-b94e-4568-8e0a-f16e209a88ec	<ul><li>Работающий или ИП может передать право на получение пособия другому члену семьи</li><li>Можно прервать отпуск по уходу за ребёнком и выйти на работу или возобновить учёбу в любой момент — пособие продолжат платить</li></ul>
b980f4f5-3dd1-4aea-9de6-30485a8b510c	2c45a306-b6bc-4090-96e9-85bc868ecdfd	<p><strong>Ежемесячное пособие на ребёнка военнослужащего по призыву</strong></p>
a0cc166b-c68b-4cae-9b0d-b3e827d4ac2c	742a2599-3868-454b-bb03-18bb1b897031	<p>Пособие может получить мать, опекун или другой родственник ребёнка, отец которого:- проходит срочную службу в армии- курсант 1 курса военной профессиональной образовательной организации- курсант 1 курса военной образовательной организации высшего образования</p>
3fdede94-2acd-4eba-b816-d2b85377e917	32498358-a8de-4301-a98c-1b3864c16277	<p>Пособие не назначается:- если дети находятся на полном государственном обеспечении- лишённым родительских прав либо ограниченным в родительских правах- выехавшим на постоянное место жительства за пределы РФ</p>
a7d326c7-2d01-491c-b83e-cac1fb733118	dd136a97-f8e0-4f9b-94a2-db5a58759dd6	<p>Пособие может начисляться со дня рождения ребёнка до достижения им трёх лет, но выплачивается только за период, когда отец находится на военной службе. Если детей несколько, получать пособие можно на каждого ребёнка</p>
4f96114b-6748-46ac-816b-11222e0fc01c	f09315e5-9149-4fb8-8c28-ae6415e87393	<p>Оформить пособие можно не позднее 6 месяцев после окончания призывником срочной военной службы</p>
c315a218-87a8-46c2-81d4-1998765efabc	8b823ccb-4d0f-49b1-986a-4e7164725557	<p>На каждого ребёнка подается отдельное заявление</p>
6e587403-cae7-41da-802c-a2cf31040751	a38ed5c7-bdbc-4710-ada7-a06d3c75f5f5	<p><strong>Стандартные налоговые вычеты </strong></p>
e702be09-2d30-42ca-bb70-e4be5503c423	df5517f7-428d-451c-b41a-d4a8041ff8b1	<p>В соответствии с федеральным законом от 12 июля 2024 г. № 176-ФЗ «О внесении изменений в части первую и вторую Налогового кодекса Российской Федерации, отдельные законодательные акты Российской Федерации и признании утратившими силу отдельных положений законодательных актов Российской Федерации», которым предусмотрено увеличение стандартных налоговых вычетов до 2 800 рублей в месяц на второго ребенка и до 6 000 рублей в месяц на третьего и каждого последующего ребенка, включая увеличение размера годового дохода, на который распространяется стандартный налоговый вычет с 350 тыс. рублей до 450 тыс. рублей</p>
64b8db25-fa37-41b3-9d62-632727e9715a	c111e528-515d-4b6d-ad65-c1bc0ccdc848	<p><strong>Специальные налоговые выплаты</strong></p>
f998b063-36f6-4606-ac04-0cfcdbfb3ae3	a3a384c8-7f18-4814-8777-aac4e41d1f56	<p>В целях поддержки работающих родителей принят Федеральный закон от 13 июля 2024 г. № 179-ФЗ «О ежегодной семейной выплате гражданам Российской Федерации, имеющим двух и более детей», предусматривающий введение с 2026 г. семейной налоговой выплаты, которая будет выплачиваться в случае, если размер среднедушевого дохода семьи не превышает 1,5-кратную величину прожиточного минимума на душу населения, установленную в субъекте Российской Федерации по месту жительства (пребывания) или фактического проживания заявителя в соответствии с пунктом 3 статьи 4 Федерального закона «О прожиточном минимуме в Российской Федерации» на год, предшествующий году обращения за указанной выплатой</p>
8a6876be-4cba-43ba-a801-08158ebabee5	fc520f2c-f10b-4d56-8748-b2a2a4fdba84	<div class="wp-block-group has-secondary-background-color has-background"><div class="wp-block-group__inner-container">\n<div class="wp-block-columns has-white-background-color has-background">\n<div class="wp-block-column" style="flex-basis:100%">\n<p><strong>Контактная информация: </strong>Для получения подробной информации предлагаем обратиться в кабинет 204 или по адресу: <a href="mailto:profstankin@mail.ru">profstankin@mail.ru</a></p>\n</div>\n</div>\n</div></div>
ec946bc3-0044-4d98-9284-df21b0c6c4c3	9498ae7f-ac04-42b3-8a1a-0cd48ce9ff0b	<div class="wp-block-group__inner-container">\n<div class="wp-block-columns has-white-background-color has-background">\n<div class="wp-block-column" style="flex-basis:100%">\n<p><strong>Контактная информация: </strong>Для получения подробной информации предлагаем обратиться в кабинет 204 или по адресу: <a href="mailto:profstankin@mail.ru">profstankin@mail.ru</a></p>\n</div>\n</div>\n</div>
00a92efe-a285-4905-a4d0-8e5135994587	11bc430e-7534-4672-abf6-32eb04e68669	<div class="wp-block-columns has-white-background-color has-background">\n<div class="wp-block-column" style="flex-basis:100%">\n<p><strong>Контактная информация: </strong>Для получения подробной информации предлагаем обратиться в кабинет 204 или по адресу: <a href="mailto:profstankin@mail.ru">profstankin@mail.ru</a></p>\n</div>\n</div>
0831ba73-fcef-4d63-afa3-364a18ce93d5	9414c483-1278-4f96-90bc-614b57ee029e	<div class="wp-block-column" style="flex-basis:100%">\n<p><strong>Контактная информация: </strong>Для получения подробной информации предлагаем обратиться в кабинет 204 или по адресу: <a href="mailto:profstankin@mail.ru">profstankin@mail.ru</a></p>\n</div>
ee14e915-3af1-4fc0-b0cd-083f1e8b7c64	d6b553e0-b27e-4fdf-8e11-1d0a2415f4a9	<p><strong>Контактная информация: </strong>Для получения подробной информации предлагаем обратиться в кабинет 204 или по адресу: <a href="mailto:profstankin@mail.ru">profstankin@mail.ru</a></p>
d3a0336d-dddd-4f53-a011-666003896132	eb64c301-d968-47af-abdf-d6f87d1eab7b	<p>Совсем скоро в Live Arena пройдет одно из главных музыкальных событий года — церемония Жара Media Awards 2025. Это масштабное шоу, соберет самых популярных музыкантов, блогеров и инфлюенсеров, которые сегодня формируют медиаландшафт.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>30 октября, 20:00<br/><em><strong>Где:</strong></em> Западная, 145<br/><strong><em>Стоимость: </em></strong>от 2000 рублей<br/><a href="https://vk.cc/cQCLl1">https://vk.cc/cQCLl1</a></p>
8562e484-2af6-46ad-bdb7-67f6dc1343ef	f66dca2f-fa8b-4daa-ad02-055340f31bbe	<p>Экспозиция охватывает историю учреждения с момента открытия до современности. Она включает разделы, демонстрирующие творческие работы пациентов и результаты трудовой терапии. Особый акцент сделан на истории главы города Алексеева Николая Александровича и его вкладе в основание больницы в период с 1885 по 1893 год.<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>пн-пт, 10:00-15:00<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Загородное шоссе, 2к16<strong><em><br/><strong><em>Вход свободный</em></strong></em></strong><br/><a href="https://vk.cc/cNh2HJ">https://vk.cc/cNh2HJ</a></p>
7e68d57e-758c-447e-87be-d0ab93345ebd	f78cfb14-41ed-4dba-8129-e50035abd073	<p>В галерее Тотибадзе открывается выставка картин Гоги и Иры Тотибадзе, дополненные фотографиями Александра Смирнова и архивными снимками из семейной коллекции. Событие проходит параллельно с персональной выставкой художников в ММОМА.<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>вт–вс, 12:00-20:00<strong><em><br/><strong><em>Где:</em></strong> </em></strong>4-й Сыромятнический переулок, 1/8<strong><em><br/>Вход свободный</em></strong><br/><a href="https://vk.cc/cQCM7y">https://vk.cc/cQCM7y</a></p>
293dc133-5026-4f40-9b1e-8c8da0390af6	9bf76aec-b7a2-4c23-91b4-588b73dcfa5d	<p>Музей кино — это больше, чем просто музей. В нем есть три кинозала, выставочные зоны и аудитории для лекций о киноискусстве. В его коллекции хранятся костюмы, фотографии, афиши, а также предметы, принадлежавшие деятелям российского кинематографа с XIX века до наших дней.<br/><br/><em><strong>Когда:</strong></em> пт, сб, 10:00-20:00,<br/>вт-чт, вс, 10:00-18:00 <br/><em><strong>Где:</strong></em> Проспект Мира, 11<br/><strong><em><strong><em>Стоимость: </em></strong></em></strong>250 рублей для студентов<br/><a href="https://vk.cc/cqK0qu" rel="noreferrer noopener" target="_blank">https://vk.cc/cqK0qu</a> </p>
06d56004-bc72-4208-82b6-125a1d464dc7	44f0a012-c986-4ee7-a1b4-e1904d80188a	<p>Массивные подземные структуры и уникальная архитектура предоставляют возможность для организации персональных и групповых экскурсий по одному из когда-то секретных военных объектов СССР.<br/><br/><strong><em>Когда:</em></strong> пн-вс, 10:00-21:00<br/><strong><em>Где:</em></strong> 5-й Котельнический переулок, 11<br/><strong><em>Стоимость: </em></strong>от 650 рублей<br/><a href="https://vk.cc/cQCMUg">https://vk.cc/cQCMUg</a></p>
3a070b93-3a70-4a78-a3b2-2ce6af76009e	d2b79f88-53ea-47aa-a59f-5611523df807	<p>Знаменитый Дом Пашкова хранит память об интереснейших эпизодах истории России. Именно здесь, в самом красивом классицистическом здании столицы, началась история Российской государственной библиотеки. Экскурсия поможет попасть в знаменитый московский особняк XVIII века, узнать его удивительную историю, восхититься залами и увидеть город с необычного ракурса.</p>
ef5b80d4-93b2-4f41-af24-9971bc0e6fe8	0ec4ff00-c210-4260-b856-8936537fd3c1	<p><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em></strong> 21 октября, 14:15<br/><em><strong>Где:</strong></em> Воздвиженка, 3/5с1<br/><strong><em>Стоимость:</em></strong> 600 рублей для студентов<br/><strong><em>Мероприятие можно посетить по Пушкинской карте</em></strong><br/><a href="https://vk.cc/cmplGr" rel="noreferrer noopener" target="_blank">https://vk.cc/cmplGr</a></p>
19305bcc-59e7-4f61-a5f3-4ee2fa544803	d5ccf002-0856-4b92-84f5-1f1dfd6c8a53	<p>Выставка Евгения Родионова покажет его знаменитые небольшие картины и большие работы-полиптихи. Художник создает удивительный мир «Чудолесья», который понятен и близок всем, надолго запоминается и дает простор для фантазии<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 12:00-20:00<br/><em><strong>Где:</strong></em> Старопименовский переулок, 14<br/><strong><em>Стоимость: </em></strong>100 рублей для студентов<br/><a href="https://vk.com/away.php?to=https%3A%2F%2Fwww.art-story.com%2F&amp;cc_key=cfqPdh" rel="noreferrer noopener" target="_blank">https://vk.cc/cfqPdh</a></p>
3b11490f-eaa9-40b5-98f5-fb08bf5f8f86	cacbf5d7-ac48-4867-8561-f9bb9f35091c	<h3 id="muzey-podpolnaya-tipografiya-1905-1906-godov">Музей «Подпольная типография 1905–1906 годов»</h3>
a6ab17fe-f4b1-4248-9502-54687c115ee6	f4b6b322-5794-4db1-b560-1da20c0bd2ea	<p>Здесь в дни Первой российской революции находилась законспирированная нелегальная типография, где издавалась социал-демократическая газета «Рабочий» и печатались революционные листовки. Музей дает представление о жизни московских мещан конца XIX-начала XX века.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт, ср, пт, вс, 11:00-19:00<br/>чт, сб, 11:00-20:00<br/><em><strong>Где:</strong></em> Лесная, 55<br/><strong><em>Стоимость: </em></strong>130 рублей для студентов<br/><strong><em>Мероприятие можно посетить по Пушкинской карте</em></strong><br/><a href="https://vk.com/away.php?to=https%3A%2F%2Fafisha.yandex.ru%2Fmoscow%2Ftheatre_show%2Fvishnevyi-sad-lenkom%3Fsource%3Drubric%26schedule-date%3D2023-01-16&amp;cc_key=ckF8ix" rel="noreferrer noopener" target="_blank"></a><a href="https://vk.com/away.php?to=https%3A%2F%2Fwww.sovrhistory.ru%2Fmuseum%2Fbuild%2Ftypography%2Findex.php&amp;cc_key=ckF9pL" rel="noreferrer noopener" target="_blank">https://vk.cc/ckF9pL</a></p>
5f67248d-45b1-40b9-89a1-4603fc17c5de	38232d3a-dd24-4047-abba-f421bc4a792a	<p>Профессор Хиггинс специализируется на изучении речи и звуков, используя фонограф для своих исследований. Фонограф Виктор Крамер создает сценографию, превращая сцену в лабораторию, где Хиггинс собирает коллекцию звуков и голосов, по сути, создавая коллекцию человеческих душ.</p>
f986c188-4e60-4172-8e47-f241a0dfbe76	7a842a2f-ee15-442c-b0ff-8a755f5eaa0e	<p><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong>22 октября, 19:30<br/><strong><em><strong><em><strong>Где:</strong> </em></strong></em></strong>Павловская, 6<br/><strong><em>Стоимость: </em></strong>от 1000 рублей<br/><a href="https://vk.cc/cQvyfo">https://vk.cc/cQvyfo</a></p>
751eaae8-97aa-4cbd-bb20-f16d437478ce	3d3d017a-7920-4e7a-9ccb-43f4411bfd8e	<p>Мастер-класс по скульптуре — это увлекательное занятие, где под руководством преподавателя вы создадите свою первую скульптуру. Процесс лепки улучшает пространственное мышление, а также помогает расслабиться и отвлечься от повседневных забот.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> дату и время конкретного мастер-класса уточняй на сайте<br/><em><strong>Где:</strong></em> Земляной вал 52/16с2<br/><strong><em>Стоимость:</em></strong> 1790 рублей<br/><a href="https://vk.cc/cI9NC1">https://vk.cc/cI9NC1</a></p>
ab692417-4992-41f8-8711-d209787fe85a	f6c0bc58-e54f-48a7-a545-1531896c1b50	<p>Архитектурный макет Москвы выделяется своей детализацией зданий и точностью воспроизведения ландшафта. Общая площадь макета составляет 429 квадратных метров в масштабе 1:400, на котором отображено более 23 тысяч объектов.<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>пн-вс, 10:00-20:00<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>Проспект Мира, 119с7А<strong><em><br/><strong><em>Вход свободный</em></strong></em></strong><br/><a href="https://vk.cc/cgotIL">https://vk.cc/cgotIL</a></p>
77945d38-f4d1-4993-b483-5eb6eb53b840	25aeb9bf-227c-491a-9b52-1fd26323ce66	<p>Абстрактный фигуратив становится для участников выставки безмолвным языком общения. Этот общий стиль позволяет через очертания и формы выражать сложные идеи, будь то в лаконичной графике или в буйстве красок.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 12:00-20:00<br/><em><strong>Где:</strong></em> 4-й Сыромятнический переулок, 1/8<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cQiChP">https://vk.cc/cQiChP</a></p>
f426f7e0-dec3-408e-83e8-62ccc2b36935	bdee6668-8951-4ecf-88e3-d7dd038e0e95	<p>Экспозиция этого компактного музея, целиком построенная на собраниях российских коллекционеров, погружает в мир времени. Здесь замираешь над изящными песочными часами, солнечными циферблатами и сложными раритетными механизмами.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн-вс, 10:00-21:00<br/><em><strong>Где:</strong></em> Русаковская, 1<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cQiCPr">https://vk.cc/cQiCPr</a></p>
de02406a-6e4f-4360-9925-36f1e169913a	463dc934-15d1-4466-bde2-edbf35676451	<p>Александр Беридзе предстает художественным феноменом на своей первой выставке. Соединяя живопись, графику и фотографию, он создает энергетически заряженные работы, которые дарят эстетическое удовольствие и побуждают размышлять о природе искусства.<br/><br/><strong><em>Когда:</em></strong> пн-вс, 10:00–22:00<br/><strong><em>Где:</em></strong> Красная площадь, 3<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cFKwqM">https://vk.cc/cFKwqM</a></p>
1f4d893f-85c9-42d7-9ac2-79249a3c01b5	4081a7e9-cc30-4c7b-9637-8a3f883b293d	<p>Молодая московская пара попадает в волшебный мир Шахерезады, где встречает героев «Тысячи и одной ночи» и, переживая невероятные приключения, находит путь к возрождению своей любви.</p>
7ce7f9c6-98a5-48af-8dcb-a06e8ecbde30	d0096f3c-0d2c-4840-8692-e78ed38ceebd	<p><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>16 октября, 19:00<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>Комсомольский проспект, 28<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 1100 рублей<br/><a href="https://vk.cc/cInyBT">https://vk.cc/cInyBT</a></p>
3582cee3-9b14-4439-a63f-c2fac0afafe1	e297bee8-1efa-4f07-bf4d-add1d532ed21	<p>Автобусная экскурсия по Москве посвящена истории династии Романовых. Экскурсовод расскажет о судьбе Романовых, разберется в исторических фактах и легендах, связанных с этой династией, и поведает правду о жизни династии.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> дату и время конкретной экскурсии уточняй на сайте<br/><em><strong>Место встречи:</strong></em> станция метро Маяковская<br/><strong><em>Стоимость: </em></strong>от 1200 рублей<br/><a href="https://vk.cc/cFxS4j" rel="noreferrer noopener" target="_blank">https://vk.cc/cFxS4j</a></p>
79f156e1-272c-41d1-9f5c-9e79f4086707	451b2bc7-0674-44ef-9628-f6c4ab262428	<p>Не упусти шанс провести свой вечер в атмосфере шуток и юмора! Тебя ждут выступления профессиональных комиков, участниц шоу «Женский Стендап на ТНТ», «Labelcom», «Открытый микрофон на ТНТ» и других популярных ТВ и YouTube проектов.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> 13 октября, 20:00<br/><em><strong>Где:</strong></em> Новый Арбат, 15<br/><strong><em>Стоимость: </em></strong>от 1190 рублей<br/><a href="https://vk.cc/cMS4J9">https://vk.cc/cMS4J9</a></p>
8e028603-1963-45a2-b811-b7d1f5945ad9	a0f95493-91fb-48f6-be80-20903a546bd0	<p>Обезумев от горя после смерти любимой жены Елизаветы, принц Влад II, граф Дракула, отрекается от Бога. Он заключает сделку с темными силами, обрекая себя на вечное существование, чтобы однажды вновь найти ее душу. Спустя 400 лет его надежда оживает в юной девушке Мине.<br/><br/><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong>расписание сеансов уточняй на сайте<strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong>адрес кинотеатра уточняй на сайте<br/><strong><em>Стоимость: </em></strong>от 230 рублей<br/><a href="https://vk.cc/cQ6K7X">https://vk.cc/cQ6K7X</a></p>
62c87892-1c41-4277-8a1a-99e973ddfe0b	038c8635-6e2a-4068-9dc9-a457bf2c9ef3	<p>На арене — звезды российского цирка! Отчаянные акробаты, грациозные гимнасты и ловкие эквилибристы. Ты увидишь выступления собачек и великолепных лошадей в номерах высшей школы верховой езды, а также легендарный дуэт юмористов — Сергея Колганова и Олега Белогорлова!<br/><br/><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong>11 октября, 14:00<strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong>Цветной бульвар, 13<br/><strong><em>Стоимость: </em></strong>от 1500 рублей<br/><a href="https://vk.cc/cQ6KCE">https://vk.cc/cQ6KCE</a></p>
20e1c7eb-e0bf-46a5-a4d1-d43b61c70fc5	11e40d4e-8d7e-4a91-b80b-262e39bcbf17	<p>Проект Василия Слонова — это художественная вселенная, построенная на одном базовом элементе — кирпиче. Художник использует его как метафору, чтобы переосмыслить мироустройство, доказывая, что ценность произведения рождается не из материала, а из творческой энергии, оживляющей его.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 12:00-20:00<br/><em><strong>Где:</strong></em> 4-й Сыромятнический переулок, 1/8<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cQ6KR6">https://vk.cc/cQ6KR6</a></p>
df7ffcb3-097f-4449-a3ca-03218b339923	099b958a-00ca-4f2d-a48f-6a3afd97f0dc	<p>Представляем выставку живых тропических бабочек и музей коллекций насекомых со всего мира! Ты сможешь увидеть уникальную коллекцию бабочек, жуков и других насекомых из различных стран мира, которая собиралась профессиональным энтомологом десятки лет, а также сувениры, картины из крыльев бабочек и многое другое.<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>пн-пт, 11:00-22:00,<br/>сб, вс, 10:00-21:00<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>Проспект Мира 119с519<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>1950 рублей<br/><a href="https://vk.cc/cAOMcX">https://vk.cc/cAOMcX</a></p>
d933757b-d961-41f6-9dcf-1df3aa7345cb	ffd1cd62-319a-4842-8c2e-2eeeb5900975	<p>Здесь ты сможешь исследовать историю первых водопроводов в Кремле и узнать о развитии систем водоснабжения и канализации в Москве с XVIII века до современных технологий очистки воды и обработки сточных вод. В выставочных залах ты найдешь предметы быта и документы, относящиеся к этой теме, включая рукописи и чертежи известных ученых и инженеров.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн-чт,<em> </em>10:00-17:00,<br/>пт,<em> </em>10:00-16:00,<br/><em><strong>Где:</strong></em> Саринский проезд, 13<br/><strong><em><strong><em>Вход свободный</em></strong></em></strong><br/><a href="https://vk.com/away.php?to=https%3A%2F%2Fwww.mosvodokanal.ru%2Fabout%2Fmuseum.php&amp;cc_key=cuxUUX" rel="noreferrer noopener" target="_blank">https://vk.cc/cuxUUX</a></p>
aa70bac8-dafb-453c-858c-cd7783649637	4281bd1a-c7f8-4ca5-8a36-9313d66ce3bb	<p>Экспозиция воссоздает «воображаемую вселенную» автора через его архитектуру, дизайн и сценографию, отражая идею культуры как пространства равенства и общности. Схожие принципы лежат в основе «ГЭС-2» — с его акцентом на горизонтальные связи и коллективное творчество.<br/><br/><strong><em>Когда:</em></strong> пн–вс, 11:00-22:00<br/><strong><em>Где:</em></strong> Болотная набережная, 15<br/><strong><em>Вход св</em></strong><em><strong>ободный, нужна предварительная регистрация</strong></em><br/><a href="https://vk.cc/cNCinC">https://vk.cc/cNCinC</a></p>
b16c9c27-7864-4378-ba33-17c19b1f595e	a45b1900-4d07-42fa-aead-ae70531405ef	<p>Комедия Оскара Уайльда, насыщенная забавными интригами, неожиданными ситуациями и комическими недоразумениями. В спектакле присутствуют остроумные, ироничные диалоги и выдающийся актерский состав, что делает просмотр приятным и веселым, а также может заставить задуматься о том, как создание идеалов может быть опасным занятием.</p>
10d19937-3447-4848-a7e8-d84ba8136c27	667a10d1-f846-4965-b390-7c685ab96ae5	<p><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong>29 сентября, 19:00<strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong>проспект Мира, 119с84<br/><strong><em>Стоимость: </em></strong>от 1200 рублей<br/><a href="https://vk.cc/cwrEQ1" rel="noreferrer noopener" target="_blank">https://vk.cc/cwrEQ1</a></p>
4eb1f0ec-b7f9-44f7-9c8e-f54c79b63dc4	1e17c59f-fbac-48ea-93f5-42efe787c35a	<p>Хотя выставка формально рассказывает о Хорезмской археолого-этнографической экспедиции, ее настоящая цель – показать неожиданные параллели между модернизмом и археологическими исследованиями.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн-вс, 11:00-22:00<br/><em><strong>Где:</strong></em> Болотная набережная, 15<br/><strong><em>Вход свободный, нужна предварительная регистрация</em></strong><br/><a href="https://vk.cc/cKcoDU">https://vk.cc/cKcoDU</a></p>
d03938bb-94b5-4503-b29e-9f5a31034e1c	c88ec3a8-0150-47dd-9169-c09b15fb5673	<p>Мясницкая — историческая улица Москвы, где прошлое встречается на каждом шагу. Здесь можно увидеть старинные особняки, доходные дома и уникальный дом «чайного короля». Приглашаем на прогулку сквозь века!<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>дату и время конкретной экскурсии уточняй на сайте<br/><em><strong>Где:</strong></em> станция метро «Лубянка», выход №4<br/><strong><em>Стоимость: </em></strong>от 855 рублей<br/><a href="https://vk.cc/cKNyKK">https://vk.cc/cKNyKK</a></p>
94b7d99a-cdfe-45ba-b056-be1a3e05e8cb	f92c0736-4dd4-4615-bf83-b7d484307c58	<p>Насладись живописными видами Москвы и Подмосковья, а также сделай великолепные фотографии с борта теплохода. Экскурсия на одном из крупнейших теплоходов Восточной Европы по Химкинскому водохранилищу и Каналу имени Москвы завершится возвращением на Северный речной вокзал Москвы.<br/><br/><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong>пн-вс, время конкретной прогулки уточняй на сайте<strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong>Северный речной вокзал<br/><strong><em>Стоимость: </em></strong>249 рублей<br/><a href="https://vk.cc/cxvM94">https://vk.cc/cxvM94</a></p>
a4d5ac44-13f1-4d75-98a7-f13b96facc49	dfe22432-eed4-428a-988d-638e7f66557b	<p>Экспозиция включает 59 игровых автоматов — популярные «Морской бой», «Баскетбол», «Снайпер», «Городки» и многие другие. Отдельно выделен зал с автоматами на платформе ТИА-МЦ, в котором представлены электронные автоматы — «Сафари», «Снежная королева», «Авторалли».<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>пн-вс, 11:00-21:00<strong><em><br/><strong><em>Где:</em></strong></em></strong> Рождественка, 15<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>950 рублей для студентов<br/><a href="https://vk.cc/cxkCiG" rel="noreferrer noopener" target="_blank">https://vk.cc/cxkCiG</a></p>
1de9a5eb-8131-4315-9d4c-89dea6d3f07f	ebbd5313-8347-458b-97a8-df06ef739782	<p>Постоянная экспозиция музея включает 12 тематических залов с интерактивными медиа. Здесь можно посмотреть 4D-фильм о сотворении мира, отдохнуть в кафе, посетить базарную площадь, изучить биографии деятелей советской политики и культуры, услышать разговоры на советской кухне и рассказы диссидентов, а также почтить память павших в Великой Отечественной войне.<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>пн-чт, вс, 12:00-22:00,<br/>пт, 10:00-15:00<strong><em><br/><strong><em>Где:</em></strong></em></strong> Образцова, 11с1А<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>500 рублей<br/><a href="https://vk.cc/7g0DMR" rel="noreferrer noopener" target="_blank">https://vk.cc/7g0DMR</a></p>
0e9e2607-9311-4df9-9f3b-fecab0e05350	32a08d0f-eab1-4f79-84de-052bf95b6100	<p>Известный стендап-комик Андрей Бебуришвили выступит со своей новой программой! Он входит в число самых популярных комиков, его гастрольный график включает концерты по всей стране, в том числе на самых крупных площадках.<br/><br/><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>26 сентября, 19:00<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>Мира, 2а<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 2000 рублей<br/><a href="https://vk.cc/cPHcaf">https://vk.cc/cPHcaf</a></p>
ba523eed-7f2d-4b6c-9e79-98b57188986a	754f4a77-073d-4f6a-83fd-f63c6595796e	<p>В музее собраны уникальные исторические коллекции шифровальной техники, средства передачи информации и архивные документы.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 11:00-20:00<br/><em><strong>Где:</strong></em> Ботаническая, 25с4<br/><strong><em>Стоимость: </em></strong>500 рублей для студентов<br/><a href="https://vk.cc/cl6IsG">https://vk.cc/cl6IsG</a></p>
dc2ef474-a9f2-4986-a8b5-5f8cff958142	4994d72a-e806-401b-9bf6-c40566dad5ce	<p>Загадочный отель вновь открывает свои двери, чтобы стать порталом в эпоху немого кинематографа. Это не просто шоу, а лиричное и атмосферное путешествие во времени, сотканное из лихо закрученных новелл, прекрасной музыки и эксцентричных номеров, где стираются границы между жанрами.<br/><br/><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>27 сентября, 15:00<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>Измайловское шоссе, 71к5<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 1500 рублей<br/><a href="https://vk.cc/cPHe7H">https://vk.cc/cPHe7H</a></p>
6c78a9da-4742-462a-b623-4ffc50692b85	920455d3-f463-459f-82a6-e45d2ba9b8c4	<p>В галерее XL открылась выставка Игоря Самолета «Выбор». Художник размышляет о внутренней борьбе и механизмах, стоящих за каждым нашим решением — от бытовых до судьбоносных.<br/><br/><strong><em>Когда:</em></strong> вт-вс, 12:00-20:00<br/><strong><em>Где:</em></strong> 4-й Сыромятнический переулок, 1/8<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cPHepf">https://vk.cc/cPHepf</a></p>
da5843d1-93c8-4a2b-b932-4c4c50372c83	e80f3ce3-d6dd-40e8-8361-217f18ff74ec	<p>Молодые обитатели парижской мансарды — поэт, художник и музыкант — грезят о славе. Один разрывается между двумя женщинами, а другие — о постановке своего спектакля, музыку из которого услышат зрители.<br/><br/><strong><em>Когда:</em></strong> 25 сентября, 19:00<br/><strong><em>Где:</em></strong> Большая Дмитровка, 6<br/><strong><em>Стоимость: </em></strong>от 1400 рублей<br/><strong><em>Мероприятие можно посетить по Пушкинской карте</em></strong><br/><a href="https://vk.cc/cPHeYj">https://vk.cc/cPHeYj</a></p>
8beb6d82-59cf-45f2-8bc5-703a2fdf311b	afa711b2-054b-4fd3-9719-d5da791ed790	<p>Познакомься с одной из крупнейших передовых киностудий не только России, но и Европы! В рамках экскурсии ты узнаешь истории создания легендарных фильмов, заглянешь в действующие кинопавильоны, а также увидишь уникальную коллекцию съемочного инвентаря.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>дату и время конкретной экскурсии уточняй на сайте<br/><em><strong>Место встречи:</strong></em> Мосфильмовская, 1с4<br/><strong><em><strong><em>Стоимость: </em></strong></em></strong>1260 рублей<br/><a href="https://vk.cc/cqBtrE">https://vk.cc/cqBtrE</a></p>
280b1ed2-ec9f-4105-8095-babc7ae3ae17	28cdf79e-6356-451a-a301-c3dee912cd58	<p>Фонд насчитывает около 68 тысяч предметов, включая древнерусские и средневековые монеты, денежные знаки России и зарубежья, крупные золотые слитки, медали и исторические документы. Коллекция памятных монет РФ является одной из самых полных в стране.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> пн-вс, 10:00-18:00<br/><em><strong>Где:</strong></em> Неглинная, 12<br/><strong><em>Вход свободный, нужна предварительная регистрация</em></strong><br/><a href="https://vk.cc/cF7VlT">https://vk.cc/cF7VlT</a></p>
078679a2-08d0-457d-8280-c736e7abd961	718d580f-4dc9-4241-900f-a6ac7078f23f	<p>В рамках юбилейной серии к 100-летию Бориса Александровича Чайковского прозвучат его камерные шедевры: скрипичные квартеты и масштабный Фортепианный квинтет 1962 года.<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>20 сентября, 19:00<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Большая Никитская, 13/6<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 700 рублей<br/><a href="https://vk.cc/cPwohv">https://vk.cc/cPwohv</a></p>
e995f435-29b9-44fb-b778-528c7598e32d	29009a03-e908-4f36-964f-e3849bb83c6f	<p>Насладись Москвой с высоты 354 метра на смотровой площадке небоскреба. Чистый воздух, шквал эмоций и вид, выше которого только любовь!<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>дату и время конкретного мероприятия уточняй на сайте<strong><em><br/><strong><em>Место встречи:</em></strong></em></strong> 1-ый Красногвардейский проезд, 21с1<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 1000 рублей<br/><a href="https://vk.cc/cPwoAR">https://vk.cc/cPwoAR</a></p>
e791e956-248e-47e2-8956-fe4b13dde22d	dbb298dd-d4c2-4d48-9cbd-e980c26b3f32	<p>Художник Йируй Фан соединяет в абстрактной живописи эстетику Востока и Запада. Белые линии и воздушные формы на его полотнах, перекликаясь с философией Хайдеггера, символизируют текучесть и хрупкость бытия.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 12:00-20:00<br/><em><strong>Где:</strong></em> 4-й Сыромятнический переулок, 1/8<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cPwoQO">https://vk.cc/cPwoQO</a></p>
a570ac88-2254-424a-a65b-0dc6b59664d1	fe0fc905-d363-4a7b-b38d-4a5fa3da1a54	<p>Ты сможешь познакомиться с фермерской жизнью, традициями и ее обитателями. А также увидишь коз, альпак, айширских и индийских коров, северных оленей, карликовых кроликов и многих других жителей фермы.</p>
bb94bd4f-1fa1-425a-b682-91529944a7f4	d0981c80-551b-4b46-a0db-6b2a70a789a2	<p><strong><em>Когда:</em></strong> вт-пт, 10:30-19:00,<br/>сб-вс, 10:30-20:00<br/><strong><em>Где:</em></strong> проспект Мира, 119с244<br/><strong><em>Стоимость</em></strong>: от 1000 рублей<br/><a href="https://vk.cc/cyEz0V">https://vk.cc/cyEz0V</a></p>
f040176e-8fed-477b-8248-22d6b0c41d20	2d0b056f-1ede-42de-a752-a206502f3fa5	<p>Отправившись на литературно-мистическую прогулку по Булгаковской Москве, вы познакомитесь с историей создания культового романа «Мастер и Маргарита» и побываете в местах, связанных с жизнью героев произведения и происходившими с ними событиями.</p>
981da223-338e-4709-9069-31aee4f5e07f	e70ec373-31f6-4c4b-aaec-01be1692cbfd	<p><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>20 сентября, 15:30<br/><em><strong>Где:</strong></em> Триумфальная площадь, 2<br/><strong><em>Стоимость</em></strong>: 800 рублей для студентов<br/><a href="https://vk.cc/crPXZh" rel="noreferrer noopener" target="_blank">https://vk.cc/crPXZh</a></p>
b42636c0-3926-4a24-b320-1ee66ae88467	6ba0a1d7-3474-44c7-9c63-a2c6ff53f647	<p>Автор выставки создает работы, снимая на телефон изображение с компьютерного экрана и затем печатая этот снимок вручную. Этот метод превращает цифровые пиксели в аналоговые, напоминающие мазки краски. На крупноформатных фотографиях изображены анонимные персонажи из интернета, ставшие частью нашей повседневной реальности.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 12:00-20:00<br/><em><strong>Где:</strong></em> 4-й Сыромятнический переулок, 1/8<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cPfims">https://vk.cc/cPfims</a></p>
3192884b-386e-4ab2-9bae-524d1a33cf9e	e336b171-62f1-4aba-bf80-97f8735ae93c	<p>Во время представления ты увидишь истории о внешней и внутренней борьбе человека, о самых низких и самых прекрасных проявлениях его качеств. Актеры постарались совместить на сцене драматический и физический театр с хореографией и акробатикой, что в<strong> </strong>совокупности создает невероятную атмосферу с ярким антуражем постановок.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>12 сентября, 23:00<br/><em><strong>Где:</strong></em> Пушкинская площадь, 2<br/><strong><em>Стоимость: </em></strong>от 1500 рублей<br/><a href="https://vk.cc/cPiOzb">https://vk.cc/cPiOzb</a></p>
7d42fd99-1088-48cd-99eb-f6a81abadf13	e49f3106-169f-4dbe-a689-f00c68f48ef7	<p>Молодая пара застревает в лифте с незнакомцем, который знает о них все. Случайная встреча оборачивается смертельной ловушкой, где выживание становится единственной целью.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>дату и время конкретного сеанса уточняй на сайте<br/><em><strong>Где:</strong></em> место проведения конкретного показа уточняй на сайте<br/><strong><em>Стоимость: </em></strong>от 250 рублей<br/><a href="https://vk.cc/cPiOzb">https://vk.cc/cPiPy4</a></p>
32a2435c-dbed-4c0d-97a8-f2428d890161	daf3bba0-cc6c-4e81-91ad-76fb68e8bb83	<p>Это старейшая официальная миссия иностранного государства в Москве. Здание, состоящее из древних помещений и музея, рассказывает историю жизни английской купеческой семьи в XVI-XVII веках и развитие отношений между Россией и Великобританией.<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>вт-вс, 10:00-21:00<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Варварка, 4А<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 175 рублей для студентов<br/><a href="https://vk.cc/cCXhuD">https://vk.cc/cCXhuD</a></p>
37390f30-b0a5-4c1c-a6c9-6e192f0f3277	319230ec-8ed8-474a-b52a-a38d39aa599b	<p>В Ледяной пещере открылось уникальное иммерсивное представление «Вьюжн» объединяющее снег, светомузыку и ностальгические воспоминания. Здесь ты почувствуешь всю магию январской вьюги, хруст снега под ногами, полуночный фейерверк и множество ностальгических моментов.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн, 14:00-21:00,<br/>вт-вс, 10:00-21:00<br/><em><strong>Где:</strong></em> Варварка, 6<br/><strong><em><strong><em>Стоимость: </em></strong></em></strong>450 рублей<br/><a href="https://vk.cc/cJwl78">https://vk.cc/cJwl78</a></p>
bf5d241c-e739-490f-98b2-b672f980e58a	1312ac9f-46e5-4a40-9598-c9d5e4be7d5c	<p>Вы — команда героев, стремящихся спасти человечество от неизбежной катастрофы. Ваша задача — проникнуть на глубинные уровни секретной лаборатории, где проводились опасные биологические исследования, найти технику, позволяющую воссоздать опасный вирус, и предотвратить глобальную катастрофу с помощью вакцины.<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>дату и время конкретного квеста уточняй на сайте<strong><em><br/><strong><em>Где:</em></strong> </em></strong>4-я Кабельная, 2с1<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>6000 рублей для команды от 2 до 4 человек<br/><a href="https://vk.cc/cAwW4x">https://vk.cc/cAwW4x</a></p>
194a880b-7379-4d5f-9ea6-f904febeef4e	e0814989-f286-43a4-a8bf-cde76d471eba	<p>В рамках мероприятия пройдет вручение премии «Моя марка». Награды получат юные таланты со всей России в разных творческих направлениях, победившие по мнению зрителей.<br/><br/><strong><em>Когда:</em></strong> 5 сентября, 19:00<br/><strong><em>Где:</em></strong> Кремлевская набережная, 1<br/><strong><em>Стоимость:</em></strong> от 1000 рублей<br/><a href="https://vk.cc/cP7aPY">https://vk.cc/cP7aPY</a></p>
d8c1cc0a-a969-4dc1-9b06-e3033763a3ed	dff73365-2f24-4fc2-b9c8-12166477c7a3	<h2 id="vyistavka-kartinyi-uskolzayushhego-mira-zolotoy-vek-yaponskoy-grafiki">Выставка «Картины ускользающего мира. Золотой век японской графики»</h2>
97ee2a03-d9bc-4a2b-9928-9a4d5d65d085	d92ec52c-b206-4b2a-b903-4eae43de10a5	<p>Два странствующих актера — трагик Несчастливцев и комик Счастливцев — попадают в имение своей тети. Там царит хаос: тетя хочет выйти за юного возлюбленного, племянница в отчаянии собирается утопиться, а гимназист готов жениться ради выгоды. Лишь бродячие актеры сохраняют искреннее сочувствие к людям.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>7 сентября, 19:00<br/><em><strong>Где: </strong></em>Триумфальная площадь, 2<em><strong><br/>Стоимость:</strong></em> от 600 рублей<br/><a href="https://vk.cc/cP7boz">https://vk.cc/cP7boz</a></p>
eedcaf5c-e655-4bdd-a19b-4a974cd921de	eaceebf0-8485-4a04-9a7c-beb45ab4e2b8	<p>Стендап в кинотеатре — это уникальное путешествие в мир живой комедии! Список комиков держится в секрете для того, чтобы сделать зрителям приятный сюрприз на концерте.</p>
b1b2d4fd-84f2-4170-837c-0c4f359044a6	5ae5c633-1b5f-4574-bd56-e33e86dbac05	<p><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>5 сентября, 19:30<br/><em><strong>Где:</strong></em> Андропова проспект, 8<br/><strong><em>Стоимость: </em></strong>от 990 рублей<br/><a href="https://vk.cc/cNh1pc">https://vk.cc/cNh1pc</a></p>
827b87c8-c030-46ab-b20c-85908114a3a4	6679ef5b-2cf7-4435-80d7-737dcd7d65fb	<p>Выставка Юли Киракосян «Лето» — это ностальгические и уютные работы, написанные в Суздале. Ее узнаваемый стиль сочетает декоративность, сложную палитру и многослойную композицию, напоминающую мозаику.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>с 3 сентября, вт-вс, 12:00-20:00<br/><em><strong>Где:</strong></em> 4-й Сыромятнический переулок, 1/8<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cP7c8p">https://vk.cc/cP7c8p</a></p>
9221fb8f-6293-4c74-8cda-64df5875fdab	23fa02e6-6c28-4885-9813-7db164ff67fc	<p>Квест — отличный способ весело провести время с друзьями. По сюжету, вы – отряд специального назначения, которому предстоит проникнуть в секретный бункер времен холодной войны и предотвратить ядерную катастрофу.<br/><br/><strong><em><strong><em>Когда:</em></strong> </em></strong>дату и время конкретного квеста уточняй на сайте<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Большая Новодмитровская, 36с3<strong><em><br/><strong><em>Стоимость:</em></strong> </em></strong>от 4000 рублей для команды из 2-5 человек<strong><em><br/></em></strong><a href="https://vk.com/away.php?to=http%3A%2F%2Fcubiculum.ru%2Fknopka_quest_02%2F&amp;cc_key=cizlCY" rel="noreferrer noopener" target="_blank">https://vk.cc/cizlCY</a></p>
41909018-fce7-4aa2-8c82-cf5b4ee8dc83	b10069d4-0b03-4fc5-8926-a9554ec598f3	<p>Мастер-класс на гончарном круге — это не просто создание красивого изделия из глины, которое ты можешь забрать с собой, но и замечательная арт-терапия, помогающая расслабиться и сосредоточиться на настоящем моменте!<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>дату и время проведения мастер-класса уточняй на сайте<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>место проведения мастер-класса уточняй на сайте<br/><strong><em>Стоимость:</em></strong> 1700 рублей<br/><a href="https://vk.cc/cyMkT7" rel="noreferrer noopener" target="_blank">https://vk.cc/cyMkT7</a></p>
078ba6fa-b74d-4e71-85dc-022c4f2e2ca2	e4fa1add-e687-460d-802f-02c13d44378f	<p>Автор выставки вдохновлен детским воспоминанием, когда его мама создала из картонных коробок целый мир для игрушек. Это переросло в творческий проект, где он строит из картона не просто формы, а сюжеты с характером. Его работы, подсвеченные театральным светом, — это попытка найти точку, где начинается реальность.<br/><br/><strong><em>Когда:</em></strong> вт-вс, 12:00-20:00<br/><strong><em>Где:</em></strong> 4-й Сыромятнический переулок, 1/8<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cOSgFb">https://vk.cc/cOSgFb</a></p>
edd46474-e719-4f57-9b61-2d645b550ade	d4dc6fea-2fb6-454e-a506-60e04734def8	<p>Певица, чьи песни становятся хитами с первых секунд. Самая популярная артистка России по версии Яндекс Музыки. Уже скоро — грандиозный летний концерт!<br/><br/><strong><em>Когда:</em></strong> 30 августа, 18:00<br/><strong><em>Где:</em></strong> Партийный переулок, 1к6<br/><strong><em>Стоимость: </em></strong>от 2300 рублей<br/><a href="https://vk.cc/cOShEJ">https://vk.cc/cOShEJ</a></p>
6e4b33d5-2647-4138-9c2f-e8e28a58747c	0e15153c-1870-438b-a98d-d2be6e3f6992	<p>История князя Мышкина трогает не одно поколение читателей и зрителей. Федор Михайлович Достоевский ставит перед нами множество сложных вопросов. Спектакль театра имени Моссовета предлагает осмыслить их вместе с автором и прожить с героями его романа часть их жизни.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>28 августа, 19:00<br/><em><strong>Где:</strong></em> Большая Садовая, 16с1<br/><strong><em>Стоимость: </em></strong>от 500 рублей<br/><a href="https://vk.cc/cvv1lL">https://vk.cc/cvv1lL</a></p>
d220d356-aa52-426c-9005-f7b1fb04fefe	b7eb8f3f-4730-4842-9c51-53a2e59d69fd	<p>Выставка посвящена героизму российских военнослужащих в ходе Специальной военной операции. Ее ключевая идея — преемственность победных традиций и духовная связь современных защитников с поколением победителей в Великой Отечественной войне.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 11:00-22:00<br/><em><strong>Где:</strong></em> Проспект Мира, 119, павильон №59<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cOSj2m">https://vk.cc/cOSj2m</a></p>
474e53d4-a0fd-4927-b935-35335484a4ba	d6726c67-0d7a-4b96-86f9-25254bf6a0e7	<p>Укие-э, или «картины ускользающего мира» — это японская гравюра эпохи Эдо. Она изображала быт горожан, гейш, актеров и природу, отражая идею о мимолетности мгновений. Эти красочные гравюры, не имевшие аналогов на Востоке, использовались как украшения, театральные афиши и реклама.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн-вс, 11:00<br/><em><strong>Где:</strong></em> Берсеневский переулок, 2с1<br/><strong><em>Стоимость: </em></strong>от 500 рублей<br/><a href="https://vk.cc/cOSjKF">https://vk.cc/cOSjKF</a></p>
d0a7da18-6cba-4121-8123-9849dbc22bf9	e833ce1a-1d52-4e64-afcb-e2daebee6f13	<p>В квесте по мотивам Гравити Фолз игроки помогают Мейбл спасти дневники от Гидеона, который уменьшил всех до размера насекомых. Приключение проходит внутри Хижины чудес, где нужно исследовать сувенирный магазин, музей и чердак, решая загадки и сражаясь с Биллом Шифром.<br/><br/><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>дату и время конкретного квеста уточняй на сайте<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>Чертановская, 66к1<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 500 рублей<br/><a href="https://vk.cc/cIEIkz">https://vk.cc/cIEIkz</a></p>
94c094a3-ef4a-4d1b-bcb9-886bdf9d7a17	ace4673b-a9a7-4f8b-baa0-5c6f80defa58	<p>Выставка сближает гербарий и коллекционирование: оба сохраняют выбранное, предотвращая забвение. В рамках Биеннале частных коллекций проект исследует фиджитал-коллекционирование — синтез digital и physical.<br/><br/><strong><em>Когда:</em></strong> вт-вс, 12:00-20:00<br/><strong><em>Где:</em></strong> Малая Пионерская, 12<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cOEUgc">https://vk.cc/cOEUgc</a></p>
eb6760b4-fcb1-48c6-95f0-c693bbf4a425	dc536111-1a6d-4657-9d66-79aa130a7f3e	<p>Мультижанровый артист исполнит свои треки на стыке хип-хопа, R&amp;B и альтернативы — только искренние эмоции и звук, в который хочется погрузиться. Тебя ждет сольный концерт под открытым небом!<br/><br/><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>23 августа, 20:00<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>Новозаводская, 27<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 3000 рублей<br/><a href="https://vk.cc/cOEUWr">https://vk.cc/cOEUWr</a></p>
a794fef7-6411-4e9b-bb71-0400daa47b3e	fa71fc24-d5de-48e3-a1b7-572beff3656e	<p>Премьера пьесы состоялась 28 августа 1961 года в самом сердце Парижа в театре «Эдуард VII», однако постановки до сих пор не сходят со сцен мира. Детективная история о том, как дамы трех поколений одной семьи и их домочадцы ведут самостоятельное расследования убийства главы фамилии, совершенное в канун Рождества.</p>
99d8eca3-e1d9-4997-a941-cad9e08f343f	6fee22c1-0c57-4671-b8d5-c37243e2216d	<p><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>21 августа, 19:00<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>ул. Большая Садовая, 16c1<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 500 рублей<strong><em><strong><em><strong><em><strong><em><br/></em></strong></em></strong></em></strong></em></strong><a href="https://vk.cc/czSd38">https://vk.cc/czSd38</a></p>
50b6d24a-dcd7-419d-8e08-fc4a7043b211	ccda0441-2b68-41f1-964d-3fd5f8a3639f	<p>Орган при свечах — это не только потрясающая музыка, но и особая атмосфера, которая позволит слушателям отключиться от суеты повседневности и погрузиться в мир гармонии и покоя. Красивые свечи, создающие нежное и теплое освещение, добавят вечеру нотку загадочности и романтики.</p>
0d9372c4-aac3-4d0e-b152-4201c30beeba	4a8731fa-24ca-406f-a1cc-dc02916660cf	<p><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>23 августа, 19:00<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>ул. Пречистенка, 12/2с1<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 1000 рублей<strong><em><strong><em><strong><em><strong><em><br/></em></strong></em></strong></em></strong></em></strong><a href="https://vk.cc/czSbKl">https://vk.cc/czSbKl</a></p>
dfd647ab-e76e-42b9-b995-b6bd1e67ca81	934eeaa5-9c09-45bc-8490-62c4ed65068b	<p>Это грандиозное мультимедийное шоу от солиста Цирк Дю Солей, основанное на повести Ричарда Баха «Чайка по имени Джонатан Ливингстон». Это история о стремлении к самосовершенствованию и абсолютной свободе. Джонатан, нарушив законы своей стаи и изгнанный за это, продолжает путь к мечте, достигая мастерства в полете и постигая высшую любовь.</p>
f35ee10c-8d3f-4ec9-b98f-4ffb2da8312a	b45497c1-013f-4344-9277-1036a1230087	<p>Тебя ждет экскурсия по Александровскому саду с гидом: вместе вы расшифруете тайные символы Кремля, узнаете скрытые смыслы в архитектуре и скульптурах, откроете историю Москвы через ее древние знаки. А еще увидите башни с необычными прозвищами, разгадаете загадки Исторического музея и даже встретите мифическое существо на его стенах.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>19 августа, 13:00<em><strong><br/>Место встречи:</strong></em> станция метро «Александровский сад», выход №5<br/><em><strong>Стоимость:</strong></em> 675 рублей<br/><a href="https://vk.cc/cN4eNk">https://vk.cc/cN4eNk</a></p>
83f64861-130f-4357-8f57-670ca4f61a52	657cdd04-aa2a-4069-9eee-cab5000953be	<p>Ваша команда исследует паранормальные явления в местах с призраками. Каждый игрок оснащен специальным снаряжением и может применять ненаучные методы. Миссия будет успешной, если вы сохраните рассудок, правильно определите призрака и останетесь живы.</p>
eb98a55c-20b4-40a1-b028-a24c9f0e9a50	d8d16349-ab15-4c57-b50a-75845a9bfff3	<p><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>дату и время конкретного квеста уточняй на сайте<br/><em><strong>Где:</strong></em> Суворовская, 51<br/><strong><em>Стоимость: </em></strong>от 1200 рублей<br/><a href="https://vk.cc/cy3Ry9" rel="noreferrer noopener" target="_blank">https://vk.cc/cy3Ry9</a></p>
eb6d3af5-8db2-4c55-af08-0a71b5d41f72	6d9b3c22-903c-4c00-ad59-80b8a80474d8	<p>Музыка и тексты Рамиля взрослеют вместе с ним, его творчество становится сложнее и разнообразнее. Всего за пару лет рэпер перешел из статуса инди-артиста с небольшим отрядом поклонников в соцсети в статус российской рэп-звезды нового поколения — останавливаться на достигнутом он не намерен.<br/><br/><strong><em>Когда:</em></strong> 15 августа, 19:30<br/><strong><em>Где:</em></strong> Большая Новодмитровская, 36<br/><strong><em>Стоимость:</em></strong> от 2300 рублей<br/><a href="https://vk.cc/cOtFhc">https://vk.cc/cOtFhc</a></p>
731e251a-d4bb-4847-9ad1-bd9f12dabe6f	3fc740ae-ff5f-46f9-9cec-77c5e0d95185	<p>Филипп, наследник состояния, и его невеста Мардж живут в роскоши в Риме. Внезапно появляется Том Рипли, присланный родителями Филиппа, чтобы уговорить его вернуться в США и заняться семейным бизнесом. Но Филипп не хочет возвращаться, а Том, очарованный их беззаботной жизнью, тоже не спешит уезжать.<br/><br/><strong><em>Когда:</em></strong> 14 августа, 16:00-18:00<br/><strong><em>Где:</em></strong> Болотная набережная, 15<br/><strong><em>Стоимость:</em></strong> 200 рублей<br/><a href="https://vk.cc/cOtFlR">https://vk.cc/cOtFlR</a></p>
bbbff457-a9b4-4719-bede-af4b6557dc1d	745ba9b4-3e9b-4334-8f64-6133dff8ff05	<h2 id="vyistavka-moy-vyibor">Выставка «Мой выбор» </h2>
7d413fad-2f18-454b-bfb4-cb4483031681	34b57cb9-2d72-4424-bb14-8935dcdcf4f9	<p>Галерея представит на Биеннале частных коллекций выставку, основанную на личном собрании ее основателя Александра Шарова. В экспозицию войдут работы, приобретенные им с 2005 по 2025 год, отражающие эволюцию его вкусов. Все представленные художники связаны с галереей, так как автор покупал только те работы, которые хотел видеть в своей коллекции.<br/><br/><strong><em>Когда:</em></strong> вт-вс, 12:00-20:00<br/><strong><em>Где:</em></strong> 4-й Сыромятнический переулок, 1/8<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cOtFta">https://vk.cc/cOtFta</a></p>
2c8aecc2-72f6-4092-a6d6-9375ade281b8	a1a9c443-fd65-446e-a554-5228d21030c8	<p>Стендап в темноте – единственный в России иммерсивное шоу, где топовые комики смешат зал без света, полагаясь только на юмор. Популярный концепт теперь в Москве: никакой визуализации, только чистая комедия для твоего слуха.<br/><br/><em><strong><em>К</em>огда<em>:</em> </strong></em>15 августа, 21:30<em><br/><strong>Где:</strong> </em>Верхняя Радищевская, 15с2<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 1120 рублей<br/><a href="https://vk.cc/cOtFxY">https://vk.cc/cOtFxY</a></p>
80125505-61dc-44ca-a67d-ec49c228ad81	b393e86e-c227-4238-8a6a-6cbd72b28d6a	<h2 id="vyistavka-morskoe-puteshestvie-1933-goda">Выставка «Морское путешествие 1933 года»  </h2>
6043b37b-a641-469e-a843-d9e16661e82d	e6fadd27-dfaf-4989-9f51-21d535233933	<p>Спектакль рассказывает о любви, за которую цепляются, как за спасательный круг, пассажиры корабля. Одни встречают первую любовь, другие — последнюю. На фоне прекрасного морского пейзажа, созданного с помощью компьютерной графики, рождаются надежды и рушатся жизни, возникают дружба и конфликты.<br/><br/><em><strong><em>К</em>огда<em>:</em> </strong></em>15 августа, 19:00<em><br/><strong>Где:</strong> </em>Большая Садовая, 16с1<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 500 рублей<br/><a href="https://vk.cc/cOtFEo">https://vk.cc/cOtFEo</a></p>
bf1adac0-8ebc-4cbe-9916-42b3bb789148	918b2c94-aac4-4461-8e0b-ffc019d91f17	<p>Один из самых креативных мастер-классов в Москве: здесь ты научишься работать с нейросетями и создашь свой стикерпак. Отличный вариант для тех, кто хочет освоить современные технологии через творчество!<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>дату и время конкретного мастер-класса уточняй на сайте<br/><em><strong>Где: </strong></em>Пятницкая, 76<em><strong><br/>Стоимость:</strong></em> 700 рублей<br/><a href="https://vk.cc/cOtFMj">https://vk.cc/cOtFMj</a></p>
ee9e6ed1-d267-4655-b161-31b0175348c1	ab145ce9-5679-4818-a89a-c111c877a503	<p>В основе выставки находится известная присказка: «Сказка — ложь, да в ней намек — добрым молодцам урок». Эта народная мудрость поделила экспозицию на две смысловые части: школьные классы и захватывающие сказочные ландшафты и интерьеры, знакомые каждому с детства.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 12:00-20:00<br/><em><strong>Где:</strong></em> 4-й Сыромятнический переулок, 1/8<br/><strong><em>Стоимость: </em></strong>1000 рублей<br/><a href="https://vk.cc/cGfDFw">https://vk.cc/cGfDFw</a></p>
ab2fb25f-6537-4ae1-850b-bb5bec742550	c995bb74-822d-4a82-b849-d8ba98278148	<p>Это волшебный музыкальный вечер, погружающий в эпоху барокко. Здесь прозвучат прекрасные произведения в исполнении струнного квартета, включая симфонические шедевры в новой аранжировке. <br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>7 августа, 19:00<br/><em><strong>Где:</strong></em> Брюсов переулок, 2/14с8<br/><strong><em>Стоимость: </em></strong>от 1500 рублей<br/><a href="https://vk.cc/cO1P4O">https://vk.cc/cO1P4O</a></p>
f780ccc2-700e-4902-8f6b-2c33009cfba2	50c24df9-040a-4b83-99d3-00545a142b78	<p>Отправившись на литературно-мистическую прогулку по Булгаковской Москве, вы познакомитесь с историей создания культового романа «Мастер и Маргарита» и побываете в местах, связанных с жизнью героев произведения и происходившими с ними событиями.</p>
6119ae89-9631-4742-bc09-f27c27474777	6b24d95a-9cdb-422f-b38e-8f87b183c4ab	<p><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>дату и время конкретной экскурсии уточняй на сайте<br/><em><strong>Где:</strong></em> Триумфальная площадь, 2<br/><strong><em>Стоимость</em></strong>: 700 рублей для студентов<br/><a href="https://vk.cc/crPXZh">https://vk.cc/crPXZh</a></p>
6c13354e-742a-4493-bd07-ff367e9d75e3	60ed66e0-cb37-4419-bbd0-65b47a6bbf20	<p>Каждый автомобиль, находящийся здесь, — итог огромного труда коллекционеров и реставраторов. Старейшим экспонатам музея больше ста лет: это американский Studebaker EMF-30 и немецкий 8/20 Sport Benz, оба 1912 года выпуска. А благодаря интерактивным экспонатам и инсталляциям можно узнать много интересного, например, как устроены автомобильные механизмы.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн-вс, 10:00-21:00<br/><em><strong>Где:</strong></em> Самокатная, 4с34<br/><strong><em><strong><em>Стоимость: </em></strong></em></strong>900 рублей для студентов<br/><a href="https://vk.com/away.php?to=https%3A%2F%2Fautomuseum.ru%2F&amp;cc_key=crYv3K" rel="noreferrer noopener" target="_blank">https://vk.cc/crYv3K</a></p>
affeb830-0647-4d39-8057-8cf86f176523	75f9d62d-6604-4d0e-9b4f-5731ce6485ac	<p>В Мультимедиа Арт Музее проходит выставка Данила Головкина — звезды фэшн-фотографии, работавшего с Vogue, Harper’s Bazaar, Tatler и Elle. Уникальные снимки от одного из самых влиятельных фотографов индустрии!<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн-вс, 12:00-21:00<br/><em><strong>Где:</strong></em> Остоженка, 16<br/><strong><em><strong><em>Стоимость: </em></strong></em></strong>от 350 рублей<br/><a href="https://vk.cc/cO1PTe">https://vk.cc/cO1PTe</a></p>
d795c948-d9d7-4af0-895f-cea0235b5143	f3801b18-03ca-412b-972f-62677e687d1b	<p>Обзорная экскурсия по знаменитым читальным залам и самому большому в стране Музею книги познакомит тебя с главной библиотекой России, ее богатейшей историей, величественной архитектурой и уникальными фондами.</p>
90e6189c-9eda-4f7a-9088-e1d7fcf7c935	bfc81126-97e3-469f-92c0-ba3471796984	<p><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>дату и время уточняй на сайте<br/><strong><em>Где: </em></strong>ул. Воздвиженка, 3/5<br/><strong><em>Стоимость: </em></strong>600 рублей для студентов<br/><strong><em>Мероприятие можно посетить по Пушкинской карте</em></strong><br/><a href="https://vk.cc/cO1ReC">https://vk.cc/cO1ReC</a></p>
57743449-e036-495b-80e3-d0095de668bc	e615bb55-a10f-45a8-a92e-474e5d399e69	<p>Выставка рассказывает о парфюмерной индустрии России 1920–1930-х годов. Более 200 экспонатов — от картин до винтажных аксессуаров и ароматических инсталляций — покажут, как развивалась индустрия красоты и менялась советская повседневность.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 11:00-21:00<br/><em><strong>Где: </strong></em>Ходынская, 2с1<em><strong><br/>Стоимость: </strong></em>400 рублей для студентов<br/><a href="https://vk.cc/cNWpyc">https://vk.cc/cNWpyc</a></p>
3c69179a-0915-43fd-8115-fe9d59c4e289	99d1aabc-14db-485b-aaf7-eee5046671ab	<p>Комедия Оскара Уайльда, насыщенная забавными интригами, неожиданными ситуациями и комическими недоразумениями. В спектакле присутствуют остроумные, ироничные диалоги и выдающийся актерский состав, что делает просмотр приятным и веселым, а также может заставить задуматься о том, как создание идеалов может быть опасным занятием.</p>
8e60887c-7ca9-404a-9b2e-2994185ea2aa	e5ddd32b-2027-4610-a133-d0ad15b83885	<p><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong>30 июля, 19:30<strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong>проспект Мира, 119с84<br/><strong><em>Стоимость: </em></strong>от 1000 рублей<br/><a href="https://vk.cc/cwrEQ1" rel="noreferrer noopener" target="_blank">https://vk.cc/cwrEQ1</a></p>
3c40017e-ab23-49ee-8403-968f1e1cf5f2	410c0060-05c2-4106-a3ad-8dab0db296aa	<p><em><strong>Когда</strong></em><strong><em>: </em></strong>12 июля, 18:00<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Новозаводская, 27<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 1000 рублей<br/><a href="https://vk.cc/cwXlDf">https://vk.cc/cwXlDf</a></p>
1341c547-183e-4dae-9219-d62586c98b41	07c12652-c636-4eec-b7ae-c6d57d33b6c0	<p>В рамках Биеннале частных коллекций пройдет выставка, основанная на личном собрании основателя галереи Александра Шарова. В экспозицию войдут работы, приобретенные с 2005 по 2025 год, отражающие эволюцию его вкусов. Все представленные художники — из числа тех, чьи работы автор сам хотел видеть в своей коллекции, что стало ключевым принципом отбора для галереи.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> вт-вс, 12:00-20:00<br/><em><strong>Где:</strong></em> 4-й Сыромятнический переулок, 1/8<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cNWqVN">https://vk.cc/cNWqVN</a></p>
d84a6ec3-0125-41e5-b946-865d2b8f4ef2	4a916a9b-82d0-4c4e-aab7-f398b015c025	<p>Открой Вьетнам через искусство: кукольный театр на воде, этническая музыка, национальные танцы, декоративное искусство и фотографии. В центре Москвы пройдет более 100 мероприятий, где гости услышат мелодии природы, увидят танцы и узнают секреты вьетнамской кухни.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> с 25 июля по 3 августа, время конкретного мероприятия уточняй на сайте<br/><em><strong>Где:</strong></em> Манежная площадь<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cO0Go5">https://vk.cc/cO0Go5</a></p>
d2ca83b6-8e90-4934-85be-3ca4ffacf3cc	8c0d9446-d5c3-4b61-8789-1f6adcc632c9	<p>Ты сможешь полюбоваться живописными видами Москвы-реки и главными достопримечательностями города. Тебя ждут: Парящий мост в Зарядье, Кремль, храм Василия Блаженного, Храм Христа Спасителя, памятник Петру I, парк Горького и другие знаковые места!<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> дату и время конкретной экскурсии уточняй на сайте<br/><em><strong>Место встреча:</strong></em> Причал «Киевский» (сектор «A»)<br/><strong><em>Стоимость: </em></strong>от 700 рублей<br/><a href="https://vk.cc/cO15ep">https://vk.cc/cO15ep</a></p>
bbb10c91-414e-4d8f-bc9f-526d4b27e37a	5f64d1cf-f1cb-48f7-a491-d6ab03d488c5	<p>Во Флорариуме представлены разнообразные виды растений, включая лекарственные, декоративные, хозяйственно важные и редкие, со всей территории России. Для выращивания растений используется метод аэропоники, при котором растения не растут в почве, а получают питательные вещества в виде аэрозоля, направленных к корням.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>29 июля, 11:00-19:00<br/><em><strong>Где:</strong></em> Варварка, 6с1<br/><strong><em><strong><em>Стоимость: </em></strong></em></strong>650 рублей<br/><a href="https://vk.cc/cO15JS">https://vk.cc/cO15JS</a></p>
64aed25b-4bb9-4102-b76c-4acb87f5da8c	2b9e5c0a-0d22-410f-959f-629bdb84095e	<p>Экспозиция разделена на зоны: живопись, графика, скульптура, игрушки. В глубине — шоу-рум с красным бархатом, пародирующий музейную торжественность. Вся эта нарочитая коммерциализация высмеивает рыночные правила, защищая искусство от превращения в бездушный товар.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 12:00-20:00<br/><em><strong>Где: </strong></em>4-й Сыромятнический переулок, 1/8<em><strong><br/>Вход свободный</strong></em><br/><a href="https://vk.cc/cNCiqr">https://vk.cc/cNCiqr</a></p>
02cbea17-75cc-45d7-abbd-a029e8c08d6a	41ba50e0-1df1-41e4-a297-38916e095805	<p>В Москве пройдет стендап-концерт, на котором именитые комики представят свой проверенный материал. Для гостей выступят участники многочисленных телевизионных и YouTube проектов: StandUp, Открытый микрофон, Comedy Battle, Прожарка и многих других.</p>
6cd50c3c-8d06-45c7-8420-65447e7fde9b	040ce2ac-8f3b-4966-bcf3-d95f039a9ac7	<p><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн-вс, время уточняй на сайте<br/><em><strong>Где:</strong></em> место проведения конкретного концерта уточняй на сайте<br/><strong><em>Стоимость: </em></strong>от 790 рублей<br/><a href="https://vk.cc/cNQOej">https://vk.cc/cNQOej</a></p>
9b2339e1-4e90-4923-a949-1405e0fd29b6	25804377-4adb-45ce-bd19-d52110b1d6fc	<p>Тима Белорусских на сцене — значит, будет море драйва, нежности и хитов, от которых мурашки. Готов танцевать до последнего?<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>25 июля, 17:00<br/><em><strong>Где:</strong></em> Шмитовский проезд, 32А<br/><strong><em>Стоимость: </em></strong>от 1699 рублей<br/><a href="https://vk.cc/cNQPn7">https://vk.cc/cNQPn7</a></p>
3a535df5-f6a7-46ec-b59c-2438ece0909c	e0f55865-6fc7-4cd0-8a30-a2c371da36cf	<p>Это место, где можно познакомиться с культовыми японскими автомобилями разных классов, выпущенными до 1990 года. В музее представлены как редкие и уникальные модели, так и автомобили, известные по различным произведениям поп-культуры.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> вт-пт, 11:00-21:00,<br/>сб, вс, 10:00-22:00<br/><em><strong>Где:</strong></em> Ташкентская, 28с1<br/><strong><em>Стоимость: </em></strong>700 рублей для студентов<br/><a href="https://vk.cc/aApUYh">https://vk.cc/aApUYh</a></p>
9c36be3e-640b-4ddc-bf36-e19acbbb3417	a5201c1c-e705-466c-abac-0a27dc7e9d02	<p>Галерея XL представляет выставку Антона Морокова, Артема Филатова и Якова Хорева, посвященную визуальной природе искусства, его видимым и скрытым аспектам, а также влиянию зрительного восприятия на размышления и критику.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 12:00-20:00<br/><em><strong>Где: </strong></em>4-й Сыромятнический переулок, 1/8<em><strong><br/>Вход свободный</strong></em><br/><a href="https://vk.cc/cNt0Sl">https://vk.cc/cNt0Sl</a></p>
8b2ae24e-4ec3-4bed-94f5-3f91d3fab41a	f4d5be75-45c4-4571-a2ef-07c56c4c5288	<p>Егор работает в караоке, но мечтает о собственных хитах и жизни с девушкой Юлей, несмотря на запрет ее отца. Найдя в шкафу портал в 1991 год, он начинает выдавать будущие суперхиты за свои. Слава, деньги и власть над судьбой — все в его руках. Но каждая попытка улучшить будущее оборачивается неожиданными последствиями.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> дату и время конкретного кинопоказа уточняй на сайте<br/><em><strong>Где:</strong></em> место проведения конкретного показа уточняй на сайте<br/><strong><em>Стоимость: </em></strong>от 250 рублей<br/><a href="https://vk.cc/cNQPTz">https://vk.cc/cNQPTz</a></p>
38170e97-9540-4a8a-b156-cd373df8019c	a6b9d269-95c2-4a2c-9e0f-26660ea97858	<p>Представляем первое в Москве тайм-кафе с живыми ежиками. Ты сможешь провести время в компании Африканских и ушастых ежиков, особенностью которых является аномальное дружелюбие. Также тебя ожидает большой выбор настольных игр и Playstation.</p>
76e659fc-a6ed-4026-bb9a-f989fd58a623	b2f7b9be-70c0-47e9-bb99-235fc52baabd	<p><strong><em>Когда:</em></strong> пн-вс, 11:00-23:00<br/><strong><em>Где:</em></strong> Арбат, 6/2<br/><strong><em>Стоимость:</em></strong> от 450 рублей<br/><a href="https://vk.cc/cE0T6O">https://vk.cc/cE0T6O</a></p>
ace64da5-8052-4ad0-9aac-6e56de739d5c	2ce38fa6-bc7e-442c-ab38-acf8b61a10ea	<p>Автор в своей работе подчеркивает, как важно наполнять серые будни теплыми воспоминаниями и близостью любимых. Его герои – влюбленные, чье безмолвное общение согревает холод городских пейзажей, показывая ценность душевной теплоты в это время.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 12:00-20:00<br/><em><strong>Где: </strong></em>4-й Сыромятнический переулок, 1/8<em><strong><br/>Вход свободный</strong></em><br/><a href="https://vk.cc/cCXjbv">https://vk.cc/cCXjbv</a></p>
d87287fa-3815-40a3-b9b0-32c0b70fce2b	bda91c4b-e7f7-4f50-9812-aba30f48d7a3	<p>Это одно из немногих оригинальных театральных произведений. Написанная в 1997 году, пьеса проникнута атмосферой 1960–70-х, эпохи его молодости. Ее кинематографичный стиль, изящный и простой сюжет держат зрителя в напряжении — невозможно угадать, что ждет героев в следующий момент.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>18 июля, 19:00<br/><em><strong>Где: </strong></em>Хамовнический Вал, 34<em><strong><br/>Стоимость: </strong></em>от 2000 рублей<br/><a href="https://vk.cc/cNFA0J">https://vk.cc/cNFA0J</a></p>
43e790d8-8252-4b3d-a0ba-bb3f1b15eb16	cfaf63e5-e397-4597-8f64-90ad1f87965e	<p>Прогулки на сапогах с инструктором — это уникальный способ развлечься, насладиться красотами природы и провести время в компании близких. Все участники получают необходимое снаряжение, включая специальный чехол для телефона.<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>дату и время конкретной прогулки уточняй на сайте<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>Серебряный Бор, пляж №2 и №3<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 2200 рублей<br/><a href="https://vk.cc/cy6ifP" rel="noreferrer noopener" target="_blank">https://vk.cc/cy6ifP</a></p>
1c2fc731-440d-4ae7-a1a1-a7c4977785a3	53a8b306-b194-45b2-9d30-5cac69a4da04	<p>Это необычный музей, в котором каждый окунется в мир ощущений через призму отсутствия одного из важнейших чувств – слуха, где обостряются обоняние, осязание, вкус и зрение. На протяжении всей экскурсии тебя будет сопровождать гид, который поможет погрузиться в мир тишины и пройти 5 интерактивных зон.<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>дату и время конкретной экскурсии уточняй на сайте<strong><em><strong><em><strong><em><br/><strong>Где:</strong></em></strong></em></strong></em></strong> природно-исторический парк Кузьминки-Люблино, 1с12<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 350 рублей<br/><a href="https://vk.cc/cocjHL" rel="noreferrer noopener" target="_blank">https://vk.cc/cocjHL</a></p>
56a1f47f-5910-485e-86fb-7994d0f10306	5ae2c3ea-a04b-4349-a267-293c33144029	<p>Экспозиция музея Яндекса представляет собой коллекцию компьютеров и рабочих станций. Ее основу составляет техника советского производства из коллекции Виктора Боева — основателя Клуба Любителей Советских Компьютеров. Выставка также дополнена зарубежными образцами.  <br/><br/><strong><em>Когда:</em></strong> вт-вс, 11:00-20:00<br/><strong><em>Где:</em></strong> Тимура Фрунзе, 11с13<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cE0TIn">https://vk.cc/cE0TIn</a></p>
616d8971-6931-4f3f-b8eb-49dab37c381e	bd152967-3a71-41c9-bc5e-4dace1455b22	<p>Экспозиция воссоздает «воображаемую вселенную» автора через его архитектуру, дизайн и сценографию, отражая идею культуры как пространства равенства и общности. Схожие принципы лежат в основе «ГЭС-2» — с его акцентом на горизонтальные связи и коллективное творчество.<br/><br/><strong><em>Когда:</em></strong> пн–вс, 11:00-22:00<br/><strong><em>Где:</em></strong> Болотная набережная, 15<br/><strong><em>Вход св</em></strong><em><strong>ободный, нужна предварительная регистрация</strong></em><br/><a href="https://vk.cc/cNCinC">https://vk.cc/cNCinC</a></p>
9ebd88dc-d6a3-49de-907b-ee2221918f08	60c9ff8b-32b0-44a1-ac4d-497978346e20	<h2 id="a106nq2x59ah5auu"><span id="oborona-brestskoy-kreposti">Оборона Брестской крепости </span></h2>
6375b1fe-ff58-450c-9dd6-b1c50b2867cc	4f992d6b-f8c6-4d0f-b75b-0bd97dc33c96	<p>Парк «Патриот» — главный парк КиО ВС РФ с экспозицией военной техники, включая редкие и экспериментальные образцы. Посетителям доступны мини-танки, пневматическое оружие, верховая езда и тренажеры-симуляторы.<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>вт-пт, 10:00-18:00, <br/>сб, вс, 10:00-19:00<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Минское шоссе, 43-й километр, 55<strong><em><br/><strong><em>Вход свободный</em></strong></em></strong><br/><a href="https://vk.cc/cttu8f">https://vk.cc/cttu8f</a></p>
101aaddd-5fe3-49fe-9317-548f34dc19a7	07ca308f-47a0-4856-b74c-a9127ba8bf06	<p>Это уникальная коллекция шедевров ювелирного искусства XVIII–XX веков, редких драгоценных камней, орденских знаков и самородков, имеющая огромную историческую, художественную и материальную ценность. Она тесно связана с историей Российского государства.<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>пн-ср, пь-вс, 10:00-17:20<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Москва, Кремль<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>100 рублей для студентов<br/><a href="https://vk.cc/cNt1YY">https://vk.cc/cNt1YY</a></p>
602ac7b2-5103-435c-ad5b-5a947d208283	9d774492-d16b-461a-88ed-d92c3d5034f4	<p>Российский предприниматель решает удивить свою супругу к юбилею, организовав мюзикл с песнями группы «ABBA». Режиссер и команда взялись за проект с энтузиазмом, но в день премьеры возникают неожиданные проблемы: главная исполнительница оказывается в больнице, а заказчик делает странные замечания, заставляя изменить сюжет и музыку.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> 10 июля, 19:00<br/><em><strong>Где:</strong></em> Комсомольский проспект, 28<br/><strong><em>Стоимость: </em></strong>от 2500 рублей<br/><strong><em>Мероприятие можно посетить по Пушкинской карте</em></strong><br/><a href="https://vk.cc/cNt2iB">https://vk.cc/cNt2iB</a></p>
d98bc0c6-6dfa-499a-abcb-a10b4707b101	c490949e-a9c9-45cf-8e10-79c81c33cb7a	<p>Ты сможешь увидеть старый Арбат, избушку в центре Москвы, доходные дома и мировой памятник авангарда — дом Мельникова. Узнаешь, где придумали десерт «Птичье молоко» и почему деревянная изба была самым прогрессивным местом в конце 19 века.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> дату и время конкретной экскурсии уточняй на сайте<br/><em><strong>Место встречи:</strong></em> станция метро Арбатская<br/><em><strong>Стоимость: </strong></em>от 1200 рублей<br/><a href="https://vk.cc/cFeiLG">https://vk.cc/cFeiLG</a></p>
2c7cce88-4d98-4ef8-bbfa-96cb328252a8	bcbf95db-f528-4f67-8fee-1862f52b1058	<p>Выставка вдохновлена атмосферой современных мегаполисов Юго-Восточной Азии, где художница Дишон Юлдаш живет и работает. Через призму городского пространства она исследует механизмы власти, контроля и подчинения.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 12:00-20:00<br/><em><strong>Где: </strong></em>4-й Сыромятнический переулок, 1/8<em><strong><br/>Вход свободный</strong></em><br/><a href="https://vk.cc/cNgYU9">https://vk.cc/cNgYU9</a></p>
b450d874-dfcc-46c1-8a59-4e0dc7f278c0	65d2c1c0-bdc9-496a-8ec5-49963e44f232	<p><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>5 июля, 19:00<br/><em><strong>Где:</strong></em> Андропова проспект, 8<br/><strong><em>Стоимость: </em></strong>от 990 рублей<br/><a href="https://vk.cc/cNh1pc">https://vk.cc/cNh1pc</a></p>
09de1b4c-4765-4517-aa19-8555dcad324e	10423e5c-b839-4dae-8f74-6888470b947c	<p>Останкинская телебашня — знаковый символ Москвы, построенный в 1967 году по проекту Николая Никитина. На первом этаже расположен интерактивный мультимедийный музей, где можно узнать историю башни. На верхней площадке можно будет рассмотреть главные достопримечательности города.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>дату и время конкретной экскурсии уточняй на сайте<br/><em><strong>Где:</strong></em> Академика Королева, 15к2<br/><strong><em>Стоимость: </em></strong>от 1100 рублей<br/><a href="https://vk.cc/cNh2mU">https://vk.cc/cNh2mU</a></p>
e9a27ea6-5acb-4fec-82a0-f225a9ade41a	14ffd52f-59bc-49c7-8d6e-e2874bc8cc22	<p>Экспозиция охватывает историю учреждения с момента открытия до современности. Она включает разделы, демонстрирующие творческие работы пациентов и результаты трудовой терапии. Особый акцент сделан на истории главы города Алексеева Николая Александровича и его вкладе в основание больницы в период с 1885 по 1893 год.<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>пн-пт, 10:00-15:00<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Загородное шоссе, 2к16<strong><em><br/><strong><em>Вход свободный</em></strong></em></strong><br/><a href="https://vk.cc/cNh2HJ">https://vk.cc/cNh2HJ</a></p>
ce2abcca-7f68-4bf1-b7cf-0b0c52c54164	a1f910fe-f473-45eb-be79-a2a9400ef155	<p>Утром 22 июня Прибалтийский, Западный и Киевский Особые военные округа были преобразованы в Северо-Западный, Западный и Юго-Западный фронты, Одесский военный округ стал Южным фронтом.</p>
f53ccf72-4815-406e-bf66-becb7e41a304	bb92d241-5c58-449f-9948-4a593feab6fa	<p>Стендап в кинотеатре — это уникальное путешествие в мир живой комедии! Список комиков держится в секрете для того, чтобы сделать зрителям приятный сюрприз на концерте.</p>
bf395bbf-362e-4696-9a0c-f13f9839df8f	2a0f028b-1983-4c04-bf92-0ae488048567	<p>Государственная Третьяковская галерея проводит масштабную ретроспективу Ильи Машкова, ведущего художника раннего авангарда, сооснователя «Бубнового валета» и выдающегося колориста XX века. На выставке собрано около 200 его работ из разных коллекций, впервые представленных вместе в таком объеме.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт, ср, вс, 10:00-18:00,<br/>чт-сб, 10:00-21:00<br/><em><strong>Где:</strong></em> Кадашевская набережная, 12<br/><strong><em>Стоимость: </em></strong>450 рублей для студентов<br/><a href="https://vk.cc/cMUlmJ">https://vk.cc/cMUlmJ</a></p>
65299e0d-1d25-4982-a519-5365910f10f7	f6bf9e15-8965-4a82-90b0-829c17b92212	<p>Познакомься с одной из крупнейших передовых киностудий не только России, но и Европы! В рамках экскурсии ты узнаешь истории создания легендарных фильмов, заглянешь в действующие кинопавильоны, а также увидишь уникальную коллекцию съемочного инвентаря.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>дату и время конкретной экскурсии уточняйте на сайте<br/><em><strong>Где:</strong></em> Мосфильмовская, 1<br/><strong><em><strong><em>Стоимость: </em></strong></em></strong>960 рублей<br/><a href="https://vk.cc/cwkcSn" rel="noreferrer noopener" target="_blank">https://vk.cc/cwkcSn</a></p>
dde1ca99-e892-4357-98a6-fd5e10a09618	a1d5e218-f272-462f-80cd-ddc6733ddf0e	<h2 id="vyistavka-volshebnyiy-fonar">Выставка «Волшебный фонарь»</h2>
c6b88d37-6468-4151-8a38-1cb831ad3501	ac25e90a-061f-40cb-9f5e-8c0dc15abc0d	<p>На выставке представлена богатая палитра художника — от природных зеленых и коричневых тонов до нереальных розовых и фиолетовых. Возможно, таких цветов нет в реальности, или обычный глаз просто не способен их разглядеть в природе.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 12:00-20:00<br/><em><strong>Где: </strong></em>4-й Сыромятнический переулок, 1/8<em><strong><br/>Вход свободный</strong></em><br/><a href="https://vk.cc/cMi0Bo">https://vk.cc/cMi0Bo</a></p>
85aee320-d5c5-42ec-ab0b-7700a2993f24	a4d3d0fa-f774-4df4-933a-afaa2595e915	<p>Два странствующих актера — трагик Несчастливцев и комик Счастливцев — попадают в имение своей тети. Там царит хаос: тетя хочет выйти за юного возлюбленного, племянница в отчаянии собирается утопиться, а гимназист готов жениться ради выгоды. Лишь бродячие актеры сохраняют искреннее сочувствие к людям.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>27 июня, 19:00<br/><em><strong>Где: </strong></em>Триумфальная площадь, 2<em><strong><br/>Стоимость:</strong></em> от 800 рублей<br/><a href="https://vk.cc/cMi0Bo ">https://vk.cc/cMi0Bo</a></p>
653f1525-1b1b-4bb2-a504-83f6a6e86600	6220c8aa-aed2-4715-8106-6fabba65d4f7	<p>Один из самых креативных мастер-классов в Москве: здесь ты научишьс работать с нейросетями и создашь свой стикерпак. Отличный вариант для тех, кто хочет освоить современные технологии через творчество!<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>дату и время конкретного мастер-класса уточняй на сайте<br/><em><strong>Где: </strong></em>Пятницкая, 76<em><strong><br/>Стоимость:</strong></em> 700 рублей<br/><a href="https://vk.cc/cN4enW">https://vk.cc/cN4enW</a></p>
a026aff8-8a6a-4f4f-8d21-3088d2ce30d1	a8b77706-02a7-4393-b46f-9eff1fd5a835	<p>Тебя ждет экскурсия по Александровскому саду с гидом: вместе вы расшифруете тайные символы Кремля, узнаете скрытые смыслы в архитектуре и скульптурах, откроете историю Москвы через ее древние знаки. А еще увидите башни с необычными прозвищами, разгадаете загадки Исторического музея и даже встретите мифическое существо на его стенах.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>29 июня, 16:00<em><strong><br/>Место встречи:</strong></em> станция метро «Александровский сад», выход №5<br/><em><strong>Стоимость:</strong></em> 712 рублей<br/><a href="https://vk.cc/cN4eNk">https://vk.cc/cN4eNk</a></p>
f62962ed-b33f-4d60-8a8e-38affd801fb8	fa2b0470-9b46-4a90-b02a-69a57f7f7e29	<p>Мультимедийная выставка посвящена творчеству Ван Гога, где большие экраны и звук помогают глубже понять его искусство и погрузиться в атмосферу его произведений. Ты сможешь узнать о создании картин и жизни художника.<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>пн-вс, 11:00–23:00<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Берсеневский переулок, 2с1<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>500 рублей для студентов<br/><a href="https://vk.cc/cx7Eqc" rel="noreferrer noopener" target="_blank">https://vk.cc/cx7Eqc</a></p>
e724dfa8-e342-4bf8-8c83-26155994dd51	e22c63ce-2fdf-4dfd-9a7d-72d36cfcf57b	<p>Скоро на поле сойдутся футбольные команды «Динамо М» и «2DROTS» — ожидается яркая игра! Болельщики готовятся к ярким моментам, мощным ударам и, возможно, неожиданным поворотам.<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>26 июня, 19:00<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Ленинградский проспект., 36<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 100 рублей<br/><a href="https://vk.cc/cN4fxz">https://vk.cc/cN4fxz</a></p>
a5b4a9b6-e5c5-465d-b4dd-1988193c53c5	cb9b5993-9940-4f63-a20f-a160d7d00900	<p><strong><em>К</em></strong><em><strong>огда</strong>:</em> пн-вс, время проведения выставки уточняй на сайте<br/><em><strong>Где:</strong></em> Новодмитровская, 1с4<br/><strong><em>Стоимость: </em></strong>690 рублей для студентов<br/><a href="https://vk.cc/cw2jKW">https://vk.cc/cw2jKW</a></p>
3cdd3c09-a92e-4276-8296-7a47fb6a9359	4d22fd3b-b1ed-4e00-b813-180a8499963e	<p>22 июня 1941 года нацистская Германия напала на Советский Союз. Этот день стал самым долгим для многих бойцов и командиров Красной армии, застигнутых врасплох в приграничных округах ранним утром разрывами снарядов и бомб в казармах и полевых лагерях. 22 июня положило начало ожесточенной, упорной и бескомпромиссной борьбы на советско-германском фронте, такой еще не знала мировая военная история.</p>
53d80f23-5499-4b2d-acb4-202d6dce1197	e4a96482-3d2c-4827-a21a-7d0d44267d35	<h2 id="a1nq2x59ah5auu"><span id="pervyie-chasyi-voynyi">Первые часы войны </span></h2>
a9bd09bc-0071-4d57-b61b-00ac87aa8aa5	b433a7ab-fa50-4dba-9f92-65b59b2fd851	<p>Предрассветная тишина была обманчивой. По ту сторону границы к двум часам ночи 22 июня немецкие войска приведены в полную готовность.</p>
e64c96b7-cb7d-4662-a03c-8e30f7fd6a15	03938940-77ae-4306-b5bf-7a438092f830	<p>В три часа пять минут по берлинскому времени (четыре часа пять минут по московскому) вся советско-германская граница была окутана дымом и оглашена разрывами снарядов — началась война. Через 25 минут с немецкой стороны начался авиационный налет. Бомбежкам подверглись города Минск, Киев, Рига, Севастополь, Вильнюс, Каунас, Брест и другие. Но основные авиаудары наносились по аэродромам и воинским частям.</p>
64da1ad8-aa98-4147-a7e1-e97a5660c6b4	79094a9a-d502-459d-9db5-120044a4be32	<p>Помощник начальника штаба 4-й комендатуры старший лейтенант Михаил Цыпленков накануне войны был послан с проверкой на 15-ю погранзаставу и взял на себя командование после того, как был смертельно ранен начальник заставы лейтенант Степан Степанковский.</p>
405a7621-318d-4fb0-8d63-177d5c38b3f6	89c77c69-55f0-4e21-9ac2-4163c607af58	<p>По свидетельству Цыпленкова, сначала на заставу обрушился бомбовый, следом артиллерийско-минометный удар, а затем немцы численностью около батальона предприняли две попытки захватить позиции оборонявшихся.</p>
f0aee0b4-ea65-4755-a4e1-d6896dff77a5	048dde84-e88d-41a3-b752-b146378fbc3f	<p>Отбить третью атаку помогли 13 служебных собак, которых спустили на нацистов. Когда те в замешательстве остановились, пограничники начали расстреливать врагов. Но к 10 часам утра в живых осталось только трое бойцов, которые соединились с частями РККА.</p>
10c56d35-2519-4137-b9d2-55886ab9b428	db130c56-46da-4a76-a754-edf048262d7b	<p>В 3 часа 42 минуты утра начальник Генерального штаба генерал Георгий Жуков экстренно позвонил Сталину и, разбудив вождя, сообщил ему о случившемся. В ответ тот приказал ему вместе с наркомом обороны маршалом Семеном Тимошенко прибыть в Кремль. В 4 часа 30 минут началось совещание членов Политбюро с участием военных.</p>
5d7c6314-232b-43d8-a00d-d59e22b1d655	580a8f5d-9c2f-4c13-b847-aa81cdb59276	<h2 id="a89nq2x59ah5auu"><span id="kak-nachalas-voyna">Как началась война </span></h2>
14edbcfe-90ec-4a86-83e8-0332163b4d6f	e9fd50ca-f77a-4497-98ca-19f8564a53c2	<p>14 июня 1941 года в советских газетах появилось сообщение, в котором говорилось о том, что в английской и вообще иностранной печати стали усиленно распространяться слухи о близкой войне между СССР и Третьим рейхом.</p>
05a42a16-3a57-4ed2-9ce3-dfe8bf785770	0e884a35-7ae3-41e2-bf3f-3fbe6d420701	<p>15 июня Тимошенко и Жуков доложили Сталину о полной готовности немецких войск к нападению, напомнив в очередной раз о необходимости приведения армии в боевую готовность. В ответ вождь возразил: «Вы что же, предлагаете провести в стране мобилизацию, поднять сейчас войска и двинуть их к западным границам? Это же война!»</p>
221ee51e-c698-40ce-b608-d69d895ef3ea	aa9e18f1-b934-4298-9677-4bb53d0d0819	<p>Тревожные сигналы тем временем нарастали. В девять часов вечера 21 июня 1941 года немецкий ефрейтор Альфред Лисков переплыл Буг и сдался дозору 90-го пограничного отряда. На допросе он сообщил, что война начнется 22 июня.</p>
6c72925a-f0cb-4f2a-a000-becfc1c6f139	2fe47537-4f79-46fa-8f99-1066b121ffad	<p>Об этом был немедленно оповещен Сталин, который распорядился подготовить директиву войскам Ленинградского военного округа, Прибалтийского Особого военного округа, Западного Особого военного округа, Киевского Особого военного округа и Одесского военного округа — с копией наркому Военно-морского флота Николаю Кузнецову. В директиве наркомата обороны сообщалось, что в течение 22-23 июня возможно внезапное нападение немцев.</p>
51144619-648d-478a-ac8d-94911d61ab00	06e3f30e-522f-4b76-9387-7b121c3a22ab	<p>Частям приказывалось в течение ночи на 22 июня скрытно занять огневые точки укрепленных районов на государственной границе; рассредоточить по полевым аэродромам всю авиацию и тщательно замаскировать; войска привести в боевую готовность и держать рассредоточенно.</p>
ed5f7c85-a305-465e-9d55-b607c9645aba	52ae4c72-5190-4207-beb3-bf250a5b802b	<p>Передача директивы была закончена в 00.30 минут 22 июня 1941 года, после чего командующие округов начали телеграфировать указания Москвы в свои соединения. Но кое-где проводная связь была уже перерезана диверсантами, а где-то войска получили указания уже после начала войны.</p>
64ad712e-d17c-40f4-9dc7-b4bc9f332296	bf2f75c4-dc20-41f3-bb00-5b48386d0bd6	<p>Наибольший нажим испытывал Западный фронт, на правом фланге которого наступала 3-я танковая группа вермахта, на левом — 2-я. При этом генерал пришел к выводу, что овладеть Брестской крепостью с ее укреплениями, отделенной двумя реками и многочисленными рвами, может только пехота, но не стремительная танковая атака — у Гудериана был опыт штурма крепости в 1939-м, когда ее защищали польские войска. К июню 1941-го в окрестностях крепости были возведены доты 62-го укрепрайона, и для прорыва узла обороны требовалось вмешательство артиллерии большой мощности.</p>
97f78898-f6a2-4fc9-9e2c-bf40d546f01c	2b00d7b2-e3fc-4f5b-a025-fc6e3db9dacb	<h2 id="a124nq2x59ah5auu"><span id="uporstvo-sovetskoy-pehotyi-i-tankistov">Упорство советской пехоты и танкистов</span></h2>
1e9d51b4-548f-4068-bd11-567545598e60	9e072150-1494-48da-b691-ae39dba455d8	<p>Тем временем 2-я танковая группа обходила Брест с юга и севера, медленно переправляясь по мостам через Западный Буг. Группа армий «Центр» нанесла два удара под основание Белостокского выступа, который оборонялся 10-й армией Константина Голубева, очертив контуры будущего кольца окружения. Одновременно был совершен мощный артиллерийский удар по Гродно, в котором участвовали орудия крупных калибров, после чего последовала атака германской бронетехники.</p>
0904fa5a-477e-43c8-9f57-3fb2355dd01d	fa394ba2-f1c1-451a-b9af-c1c6ff1ffd2d	<p>На подступах к Гродно немцев ждал 11-й мехкорпус генерала Дмитрия Мостовенко. По его словам, тридцатьчетверки произвели впечатление на врага: «Танки противника, пытавшиеся атаковать наши танки, были подбиты, а оставшиеся держались за обороняющейся пехотой». Но не везде продвижение нацистов проходило столь быстро и гладко.</p>
357d3a76-052b-43a4-886a-3b24939b0659	5a808087-490f-45f2-8582-233b9a6b0fd2	<p>1-я танковая дивизия вермахта в лоб попыталась взять небольшой городок Таураге на западе Литвы. 51-й корпусной артиллерийский полк РККА, расположенный восточнее населенного пункта, открыл мощный заградительный огонь из 152-миллиметровых гаубиц. 210-миллиметровые и 150-миллиметровые немецкие гаубицы вступили в артиллерийскую дуэль. Противотанковые германские пушки отражали контратаку краснозвездных танков.</p>
747cf822-670f-4efd-9721-b5cb98651fbb	19575260-e2d4-4b7f-aa55-9b3a93eb0afe	<p>К четырем часам дня немцам удалось в целом взять город под контроль, но последние советские части были оттеснены на северо-восточные окраины Таураге только к полуночи.</p>
351d2225-2cc3-44db-aa4a-d033ae4d898d	e7d81190-bc69-49f6-83fb-24efada64002	<h2 id="a140kqik63n34zep"><span id="osobennosti-sovetskih-ognevyih-tochek">Особенности советских огневых точек </span></h2>
ea6b5dac-a954-4577-b014-c3ec7bdaecbc	bc80a500-ec43-479c-b4e6-ed85e17bd18e	<p>События на Юго-Западном фронте генерала Михаила Кирпоноса развивались чуть менее интенсивно, чем у соседей: осторожный фон Клейст придерживал ввод танковых дивизий, ожидая, когда пехота прорвет советскую оборону. Для блицкрига необходимы были дороги с твердым покрытием, а они проходили через позиции Владимир-Волынского, Струмиловского и Рава-Русского укрепрайонов.</p>
e2a359ba-4f00-46de-8221-2620358897d6	abcf3aba-9745-4f5a-9148-95ee5db41e10	<p>Несмотря на то что эти укрепрайоны были недостроены, орудия и пулеметы долговременных огневых точек простреливали пространство не только с фронта, но и с тыла, а сами доты были оснащены бронеколпаками.</p>
c9f22ed6-7574-4b42-a90c-584764f786ef	57d65710-56f1-4cf8-9a11-892866921bca	<p>87-я дивизия под командованием генерала Филиппа Алябушева при поддержке двух танковых батальонов контрударом отбросила части 298-й немецкой дивизии на шесть-десять километров от Владимира-Волынского, деблокировав при этом гарнизоны дотов укрепрайона, которые оборонялись уже в неприятельском тылу.</p>
c26b17b3-1570-4682-a193-f062eeb049ed	27012a82-c5c2-45da-9643-91b1b4b6d790	<p>Будучи мощнейшей армией мира, опередив РККА в отмобилизованности и сосредоточении войск, вермахт на широком фронте нанес 22 июня 1941 года советским частям прикрытия ряд тяжелых ударов, очертив контуры будущих котлов и окружений. Однако перед ним был совсем иной противник, чем на Западе: долгий и кровавый путь к Берлину начинался именно тогда, в самый первый день войны. Но об этом еще никто не знал.</p>
783c4080-6a36-4549-b3c9-122846420b12	5351bab9-1bb8-4642-8ae1-68890f5868b9	<p>Тебя ждет блеск и величие царских драгоценностей, непривычные предметы быта, золотая парадная колесница, статуи богов, магические украшения царской мумии и саркофаги. Но самыми впечатляющими экспонатами, конечно, являются известный бюст Нефертити и знаменитая погребальная маска Тутанхамона!<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн-вс, 10:00-22:00<br/><em><strong>Где: </strong></em>проспект Мира, 119<em><strong><br/>Стоимость: </strong></em>800 рублей для студентов<br/><a href="https://vk.cc/cjnG1s">https://vk.cc/cjnG1s</a></p>
23c53ce2-f808-4d22-a185-a197305e631a	4739cd9c-1905-476a-a757-8d2ccbb0490d	<p>Гранд-оркестр Поля Мориа задал новые стандарты эстрады, покорив мир своими турне и рекордами. Десятилетиями его музыка остается популярной, узнаваемой с первых нот. В этом концерте прозвучат органные и оркестровые версии легендарных хитов, покоривших миллионы.<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>2 июня, 21:00<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Старосадский переулок, 7/10с10<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 1000 рублей<br/><a href="https://vk.cc/cMS1Xz">https://vk.cc/cMS1Xz</a></p>
9623a3e3-bcea-4987-ad6e-7fb7b0aa801a	f5118af7-8779-4388-8bcf-43e9e3525ca3	<p>«Загадочные вариации» — пьеса с непредсказуемым сюжетом и несколькими неожиданными финалами. Ее интрига держит зрителя в напряжении, а хитросплетения отношений и обстоятельств заставляют пересматривать спектакль снова и снова.<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>17 июня, 19:00<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Тверская, 5/6<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 1488 рублей<br/><a href="https://vk.cc/cMS3WX">https://vk.cc/cMS3WX</a></p>
be6d5b4d-f338-416f-8d84-020c5e45a821	3a6ab826-5d5f-4ba3-8ce8-4d9dc2471670	<p>Не упусти шанс провести свой вечер в атмосфере шуток и юмора! Тебя ждут выступления профессиональных комиков, участниц шоу «Женский Стендап на ТНТ», «Labelcom», «Открытый микрофон на ТНТ» и других популярных ТВ и YouTube проектов.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> 16 июня, 20:00<br/><em><strong>Где:</strong></em> Покровка, 17с5<br/><strong><em>Стоимость: </em></strong>от 430 рублей<br/><a href="https://vk.cc/cMS4J9">https://vk.cc/cMS4J9</a></p>
b58079b6-7ff3-49f8-9891-dd9b5824fcd1	ae036ac0-9cfe-4648-9d98-ba22a8bc2bea	<p>Коллекция Дарвиновского музея Москвы — это наглядная иллюстрация теории эволюции Чарлза Дарвина, история живого мира Земли с самых древнейших времен до нынешних дней.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> вт-вс, 10:00-18:00<br/><em><strong>Где:</strong></em> Вавилова, 57<br/><strong><em>Стоимость: </em></strong>550 рублей<br/><a href="https://vk.cc/cl0CDc">https://vk.cc/cl0CDc</a></p>
1c16191e-5a7e-4279-a7dc-63a882cf6604	f5a82601-4915-4b99-a319-0e4720146144	<p>Москвариум на ВДНХ — крупнейший аквариум в Европе, где обитает более 12 000 морских и пресноводных животных. Ты сможешь увидеть уникальных представителей подводного мира и даже принять участие в тренировках некоторых видов, таких как нерпы и выдры.<br/><br/><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong>пн-вс, 10:00-22:00<strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong>проспект Мира, 119с23<br/><strong><em>Стоимость: </em></strong>от 900 рублей<br/><a href="https://vk.cc/cwbt8j" rel="noreferrer noopener" target="_blank">https://vk.cc/cwbt8j</a></p>
d8728117-774a-45b3-a595-8d47504817a9	ec176922-f6c6-41fa-8023-33ee5f4fad09	<p>Проект «Сообщение об ошибке» — это медитативное преобразование цифровых глитчей из видеопотоков в художественные полотна. Автор собирает случайные пиксельные артефакты, масштабирует их и воплощает в традиционном формате картины.<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>вт–вс, 12:00-20:00<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>4-й Сыромятнический переулок, 1/8<strong><em><br/><strong><em>Вход свободный</em></strong></em></strong><br/><a href="https://vk.cc/cMFk0F">https://vk.cc/cMFk0F</a></p>
3771f227-2870-4dd6-89e0-74a3158cae1b	063d1ad7-09da-40c6-a75f-385d656bba6a	<p>Квест — отличный способ весело провести время с друзьями. По сюжету, вы – отряд специального назначения, которому предстоит проникнуть в секретный бункер времен холодной войны и предотвратить ядерную катастрофу.<br/><br/><strong><em><strong><em>Когда:</em></strong> </em></strong>дату и время конкретного квеста уточняй на сайте<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Большая Новодмитровская, 36с3<strong><em><br/><strong><em>Стоимость:</em></strong> </em></strong>4000 рублей для команды из 2-5 человек<strong><em><br/></em></strong><a href="https://vk.com/away.php?to=http%3A%2F%2Fcubiculum.ru%2Fknopka_quest_02%2F&amp;cc_key=cizlCY" rel="noreferrer noopener" target="_blank">https://vk.cc/cizlCY</a></p>
480b7797-71ae-458a-856c-85cfcd04b656	6708c5fa-52cc-4dea-ac05-c996a36c1f68	<p>Это новое уникальное пространство для ценителей искусства, цифрового творчества и инновационных опытов. Здесь посетители могут погрузиться в захватывающую визуальную сказку, которая вызывает сильные эмоциональные реакции и оставляет незабываемые впечатления.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> дату и время конкретной выставки уточняй на сайте<br/><em><strong>Где:</strong></em> 2-я Останкинская, 3<br/><strong><em>Стоимость: </em></strong>1670 рублей<br/><a href="https://vk.cc/cEu0jR">https://vk.cc/cEu0jR</a></p>
40457a43-f177-42d0-bcb5-d591ee0fb4b1	2cfdb598-92f1-4b09-8795-df0274d62643	<p>В Digital Art Центре «Внутришоу» на Хлебозаводе проходит арт-проект «Лаборатория цвета» — иммерсивное шоу на стыке искусства, психологии и технологий. История из 14 уникальных проекционных сцен, которые пытаются найти ответ на вопрос: что если бы Ньютон, Кандинский, Иттен, Достоевский, Брэдбери создали экспериментальные digital-комнаты?</p>
d707ee7b-1fdb-44a5-a86f-275bb27359c9	af92dc1b-a285-4712-95c5-aae67b338b73	<p>Здесь ты сможешь исследовать историю первых водопроводов в Кремле и узнать о развитии систем водоснабжения и канализации в Москве с XVIII века до современных технологий очистки воды и обработки сточных вод. В выставочных залах ты найдешь предметы быта и документы, относящиеся к этой теме, включая рукописи и чертежи известных ученых и инженеров.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн-чт,<em> </em>10:00-17:00,<br/>пт,<em> </em>10:00-16:00,<br/><em><strong>Где:</strong></em> Саринский проезд, 13<br/><strong><em><strong><em>Вход свободный</em></strong></em></strong><br/><a href="https://vk.com/away.php?to=https%3A%2F%2Fwww.mosvodokanal.ru%2Fabout%2Fmuseum.php&amp;cc_key=cuxUUX" rel="noreferrer noopener" target="_blank">https://vk.cc/cuxUUX</a></p>
a5b08082-b54d-40e3-b374-a1a8f98a8ae5	f44e1619-32a3-42ca-ac1c-c262595698e1	<p>В Москве пройдет стендап-концерт, на котором именитые комики представят свой проверенный материал. Для гостей выступят участники многочисленных телевизионных и YouTube проектов: StandUp, Открытый микрофон, Comedy Battle, Прожарка и многих других.</p>
d8d2ebad-ad2a-47da-a0d2-61ad2b634f21	4880a1cd-4221-4f3d-be3f-4cc4cba3f91f	<p><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн-вс, время уточняй на сайте<br/><em><strong>Где:</strong></em> место проведения конкретного концерта уточняй на сайте<br/><strong><em>Стоимость: </em></strong>от 790 рублей<br/><a href="https://vk.cc/ctKl3B">https://vk.cc/ctKl3B</a></p>
809c6241-23cc-4be9-a7a4-e0ce5ef58f1b	f2606a70-00fa-45ba-97fb-42b8960514bd	<p>Московский планетарий остается одним из крупнейших в мире. Его Большой звездный зал имеет самый масштабный купол в Европе. Планетарий предоставляет посетителям уникальную возможность познакомиться с космосом, посетить интерактивные музеи, 4D-кинотеатр и обсерватории.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em></strong> пн, ср–вс, 10:00-21:00<br/><em><strong>Где:</strong></em> Садовая-Кудринская, 5с1<br/><strong><em><strong><em>Стоимость: </em></strong></em></strong>от 200 рублей<br/><a href="https://vk.cc/cxvL79">https://vk.cc/cxvL79</a></p>
fa44e21e-bcb0-44fb-bb13-571839c3cf16	56cba811-2fb2-4c61-910d-4000d9780178	<p>В Московском музее современного искусства пройдет выставка Бориса Мессерера «Калейдоскоп времени» — известного сценографа, живописца и графика, работающего в разных жанрах уже 70 лет.<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong> вт-вс, 12:00-21:00<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>Гоголевский бульвар, 10с1<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>350 рублей<br/><a href="https://vk.cc/cMsrhM">https://vk.cc/cMsrhM</a></p>
58ae002d-37b7-4ea8-93fc-4698b3adab40	25493a3c-4d9f-4b8a-9f81-1f135ee39339	<p>Два музыканта оказываются в неожиданном приключении, связанном с опасным криминальным переплетом. Их судьба сводит их в состав женского джазового оркестра. Чтобы спасти свои жизни от пуль гангстеров, им приходится надевать платья и вести себя как обычные девушки из джаз-бэнда.<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>5 июня, 19:00<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Вернадского, 41с1<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 1400 рублей<br/><a href="https://vk.cc/cMssNH">https://vk.cc/cMssNH</a></p>
eb67cce2-e05f-4c68-a702-b48d309314d7	9f71635c-b7a3-4bce-adcd-ef9c66bd7cde	<p>Концерт объединит в себе музыку, навеянную временем, и современные технологии. В первой части программы прозвучит композиция «Времена года» Антонио Вивальди. Во второй части вечера гости услышат произведения авторов-классиков — Моцарта, Брамса, Штрауса.<br/><br/><strong><em>Когда:</em></strong> 7 июня, 16:00<br/><strong><em>Где:</em></strong> Олимпийский проспект, 14<br/><strong><em>Стоимость:</em></strong> от 1400 рублей<br/><a href="https://vk.cc/cKm3Nv">https://vk.cc/cKm3Nv</a></p>
a4b0b7e9-077d-4b8d-abbd-75f0a77344ba	c8352c42-cd5b-400f-948b-86ec7badae87	<p>На выставке можно будет увидеть традиционные китайские жанры — от пейзажей шаньшуй до изображений бамбука мо-чжу. Также в экспозиции представлены работы китайских школьников, выполненные в национальных техниках, но на русские сюжеты.<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>вт–вс, 12:00-20:00<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>4-й Сыромятнический переулок, 1/8<strong><em><br/><strong><em>Вход свободный</em></strong></em></strong><br/><a href="https://vk.cc/cMstj6">https://vk.cc/cMstj6</a></p>
a1e48224-408e-44b1-9b0c-3850b8a4569d	1057f232-5c65-46d1-b690-810c37c1d4a8	<p>В день празднования 800-летия Москвы были заложены фундаменты восьми Сталинских высоток — так Советский союз показал всему миру, что он восстает из пепла войны. С тех пор высотки — один из символов мощи той эпохи и память о трудовом подвиге советских строителей.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>дату и время конкретной экскурсии уточняй на сайте<br/><em><strong>Место встречи:</strong></em> метро Красные ворота, выход №2<br/><strong><em>Стоимость:</em> </strong>1200 рублей для студентов<br/><a href="https://vk.cc/clNICu">https://vk.cc/clNICu</a></p>
83556365-6dc2-4dcb-9742-17a47e8bbf73	26dd1d42-9ae2-43a0-9431-bc01e2290ad5	<p>Художник в новой серии картин исследует природные явления, добиваясь безупречного колорита и композиции. Вдохновение он находит в путешествиях, где ощущает глубокую связь с природой и открывает новые цвета и художественные решения.<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>вт–вс, 12:00-20:00<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>4-й Сыромятнический переулок, 1/8<strong><em><br/><strong><em>Вход свободный</em></strong></em></strong><br/><a href="https://vk.cc/cMi0Bo">https://vk.cc/cMi0Bo</a></p>
cf1ce112-030f-470f-8b91-3ede29aa2050	09f9db36-90fa-4ee3-8fd1-27377ea82362	<p>Многогранная артистка Ольга Серябкина, известная как экс-солистка группы «Серебро», а также как хитмейкер и поэтесса, выступит на легендарной сцене, любимой исполнителями.<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>30 мая, 23:00<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>Болотная набережная, 3/4, стр. 2<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 1400 рублей<br/><a href="https://vk.cc/cMi15G">https://vk.cc/cMi15G</a></p>
f030901a-b6c0-4180-860d-d220c6d3e689	c6bb4a60-99ed-4437-8c17-1ed3adcc6317	<p>25 ведущих танцоров, включая 16 чемпионов мира, откроют для тебя секреты даже самых закрытых номеров отеля. Тайны каждой комнаты будут раскрыты в ярком танцевальном представлении, как калейдоскоп сменяющих друг друга сцен!<br/><br/><em><strong><em>К</em>огда<em>:</em> </strong></em>1 июня, 15:00<em><br/><strong>Где:</strong> </em>проспект Андропова, 1<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 900 рублей<br/><a href="https://vk.cc/cBBePq" rel="noreferrer noopener" target="_blank">https://vk.cc/cBBePq</a></p>
885257cf-6b65-4980-b16f-bf85e986b245	14d33695-a8f1-4a1a-9790-1599efaec8d1	<p>Молодой и красивый, но бедный адвокат Дорант устраивается на службу к богатой вдове Араминте, намереваясь завоевать ее сердце. Однако его дядя прочит ему в жены практичную компаньонку Мартон, а мать Араминты хочет выдать дочь за аристократа.<br/><br/><em><strong><em>К</em>огда<em>:</em> </strong></em>30 мая, 19:00<em><br/><strong>Где:</strong> </em>Тверской бульвар, 23<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 800 рублей<br/><a href="https://vk.cc/cMi1AU">https://vk.cc/cMi1AU</a></p>
ee5e0a7d-64c2-4420-9c82-7f156f411300	c322dda9-258e-4538-9719-0b37d8fb27b4	<p>Стендап в темноте – единственный в России иммерсивное шоу, где топовые комики смешат зал без света, полагаясь только на юмор. Популярный концепт теперь в Москве: никакой визуализации, только чистая комедия для твоего слуха.<br/><br/><em><strong><em>К</em>огда<em>:</em> </strong></em>30 мая, 21:30<em><br/><strong>Где:</strong> </em>Верхняя Радищевская, 15с2<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 1120 рублей<br/><a href="https://vk.cc/cMi6oL">https://vk.cc/cMi6oL</a></p>
9aa23000-7fef-4c9a-bc9a-3aaf020116a5	dea14f92-f9fd-4efe-a8e7-227a9d134261	<p>Обзорная экскурсия по знаменитым читальным залам и самому большому в стране Музею книги познакомит тебя с главной библиотекой России, ее богатейшей историей, величественной архитектурой и уникальными фондами.</p>
81fdd6be-8d0d-4187-96f8-606f8013bd99	804d11eb-6f77-4a37-bbe6-47151b632993	<p><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>дату и время уточняй на сайте<br/><strong><em>Где: </em></strong>ул. Воздвиженка, 3/5<br/><strong><em>Стоимость: </em></strong>1000 рублей<br/><a href="https://vk.cc/cMi6LD">https://vk.cc/cMi6LD</a></p>
336c5ec6-539d-4577-9a91-018de67806ee	4b1afe05-34da-4e38-8a82-858687ed03fa	<p>Особенность экскурсии заключается в погружении в историю российского современного искусства. Почему все пути современного искусства ведут на Винзавод? Как работают галереи современного искусства? Кто играет главные роли в современном российском искусстве? Ответы на эти вопросы вы узнаете во время посещения мероприятия.</p>
36164c6e-d005-4845-9f59-0ab9801bb68f	b82fc686-80d9-4c15-b761-e2b5ab500358	<p><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>24 мая, 18:00<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>4-й Сыромятнический пер., 1/8, стр. 6<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 1300<strong><em><strong><em> </em></strong></em></strong>рублей<br/><a href="https://vk.cc/czxLbK">https://vk.cc/czxLbK</a></p>
5750a2bb-3b9a-409f-bde3-63a3c43ec217	40a54948-5931-478c-9f0e-dc7dc6a33a16	<p>В музее представлены уникальные экспонаты телефонов — от винтажных аппаратов начала прошлого века до первых мобильников и пейджеров.<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>вс, ср, пт-вс, 10:00-18:00,<br/>чт, 12:00-20:00<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>Садовая-Кудринская, 19с2<strong><em><br/>С<strong><em>тоимость:</em></strong></em></strong> 200 рублей для студентов<br/><a href="https://vk.cc/cM4Eag">https://vk.cc/cM4Eag</a></p>
4586fe2f-0bed-4c5d-a5cd-e69e3fe2b298	100fd5fa-66b3-4f8c-a7c6-36547838385b	<p>Проект в PENNLAB исследует историю депортации жителей Молдавской ССР через призму семейных воспоминаний и архивных материалов.<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>вт–вс, 12:00-20:00<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>4-й Сыромятнический переулок, 1/8<strong><em><br/><strong><em>Вход свободный</em></strong></em></strong><br/><a href="https://vk.cc/cM4DO4">https://vk.cc/cM4DO4</a></p>
a5c5612b-0c81-491a-8c61-a6aa4de4093a	52d4b6f4-4722-4ece-8374-ec1b69abef23	<p>Ваша команда исследует паранормальные явления в местах с призраками. Каждый игрок оснащен специальным снаряжением и может применять ненаучные методы. Миссия будет успешной, если вы сохраните рассудок, правильно определите призрака и останетесь живы.</p>
c129b62a-2fee-4f6a-9cb1-6bbce29b89a6	7cffb866-1791-4288-a566-cef8de991149	<p><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>дату и время конкретного квеста уточняй на сайте<br/><em><strong>Где:</strong></em> Суворовская, 51<br/><strong><em>Стоимость: </em></strong>от 1200 рублей<br/><a href="https://vk.cc/cy3Ry9" rel="noreferrer noopener" target="_blank">https://vk.cc/cy3Ry9</a></p>
4343a64b-ae24-4c3a-8db2-80779a75204c	2feadb86-399f-4122-985d-7aefa1cd4154	<p>Музей магии — современное интерактивное пространство, с неповторимой загадочной атмосферой иллюзий, фокусов и волшебства. Изучить экспозицию можно самостоятельно, или в сопровождении профессионального экскурсовода, который расскажет много интересного о магическом мире.<br/><br/><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>пн-чт, вс, 10:00-21:00<br/>пт, сб, 10:00-22:00<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>Новый Арбат, 7с1<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>1300 рублей<br/><a href="https://vk.cc/cvgSBu" rel="noreferrer noopener" target="_blank">https://vk.cc/cvgSBu</a></p>
75b43900-230d-45bb-902c-d4877968df69	06aeefe9-f5de-4f44-86d4-0a0f951dc2ac	<h2 id="vyistavka-ulitsa-sna">Выставка «Улица Сна» </h2>
74db2f20-0ee5-4750-be04-fee7b98d35a4	b9e56bd1-8536-4211-aa4e-a98176a57cb5	<p>Выставка «Улица Сна» — не хроника творчества, а художественный мир, навеянный «Степью» Антона Павловича Чехова. Работы автора здесь складываются в метафорический ландшафт.<br/><br/><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>пн–вс, 11:00–22:00<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>Болотная набережная, 15<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Вход свободный, необходима предварительная регистрация</em></strong></em></strong></em></strong></em></strong></em></strong></em></strong><br/><a href="https://vk.cc/cLImXj">https://vk.cc/cLImXj</a></p>
ae1111f1-17be-4146-bbba-b99d23054cce	55264ef7-65d9-49bd-9da2-31f790df8bc9	<p>Дневник художницы Олеси Рубеко — это коллаж впечатлений, где автопортреты и пейзажи словно сняты в движении, оставляя «смазанные» кадры живых мгновений. <br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-сб, 13:00-20:00<br/><em><strong>Где: </strong></em>4-й Сыромятнический переулок, 1/8<em><strong><br/>Вход свободный</strong></em><br/><a href="https://vk.cc/cLODko">https://vk.cc/cLODko</a></p>
d9400579-0303-4ae5-8844-e7146bda01ea	c3549fec-0fc6-43a4-b4e3-8626e3224987	<p>Группа «Хлеб» — российский креативный коллектив в составе Дениса Кукояки, Кирилла Трифонова и Александра Шулико. Благодаря харизме и уникальному юмору они стали популярны в России и за рубежом. Их давняя мечта — выступление на стадионе — наконец сбылась!<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>16 мая, 20:00<br/><em><strong>Где: </strong></em>Ленинградский проспект, 36<em><strong><br/>Стоимость: </strong></em>от 1275 рублей<br/><a href="https://vk.cc/cLOElw">https://vk.cc/cLOElw</a></p>
1563e919-a9df-4447-97d0-f8d87c0b6f49	9782ccd5-2202-4125-8f0e-3965eabe9984	<p>Вечерняя Москва в огнях — это трехчасовой круиз на теплоходе «Артурс» с ужином. Насладитесь отдыхом на воде под музыку, в уютной атмосфере с близкими людьми!<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>13 мая, 19:00<br/><em><strong>Место встречи: </strong></em>Причал «Крымский мост»<em><strong><br/>Стоимость: </strong></em>990 рублей<br/><a href="https://vk.cc/cLR0TH">https://vk.cc/cLR0TH</a></p>
89e4ddd2-5abe-4ca1-9404-2b8ea0625f30	b86b43e2-171f-46a6-86dc-af1882d5b643	<p>Этот музей был создан в 1996 году известным коллекционером и художником Юлией Вишневской. В настоящее время в музейных фондах насчитывается около 6000 экспонатов, представляющих период с XVIII по начало XX века. Экспозиция включает в себя фарфоровых, восковых, деревянных кукол, созданных ведущими мировыми производителями, а также кукольные аксессуары и предметы кукольной мебели.<br/><br/><strong><em>Когда:</em></strong> вт, сб, вс, 12:00 — 19:00,<br/>пн, ср-пт, 12:00 — 17:00<br/><strong><em>Где:</em></strong> Покровка, 13с2<br/><strong><em>Стоимость: </em></strong>200 рублей для студентов<br/><a href="https://vk.com/away.php?to=https%3A%2F%2Fdollmuseum.ru%2F&amp;cc_key=csuCfi" rel="noreferrer noopener" target="_blank">https://vk.cc/csuCfi</a></p>
90808cde-ecd3-49dd-8256-5b576973c3ff	9b61ae5e-208c-45aa-bf6f-33626ca85339	<p>В основе постановки — знаменитая комедия Кена Людвига <em>«</em>Луна над Буффало<em>»</em>. Это классическая комедия положений о некогда известных актерах Джордже и Шарлотте Хэй, которые теперь владеют небольшим театром в Буффало и играют в двух пьесах с крошечной труппой.<br/><br/><strong><em>Когда:</em></strong> 18 мая, 19:00<br/><strong><em>Где:</em></strong> Тверской бульвар, 23<br/><strong><em>Стоимость: </em></strong>от 800 рублей<br/><a href="https://vk.cc/cLR3jr">https://vk.cc/cLR3jr</a></p>
3ec4197f-cb01-442f-ba34-15860c848438	9492fcd2-f4ae-4de9-b44c-396f73f03f06	<p>Выставка приурочена к 80-летию Победы в Великой Отечественной войне. Она освещает ключевые события весны 1945 года: взятие Кенигсберга и Берлина, освобождение европейских столиц и капитуляцию Германии.<br/><br/><strong><em>Когда:</em></strong> дату и время конкретной выставки уточняй на сайте<br/><strong><em>Где:</em></strong> Варварка, 6<br/><strong><em>Стоимость: </em></strong>от 800 рублей<br/><a href="https://vk.cc/cLR3G6">https://vk.cc/cLR3G6</a></p>
d61f7e51-41e0-4486-8dfe-c373081c6b0d	4014c507-97c8-4658-9ca6-f5ef78422853	<p>В парке ВДНХ состоялось долгожданное открытие — ландшафтный аттракцион «Лента Мебиуса». Внутри пешеходной дорожки расположился сад пяти чувств. Растения в нем пробуждают зрение, слух, обоняние, осязание и вкус.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн-вс, 9:00-22:00<br/><em><strong>Где:</strong></em> проспект Мира, 119<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.com/away.php?to=https%3A%2F%2Fvdnh.ru%2Fplaces%2Flandshaftnyy-attraktsion-lenta-mebiusa%2F&amp;cc_key=coyipu" rel="noreferrer noopener" target="_blank">https://vk.cc/coyipu</a></p>
61b9d590-4aec-44aa-bf4a-ffab774bdee6	91e06404-1624-46d1-9981-d03025cc3b30	<p>Это уникальное экспозиционно-выставочное пространство, наполненное историческими предметами, собраниями документов и фотографий — рассказывающими о крупнейшем транспортном предприятии Москвы.</p>
f5f88765-dc87-4481-b810-b1da95cf448e	00b85b27-db42-42f3-9bf7-45b1616c88eb	<p><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн-вс, 10:00-18:00<br/><em><strong>Где: </strong></em>Пресненская набережная, 2<em><strong><br/>Вход свободный</strong></em><br/><a href="https://vk.com/away.php?to=https%3A%2F%2Fkudamoscow.ru%2Fplace%2Fmuzej-metropolitena%2F&amp;cc_key=coImZW" rel="noreferrer noopener" target="_blank">https://vk.cc/coImZW</a></p>
2747fdf0-56c9-4a7e-a25a-b2a82e4415c5	293c47d5-217e-4746-833b-d9df5b670354	<p>Насыщенный достопримечательностями Китай-город часто находится «в тени» Кремля и Красной площади. На экскурсии ты узнаешь о нем малоизвестные исторические факты, раскроешь душу и характер этого удивительного квартала, а также отыщешь в нем следы старой Москвы.</p>
b33357d6-7ac5-40c9-b6a5-5d0fabbbb7e5	279cf539-9025-485e-9fbb-6eea6da0e02c	<p><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>сб, вс, 10:00-18:00<br/><em><strong>Место встречи: </strong></em>около метро «Площадь революции»<em><strong><br/>Стоимость: </strong></em>от 700 рублей<br/><a href="https://vk.com/away.php?to=https%3A%2F%2Fextraguide.ru%2Frussia%2Fmoscow%2Fexcursion-39387%2F&amp;cc_key=coInV5" rel="noreferrer noopener" target="_blank">https://vk.cc/coInV5</a></p>
642abc34-28a8-4176-a913-e9523e8933c8	e785d551-f209-47ae-8e2b-9f9458e5e01f	<p>Экспозиция включает графические работы, изображающие фантазийное место, где есть все, что можно пожелать. Название проекта отсылает к легендарному нью-йоркскому джаз-клубу «Birdland».<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-сб, 13:00-20:00<br/><em><strong>Где: </strong></em>4-й Сыромятнический переулок, 1/8<em><strong><br/>Вход свободный</strong></em><br/><a href="https://vk.cc/cLBzzH">https://vk.cc/cLBzzH</a></p>
57bd06c4-0929-490d-b2d5-9683c036089e	a94a9efd-a6e0-4d80-a3d2-8cf9e67aa9aa	<p>Студенты Бусыгин и Сильва оказываются без денег на проезд и решают устроиться в дом Сарафановых, представившись как незаконный сын одного из членов семьи. Вскоре они проникаются к семье такими теплыми чувствами, что даже раскрытие их маскировки не может их разлучить.<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>8 мая, 18:00<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Большая Никитская, 19/13<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 900 рублей<br/><a href="https://vk.cc/cx7Elc" rel="noreferrer noopener" target="_blank">https://vk.cc/cx7Elc</a></p>
d400e868-2681-41d4-9ebe-59ada079220f	c3644d5f-75ed-4fb9-bbac-689bda91ce3d	<p>Японский парк в Куркино — уникальный ландшафтный проект, ставший популярным среди москвичей и одной из достопримечательностей города. Открытый в 2020 году на День города, парк разделен на несколько зон: ярмарочный павильон, фестивальная площадка и сад.<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>вт-вс, 10:00-22:00<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>Соколово-Мещерская, 23<strong><em><br/><strong><em>Вход свободный</em></strong></em></strong><br/><a href="https://vk.cc/cyyu9a" rel="noreferrer noopener" target="_blank">https://vk.cc/cyyu9a</a></p>
cdc4e2eb-dbe3-413c-a936-6932a7faf5f3	ba499f03-c5b7-4cc6-beac-45c1d6c04890	<p><strong>22 и 23 февраля</strong> у тебя есть уникальная возможность насладиться лучшими спектаклями талантливых коллективов-участников заключительного этапа фестиваля. Это отличный способ поддержать молодых артистов, насладиться яркими постановками и стать частью театрального искусства!</p>
be84738d-c7f3-4025-89a1-932072e98b02	1930271f-eccc-48ef-a607-047b5ca95beb	<p>Стендап-экскурсия — уникальное и оригинальное событие! Это пеший тур по Китай-городу, который проводится стендап-комиком. Гарантированы интересное развлечение и веселое настроение, а все происходит в непринужденной атмосфере!<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>30 апреля, 19:00<br/><strong><em><strong><em>Место встречи: </em></strong></em></strong>Славянская площадь, около памятника Кириллу и Мефодию<br/><strong><em>Стоимость:</em></strong> от 1190 рублей<br/><a href="https://vk.cc/cpn5p6">https://vk.cc/cpn5p6</a></p>
a54c8812-5cca-407f-b4fd-4b6f83473058	e5edaae2-c55b-4833-8e55-5b2b33fc57b8	<p>Постоянная экспозиция музея включает 12 тематических залов с интерактивными медиа. Здесь можно посмотреть 4D-фильм о сотворении мира, отдохнуть в кафе, посетить базарную площадь, изучить биографии деятелей советской политики и культуры, услышать разговоры на советской кухне и рассказы диссидентов, а также почтить память павших в Великой Отечественной войне.</p>
b47af4cf-448a-4d1b-b2ea-4c60d081ada3	7afc266a-6b36-467d-aacd-8dadbbc455a6	<p><em><strong>Когда</strong></em><strong><em>: </em></strong>пн-чт, вс, 12:00-22:00,<br/>пт, 10:00-15:00<strong><em><br/><strong><em>Где:</em></strong></em></strong> Образцова, 11с1А<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 500 рублей<br/><a href="https://vk.cc/7g0DMR" rel="noreferrer noopener" target="_blank">https://vk.cc/7g0DMR</a></p>
0dcf9cbe-3dfe-407d-8dc1-30c03eaa6316	8c515158-2e44-4bbc-9fac-09e7a30cd55d	<p>Исследуй стадион «Лужники» изнутри в эксклюзивном туре, где ты сможешь примерить роли болельщика, VIP-гостя, футболиста, тренера и журналиста. Посети раздевалки, прогуляйся по полю, сядь на скамейку запасных, загляни в пресс-центр и скай-боксы!</p>
c015b4f0-bee4-489c-9ff0-9084fdd9fa2c	717b8a55-b8e2-4bad-88a0-bd6bdcbdee37	<p><em><strong>Когда</strong></em><strong><em>: </em></strong>29 апреля, 27:00<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Лужники, 24с1<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 500 рублей<br/><a href="https://vk.cc/cuJZun">https://vk.cc/cuJZun</a></p>
6702452a-7b66-4d43-a496-4ae05722545f	8cf3e826-5f33-4a7b-8f46-ca986bf422bc	<p>Выставка посвящена городскому пространству как хрупкой структуре, подверженной разрушению и музеефикации. В экспозиции представлены работы, созданные в рамках программы «ColLab» мастерских Центра художественного производства «Своды» Дома культуры «ГЭС-2».<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>вт–вс, 12:00-20:00<strong><em><br/><strong><em>Где:</em></strong> </em></strong>4-й Сыромятнический переулок, 1/8<strong><em><br/></em></strong><span style="background-color: rgba(0, 0, 0, 0.2);"><strong><em>В</em></strong></span><strong><strong><em>ход свободный</em></strong></strong><br/><a href="https://vk.cc/cLdihZ">https://vk.cc/cLdihZ</a></p>
a458d021-298f-4951-94da-78c3d5e0a013	edb15b00-1c86-4e4b-be75-eeceb491b58b	<p>Это место, где можно познакомиться с культовыми японскими автомобилями разных классов, выпущенными до 1990 года. В музее представлены как редкие и уникальные модели, так и автомобили, известные по различным произведениям поп-культуры.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> вт-пт, 11:00-21:00,<br/>сб, вс, 10:00-22:00<br/><em><strong>Где:</strong></em> Ташкентская, 28с1<br/><strong><em>Стоимость: </em></strong>700 рублей для студентов<br/><a href="https://vk.cc/aApUYh">https://vk.cc/aApUYh</a></p>
21252ab8-c92a-4263-b520-6cfa9a9279d4	554765a0-48c6-4dd1-89aa-66767ddf6536	<p>«Атлантида.AI» — так называется эксперимент, на который соглашается главный герой Капитан. 10 дней общения только с искусственным интеллектом Нейрой, у которой есть доступ к его воспоминаниям, фантазиям и мечтам. Сценарий и визуалы созданы с помощью искусственного интеллекта.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> дату и время проведения конкретной выставки уточняй на сайте<br/><em><strong>Где:</strong></em> Новодмитровская, 1<br/><strong><em>Стоимость: </em></strong>690 рублей для студентов<br/><a href="https://vk.cc/cEu3TJ">https://vk.cc/cEu3TJ</a></p>
c4703826-aa48-4974-aa3a-92b4ed22909b	02f4d2cb-1e75-4441-b54e-427369ab2d1d	<p>Мы рады сообщить тебе о захватывающей исторической интеллектуальной онлайн-игре «НАША ПОБЕДА», посвященная защитникам Отечества и подвигам Героев Великой Отечественной войны. Организатором выступает Всероссийское общественное движение «ВОЛОНТЕРЫ ПОБЕДЫ», одна из крупнейших добровольческих организаций России, активно занимающаяся сохранением исторической памяти и патриотическим воспитанием.</p>
9aab0cf0-f11c-4555-a5e0-4bf3c1d71a64	eed24f58-8fe7-41b6-b63a-9239b7eebc2f	<p>Это отличная возможность проверить свои знания, логику и сообразительность. Не упусти шанс стать частью этого важного события.</p>
00bc2c4b-aabd-4ae3-b17e-5fb3f4d491b4	7484d899-ae4d-4c64-808c-44d0a2a1f9df	<p>Дата проведения игры: 30 апреля 2025 года.</p>
6eb7dad2-8625-40de-a36f-479ea29bcf9b	c7fee522-155e-4da4-8730-4ef82b661777	<p>Могут участвовать все желающие от 14 лет из любой точки мира!</p>
487ee8f5-7d87-4b18-ba1d-68857f564b3f	82cf443e-cf94-43f2-8fb6-6ba21f5bc91b	<p>Для участия необходимо пройти предварительную регистрацию на сайте: <a href="http://xn----7sbbaafjnix2domi8j.xn--p1ai">http://игра-нашапобеда.рф</a></p>
8645e1b6-f713-40df-98a1-aa74b68febef	dc6ab13c-41e6-43e0-b323-73bcd1bafe77	<p><strong><em>Регистрация на мероприятие:</em></strong> <a href="https://sretenit-fest.timepad.ru/event/3241072/">https://sretenit-fest.timepad.ru/event/3241072/</a></p>
48373401-c393-49cb-aa4f-d1ef6e7e34e2	51d3e63e-3aa6-4396-a703-c3dda58f0e17	<p>В этом году японская сакура расцвела на 10 дней раньше обычного – ее нежные розовые цветы и бутоны уже украшают парк! Кроме того, здесь можно увидеть традиционный сад камней, декоративный ручей, уютные дорожки и скамейки для отдыха.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн-вс, круглосуточно<br/><em><strong>Где:</strong></em> Липецкая, 5А<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cKZ26b">https://vk.cc/cKZ26b</a></p>
0691c052-6256-47a0-b918-436c4504e343	e3d3ce13-b4b8-434c-846e-89828867896f	<p>Обеспеченный мсье Александр пытается купить иллюзию семейного счастья, нанимая актеров вместо родственников. Но холодный расчет дает сбой – формальные отношения неожиданно превращаются в искреннюю привязанность. <br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>22 апреля, 19:00<br/><em><strong>Где:</strong></em> Малая Дмитровка, 6<br/><strong><em>Стоимость:</em></strong> от 1100 рублей<br/><strong><em>Мероприятие можно посетить по Пушкинской карте</em></strong><br/><a href="https://vk.cc/cKZ2An">https://vk.cc/cKZ2An</a></p>
9f54f909-b12c-449c-9232-c91edc450260	eff69031-8bdf-4ddc-ac70-75c8e9b753cf	<p>Автор выставки<strong> </strong>посвящает проект своему дедушке, болеющим Альцгеймером. Недели заботы и близости с человеком, теряющим связь с реальностью, вдохновили его на переосмысление этой темы через искусство. Работы в проекте меняют привычное восприятие, предлагая зрителю новый, глубоко личный взгляд на деменцию.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 12:00–20:00<br/><em><strong>Где:</strong></em> 4-й Сыромятнический переулок, 1/8<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cKiuky">https://vk.cc/cKiuky</a></p>
b6f2074f-6e13-459f-a40b-0f11af5fc1c0	b4f90b42-e464-4878-9d82-c39196890b4f	<p>Ты сможешь познакомиться с фермерской жизнью, традициями и ее обитателями! А также увидишь коз, альпак, айширских и индийских коров, северных оленей, карликовых кроликов и многих других жителей фермы.</p>
cc6d4d85-a3ac-4e5c-aab8-b777872f8131	4b441243-e3bf-4047-bff3-60acf4815943	<p><strong><em>Когда:</em></strong> вт-пт, 10:30-19:00,<br/>сб-вс, 10:30-20:00<br/><strong><em>Где:</em></strong> проспект Мира, 119с244<br/><strong><em>Стоимость</em></strong>: от 1000 рублей<br/><a href="https://vk.cc/cyEz0V">https://vk.cc/cyEz0V</a></p>
7151f8b9-05d8-48fb-bfcf-62ace3582656	aedceef4-4ef0-402d-921d-e73282dbf1c3	<p>В центре Москвы работают два уютных котокафе, где посетители могут расслабиться за чашкой кофе или чая, пообщаться с пушистыми котиками, поиграть в настольные игры или просто поработать. Все коты прошли социализацию и готовы к переезду в новые семьи — уже более 300 животных нашли свое счастье!<br/><br/><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>пн-пт, 11:00-22:00,<br/>сб, вс, 10:00-22:00<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>адрес конкретного кафе уточняй на сайте<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 630 рублей<br/><a href="https://vk.cc/cIRhTs" rel="noreferrer noopener" target="_blank">https://vk.cc/cIRhTs</a></p>
ab0631f4-ac18-481f-af73-89cfa9579e8d	9a163b86-04e6-4d84-b4a7-892ecebbd0ef	<p>Музей предлагает погрузиться в историю компании Apple, основанной Стивом Джобсом. Здесь ты ощутишь значимость впечатляющего стартапа XX века и узнаешь то, как настойчивость одного человека может преобразить весь мир.<br/><br/><strong><em>Когда:</em></strong> ср, 17:00–21:00,<br/>сб, вс 12:00–18:00<br/><strong><em>Где:</em></strong> Складочная, 3с1<br/><strong><em>Стоимость:</em></strong> 500 рублей для студентов<br/><a href="https://vk.cc/c8sbbF">https://vk.cc/c8sbbF</a></p>
6de6834d-ba54-49d9-8868-bd740f2fcb19	3210cd16-4cc9-4b98-8869-a59592e2d3cf	<p>Российская подлодка с секретным оружием таинственно исчезает в Гренландском море. На ее поиски отправляется команда во главе с Виктором Ворониным. Тем временем из-за исследований на полярной станции пробуждается Кракен — гигантский монстр, способный сливаться с тьмой. <br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>с 16 апреля, время конкретного показа уточняй на сайте<br/><em><strong>Где:</strong></em> место проведения конкретного показа уточняй на сайте<br/><strong><em>Стоимость: </em></strong>от 200 рублей<br/><a href="https://vk.cc/cKNvEb">https://vk.cc/cKNvEb</a></p>
f625845c-daea-4226-b96b-7a871395e28b	e2bd8529-c271-48e9-ac21-4a94f31c9ce5	<p>Комики шутят, зрители выбирают победителя. У каждого выступающего всего несколько минут, чтобы рассмешить зал. Кто наберёт больше очков — получит все деньги. Все просто: больше смеха — ближе к победе!<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>15 апреля, 19:00<br/><em><strong>Где:</strong></em> Покровка, 16<br/><strong><em>Стоимость: </em></strong>500 рублей<br/><a href="https://vk.cc/cKNwaM">https://vk.cc/cKNwaM</a></p>
5ab74536-a44e-4b05-8882-944f78c80c83	1fc90b03-ca42-4f34-91c4-c6f14ee36566	<p><strong><em>Место и адрес проведения:</em></strong> Культурный центр Главного управления МВД России по г. Москве, ул. Новослободская, 47  </p>
b55efd6d-27d5-47a6-9ca3-437ff7a8046e	301d7977-225f-480f-8c6d-4ee4a5d67f41	<p>Трагикомическая история о простом человеке, который пытается сохранить свой маленький мир и личное счастье во время революции. Главный герой, Савватий Гуска, хочет спрятаться от бурных событий в своем уютном уголке, но сталкивается с жестокой реальностью.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>15 апреля, 19:00<br/><em><strong>Где:</strong></em> Фролов переулок, 2<br/><strong><em>Стоимость: </em></strong>от 1000 рублей<br/><a href="https://vk.cc/cKNwPk">https://vk.cc/cKNwPk</a></p>
3d8ae8e8-5a1a-4dbe-ae22-de5e9fcdd2f5	0f73cc5f-9184-4450-899b-37509d7c9a73	<p>Мясницкая — историческая улица Москвы, где прошлое встречается на каждом шагу. Здесь можно увидеть старинные особняки, доходные дома и уникальный дом «чайного короля». Приглашаем на прогулку сквозь века!<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>дату и время конкретной экскурсии уточняй на сайте<br/><em><strong>Где:</strong></em> станция метро «Лубянка», выход №4<br/><strong><em>Стоимость: </em></strong>800 рублей<br/><a href="https://vk.cc/cKNyKK">https://vk.cc/cKNyKK</a></p>
8cb6f2a4-60e3-4212-8174-d0dac7b6c735	a7fcb2c9-2f96-483f-8594-2f2477f5465c	<p>Хотя выставка формально рассказывает о Хорезмской археолого-этнографической экспедиции (1937–1991), ее настоящая цель – показать неожиданные параллели между модернизмом и археологическими исследованиями.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн-вс, 11:00-22:00<br/><em><strong>Где:</strong></em> Болотная набережная, 15<br/><strong><em>Вход свободный, нужна предварительная регистрация</em></strong><br/><a href="https://vk.cc/cKcoDU">https://vk.cc/cKcoDU</a></p>
49313060-0d99-432e-8a4a-b4b5f7e22390	c84ac6ab-1c91-4c52-b603-7666493b5e9c	<p>На выставке представлены крупноформатные монохромные пейзажи, созданные углем и сангиной. Эти работы — своеобразные «трофеи» из путешествий художника, перекликающиеся с идеями эскапизма из эссе Юнгера «Уход в лес».<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>вт-вс, 12:00–20:00<br/><em><strong>Где:</strong></em> 4-й Сыромятнический переулок, 1/8<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cKNACa">https://vk.cc/cKNACa</a></p>
005104da-e195-479c-a372-e34c17863b63	7a498406-74a4-47c1-baeb-fbf325e9aa81	<p>В Москве пройдет стендап-концерт, на котором именитые комики представят свой проверенный материал. Для гостей выступят участники многочисленных телевизионных и YouTube проектов: StandUp, Открытый микрофон, Comedy Battle, Прожарка и многих других.</p>
4413f12f-ea65-4816-8bfc-f943c57d0177	f62dfae1-5831-4209-a6fa-fa7a79158e13	<p><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн-вс, время уточняй на сайте<br/><em><strong>Где:</strong></em> место проведения конкретного концерта уточняй на сайте<br/><strong><em>Стоимость: </em></strong>от 790 рублей<br/><a href="https://vk.cc/ctKl3B">https://vk.cc/ctKl3B</a></p>
7290d91b-9bc7-4dec-8bd2-5e3d5bc110c8	af081d23-44a2-4802-ae68-63e228e5ae1c	<p>В Венеции во время карнавала происходит драма в домах местных жителей. Жены и дети четырех «тиранов», уставших от своих властивых отцов, пытаются справиться с их грубым нравом и строгими законами. Но вмешательство хитроумной синьоры Феличе, жены одного из них, решает проблему для всех.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> 8 апреля, 19:00<br/><em><strong>Где:</strong></em> площадь Журавлева, 1<br/><em><strong>Стоимость: </strong></em>от 700 рублей<em><strong><br/>Мероприятие можно посетить по Пушкинской карте</strong></em><br/><a href="https://vk.cc/cFeeev">https://vk.cc/cFeeev</a></p>
99a41067-b234-4563-96da-f4e7e3f89e4e	4314a7e5-c301-4c00-9ae1-36d604f4808b	<p>Экспозиция основана на трех концепциях: монографические залы с произведениями великих художников, коллекционерские залы и показ разнообразных художественных направлений ХХ века. В обновленных залах галереи представлено современное восприятие русского искусства начала ХХ века.<br/><br/><strong><em>Когда:</em></strong> вт, ср, вс, 10:00-16:30,<br/>чт-сб, 10:00-19:30<br/><strong><em>Где:</em></strong> Крымский Вал, 10<br/><strong><em>Стоимость: </em></strong>350 рублей для студентов<br/><a href="https://vk.com/away.php?to=https%3A%2F%2Fafisha.yandex.ru%2Fmoscow%2Fart%2Fiskusstvo-khkh-veka-tretiakovkskaia-galereia%3Fsource%3Dselection-events&amp;cc_key=cpXsVm" rel="noreferrer noopener" target="_blank">https://vk.cc/cpXsVm</a></p>
df98a453-8f6a-49ee-99f6-48d393bdb2dc	62de8c38-688a-4326-b372-e6bacada1c26	<p>Селективный сонгбук, стильное караоке в столице, любимые треки под аккомпанемент live band на легендарной сцене — это и есть «Рокикараоке». Каждую пятницу здесь на сцену поднимаются самые разные люди, объединенные одним — любовью к хорошей музыке!<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> 11 апреля 23:00<br/><em><strong>Где:</strong></em> Пресненский Вал, 6с1<br/><strong><em>Стоимость: </em></strong>от 1000 рублей<br/><a href="https://vk.cc/cE0Srp">https://vk.cc/cE0Srp</a></p>
4323405a-b6ad-4fa6-84a5-c957af3731a7	0539c6d4-065f-4866-909f-6fb7ba44b7a4	<div class="wp-block-columns">\n<div class="wp-block-column" style="flex-basis:100%">\n<div class="wp-block-group has-secondary-background-color has-background"><div class="wp-block-group__inner-container">\n<div class="wp-block-columns has-white-background-color has-background">\n<div class="wp-block-column" style="flex-basis:100%">\n<p>Не упусти возможность расширить свои горизонты, задать вопросы и просто хорошо провести время!</p>\n</div>\n</div>\n</div></div>\n</div>\n</div>
ca2010be-7aa6-49bb-98dc-45ffaf477f52	866f4467-9a87-4dc5-9b33-a7f0af042786	<p>Экспозиция музея Яндекса представляет собой коллекцию компьютеров и рабочих станций. Ее основу составляет техника советского производства из коллекции Виктора Боева — основателя Клуба Любителей Советских Компьютеров. Выставка также дополнена зарубежными образцами.  <br/><br/><strong><em>Когда:</em></strong> вт-вс, 11:00-20:00<br/><strong><em>Где:</em></strong> Тимура Фрунзе, 11с13<br/><strong><em>Вход свободный</em></strong><br/><a href="https://vk.cc/cE0TIn">https://vk.cc/cE0TIn</a></p>
ec009f31-5bdf-41e7-9977-fa4408cd4070	a520f5a0-bd18-4bab-975c-03a47181d273	<p>Мир фантасмагории, обмана и иллюзий, созданный драматургией Николая Васильевича Гоголя и режиссурой Альберта Хасиева, погружает зрителя в историю искусного карточного шулера, который становится жертвой собственного мошенничества.<br/><br/><strong><em>Когда:</em></strong> 12 апреля, 19:00<br/><strong><em>Где:</em></strong> Станиславского, 21с7<br/><strong><em>Стоимость: </em></strong>от 700 рублей<br/><a href="https://vk.cc/cE0YOr">https://vk.cc/cE0YOr</a></p>
a0eb66a4-697e-41d1-9db6-2bc88a5d9bd8	a4711d7c-7d8e-441e-8456-d76f61628ac8	<p>Здесь ты сможешь исследовать историю первых водопроводов в Кремле и узнать о развитии систем водоснабжения и канализации в Москве с XVIII века до современных технологий очистки воды и обработки сточных вод. В выставочных залах ты найдешь предметы быта и документы, относящиеся к этой теме, включая рукописи и чертежи известных ученых и инженеров.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн-чт,<em> </em>10:00-17:00,<br/>пт,<em> </em>10:00-16:00,<br/><em><strong>Где:</strong></em> Саринский проезд, 13<br/><strong><em><strong><em>Вход свободный</em></strong></em></strong><br/><a href="https://vk.com/away.php?to=https%3A%2F%2Fwww.mosvodokanal.ru%2Fabout%2Fmuseum.php&amp;cc_key=cuxUUX" rel="noreferrer noopener" target="_blank">https://vk.cc/cuxUUX</a></p>
3dadf64c-b295-4b93-8f38-67bc4b860c04	cbafcc6e-4fb5-4fb1-be63-3c36395d7baf	<p>Концерт объединит в себе музыку, навеянную временем, и современные технологии. В первой части программы прозвучит композиция «Времена года» Антонио Вивальди. Во второй части вечера гости услышат произведения авторов-классиков — Моцарта, Брамса, Штрауса.<br/><br/><strong><em>Когда:</em></strong> 5 апреля, 16:00<br/><strong><em>Где:</em></strong> Измайловское шоссе, 71к5<br/><strong><em>Стоимость:</em></strong> от 1300 рублей<br/><a href="https://vk.cc/cKm3Nv">https://vk.cc/cKm3Nv</a></p>
ac41bff1-79d4-4ea3-9729-93c9594a3eb1	a96d230c-be99-4ded-a68e-352270951fb5	<p>Экспозиция включает 59 игровых автоматов — популярные «Морской бой», «Баскетбол», «Снайпер», «Городки» и многие другие. Отдельно выделен зал с автоматами на платформе ТИА-МЦ, в котором представлены электронные автоматы — «Сафари», «Снежная королева», «Авторалли».<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>пн-вс, 11:00-21:00<strong><em><br/><strong><em>Где:</em></strong></em></strong> Рождественка, 12<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>850 рублей для студентов<br/><a href="https://vk.cc/cxkCiG" rel="noreferrer noopener" target="_blank">https://vk.cc/cxkCiG</a></p>
ff75cd74-209a-4ef5-9a96-190c86a63bcb	3ae23a8b-7a76-409b-8efc-293ec686eb54	<p>История разворачивается в центре событий, где помощник премьер-министра Великобритании забронировал номер в отеле, собираясь провести вечер со своей секретаршей, которая работает у его политического оппонента. Однако их встреча омрачается обнаружением трупа за окном их номера.<br/><br/><strong><em>Когда:</em></strong> 11 мая, 19:00<br/><strong><em>Где:</em></strong> Лесная, 18<br/><strong><em>Стоимость: </em></strong>от 1200 рублей<br/><a href="https://vk.cc/cuVy2x" rel="noreferrer noopener" target="_blank">https://vk.cc/cuVy2x</a></p>
d095d1b0-12c5-482d-9a74-5dd1b95149f8	7f8de363-d3f5-40a8-b52d-a5ecdd326cdc	<p>Отправившись на литературно-мистическую прогулку по Булгаковской Москве, вы познакомитесь с историей создания культового романа «Мастер и Маргарита» и побываете в местах, связанных с жизнью героев произведения и происходившими с ними событиями.</p>
0c40e82e-f895-462d-8f4d-c88cb65feb29	38695da5-86aa-412d-acf9-2cd97d6b2b5f	<p><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>сб, вс, 13:00 и 16:00<br/><em><strong>Где:</strong></em> Триумфальная площадь, 2<br/><strong><em>Стоимость</em></strong>: 700 рублей для студентов<br/><a href="https://vk.cc/crPXZh" rel="noreferrer noopener" target="_blank">https://vk.cc/crPXZh</a></p>
6b9f27d3-5744-4a04-a106-675c30ea5ac2	f1809388-adff-4a73-9e68-d24d2047ef40	<p>Это грандиозное мультимедийное шоу от солиста Цирк Дю Солей, основанное на повести Ричарда Баха «Чайка по имени Джонатан Ливингстон». Это история о стремлении к самосовершенствованию и абсолютной свободе. Джонатан, нарушив законы своей стаи и изгнанный за это, продолжает путь к мечте, достигая мастерства в полете и постигая высшую любовь.</p>
b2132d76-11ef-41db-b885-fb434b555bc1	4d021bb5-f4b8-45b3-b4dc-7889abf5f60a	<p><em><strong>Когда</strong></em><strong><em>: </em></strong>23 октября, 19:00<strong><em><br/><strong><em>Где:</em></strong> </em></strong>Новозаводская, 27<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 1000 рублей<br/><a href="https://vk.cc/cwXlDf">https://vk.cc/cwXlDf</a></p>
8aeeb872-7549-426d-8dcb-998902d50f91	86bac2fa-a645-45df-bbbc-19358dc41a56	<p><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>дату и время конкретного квеста уточняй на сайте<br/><em><strong>Где:</strong></em> Суворовская, 51<br/><strong><em>Стоимость: </em></strong>от 1200 рублей<br/><a href="https://vk.cc/cy3Ry9" rel="noreferrer noopener" target="_blank">https://vk.cc/cy3Ry9</a></p>
09bcffed-2a06-490d-9181-f0dcb8a774ee	003f43a3-b5fa-4593-84f5-cabd69b28d3c	<div class="wp-block-columns has-black-color has-text-color has-background" style="background-color:#96d4a3">\n<div class="wp-block-column" style="flex-basis:100%">\n<div class="wp-block-columns">\n<div class="wp-block-column" style="flex-basis:100%">\n<p><strong>Пищевые привычки</strong> — это устоявшиеся предпочтения, связанные с приемом пищи, которые формируются у человека на протяжении всей жизни. Они включают в себя выбор продуктов, способы их приготовления, частоту приемов пищи, размеры порций и время приема пищи. </p>\n</div>\n</div>\n</div>\n</div>
a39d6430-7991-471b-bc99-f829f6578fa6	16217dcf-51fd-49d1-9ee6-989198cdaf33	<div class="wp-block-column" style="flex-basis:100%">\n<div class="wp-block-columns">\n<div class="wp-block-column" style="flex-basis:100%">\n<p><strong>Пищевые привычки</strong> — это устоявшиеся предпочтения, связанные с приемом пищи, которые формируются у человека на протяжении всей жизни. Они включают в себя выбор продуктов, способы их приготовления, частоту приемов пищи, размеры порций и время приема пищи. </p>\n</div>\n</div>\n</div>
d2bc622e-cdcf-4572-be62-e1f647956871	22c73cc5-8957-49e3-91cd-5537384943a4	<div class="wp-block-columns">\n<div class="wp-block-column" style="flex-basis:100%">\n<p><strong>Пищевые привычки</strong> — это устоявшиеся предпочтения, связанные с приемом пищи, которые формируются у человека на протяжении всей жизни. Они включают в себя выбор продуктов, способы их приготовления, частоту приемов пищи, размеры порций и время приема пищи. </p>\n</div>\n</div>
beb17c63-d92e-45e1-870e-0e53d0a3c7b6	fe705a6f-2ab9-40b0-956f-3209d0af32c0	<div class="wp-block-column" style="flex-basis:100%">\n<p><strong>Пищевые привычки</strong> — это устоявшиеся предпочтения, связанные с приемом пищи, которые формируются у человека на протяжении всей жизни. Они включают в себя выбор продуктов, способы их приготовления, частоту приемов пищи, размеры порций и время приема пищи. </p>\n</div>
13da0e72-e7f7-4cdf-88ed-c1d68f0bc8f9	fbfeb5f8-90bf-4f55-a802-01c031d72826	<p><strong>Пищевые привычки</strong> — это устоявшиеся предпочтения, связанные с приемом пищи, которые формируются у человека на протяжении всей жизни. Они включают в себя выбор продуктов, способы их приготовления, частоту приемов пищи, размеры порций и время приема пищи. </p>
71d11104-a959-4129-b94b-36323dea4ebc	8c8a0014-23ec-42ac-863d-75b9de3cb8c8	<p>Пищевые привычки могут быть как полезными, так и вредными для здоровья. Например, регулярное употребление овощей, фруктов и цельнозерновых продуктов способствует поддержанию здорового веса, снижению уровня холестерина и укреплению иммунитета. В то же время, частое употребление фастфуда и сладкого может привести к ожирению и сердечно-сосудистым заболеваниям.</p>
a74e1f3c-d6b9-49ae-8a31-4c5bf8c8bfa5	329df443-2a4e-409d-b927-69798f495279	<p>Изменение пищевых привычек — это процесс, требующий времени и осознанного подхода. Мы подготовили несколько советов, которые помогут тебе в этом:</p>
fc9477ae-0105-4aaf-8eec-df7e92e9d842	e2de178c-d27e-4f1b-a57e-875f3a895efc	<ol><li><strong>Оцени свои привычки</strong>. Начни с анализа своего рациона. Какие продукты ты ешь чаще всего? Есть ли у тебя склонность к перееданию или употреблению вредной пищи?</li><li><strong>Постепенное изменение</strong>. Не стоит кардинально менять все сразу. Постепенно добавляй в рацион больше овощей и фруктов, заменяй обработанные продукты на натуральные.</li><li><strong>Установи цели</strong>. Ставь реалистичные цели: например, начать завтракать каждый день или сократить потребление сахара.</li><li><strong>Будь терпеливым</strong>. Привычки не меняются мгновенно. Дай себе время на адаптацию и не обвиняй себя за возможные ошибки. </li></ol>
fc6d2593-6da7-4670-a431-3d4678fe78a7	f374cb9f-c03e-43bd-a006-900441f6a8f8	<p><strong>Формирование полезных привычек требует времени, однако это одно из самых важных вложений в свое здоровье и будущее!</strong></p>
fd9674a4-8031-440c-8ce1-5b2c2c7984b2	5622098a-0656-4375-b87e-68a73991b242	<p>Выставка довольно необычна для современного искусства: работы многогранны, наполнены подтекстами, что придает им философскую глубину. Сатира и сарказм уступают изяществу пластических решений.<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>вт-вс, 12:00–20:00<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>4-й Сыромятнический пер., 1/8, стр. 6<strong><em><br/><strong><em>Вход свободный</em></strong></em></strong><br/><a href="https://vk.cc/cK7ixd">https://vk.cc/cK7ixd</a></p>
811ae602-87db-4aa6-a624-7bd2d78872d7	14c0dbd4-c255-49aa-99d0-a75aa947400c	<p>«Служебные страсти или Любовь по графику» — это не просто экранизация, а свежее театральное прочтение известного сюжета, объединяющее юмор, драму и уникальную атмосферу живого спектакля.<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>27 марта, 19:00<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>Вернадского, 41с1<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 1400 рублей<br/><a href="https://vk.cc/cK7jrT">https://vk.cc/cK7jrT</a></p>
7c14d889-a308-44c9-a208-ed455e8f1e3b	c89d9b8d-b15a-41f3-a9dd-084be47d0b80	<h2 id="sluzhba-krovi-zapustila-donorskiy-fleshmob-dlya-studentov">Служба крови запустила донорский флешмоб для студентов</h2>
172fb411-1f41-4faa-b3be-95c62b684601	3dbede3f-86e6-47ec-8169-90837e3a1375	<p>Загадывай желание, ведь ты отправишься в путешествие за звездой! Тебя ждет посещение шпиля Сталинской высотки гостиницы «Украина», захватывающий вид на Москву с высоты 180 метров, вкусные напитки и полный удивительных фактов рассказ гида.<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>дату и время конкретной экскурсии уточняй на сайте<strong><em><br/><strong><em>Место встречи:</em></strong> </em></strong>станция метро Киевская<strong><em><br/><strong><em>С</em></strong>тоимость</em></strong>: 2500 рублей<br/><a href="https://vk.cc/cK7kF7">https://vk.cc/cK7kF7</a></p>
5100e8e8-abee-4c9e-b2e1-f4c593a57bd1	498f644e-7df4-43c2-b4e9-4abd3aa88ee5	<p>Летчик Лазарев с семьей переезжает в глубинку. Его сын находит медвежонка Мансура, которого похищают браконьеры. Когда косолапого похищают местные браконьеры, ему на помощь приходит верная овчарка Пальма. Двум животным нужно найти дорогу домой через лес, полный диких зверей, охотников и прочих опасностей.<br/><br/><em><strong>Когда</strong></em><strong><em>: </em></strong>дату и время конкретного сеанса уточняй на сайте<strong><em><br/><strong><em>Где:</em></strong> </em></strong>место конкретного показа уточняй на сайте<strong><em><br/><strong><em>С</em></strong>тоимость</em></strong>: от 150 рублей<br/><a href="https://vk.cc/cK7mO3">https://vk.cc/cK7mO3</a></p>
36412efb-b542-42f4-9203-df7975afbb4d	e067fa6c-c088-41ea-b36a-a448bb4947b2	<p>Это уникальная интерактивная экспозиция, расположенная недалеко от канатной дороги и знаменитой смотровой площадки Москвы. Экспозиция предлагает множество уникальных опытов, таких как игра с тиграми, восхождение на сноуборде с Воробьевых Гор и создание впечатляющих фотографий в различных эксклюзивных локациях.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> пн-пт, 11:00-22:00,<br/>сб, вс, 10:00-22:00<br/><em><strong>Где:</strong></em> Косыгина, 28/2<br/><strong><em>Стоимость: </em></strong>от 300 рублей<br/><a href="https://vk.cc/cEtZ3J">https://vk.cc/cEtZ3J</a></p>
e83bd300-5cef-4d55-af7f-af530ee04f2a	20bc6bc6-27e5-40e4-ae0d-bfb16336a54f	<p>Во Флорариуме представлены разнообразные виды растений, включая лекарственные, декоративные, хозяйственно важные и редкие, со всей территории России. Для выращивания растений используется метод аэропоники, при котором растения не растут в почве, а получают питательные вещества в виде аэрозоля, направленных к корням. В обширной коллекции Флорариума представлено более 250 видов растений.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>25 марта, 11:00-19:00<br/><em><strong>Где:</strong></em> Варварка, 6с1<br/><strong><em><strong><em>Стоимость: </em></strong></em></strong>от 500 рублей<br/><a href="https://vk.com/away.php?to=https%3A%2F%2Fafisha.yandex.ru%2Fmoscow%2Fexcursions%2Fflora-rossii-v-aeroponike-florariuma%3Fsource%3Drubric%26schedule-date%3D2023-10-16&amp;cc_key=crCmoF" rel="noreferrer noopener" target="_blank">https://vk.cc/crCmoF</a></p>
880d485b-b28f-46f0-a26d-5b82228852a8	964931e5-309d-455a-95a4-726e3afa8941	<p>Выставка «Порывы и дуновения» отражает миссию галереи — поддерживать творчество и новые идеи. Экспозиция обращается не к перечислению проектов, а к глубинной сути искусства — к чувствам и переживаниям, которые рождаются при встрече с произведениями, сохраненными в коллекциях благодаря галерее.<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>9 марта, 17:00<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>4-й Сыромятнический пер., 1/8, стр. 6<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 350<strong><em><strong><em> </em></strong></em></strong>рублей<br/><a href="https://vk.cc/cJwjAz">https://vk.cc/cJwjAz</a></p>
55036db4-5e20-42c9-85c4-6dc1c51514d5	36e49c2a-8f96-445f-9d78-a02d98f9d532	<p>В городском парке жила лягушка, которая очень любила смотреть фильмы в летнем кинотеатре. Однажды она увидела мультфильм, где лягушка превратилась в девушку, поймав стрелу. Вдохновленная этим, она отправилась искать стрелу, но вместо нее поймала мячик для гольфа.<br/><br/><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>дату и время конкретного сеанса уточняй на сайте<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>место показа конкретного сеанса уточняй на сайте<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>от 150<strong><em><strong><em> </em></strong></em></strong>рублей<br/><a href="https://vk.cc/cJwkT1">https://vk.cc/cJwkT1</a></p>
3ce45fe7-4b07-42b2-b264-3a0c805e2362	0be5e976-1bc3-475c-8cf2-2119bc902e4a	<p>В Ледяной пещере открылось уникальное иммерсивное представление «Вьюжн» объединяющее снег, светомузыку и ностальгические воспоминания. Здесь ты почувствуешь всю магию январской вьюги, хруст снега под ногами, полуночный фейерверк и множество ностальгических моментов.</p>
ce773475-0624-4bc6-824f-b0176e43dd55	216a2caf-988d-4bc7-9281-3ef4124d9276	<p><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн, 14:00-21:00,<br/>вт-вс, 10:00-21:00<br/><em><strong>Где:</strong></em> Варварка, 6<br/><strong><em><strong><em>Стоимость: </em></strong></em></strong>450 рублей<br/><a href="https://vk.cc/cJwl78">https://vk.cc/cJwl78</a></p>
64ca5d60-e782-4ca1-bd67-b81cdf6a6da7	f5ba8170-dccc-44aa-a199-14cb31af4ab9	<p>Главный герой комедии — вор и авантюрист, воплощение отрицательных черт: расчетливость, обман, предательство и азарт. Но его истинная природа раскрывается только через испытание любовью.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>14 марта, 19:00<br/><em><strong>Где:</strong></em> Неглинная, 29, стр. 1<br/><strong><em><strong><em>Стоимость: </em></strong></em></strong>от 770 рублей<br/><strong><em>Мероприятие можно починить по Пушкинской карте</em></strong><br/><a href="https://vk.cc/cJwlrk">https://vk.cc/cJwlrk</a></p>
8d9d2b46-f25f-42fe-831d-5ec7e3fbdffe	4600498c-606e-4a37-b598-eef5e29d06b0	<p>«Стендап Интуиция» — это шоу, где комики гадают, кем работают зрители. Угадывай вместе с ними: попал в точку — получишь приз, а если нет — просто посмеемся вместе!<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>14 марта, 21:30<br/><em><strong>Где:</strong></em> Покровка, 17с5<br/><strong><em><strong><em>Стоимость: </em></strong></em></strong>от 500 рублей<br/><a href="https://vk.cc/cJwmoh">https://vk.cc/cJwmoh</a></p>
23ef2a58-9748-47f2-a856-2c1763c05122	d66f2f49-61b2-487b-b630-ecd6cb7331c1	<p>Приглашаем на концерт при свечах «Времена года» Вивальди! Погрузись в музыкальное путешествие, где каждая нота оживляет смену сезонов. Это незабываемое событие для всех ценителей классической музыки.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>16 марта, 19:00<br/><em><strong>Где:</strong></em> Тверская, 14<br/><strong><em><strong><em>Стоимость: </em></strong></em></strong>от 1999 рублей<br/><a href="https://vk.cc/cJwnhD">https://vk.cc/cJwnhD</a></p>
d40ed7fa-3cae-4bab-a1ce-14aa9da76a32	aa87a760-34a5-4af3-80d7-7389aa2d19ba	<p>Особенность экскурсии заключается в погружении в историю российского современного искусства. Почему все пути современного искусства ведут на Винзавод? Как работают галереи современного искусства? Кто играет главные роли в современном российском искусстве? Ответы на эти вопросы вы узнаете во время посещения мероприятия.</p>
7ca361a0-ee2c-4ec0-9670-60c1e99cdd7b	2dbf7a7e-b33b-48dd-82a2-3be2b772dbe7	<p><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong>9 марта, 17:00<strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong>4-й Сыромятнический пер., 1/8, стр. 6<strong><em><br/><strong><em>Стоимость: </em></strong></em></strong>1300<strong><em><strong><em> </em></strong></em></strong>рублей<br/><a href="https://vk.cc/czxLbK">https://vk.cc/czxLbK</a></p>
81d247fd-9a6a-4fb0-90ff-90717504085c	9bcffb9a-3b1f-4819-874b-db61bec0fbc8	<p>Не упусти шанс провести свой вечер в атмосфере шуток и юмора! Тебя ждут выступления профессиональных комиков, участниц шоу «Женский Стендап на ТНТ», «Labelcom», «Открытый микрофон на ТНТ» и других популярных ТВ и YouTube проектов.</p>
f8761c23-12b3-446a-bda8-2e79d1ac0d01	f36eee19-fba4-49cc-8ba6-4b26d597fbf8	<p><strong><em>К</em></strong><em><strong>огда</strong>:</em> 6 марта, 19:30<br/><em><strong>Где:</strong></em> Кожевническая, 14, стр. 2<br/><strong><em>Стоимость: </em></strong>от 890 рублей<br/><a href="https://vk.cc/cJeZWZ">https://vk.cc/cJeZWZ</a></p>
abf48d55-e454-414f-9a55-2f723c06dc3e	cf63a05b-2362-4493-8be9-b562b5450fd5	<p>Профессор Хиггинс специализируется на изучении речи и звуков, используя фонограф для своих исследований. Фонограф Виктор Крамер создает сценографию, превращая сцену в лабораторию, где Хиггинс собирает коллекцию звуков и голосов, по сути, создавая коллекцию человеческих душ.</p>
f059791d-1177-4f32-8d38-5e4b325fe055	3218ce10-3c5b-4a61-8b9b-42e957d69438	<p><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong>4 марта, 19:00<br/><strong><em><strong><em><strong>Где:</strong> </em></strong></em></strong>Триумфальная площадь, 2<br/><strong><em>Стоимость: </em></strong>от 800 рублей<br/><a href="https://vk.cc/cwL8c2">https://vk.cc/cwL8c2</a></p>
41077774-fb14-4455-8b07-06ef64288537	218f888f-6290-4ad4-a4ad-92296019a3c9	<p>Художник Иван Смирнов разработал концепцию «генератора счастливых случайностей», которая предполагает неожиданные результаты проекта благодаря реакции материала на воздействие инструмента. Такой подход превращает мастерскую в лабораторию, где создание произведений напоминает эксперимент с непредсказуемым исходом.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>пн–вс, 11:00-22:00<br/><em><strong>Где:</strong></em> Болотная набережная, 15<br/><strong><em>Вход свободный, нужна предварительная регистрация</em></strong><br/><a href="https://vk.cc/cEIlSl" rel="noreferrer noopener" target="_blank">https://vk.cc/cEIlSl</a></p>
4c25e345-f8a4-44a5-a491-a7ecff2adf85	127ccd1b-8903-4823-ad32-8cf565131d1a	<p>В спектакле Театра Моссовета поднимаются актуальные философские вопросы о человеческой природе и непредсказуемости судьбы. Основной символ — образ Старой графини, который является ключом к раскрытию внутренних конфликтов главного героя.<br/><br/><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong>4 марта, 19:00<strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong>Большая Садовая, 16с1<br/><strong><em>Стоимость: </em></strong>от 500 рублей<br/><a href="https://vk.cc/cw2ibU" rel="noreferrer noopener" target="_blank">https://vk.cc/cw2ibU</a></p>
3871e199-3de5-42e3-acb8-0c1b3a3c64e7	c923f83b-efbb-4d97-a733-57bd7bff470c	<div class="wp-block-column" style="flex-basis:100%">\n<div class="wp-block-group has-secondary-background-color has-background"><div class="wp-block-group__inner-container">\n<div class="wp-block-columns has-white-background-color has-background">\n<div class="wp-block-column" style="flex-basis:100%">\n<p>Не упусти возможность расширить свои горизонты, задать вопросы и просто хорошо провести время!</p>\n</div>\n</div>\n</div></div>\n</div>
f1594856-9889-44ec-9cc0-37d7a59808f9	e30b315d-dc6a-4f95-abb1-5a8958e9f903	<p>Начало 1960-х, период обострения противостояния СССР и США. В сложнейших погодных условиях и с неисправностями на борту первая советская атомная подводная лодка отправляется в поход подо льдами Северного Ледовитого океана, чтобы всплыть на Северном полюсе.<br/><br/><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong>дату и время конкретного сеанса уточняй на сайте<strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong>место показа конкретного сеанса уточняй на сайте<br/><strong><em>Стоимость: </em></strong>от 150 рублей<br/><a href="https://vk.cc/cJf35x">https://vk.cc/cJf35x</a></p>
4c67a60f-31d0-403f-9553-085e647b437c	6bd2c327-9041-4c62-80d6-92fdc24a8634	<h2 id="v-stankine-proshla-mnogoprofilnaya-olimpiada-po-angliyskomu-yazyiku">В СТАНКИНе прошла многопрофильная олимпиада по английскому языку</h2>
f5368b43-c5b5-4e80-969c-a81a6a6c3c15	3348bbba-8a09-4608-b601-9c3ac36999fa	<p>Каждый участник олимпиады разработал решения для описанных проблемных ситуаций из их профессиональной сферы на английском языке. Оценивали не только языковую грамотность студентов, но и креативность предложенных решений, их практическую ценность и аргументацию.<br/><a href="https://vk.cc/cIMej5" rel="noreferrer noopener" target="_blank">https://vk.cc/cIMej5</a></p>
b39ea3af-bcf1-45d0-b7d9-15c8e2cc06dd	a0befc30-6163-48fb-a66c-581e085269b3	<h2 id="v-stankine-sostoyalas-vstrecha-s-nachalnikom-vuts">В СТАНКИНе состоялась встреча с начальником ВУЦ</h2>
659bd62e-2ca7-41ab-8f8b-379694ea18f9	7553d3a2-9084-4821-ae3e-637d7c47d0cd	<p>В актовом зале МГТУ «СТАНКИН» прошла встреча студентов с начальником Военного учебного центра. Полковник Алексей Дроздов рассказал о программах обучения, о необходимых документах для подачи заявления, военных сборах, а также ответил на вопросы обучающихся.<br/><a href="https://vk.cc/cIMevl" rel="noreferrer noopener" target="_blank">https://vk.cc/cIMevl</a></p>
51ac84f0-8121-4b98-9aaf-480e24084b3a	402babdb-9082-4e9d-8aad-23cbd62a43cd	<h2 id="proshel-pervyiy-kubok-stankina-po-bilyardu">Прошел Первый Кубок СТАНКИНа по бильярду</h2>
722364e6-1140-4716-8cb6-6463d760de95	2cdd6528-3d5e-4014-aa9b-17ee7e573b8a	<p>Пять часов в бильярдном клубе «БАЗА» семь станкиновцев соревновались за звание лучшего в Первом Кубке СТАНКИНа по пулу. Каждый из участников продемонстрировал мастерское владение кием и свою точность.<br/><a href="https://vk.cc/cIMeBg" rel="noreferrer noopener" target="_blank">https://vk.cc/cIMeBg</a></p>
bf7f39aa-0b54-46d8-8c20-1d7efe31b9bf	0ab7f45f-711f-4b38-b57c-b01e334bef48	<h2 id="profkom-obuchayushhihsya-obyavil-o-prieme-dokumentov-na-dve-vyiplatyi">Профком обучающихся объявил о приеме документов на две выплаты</h2>
2efef02b-2389-4dd6-8b88-113564c89bcc	bd90062f-db68-4ca9-ae91-f0050efa1a58	<p>С 20 февраля в профкоме обучающихся начался прием документов на материальную и социальную поддержку. Данные выплаты осуществляются только студентам, обучающимся на бюджетной основе.<br/><a href="https://vk.cc/cIMhI2" rel="noreferrer noopener" target="_blank">https://vk.cc/cIMhI2</a></p>
448aa0dd-0e99-4e33-bfc7-a0cf30b25b32	d7350a43-6f3d-48a9-9fe5-71ee83810740	<h2 id="nachalsya-priem-zayavok-na-novyiy-sezon-spetsproekta-tvoy-hod-h-debattl">Начался прием заявок на новый сезон спецпроекта «Твой Ход х Дебаттл»</h2>
cb035540-a82d-4e9e-a8ed-60ef88b0936f	3c887599-1971-4499-9f86-d127039633eb	<p>Спецпроект «Твой Ход х Дебаттл» объявил о старте приема заявок на новый сезон, где каждый участник сможет прокачать свое ораторское мастерство. Это огромный шанс заявить о себе, развить навыки убеждения и научиться побеждать в интеллектуальных битвах.<br/><a href="https://vk.cc/cIMi8D" rel="noreferrer noopener" target="_blank">https://vk.cc/cIMi8D</a></p>
eb7d32c2-fd5b-48f5-8a86-f63b2eaf31c5	49965b01-766f-40d6-9c3f-992445a61940	<h2 id="v-stankine-sostoyalas-prezentatsiya-nastavnicheskoy-programmyi">В СТАНКИНе состоялась презентация наставнической программы </h2>
07d6d3af-8ecb-4980-819f-d6f5d1b8a626	4be92717-c227-42f2-a95d-828e94d19482	<p>Ребятам рассказали о структуре программы «Правовая мастерская столицы», ее целях и задачах. Программа будет полезна для студентов, позволяя углубиться в знания в области профессионального развития и правозащитной деятельности.<br/><a href="https://vk.cc/cIMQZb" rel="noreferrer noopener" target="_blank">https://vk.cc/cIMQZb</a></p>
a53debc6-8728-45cb-92aa-15f4e7693ef0	b51f23df-e596-4485-8840-1ea9d9c4abb0	<p>Приглашаем тебя на захватывающие события, которые пройдут в ближайшие дни и обещают быть познавательными! </p>
a333e33b-c85e-4e5a-b1a0-f80cbb7f0707	6ac2d6e6-8dc5-40ed-8e94-d423a956eb4f	<h2 id="sovremennyie-vyizovyi-bioetiki">Современные вызовы биоэтики</h2>
4ebad488-036a-42bf-bd06-633aca61d005	6a408a54-48b0-4457-9b0a-c07e61d0beb6	<p><strong>20 февраля в 18:00</strong> состоится встреча с проповедником и священником, протоиереем Александром Абрамовым. Это уникальная возможность обсудить с экспертом важные вопросы, касающиеся биоэтики в нашем современном мире. Ты сможешь задать вопросы и получить ценные ответы!</p>
6554ec12-c7b1-4612-991f-3425bfe7caa2	cac24fca-d6ab-47b4-83ec-b37ee5e32f25	<p><strong><em>Регистрация на мероприятие:</em></strong> <a href="https://molodezh-sovet-centrvik.timepad.ru/event/3241215/">https://molodezh-sovet-centrvik.timepad.ru/event/3241215/</a></p>
1f399e06-04e8-40e4-85f2-421fd0e8e7be	cbdc54eb-29de-4fb9-ac89-31761785520f	<p><em><strong>Место и адрес проведения:</strong></em> Издательство «Просвещение», ул. Краснопролетарская, 16с3</p>
bdb566d1-729f-4531-a06c-a296c7ffd54d	4b826a2a-ec21-4b5b-802b-8c6104665599	<h2 id="hh-teatralnogo-festivalya-sretenie"><strong>ХХ Театрального фестиваля «Сретение»</strong></h2>
a0abfadf-dc14-4a3c-95b3-2eae7e9d3311	fb170f6e-8a69-4dbf-9e7e-8958152088f9	<div class="wp-block-group has-secondary-background-color has-background"><div class="wp-block-group__inner-container">\n<div class="wp-block-columns has-white-background-color has-background">\n<div class="wp-block-column" style="flex-basis:100%">\n<p>Не упусти возможность расширить свои горизонты, задать вопросы и просто хорошо провести время!</p>\n</div>\n</div>\n</div></div>
5b24442f-f8fc-4d0e-a1d9-4ae6634e8500	f6c2ef6c-740c-4beb-bada-feacbd28e445	<div class="wp-block-group__inner-container">\n<div class="wp-block-columns has-white-background-color has-background">\n<div class="wp-block-column" style="flex-basis:100%">\n<p>Не упусти возможность расширить свои горизонты, задать вопросы и просто хорошо провести время!</p>\n</div>\n</div>\n</div>
fdd4f132-8d69-4064-9487-a8eefe2f9e94	968c6ec6-fc26-4e61-801b-e01e45f78df7	<div class="wp-block-columns has-white-background-color has-background">\n<div class="wp-block-column" style="flex-basis:100%">\n<p>Не упусти возможность расширить свои горизонты, задать вопросы и просто хорошо провести время!</p>\n</div>\n</div>
deda051b-9845-4c35-8671-20b524b561c2	25bf9fee-37c2-4eee-8938-3ed6382273a2	<div class="wp-block-column" style="flex-basis:100%">\n<p>Не упусти возможность расширить свои горизонты, задать вопросы и просто хорошо провести время!</p>\n</div>
a834b0ee-bd98-4e6a-a3f1-321b4ac30528	6dbd6732-7e75-49b9-8c37-ebb383390e26	<p>Не упусти возможность расширить свои горизонты, задать вопросы и просто хорошо провести время!</p>
e0ff0d52-7786-422c-9e10-c8261aa2b157	14d8e7cb-4acd-4874-84c6-db5eb5962d9e	<p>Шоу «Каскадерская Масленица» приурочено к народному гулянью — Масленице 2025. Мероприятие представляет собой зрелищное представление с автомобильными и мотоциклетными трюками, полетами в высоте и острыми ощущениями, созданное в стиле комедийного боевика!<br/><br/><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>22 февраля, 13:00<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>2-й Сетуньский проезд, 3с1<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 1000 рублей<br/><a href="https://vk.cc/cIEpk1" rel="noreferrer noopener" target="_blank">https://vk.cc/cIEpk1</a></p>
e17ca493-6ccb-4374-851c-20d965713742	28f92b1d-cf6f-4091-aee6-b64488775f1a	<p>Совсем скоро на территории «Хлебозавода №9» пройдет пятая юбилейная выставка, где более 100 здоровых и социализированных собак и кошек из приютов будут ждать своих новых хозяев. Передача животных осуществляется бесплатно по договору, для оформления требуется паспорт.<br/><br/><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>23 февраля, 12:00–18:00<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>Новодмитровская, 1<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Вход свободный</em></strong></em></strong></em></strong></em></strong></em></strong></em></strong><br/><a href="https://vk.cc/cIEqyL" rel="noreferrer noopener" target="_blank">https://vk.cc/cIEqyL</a></p>
cca6dae8-79e9-4ac7-9bfb-871c5c58779f	4618fe8c-0015-4189-9f94-620b30db9339	<p>Спектакль рассказывает о молодых людях, чья жизнь встречается с войной. Это история о честных людях, которые, несмотря на ошибки и слабости, не теряют из виду большую цель, сталкиваясь с трагической любовью, подвигом и сложными жизненными вызовами.<br/><br/><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>20 февраля, 19:00<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>Малая Бронная, 4<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 900 рублей<br/><a href="https://vk.cc/cIEr4y" rel="noreferrer noopener" target="_blank">https://vk.cc/cIEr4y</a></p>
889436d0-c041-4e06-b9b7-0f717e8b1312	b64333d8-1b60-4b31-9e55-00d15cf46a66	<p>Выставка исследует тему счастья через сочетание древних символов и современных размышлений. Работы отсылают к средневековым алхимическим трактатам, в которых занимались поисками формулы философского камня — источника мудрости и бессмертия.<br/><br/><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>вт-вс, 12:00-20:00<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>4-й Сыромятнический переулок, 1/8<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Вход свободный</em></strong></em></strong></em></strong></em></strong></em></strong></em></strong><br/><a href="https://vk.cc/cIEqEH" rel="noreferrer noopener" target="_blank">https://vk.cc/cIEqEH</a></p>
70faf96c-b166-4d9d-9598-9a64d2ff1d25	79323578-8d7f-4268-b418-d06bd5d1ad38	<p>Ваша команда исследует паранормальные явления в местах с призраками. Каждый игрок оснащен специальным снаряжением и может применять ненаучные методы. Миссия будет успешной, если вы сохраните рассудок, правильно определите призрака и останетесь живы.</p>
37fd8c25-0791-4cec-abd1-fbdeec4bc5f1	29b5cd4d-87ae-4223-b203-3d634d67afdb	<p>Гостей парка ждет 1000 квадратных метров искусственного льда, а также комфортный павильон-раздевалка, украшенный гирляндами, красавицей-елкой и другими яркими символами зимы. Рядом с катком расположены 2 торговых павильона с едой и горячими напитками. <br/><br/><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>дату и время конкретного сеанса уточняй на сайте<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>Лазо, 7<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 150 рублей<br/><a href="https://vk.cc/cIEHm7">https://vk.cc/cIEHm7</a></p>
0559fc21-75f8-419b-8855-ff4f6c1833e7	99834887-d951-418d-b2b7-292f84737418	<p>В квесте по мотивам Гравити Фолз игроки помогают Мейбл спасти дневники от Гидеона, который уменьшил всех до размера насекомых. Приключение проходит внутри Хижины чудес, где нужно исследовать сувенирный магазин, музей и чердак, решая загадки и сражаясь с Биллом Шифром.<br/><br/><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>дату и время конкретного квеста уточняй на сайте<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>Чертановская, 66к1<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 1000 рублей<br/><a href="https://vk.cc/cIEIkz">https://vk.cc/cIEIkz</a></p>
f194adc0-1df2-4b7b-98b4-d0abe68b9965	ed20d954-4df7-4037-8589-4fdb711a9a2a	<h2 id="v-stankine-proshel-den-donora">В СТАНКИНе прошел День донора</h2>
a95bc3f9-d99c-424e-8966-2893e9fee6f8	328d51ef-ea32-40ba-84ad-1881deccff63	<p>13 февраля добровольцы МГТУ «СТАНКИН» приняли участие в донорском движении. В акции приняло участие более 90 человек, среди которых были не только студенты, но и преподаватели и сотрудники нашего университета.<br/><a href="https://vk.cc/cIzDPT" rel="noreferrer noopener" target="_blank">https://vk.cc/cIzDPT</a></p>
a73d2cff-59ed-4e25-a568-342ad0ec52d4	ef3474ad-bfa4-4362-b74e-1f774cf75a48	<h2 id="obyavlen-nabor-na-1-kurs-v-vuts">Объявлен набор на 1 курс в ВУЦ</h2>
9dac37db-c8be-4302-b9a2-e0abea8fb7c8	a2db8d41-19ed-4ae3-bd57-c94d75f89c6b	<p>ВУЦ МГТУ «СТАНКИН» открыл прием документов для участия в конкурсном отборе студентов. В ВУЦ студенты сначала изучают теорию, проходят учебные сборы в войсках, а уже после сборов сдают государственный экзамен.<br/><a href="https://vk.cc/cIwmu3" rel="noreferrer noopener" target="_blank">https://vk.cc/cIwmu3</a></p>
90cb3431-363b-400c-a4a0-7bcf2a2b92e3	9bc3f9a9-c20a-4256-ac0c-d60f88cd4bba	<h2 id="otkryita-registratsiya-na-turnir-po-programmirovaniyu">Открыта регистрация на турнир по программированию</h2>
667da5f2-d989-4910-b769-cd02826ae45a	9c616ba1-acaa-46fc-bc82-443be536e331	<p>Открыт набор на турнир по скоростному программированию. В День программиста в СТАНКИНе каждый сможет продемонстрировать свои навыки, смекалку и скорость программирования, соревнуясь между собой!<br/><a href="https://vk.cc/cIwmOz" rel="noreferrer noopener" target="_blank">https://vk.cc/cIwmOz</a></p>
8cb7ecb7-adba-4c3f-8536-1d7c8e1c1b01	c806d07b-d120-47c3-ad02-635e6b01d526	<h2 id="konkurs-na-samuyu-tepluyu-semeynuyu-traditsiyu">Конкурс на самую теплую семейную традицию</h2>
5fd5e1d3-1097-43c1-a2d4-5c51d09c6873	e648c329-94ec-46cf-a683-23d64c373351	<p>Профком обучающихся запустил конкурс на самую теплую семейную традицию. Этот конкурс позволит лучше узнать друг друга и сохранить теплые воспоминания о семье. <br/><a href="https://vk.cc/cIzIf4" rel="noreferrer noopener" target="_blank">https://vk.cc/cIzIf4</a></p>
8dd915d9-34ff-453d-bd06-e0822c72b181	0edd8460-9292-4d57-9040-38dce3b2165d	<h2 id="proekt-gorod-geroev-moskva-zapustil-blagotvoritelnuyu-aktsiyu">Проект «Город Героев Москва» запустил благотворительную акцию</h2>
c6672b60-c19a-4525-8a0e-29f32b393b32	ac5c5206-3c65-410c-8690-8c0d1b64a20a	<p>Стартовала благотворительная акция «Помощь нашим героям» от проекта <a href="https://vk.com/gorodgeroevmsk" rel="noreferrer noopener" target="_blank">«Город Героев Москва»</a>. Участвуя в этой акции, ты сможешь помочь в подготовке патриотических мероприятий и ветеранам в повседневных делах.<br/><a href="https://vk.cc/cItytM" rel="noreferrer noopener" target="_blank">https://vk.cc/cItytM</a></p>
f25e38c6-d773-4f22-a818-5618d09a76ed	9a6c8dcf-12de-46a1-be02-266602427a81	<h2 id="it-planeta-zapustila-20-masshtabnyih-konkursov">«IT-Планета» запустила 20 масштабных конкурсов</h2>
d9b88b9a-6c67-44ed-a6ce-6da5141ddda4	ad1ce258-a38a-4bb9-8eb5-e51ea425f970	<p>Стартовали 20 масштабных международных и национальных конкурсов для инженеров и IT-специалистов. Программа этого года затрагивает VR/AR, разработку мобильных приложений и чат-ботов и многое другое.<br/><a href="https://vk.cc/cIyIpC" rel="noreferrer noopener" target="_blank">https://vk.cc/cIyIpC</a></p>
4c8d1a44-39fd-4f64-b5af-c71b1a5e954e	f2e51b16-56c7-4ddf-83c5-e2f2c44d8078	<p>Проект посвящен образу гопников, который сегодня романтизирован и активно используется в массовой культуре. Однако для автора выставки эта тема выходит за пределы стереотипов. В его работах раскрываются вопросы дружбы, риска, свободы и внутренней честности.<br/><br/><strong><em>К</em></strong><em><strong>огда</strong>:</em> вт-вс, 12:00-20:00<br/><em><strong>Где:</strong></em> 4-й Сыромятнический переулок, 1/8<br/><strong><em>Вход свободный</em></strong><br/>h<a href="ttps://vk.cc/cInxpd">ttps://vk.cc/cInxpd</a></p>
88538e26-1886-4d08-a767-ee95f51ce6ab	342099ce-0ad3-40dd-81be-796cfcffcc36	<p>Представляем первое в Москве тайм-кафе с живыми ежиками. Ты сможешь провести время в компании Африканских и ушастых ежиков, особенностью которых является аномальное дружелюбие. Также тебя ожидает большой выбор настольных игр и Playstation.<br/><br/><strong><em>Когда:</em></strong> пн-вс, 11:00-23:00<br/><strong><em>Где:</em></strong> Арбат, 6/2<br/><strong><em>Стоимость:</em></strong> от 450 рублей<br/><a href="https://vk.cc/cE0T6O">https://vk.cc/cE0T6O</a></p>
7418b56c-3359-4e50-bd10-2b659a819f0a	e5387349-4873-427b-a9e8-7e2f831604c1	<p>Музей магии — современное интерактивное пространство, с неповторимой загадочной атмосферой иллюзий, фокусов и волшебства. Изучить экспозицию можно самостоятельно, или в сопровождении профессионального экскурсовода, который расскажет много интересного о магическом мире.<br/><br/><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>пн-чт, вс, 10:00-21:00<br/>пт, сб, 10:00-22:00<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>Новый Арбат, 7с1<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>900 рублей для студентов<br/><a href="https://vk.cc/cvgSBu" rel="noreferrer noopener" target="_blank">https://vk.cc/cvgSBu</a></p>
5f91d550-fc84-4c17-b451-2b707a97db1b	d5f17caa-434e-4335-9e89-74da9d1cbe98	<p>Молодая московская пара попадает в волшебный мир Шахерезады, где встречает героев «Тысячи и одной ночи» и, переживая невероятные приключения, находит путь к возрождению своей любви.<br/><br/><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em>К</em>огда<em>:</em> </strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>14 февраля, 14:00<strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong>Где:</strong> </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>Комсомольский проспект, 28<strong><em><strong><em><strong><em><strong><em><strong><em><br/><strong><em>Стоимость: </em></strong></em></strong></em></strong></em></strong></em></strong></em></strong>от 1800 рублей<br/><a href="https://vk.cc/cInyBT">https://vk.cc/cInyBT</a></p>
7a0fa8b3-5383-474e-91bb-04807b3d521d	e653dbe3-a4d7-472b-be78-0deafabfaccf	<p>В Москве пройдет стендап, на котором известные комики представят свой проверенный материал. Для гостей выступят участники многочисленных телевизионных и YouTube проектов: StandUp, Открытый микрофон, Comedy Battle, Прожарка и многих других.</p>
1497d9ae-1dd1-47b3-8bf2-b966d401610a	7a2bd66a-1d09-4e0b-a689-dbca8e6930a9	<p><strong><em>К</em></strong><em><strong>огда</strong></em><strong><em>:</em> </strong>ср-вс, время конкретного стендапа уточняй на сайте<br/><em><strong>Где:</strong></em> место проведения конкретного стендапа уточняй на сайте<br/><strong><em>Стоимость: </em></strong>от 590 рублей<br/><a href="https://vk.cc/cIo5c2" rel="noreferrer noopener" target="_blank">https://vk.cc/cIo5c2</a>  </p>
08fa392f-985d-48d2-a6bf-4ac7ab4a0b00	b6635c0d-53bc-4f6c-a85c-b0e375606254	<h2 id="komanda-stankina-na-mezhdunarodnom-festivale-robototehniki"><strong>Команда СТАНКИНа на международном фестивале робототехники</strong></h2>
e765c536-6740-4e03-8ee3-ee64a3a2d170	ee3fc711-9d08-485f-81fe-cfc5bb8cc44e	<p>Студенты и сотрудники молодежного проектного центра СТАНКИНа успешно представили университет на международном фестивале робототехники «КАЛАШНИКОВ-ТЕХНОФЕСТ». Они продемонстрировали навыки управления дронами в классах мини и стандарт, показав хорошие результаты в общем зачете.<br/><a href="https://vk.cc/cIf02N" rel="noreferrer noopener" target="_blank">https://vk.cc/cIf02N</a></p>
eff14576-9779-4357-bd96-4aa7249a8972	ef592911-e3b6-41f1-8374-0c66687502d5	<h2 id="v-stankine-vruchili-diplomyi-vyipusknikam-spetsialiteta"><strong>В СТАНКИНе вручили дипломы выпускникам специалитета</strong></h2>
bbad05b6-572a-42c8-a004-9f6b0dbd68c1	194c8466-6c27-4008-ba8f-80f7346a7a49	<p>В Медведевском зале университета состоялось торжественное вручение дипломов выпускникам специалитета. В декабре 47 студентов успешно защитили дипломные работы по направлению «Проектирование технологических машин и комплексов», став гордостью и надеждой отечественного машиностроения.<br/><a href="https://vk.cc/cIf0p6" rel="noreferrer noopener" target="_blank">https://vk.cc/cIf0p6</a></p>
908a8451-a1c3-4d59-9304-b8cb29cecf09	0895043a-9ff0-4a3f-bc32-d004ec0a0c50	<h2 id="startovala-prosvetitelskaya-programma-masterskaya-ekoznaniy"><strong>Стартовала просветительская программа «Мастерская экознаний»</strong></h2>
8b0499d2-546f-4634-b123-7d9993f1a51d	e8462911-acb1-463c-96ba-3ee2597b496a	<p><a href="https://vk.com/ecodvizhenie" rel="noreferrer noopener" target="_blank">Движение «Экосистема»</a> совместно с Госкорпорацией «Росатом» выпустили курс, который состоит из 10 занятий, где учёные, экологи и футурологи будут делиться российскими и мировыми практиками в области экологии. Все участники получат сертификаты, а лучшие студенты — наставничество и стажировки.<br/><a href="https://vk.cc/cIhGVn" rel="noreferrer noopener" target="_blank">https://vk.cc/cIhGVn</a></p>
6be68fc3-4182-4eac-8e48-9d882301ad84	d9b29393-e572-4c61-a96a-5ec8ca477138	<h2 id="zavershilas-zimnyaya-shkola-lider"><strong>Завершилась зимняя школа «Лидер» </strong></h2>
7776df21-a24d-4059-82ea-ff970e8f560a	d4751c5a-02d6-44bd-a5d0-4f14201cabc2	<p>Подошла к концу зимняя школа <a href="https://vk.com/profkommospolytech" rel="noreferrer noopener" target="_blank">профсоюзного актива московского Политеха</a> «Лидер», объединившая 87 участников из 17 вузов города Москвы, в числе которых были и студенты СТАНКИНа. За 3 продуктивных дня профсоюзные активисты Москвы обменялись опытом, прослушали множество лекций, а также поучаствовали в семинарах и деловых играх.<br/><a href="https://vk.cc/cIhSkR" rel="noreferrer noopener" target="_blank">https://vk.cc/cIhSkR</a></p>
ce24328a-e2ba-4ada-99ae-95cd06de22b0	bdc64880-99d6-40ba-9bcc-8f2957c955c1	<h2 id="startoval-v-sezon-vserossiyskogo-studencheskogo-proekta-tvoy-hod"><strong>Стартовал V сезон Всероссийского студенческого проекта «Твой Ход»</strong></h2>
ef8565a9-0f2d-49d6-bedc-ba357e6996a1	7ba4fd77-6df2-4c60-9a86-ab0aba0c7e56	<p>Открыта регистрация для участия в проекте «Твой Ход», где можно не только прокачать свои навыки, но и воплотить в жизнь свой стартап, а также получить поддержку от экспертов и единомышленников. В этом году проект предоставляет участникам несколько конкурсных треков, специальную образовательную программу, конкурс старост и многое другое.<br/><a href="https://vk.cc/cIicFt" rel="noreferrer noopener" target="_blank">https://vk.cc/cIicFt</a></p>
3eeb60a7-7b58-4e67-b0b7-61273a60683a	aa0f2023-e985-4cec-be0b-65efba8bdf4d	<h2 id="v-stankine-proshla-olimpiada-dlya-shkolnikov"><strong>В СТАНКИНе прошла олимпиада </strong>для школьников</h2>
13d0ed36-493e-4ba5-92d4-5e70443608d5	73203e57-f1ac-4ce3-afd9-3f9028a584eb	<p>В СТАНКИНе прошел заключительный этап Объединенной межвузовской олимпиады школьников по математике, где порядка 60 школьникам старших классов предстояло столкнуться лицом к лицу с задачами разного уровня сложностей.<br/><a href="https://vk.cc/cIkRbX" rel="noreferrer noopener" target="_blank">https://vk.cc/cIkRbX</a></p>
5d79c24c-4d7f-4a13-82d7-f6fa6c1ec7e3	97a0179c-14ee-4e57-917f-7ecde2871a5b	<h2 id="vstrecha-s-rukovoditelem-departamenta-informatsionnyih-tehnologiy">Встреча с руководителем Департамента Информационных Технологий</h2>
0e42dd57-8055-48be-aabc-b3e46cfa108e	fa59892c-5ddf-4a3e-b672-7869b1185ae6	<p>Наши студенты посетили встречу с Эдуардом Лысенко — руководителем Департамента Информационных Технологий. Эдуард Анатольевич рассказал о развитии технологий в столице, главных ИТ-проектах и перспективах в стране. В конце выступления студенты задали интересующие их вопросы.<br/><a href="https://vk.cc/cHYIfp" rel="noreferrer noopener" target="_blank">https://vk.cc/cHYIfp</a></p>
8953073f-a305-4e56-80d6-0c0e0517c795	484e1fe6-5145-49dc-9e6b-b4b9007221e7	<h2 id="v-obshhezhitii-no3-proshel-gitarnik">В общежитии Nº3 прошел гитарник</h2>
3b47648f-72f9-4a61-a7e3-65764957b18c	b73a61cb-971d-4c87-b073-e6ebf1201638	<p>25 января Совет общежитий организовал гитарный вечер для студентов, проживающих в общежитии нашего университета. Этот вечер был наполнен живой музыкой, дружеской атмосферой и общением. Каждый желающий смог проявить свои таланты, сыграв на музыкальном инструменте.<br/><a href="https://vk.cc/cHYIP3" rel="noreferrer noopener" target="_blank">https://vk.cc/cHYIP3</a></p>
27f9defe-8b2f-49d0-8569-e42fea2ea510	67f10820-17ad-4408-bcac-5c4c0a0b2398	<h2 id="stankinovets-razrabotal-po-dlya-robotizirovannoy-platformyi">Станкиновец разработал ПО для роботизированной платформы</h2>
9ff2f609-2fee-42a6-b3f0-24d81cdaa7f3	54d0e709-94d0-4c31-8ba8-cd40eeac2dbd	<p>Магистрант Валерьян Дудьев из группы АДМ-24-06 создал программное обеспечение для инновационной роботизированной платформы, которая предназначена для маркировки стройматериалов. Проект роботизированной платформы был представлен на выставке ОЭЗ «Технополис Москва».<br/><a href="https://vk.cc/cHYIWb" rel="noreferrer noopener" target="_blank">https://vk.cc/cHYIWb</a></p>
3719c3cd-7325-4fb5-8415-44e71190572c	b1c2fd24-d3f3-4d95-9f22-59a1dd154801	<h2 id="aktivnoe-nachalo-goda-u-turkluba-stankina">Активное начало года у ТурКЛУБа СТАНКИНа</h2>
952dd86e-3b0c-493f-a5f2-585f0d7922e6	db2f4c7a-90d4-434f-9273-f15b7ed1612a	<p>Январь для станковцев был месяцем тренировок и интенсивной подготовки к соревнованиям по поисково-спасательным работам. Кроме этого, команда ТурКЛУБа СТАНКИНа успешно выступила во втором этапе «Нано-Подкуст Рогейна 2025», в Кузьминках, заняв 44 место из 128.<br/><a href="https://vk.cc/cI1X7m" rel="noreferrer noopener" target="_blank">https://vk.cc/cI1X7m</a></p>
f35d0824-6c8b-41a4-aab9-8850f07a25ca	c93fb6be-9715-4d54-a658-b80066e9d355	<h2 id="volonteryi-stankina-posetili-priyut-dlya-bezdomnyih-zhivotnyih">Волонтеры СТАНКИНа посетили приют для бездомных животных</h2>
f6b13458-8192-4b79-89a1-eb0e545ddf00	959dad8c-cebb-44ae-994a-6d19cc74bd56	<p>Ребята приехали в приют не с пустыми руками, они привезли с собой угощения для бездомных животных. Студентам также выпала возможность пообщаться с сотрудниками приюта, которые рассказали, что каждый питомец с надеждой ждет своего любящего хозяина.<br/><a href="https://vk.cc/cI1XhM">https://vk.cc/cI1XhM</a></p>
ff64c922-d9d9-4f60-821e-0fb3fc5266f1	f8375cae-3f76-40eb-a1d1-493736254b0f	<h2 id="predstaviteli-prof-media-na-otkryitii-mediaestafetyi">Представители PROF медиа на открытии Медиаэстафеты</h2>
0bdbdded-0564-44f2-b1d3-c1d1915ad387	777f71e6-bf4f-4d3f-8f54-36bf64b9b88e	<p>Министерство науки и высшего образования России запустило Медиаэстафету «17 ценностей России», которая послужит эффективным средством для продвижения традиционных ценностей России. Наш университет представили Гарифуллина Алина, Тиханова Юлия, Бычкова Екатерина и Власова Виктория.<br/><a href="https://vk.cc/cI2pwA" rel="noreferrer noopener" target="_blank">https://vk.cc/cI2pwA</a></p>
f9cbc4da-19f1-4798-81df-927ae3086c70	8bff5951-b46f-4159-8eb7-19cff0a313f0	<p>Стартовал всероссийский донорский флешмоб Службы крови, в котором студенты вузов и ссузов могут принять участие до 27 января. Участники могут сдать кровь, вступить в регистр доноров и поучаствовать в онлайн-флешмобе, опубликовав фото донации с хештегами.<br/><a href="https://vk.cc/cHEQE8" rel="noreferrer noopener" target="_blank">https://vk.cc/cHEQE8</a></p>
7ebba7fa-4f38-4e68-b9fd-de85b93c9304	61c72c42-e0d4-4c52-96fd-8ce98b60abc7	<h2 id="statya-v-gazete-pro-aspirantov-mgtu-stankin">Статья в газете про аспирантов МГТУ «СТАНКИН»</h2>
d5a7436d-04fc-4aa2-9a4a-6d98c9701194	10ac19e0-1743-4493-bd90-8fbd3192b186	<p>В честь Дня аспиранта газета «Вечерняя Москва» опубликовала статью о вкладе в развитие российской науки аспирантов нашего университета, Даниила Струневича и Андрея Гусева. В материале ребята поделились своими исследованиями и достижениями.<br/><a href="https://vk.cc/cHEQSr" rel="noreferrer noopener" target="_blank">https://vk.cc/cHEQSr</a></p>
0d666863-9c16-4c23-a341-a91182030290	8010f6d0-7318-4656-9c8c-0cca1037d897	<h2 id="zapusk-elektronnoy-platformyi-1s-biblioteka">Запуск электронной платформы  «1С БИБЛИОТЕКА» </h2>
a2f407b2-80ce-4188-b48f-0055b474c015	e3d70d59-91b9-4fe0-9f3b-09fa30ca2b2f	<p>Научно-техническая библиотека СТАНКИНа сообщила о запуске электронной платформы «1С БИБЛИОТЕКА», которая обеспечивает удобный удаленный доступ к учебным материалам. Приложение доступно для скачивания на всех платформах.<br/><a href="https://vk.cc/cHER38" rel="noreferrer noopener" target="_blank">https://vk.cc/cHER38</a></p>
d08d8dcf-ecfe-439f-8853-2f17815c0ce1	b2025e8c-f983-4bed-a7b6-4cda637e7006	<h2 id="student-stankina-zanyal-vtoroe-mesto-na-chempionate-mira">Студент СТАНКИНа занял второе место на Чемпионате мира</h2>
dd5ddec8-43fd-44fc-bf61-699d296d6a04	1692d6d1-0d59-4457-a87a-fc3dd711668d	<p>Александр Максимов завоевал серебро по восточному боевому единоборству Сетокан в категории ката мужчины на Чемпионате мира, который проходил в индийском городе Хайдарабад. А также выполнил норматив Мастера спорта международного класса.<br/><a href="https://vk.cc/cHH30k" rel="noreferrer noopener" target="_blank">https://vk.cc/cHH30k</a></p>
b4b35168-f9dc-4026-a2b3-f796d52baff2	3c4e8720-d2ec-41aa-983b-104acd06aae4	<h2 id="razgovor-s-uchastnikom-programmyi-pish-stankina">Разговор с участником программы ПИШ СТАНКИНа</h2>
55bcf24b-288f-489d-828f-138126c760cf	8e3c64bb-1885-44cd-9bf4-fe123c71cf27	<p>Состоялся разговор с участником программы Передовой инженерной школы магистрантом Владимиром Дегтяревым. Студент рассказал об уникальной возможности, которую предоставляет данная программа и поделился своим опытом.<br/><a href="https://vk.cc/cHHXyj" rel="noreferrer noopener" target="_blank">https://vk.cc/cHHXyj</a></p>
d5b25c71-8b6e-4e34-9f37-89e0570b3c4b	a457cbcf-05e8-4f48-a32a-1650b7b5a1fe	<h2 id="v-stankine-proshel-turnir-po-nastolnomu-tennisu">В СТАНКИНе прошел турнир по настольному теннису</h2>
40422905-6e71-4eaf-909d-445e441b0188	7c96c2b7-500b-48be-850a-bc809d222ce9	<p>В стенах нашего университета прошел турнир по настольному теннису. Около 50 студентов, вооружившись ракетками, сражались за звание лучшего. На протяжении всего турнира ребята демонстрировали свою ловкость, мастерство подачи и точные удары.<br/><a href="https://vk.cc/cHGWPa" rel="noreferrer noopener" target="_blank">https://vk.cc/cHGWPa</a></p>
5423ed9f-8138-489b-96a4-8be7015f2f05	cad5f9c2-3d61-4fdb-869c-635ee0880fbb	<h2 id="stankinovets-stal-prizerom-novogodney-lyizhnoy-gonki">Станкиновец стал призером новогодней лыжной гонки</h2>
2e35c0e0-2802-4f6f-a890-fc15ead17577	60dfbfdd-4de9-4aa3-936e-ad207efcac0e	<p>Константин Пахтышев занял второе место на лыжной гонке «Открытый кубок Объединенного института ядерных исследований», проходившей на стадионе «ЮДЕ-КОН» в Дубне. Константин показал результат 24 минуты 34 секунды в категории «Мужчины 18-29 лет». <br/><a href="https://vk.cc/cHmNK1" rel="noreferrer noopener" target="_blank">https://vk.cc/cHmNK1</a></p>
d0ab5931-3c7f-45c9-9ed9-5f27ba60f6db	9737db2f-9be4-4e8c-b023-e4192dd4383f	<h2 id="otkryita-registratsiya-na-ekskursionnuyu-poezdku">Открыта регистрация на экскурсионную поездку</h2>
9f40ac5a-b900-4e73-86c4-14f5dea7f51a	af6d625f-f5f8-43f7-b046-167f4d6c388a	<p>Патриотический клуб МГТУ «СТАНКИН» объявил о старте регистрации на экскурсионную однодневную поездку по Городам воинской славы. Поездка, которая позволит вам не только узнать больше о героическом прошлом нашей страны, но и вдохновиться ее величием.<br/><a href="https://vk.cc/cHm8BB" rel="noreferrer noopener" target="_blank">https://vk.cc/cHm8BB</a></p>
947eb1d1-4538-47f5-a740-f2fe20b98814	f96171cd-072d-41e3-9aa5-2ea2ab709589	<h2 id="stankin-v-top-m-reytinga-minobrnauki-rossii">СТАНКИН в ТОП М-рейтинга Минобрнауки России</h2>
d72392bf-ecd1-40df-98d7-c443a50aa336	4f39e0e1-c244-4993-b322-02312c4f879a	<p>Рейтинг медийной активности вузов — M-RATE — единственный официальный рейтинг российских вузов, подведомственных Минобрнауки России. В декабре 2024 года в рейтинге медийной активности вузов наш университет вошел в ТОП-20 и ТОП-50 сразу по двум социальным сетям!<br/><a href="https://vk.cc/cHm80a" rel="noreferrer noopener" target="_blank">https://vk.cc/cHm80a</a></p>
2f599e79-da9d-4e13-97d6-f9bf3f873139	d743716a-9e64-4212-888c-01b180b87982	<h2 id="priemnaya-komissiya-stankina-zapustila-seriyu-podkastov">Приемная комиссия СТАНКИНа запустила серию подкастов</h2>
af8df311-3417-42bd-b03e-f09f0ffc4b10	25acecb6-1ee5-4181-8667-7a01a1cd68d5	<p><a href="https://vk.com/stankinabitur" rel="noreferrer noopener" target="_blank">Приемная комиссия МГТУ «СТАНКИН»</a> представила серию подкастов, разработанных для абитуриентов. Подкасты помогут разобраться в многообразии направлений обучения университета и сделать осознанный выбор специальности.<br/><a href="https://vk.cc/cHmOb5" rel="noreferrer noopener" target="_blank">https://vk.cc/cHmOb5</a></p>
3f8ffbc6-ea82-41d0-8b6f-5ddd2cdd264a	7e4942a9-2369-4007-a2b3-86df14a25408	<h2 id="strategicheskaya-sessiya-razvitie-sistemyi-obrazovaniya-v-rf-do-2040-goda">Стратегическая сессия «Развитие системы образования в РФ до 2040 года»</h2>
b84c4eb5-b792-4188-b92d-a1f96e385741	33bb9529-279b-4a9c-b3d9-0cc1cbd6b0cd	<p>В Национальном центре «Россия» проходит Стратегическая сессия с участием представителей власти, проректоров вузов и других специалистов, которые в течение дня в группах будут работать над Стратегией развития образования до 2040 года.<br/><a href="https://vk.cc/cHmIib" rel="noreferrer noopener" target="_blank">https://vk.cc/cHmIib</a></p>
8e41f698-82cc-428b-9368-cdf6da054b11	3dd10df2-2217-4e81-b1c5-3e036cf2ee1c	<h2 id="otkryita-registratsiya-na-turnir-kibersport-dlya-vseh-v-chest-dnya-studenta">Открыта регистрация на турнир «Киберспорт для всех» в честь Дня студента</h2>
19331da2-9020-4b4f-a2b4-2c0a3fec7e7c	ca416956-7a54-419c-8865-c5ab67828718	<p>Киберцентр СТАНКИНа открыл регистрацию на отборочный турнир 1×1 для всех киберспортсменов. Это не просто шанс, а уникальная возможность проявить себя и побороться за победу! А Участие — это не только путь к первому месту, это еще и бесценный опыт.<br/><a href="https://vk.cc/cHmjL5" rel="noreferrer noopener" target="_blank">https://vk.cc/cHmjL5</a></p>
0894ef60-5fbd-44c3-8ee5-597a9def495b	61ec1b40-b71c-4ef1-b357-26eda69a3416	<h2 id="pervyiy-vyipusk-podkasta-ot-hokkeistov-nashey-sbornoy">Первый выпуск подкаста от хоккеистов нашей сборной</h2>
796db243-25bb-44ff-8a76-8ce258e17b8c	abc44ec4-9a06-4586-9c62-673ce7ecf735	<p>Вышел первый выпуск подкаста про наших студентов из сборной по хоккею МГТУ «СТАНКИН». В новом выпуске Михаил Богданов, Глеб Малышев и Константин Кольцов ответили на блиц-вопросы, поделились советами и хорошим настроением!<br/><a href="https://vk.cc/cGQYmD">https://vk.cc/cGQYmD</a></p>
9e3a1de9-d98f-4095-8275-9e0c1d4b1995	e1fbf264-819b-4086-acf9-19af36051b01	<h2 id="o-teorii-mertvogo-interneta-rasskazali-v-nos"><strong class="">О теории мертвого интернета</strong> рассказали в НОС</h2>
90567cec-a291-4aa1-9e73-2e86a3d5db28	bff53c7d-fd09-481f-8475-951251804ed6	<p>Сообщество «НОС: наука, образование, студенчество» опубликовало статью на тему теории мертвого интернета. Как возникла теория, основные аргументы сторонников и критиков этой теории, а также про ИИ в соцсетях и на других площадках можно узнать из этой статьи.<br/><a href="https://vk.cc/cGZfnY">https://vk.cc/cGZfnY</a></p>
404d80df-3a53-44b1-938b-3fa6107f0546	916aa74e-0568-4c02-bda2-04f2de817b77	<h2 id="pervyiy-den-yanvarskoy-sessii-v-stankine">Первый день январской сессии в СТАНКИНе</h2>
1567c0ae-f735-4656-9e36-c635cea1a235	791b86c4-d876-4f55-b933-f4d889d070bb	<p>Сессия — это не просто экзамены, это возможность продемонстрировать все, чему вы научились за семестр. Первый день сессии может быть немного волнительным, но помните, что вы усердно трудились весь семестр и обязательно справитесь со всеми испытаниями!<br/><a href="https://vk.cc/cH44nY">https://vk.cc/cH44nY</a></p>
298ec110-7c42-4025-b0bc-d9e6899486d9	d7085001-9ff0-49a6-8013-eef8f9ca51a5	<h2 id="novyiy-vyipusk-podkasta-ot-rosmolodezh">Новый выпуск подкаста от Росмолодежь</h2>
56515d51-7cba-4033-baad-d98b9dd9ef32	48491e10-5542-4b13-b0f7-68a3345b7fce	<p>Героем нового подкаста «Больше, чем успех» от «Росмолодежь.Бизнес» и «Росмолодежь.Карьера» стал Михаил Гребенюк, основатель консалтинговой компании Resulting и автор благотворительного проекта для школьников «Поколение».<br/><a href="https://vk.cc/cH4wLc">https://vk.cc/cH4wLc</a></p>
d6e3217c-6280-48eb-870d-1fbecdf13668	79275d78-6612-45af-b116-4359840b8bab	<p>Проект «Нетемные века» опровергает стереотипы о величии Античности и упадке Средневековья. Он показывает, что слепая вера в классику ведет к застою, а наследие средневековья, наоборот, помогает найти ответы на современные вызовы.<br><br><strong><em>Когда:</em>&nbsp;</strong>пн-вс, 11:00-22:00<br><strong><em>Где:</em></strong>&nbsp;Болотная набережная, 15<br><strong><em>Вход свободный</em></strong><br><a target="_blank" rel="noopener noreferrer nofollow" href="https://vk.cc/cRjc1t">https://vk.cc/cRjc1t</a></p>
e2a75a35-326d-4138-82e5-5217ad46bdaf	eaa2e8c9-abd8-49ca-90f3-d46253a23ae2	<p>Да-да, это суперпроверка, где комики расскажут не только новый, но и лучший материал! на сцене выступят известные участники шоу «Comedy баттл», «Открытый микрофон», «Женский стендап на ТНТ» и «StandUp на ТНТ». Не упусти свой шанс провести вечер в атмосфере юмора!</p><p><strong><em>Когда:&nbsp;</em></strong>28 октября, 19:15<strong><em><br>Где:&nbsp;</em></strong>Покровка, 16<br><strong><em>Стоимость:&nbsp;</em></strong>от 500 рублей<br><a target="_blank" rel="noreferrer noopener" href="https://vk.com/away.php?to=https%3A%2F%2Fafisha.yandex.ru%2Fmoscow%2Fstandup%2Fsuperproverka-komikov-s-tv-standup-crew-ru%3Fsource%3Drubric%26schedule-date%3D2024-01-29&amp;cc_key=cuc7bl">https://vk.cc/cuc7bl</a></p>
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.users (user_id, "group", professor, news_subscription, subgroup) FROM stdin;
744416726	ИДБ-22-10	Чеканин В.А.	f	А
\.


--
-- Name: aerich_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.aerich_id_seq', 4, true);


--
-- Name: aerich aerich_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.aerich
    ADD CONSTRAINT aerich_pkey PRIMARY KEY (id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: article_categories article_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.article_categories
    ADD CONSTRAINT article_categories_pkey PRIMARY KEY (article_id, category_id);


--
-- Name: article_views article_views_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.article_views
    ADD CONSTRAINT article_views_pkey PRIMARY KEY (id);


--
-- Name: articles articles_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: blocks blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (id);


--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: image_collection_blocks image_collection_blocks_block_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.image_collection_blocks
    ADD CONSTRAINT image_collection_blocks_block_id_key UNIQUE (block_id);


--
-- Name: image_collection_blocks image_collection_blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.image_collection_blocks
    ADD CONSTRAINT image_collection_blocks_pkey PRIMARY KEY (id);


--
-- Name: text_blocks text_blocks_block_id_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.text_blocks
    ADD CONSTRAINT text_blocks_block_id_key UNIQUE (block_id);


--
-- Name: text_blocks text_blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.text_blocks
    ADD CONSTRAINT text_blocks_pkey PRIMARY KEY (id);


--
-- Name: blocks unique_article_block_order; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.blocks
    ADD CONSTRAINT unique_article_block_order UNIQUE (article_id, "order");


--
-- Name: article_views unique_article_ip; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.article_views
    ADD CONSTRAINT unique_article_ip UNIQUE (article_id, ip_address, user_agent);


--
-- Name: articles uq_articles_slug; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT uq_articles_slug UNIQUE (slug);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: article_views article_views_article_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.article_views
    ADD CONSTRAINT article_views_article_id_fkey FOREIGN KEY (article_id) REFERENCES public.articles(id) ON DELETE CASCADE;


--
-- Name: blocks blocks_article_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.blocks
    ADD CONSTRAINT blocks_article_id_foreign FOREIGN KEY (article_id) REFERENCES public.articles(id) ON DELETE CASCADE;


--
-- Name: article_categories fk_article_categories_article_id_articles; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.article_categories
    ADD CONSTRAINT fk_article_categories_article_id_articles FOREIGN KEY (article_id) REFERENCES public.articles(id) ON DELETE CASCADE;


--
-- Name: article_categories fk_article_categories_category_id_categories; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.article_categories
    ADD CONSTRAINT fk_article_categories_category_id_categories FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: image_collection_blocks image_collection_blocks_block_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.image_collection_blocks
    ADD CONSTRAINT image_collection_blocks_block_id_foreign FOREIGN KEY (block_id) REFERENCES public.blocks(id) ON DELETE CASCADE;


--
-- Name: text_blocks text_blocks_block_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.text_blocks
    ADD CONSTRAINT text_blocks_block_id_foreign FOREIGN KEY (block_id) REFERENCES public.blocks(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict KW0doN1zSjkNguNtXf7CqUJrf5Icut9Xu6HbpnHDGZoiU22geweTELpi2XCtoW1

