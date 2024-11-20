BEGIN;


CREATE TABLE IF NOT EXISTS public.google_movie_streaming
(
    google_service_id character varying COLLATE pg_catalog."default" NOT NULL,
    price character varying COLLATE pg_catalog."default" NOT NULL,
    title character varying COLLATE pg_catalog."default",
    imdb_id character varying COLLATE pg_catalog."default"
);

CREATE TABLE IF NOT EXISTS public.google_streaming_service
(
    service_id character varying COLLATE pg_catalog."default" NOT NULL,
    service_name character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT google_streaming_service_pkey PRIMARY KEY (service_id)
);

CREATE TABLE IF NOT EXISTS public.movie
(
    imdb_id character varying COLLATE pg_catalog."default" NOT NULL,
    imdb_rank integer NOT NULL,
    title character varying COLLATE pg_catalog."default" NOT NULL,
    year integer NOT NULL,
    runtime numeric NOT NULL,
    rated character varying COLLATE pg_catalog."default" NOT NULL,
    imdb_rating numeric NOT NULL,
    CONSTRAINT movie_pkey PRIMARY KEY (imdb_id),
    CONSTRAINT title_unique UNIQUE (title)
);

CREATE TABLE IF NOT EXISTS public.movie_actor
(
    imdb_id character varying COLLATE pg_catalog."default" NOT NULL,
    actor character varying COLLATE pg_catalog."default" NOT NULL
);

CREATE TABLE IF NOT EXISTS public.movie_director
(
    imdb_id character varying COLLATE pg_catalog."default" NOT NULL,
    director character varying COLLATE pg_catalog."default" NOT NULL
);

CREATE TABLE IF NOT EXISTS public.netflix_movie
(
    netflix_id integer NOT NULL,
    imdb_id character varying COLLATE pg_catalog."default" NOT NULL,
    title character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT netflix_movie_pkey PRIMARY KEY (netflix_id)
);

CREATE TABLE IF NOT EXISTS public.top_imdb
(
    imdb_id character varying COLLATE pg_catalog."default" NOT NULL,
    title character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT top_imdb_pkey PRIMARY KEY (imdb_id)
);

CREATE TABLE IF NOT EXISTS public.utelly_movie_streaming
(
    imdb_id character varying COLLATE pg_catalog."default" NOT NULL,
    service_id character varying COLLATE pg_catalog."default" NOT NULL
);

CREATE TABLE IF NOT EXISTS public.utelly_streaming_service
(
    service_id character varying COLLATE pg_catalog."default" NOT NULL,
    service_name character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT streaming_service_pkey PRIMARY KEY (service_id)
);

ALTER TABLE IF EXISTS public.google_movie_streaming
    ADD CONSTRAINT google_movie_streaming_imdb_id_fkey FOREIGN KEY (imdb_id)
    REFERENCES public.top_imdb (imdb_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.google_movie_streaming
    ADD CONSTRAINT google_movie_streaming_service_id_fkey FOREIGN KEY (google_service_id)
    REFERENCES public.google_streaming_service (service_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.movie
    ADD CONSTRAINT movie_imdb_id_fkey FOREIGN KEY (imdb_id)
    REFERENCES public.top_imdb (imdb_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
CREATE INDEX IF NOT EXISTS movie_pkey
    ON public.movie(imdb_id);


ALTER TABLE IF EXISTS public.movie_actor
    ADD CONSTRAINT movie_actor_imdb_id_fkey FOREIGN KEY (imdb_id)
    REFERENCES public.top_imdb (imdb_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.movie_director
    ADD CONSTRAINT movie_director_imdb_id_fkey FOREIGN KEY (imdb_id)
    REFERENCES public.top_imdb (imdb_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.netflix_movie
    ADD CONSTRAINT netflix_movie_imdb_id_fkey FOREIGN KEY (imdb_id)
    REFERENCES public.top_imdb (imdb_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.utelly_movie_streaming
    ADD CONSTRAINT utelly_movie_streaming_imdb_id_fkey FOREIGN KEY (imdb_id)
    REFERENCES public.top_imdb (imdb_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.utelly_movie_streaming
    ADD CONSTRAINT utelly_movie_streaming_service_id_fkey FOREIGN KEY (service_id)
    REFERENCES public.utelly_streaming_service (service_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;