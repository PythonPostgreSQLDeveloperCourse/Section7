CREATE TABLE public.videos(
id integer,
user_id integer REFERENCES public.users,
name character varying(255) NOT NULL,
CONSTRAINT videos_id_pkey PRIMARY KEY (id))