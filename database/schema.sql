-- =============================================================
--  CINESIC — Cinema & Music Information System
--  schema.sql  |  Complete Database Schema  |  24 Tables
--  Department of Information Science & Engineering
--  National Institute of Engineering, Mysuru
--  Authors : Shreyash Dwivedi (4NI24IS196)
--            Srushthi M S     (4NI24IS206)
-- =============================================================

DROP DATABASE IF EXISTS cinesic;
CREATE DATABASE cinesic
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE cinesic;

-- =============================================================
--  DOMAIN 1 : METADATA  (lookup / reference tables)
--  Tables : languages, countries, certificates,
--           genres, streaming_platforms
-- =============================================================

-- -------------------------------------------------------------
--  1. languages
-- -------------------------------------------------------------
CREATE TABLE languages (
  language_id    TINYINT UNSIGNED  PRIMARY KEY AUTO_INCREMENT,
  language_name  VARCHAR(100)      NOT NULL,
  language_code  CHAR(5)           NOT NULL UNIQUE,   -- ISO 639-1  e.g. 'hi', 'en', 'ta'
  script         VARCHAR(60),                          -- Devanagari, Latin …
  region         VARCHAR(100),
  is_indian      BOOLEAN           DEFAULT FALSE
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  2. countries
-- -------------------------------------------------------------
CREATE TABLE countries (
  country_id    SMALLINT UNSIGNED  PRIMARY KEY AUTO_INCREMENT,
  country_name  VARCHAR(100)       NOT NULL,
  country_code  CHAR(3)            NOT NULL UNIQUE,   -- ISO 3166-1 alpha-3
  continent     ENUM('Asia','Europe','North America','South America',
                     'Africa','Oceania','Antarctica') NOT NULL,
  currency_code CHAR(3),                              -- INR, USD, GBP …
  is_major_film_market BOOLEAN     DEFAULT FALSE
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  3. certificates  (content rating boards)
-- -------------------------------------------------------------
CREATE TABLE certificates (
  certificate_id   TINYINT UNSIGNED  PRIMARY KEY AUTO_INCREMENT,
  certificate_code VARCHAR(10)       NOT NULL,         -- U, UA, A, PG-13, R …
  board            VARCHAR(60)       NOT NULL,         -- CBFC, MPAA, BBFC …
  country_id       SMALLINT UNSIGNED,
  minimum_age      TINYINT UNSIGNED  DEFAULT 0,
  description      VARCHAR(300),
  FOREIGN KEY (country_id) REFERENCES countries(country_id)
    ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  4. genres  (shared by movies AND music)
-- -------------------------------------------------------------
CREATE TABLE genres (
  genre_id    SMALLINT UNSIGNED  PRIMARY KEY AUTO_INCREMENT,
  genre_name  VARCHAR(80)        NOT NULL UNIQUE,
  genre_type  ENUM('Film','Music','Both') NOT NULL DEFAULT 'Both',
  parent_id   SMALLINT UNSIGNED  DEFAULT NULL,          -- for sub-genres
  description TEXT,
  FOREIGN KEY (parent_id) REFERENCES genres(genre_id)
    ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  5. streaming_platforms
-- -------------------------------------------------------------
CREATE TABLE streaming_platforms (
  platform_id      TINYINT UNSIGNED  PRIMARY KEY AUTO_INCREMENT,
  platform_name    VARCHAR(100)      NOT NULL UNIQUE,
  platform_type    ENUM('Video','Music','Both') NOT NULL,
  hq_country_id    SMALLINT UNSIGNED,
  monthly_users_m  DECIMAL(6,1),                         -- millions
  founded_year     SMALLINT UNSIGNED,
  website          VARCHAR(200),
  has_4k           BOOLEAN           DEFAULT FALSE,
  has_dolby        BOOLEAN           DEFAULT FALSE,
  is_subscription  BOOLEAN           DEFAULT TRUE,
  FOREIGN KEY (hq_country_id) REFERENCES countries(country_id)
    ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

-- =============================================================
--  DOMAIN 2 : PEOPLE
--  Tables : persons, directors, composers, producers,
--           production_houses
-- =============================================================

-- -------------------------------------------------------------
--  6. production_houses
-- -------------------------------------------------------------
CREATE TABLE production_houses (
  house_id        SMALLINT UNSIGNED  PRIMARY KEY AUTO_INCREMENT,
  house_name      VARCHAR(200)       NOT NULL,
  country_id      SMALLINT UNSIGNED,
  founded_year    SMALLINT UNSIGNED,
  founder_name    VARCHAR(200),
  hq_city         VARCHAR(100),
  total_films     SMALLINT UNSIGNED  DEFAULT 0,
  total_gross_usd BIGINT UNSIGNED    DEFAULT 0,
  is_active       BOOLEAN            DEFAULT TRUE,
  website         VARCHAR(200),
  FOREIGN KEY (country_id) REFERENCES countries(country_id)
    ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  7. persons  (universal hub for ALL people)
-- -------------------------------------------------------------
CREATE TABLE persons (
  person_id          INT UNSIGNED       PRIMARY KEY AUTO_INCREMENT,
  full_name          VARCHAR(255)       NOT NULL,
  birth_name         VARCHAR(255),
  date_of_birth      DATE,
  date_of_death      DATE               DEFAULT NULL,
  birthplace         VARCHAR(300),
  nationality        VARCHAR(100),
  gender             ENUM('Male','Female','Non-binary','Undisclosed') DEFAULT 'Undisclosed',
  height_cm          SMALLINT UNSIGNED,

  -- Role flags  (one person can hold multiple roles)
  is_actor           BOOLEAN            DEFAULT FALSE,
  is_actress         BOOLEAN            DEFAULT FALSE,
  is_director        BOOLEAN            DEFAULT FALSE,
  is_producer        BOOLEAN            DEFAULT FALSE,
  is_composer        BOOLEAN            DEFAULT FALSE,
  is_singer          BOOLEAN            DEFAULT FALSE,
  is_lyricist        BOOLEAN            DEFAULT FALSE,
  is_cinematographer BOOLEAN            DEFAULT FALSE,
  is_editor          BOOLEAN            DEFAULT FALSE,

  -- Career
  career_start_year  SMALLINT UNSIGNED,
  debut_film_id      INT UNSIGNED       DEFAULT NULL,   -- FK added after movies table
  total_movies       SMALLINT UNSIGNED  DEFAULT 0,
  total_awards_won   SMALLINT UNSIGNED  DEFAULT 0,
  avg_imdb_rating    DECIMAL(3,1)       DEFAULT NULL,   -- computed / updated via trigger

  -- Online presence
  imdb_id            VARCHAR(20),
  instagram_handle   VARCHAR(100),
  twitter_handle     VARCHAR(100),
  wikipedia_slug     VARCHAR(200),

  created_at         TIMESTAMP          DEFAULT CURRENT_TIMESTAMP,
  updated_at         TIMESTAMP          DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  8. directors  (extends persons for director-specific stats)
-- -------------------------------------------------------------
CREATE TABLE directors (
  director_id            INT UNSIGNED   PRIMARY KEY,
  signature_style        TEXT,
  preferred_genre_id     SMALLINT UNSIGNED,
  avg_budget_usd         BIGINT UNSIGNED DEFAULT 0,
  avg_worldwide_gross    BIGINT UNSIGNED DEFAULT 0,
  avg_roi_pct            DECIMAL(6,2)   DEFAULT 0.00,
  total_films_directed   SMALLINT       DEFAULT 0,
  highest_grossing_id    INT UNSIGNED   DEFAULT NULL,
  debut_film_id          INT UNSIGNED   DEFAULT NULL,
  awards_won             SMALLINT       DEFAULT 0,
  FOREIGN KEY (director_id)         REFERENCES persons(person_id)  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (preferred_genre_id)  REFERENCES genres(genre_id)    ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  9. composers
-- -------------------------------------------------------------
CREATE TABLE composers (
  composer_id          INT UNSIGNED   PRIMARY KEY,
  musical_style        TEXT,
  instruments          VARCHAR(300),
  total_film_scores    SMALLINT       DEFAULT 0,
  total_albums         SMALLINT       DEFAULT 0,
  grammy_wins          TINYINT        DEFAULT 0,
  avg_album_rating     DECIMAL(3,1)   DEFAULT NULL,
  FOREIGN KEY (composer_id) REFERENCES persons(person_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  10. producers
-- -------------------------------------------------------------
CREATE TABLE producers (
  producer_id      INT UNSIGNED    PRIMARY KEY,
  house_id         SMALLINT UNSIGNED,
  specialty        VARCHAR(200),
  total_films      SMALLINT        DEFAULT 0,
  total_gross_usd  BIGINT UNSIGNED DEFAULT 0,
  FOREIGN KEY (producer_id) REFERENCES persons(person_id)         ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (house_id)    REFERENCES production_houses(house_id) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

-- =============================================================
--  DOMAIN 3 : MOVIES
--  Tables : movies, movie_cast, box_office,
--           movie_genres, movie_awards, movie_reviews,
--           movie_streaming
-- =============================================================

-- -------------------------------------------------------------
--  11. movies  (core film entity — 60+ attributes)
-- -------------------------------------------------------------
CREATE TABLE movies (
  movie_id         INT UNSIGNED      PRIMARY KEY AUTO_INCREMENT,
  title            VARCHAR(255)      NOT NULL,
  original_title   VARCHAR(255),                        -- non-English original title
  tagline          VARCHAR(500),
  synopsis         TEXT,

  -- Release
  release_date     DATE,
  release_year     SMALLINT UNSIGNED NOT NULL,
  runtime_minutes  SMALLINT UNSIGNED,

  -- Classification
  language_id      TINYINT UNSIGNED,
  country_id       SMALLINT UNSIGNED,
  certificate_id   TINYINT UNSIGNED,
  franchise_id     SMALLINT UNSIGNED DEFAULT NULL,       -- FK to franchises (self-ref via separate table)
  sequel_number    TINYINT UNSIGNED  DEFAULT 1,          -- 1 = original, 2 = sequel …
  is_sequel        BOOLEAN           DEFAULT FALSE,

  -- Key people (many-to-one)
  director_id      INT UNSIGNED,
  studio_id        SMALLINT UNSIGNED,

  -- Ratings
  imdb_rating      DECIMAL(3,1)      DEFAULT NULL,
  imdb_votes       INT UNSIGNED      DEFAULT 0,
  rt_tomatometer   TINYINT UNSIGNED  DEFAULT NULL,       -- 0-100
  rt_audience      TINYINT UNSIGNED  DEFAULT NULL,       -- 0-100
  metacritic_score TINYINT UNSIGNED  DEFAULT NULL,       -- 0-100
  letterboxd_avg   DECIMAL(3,2)      DEFAULT NULL,       -- 0.00-5.00
  cinesic_rating   DECIMAL(3,1)      DEFAULT NULL,

  -- Box-office club flags (auto-set via trigger)
  is_100cr_club    BOOLEAN           DEFAULT FALSE,
  is_200cr_club    BOOLEAN           DEFAULT FALSE,
  is_300cr_club    BOOLEAN           DEFAULT FALSE,
  is_500cr_club    BOOLEAN           DEFAULT FALSE,
  is_1000cr_club   BOOLEAN           DEFAULT FALSE,
  is_billion_usd   BOOLEAN           DEFAULT FALSE,

  -- Technical
  aspect_ratio     VARCHAR(20),
  color_format     ENUM('Color','Black & White','Colorized') DEFAULT 'Color',
  sound_format     VARCHAR(100),
  is_3d            BOOLEAN           DEFAULT FALSE,
  is_imax          BOOLEAN           DEFAULT FALSE,
  is_4dx           BOOLEAN           DEFAULT FALSE,
  is_dolby_cinema  BOOLEAN           DEFAULT FALSE,

  -- Streaming
  digital_release_date  DATE         DEFAULT NULL,
  theatrical_weeks      TINYINT UNSIGNED DEFAULT NULL,

  -- Misc
  filming_locations     TEXT,
  production_notes      TEXT,

  created_at  TIMESTAMP  DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP  DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  FOREIGN KEY (language_id)    REFERENCES languages(language_id)               ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (country_id)     REFERENCES countries(country_id)                ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (certificate_id) REFERENCES certificates(certificate_id)         ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (director_id)    REFERENCES persons(person_id)                   ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (studio_id)      REFERENCES production_houses(house_id)          ON UPDATE CASCADE ON DELETE SET NULL,

  INDEX idx_movies_year      (release_year),
  INDEX idx_movies_imdb      (imdb_rating),
  INDEX idx_movies_director  (director_id),
  FULLTEXT INDEX ft_movie_search (title, synopsis)
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  12. movie_cast  (M:N  movies ↔ persons)
-- -------------------------------------------------------------
CREATE TABLE movie_cast (
  cast_id            INT UNSIGNED    PRIMARY KEY AUTO_INCREMENT,
  movie_id           INT UNSIGNED    NOT NULL,
  person_id          INT UNSIGNED    NOT NULL,
  character_name     VARCHAR(255),
  role_type          ENUM('Lead Actor','Lead Actress','Supporting Actor',
                          'Supporting Actress','Cameo','Voice',
                          'Child Artist','Item Number') NOT NULL,
  billing_order      TINYINT UNSIGNED DEFAULT 99,        -- 1 = top-billed
  screen_time_min    SMALLINT UNSIGNED DEFAULT NULL,
  is_protagonist     BOOLEAN          DEFAULT FALSE,
  is_antagonist      BOOLEAN          DEFAULT FALSE,
  award_nominated    BOOLEAN          DEFAULT FALSE,     -- nominated for this specific role

  UNIQUE KEY uq_cast (movie_id, person_id, role_type),
  FOREIGN KEY (movie_id)  REFERENCES movies(movie_id)  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES persons(person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  INDEX idx_cast_person (person_id),
  INDEX idx_cast_movie  (movie_id)
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  13. box_office  (1:1 with movies — financial deep-dive)
-- -------------------------------------------------------------
CREATE TABLE box_office (
  bo_id                  INT UNSIGNED    PRIMARY KEY AUTO_INCREMENT,
  movie_id               INT UNSIGNED    NOT NULL UNIQUE,

  -- Costs (USD)
  budget_usd             BIGINT UNSIGNED DEFAULT 0,
  production_cost_usd    BIGINT UNSIGNED DEFAULT 0,
  marketing_cost_usd     BIGINT UNSIGNED DEFAULT 0,
  distribution_cost_usd  BIGINT UNSIGNED DEFAULT 0,
  total_cost_usd         BIGINT UNSIGNED DEFAULT 0,

  -- Collections (USD)
  opening_day_usd        BIGINT UNSIGNED DEFAULT 0,
  opening_weekend_usd    BIGINT UNSIGNED DEFAULT 0,
  domestic_gross_usd     BIGINT UNSIGNED DEFAULT 0,
  overseas_gross_usd     BIGINT UNSIGNED DEFAULT 0,
  worldwide_gross_usd    BIGINT UNSIGNED DEFAULT 0,

  -- Rights revenue (USD)
  ott_deal_usd           BIGINT UNSIGNED DEFAULT 0,
  satellite_rights_usd   BIGINT UNSIGNED DEFAULT 0,
  music_rights_usd       BIGINT UNSIGNED DEFAULT 0,
  total_revenue_usd      BIGINT UNSIGNED DEFAULT 0,

  -- India-specific (INR crores stored as INTEGER × 100000)
  india_gross_inr        BIGINT UNSIGNED DEFAULT 0,

  -- Key markets (USD)
  us_opening_weekend     BIGINT UNSIGNED DEFAULT 0,
  china_gross_usd        BIGINT UNSIGNED DEFAULT 0,
  uk_gross_usd           BIGINT UNSIGNED DEFAULT 0,

  -- Computed
  profit_loss_usd        BIGINT          DEFAULT 0,      -- signed
  roi_pct                DECIMAL(8,2)    DEFAULT 0.00,
  break_even_weeks       TINYINT UNSIGNED DEFAULT NULL,

  verdict  ENUM('Blockbuster','Super Hit','Hit','Average','Below Average','Flop','Disaster') DEFAULT 'Average',

  FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON UPDATE CASCADE ON DELETE CASCADE,
  INDEX idx_bo_gross (worldwide_gross_usd),
  INDEX idx_bo_roi   (roi_pct)
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  14. movie_genres  (M:N  movies ↔ genres)
-- -------------------------------------------------------------
CREATE TABLE movie_genres (
  movie_id    INT UNSIGNED      NOT NULL,
  genre_id    SMALLINT UNSIGNED NOT NULL,
  is_primary  BOOLEAN           DEFAULT FALSE,
  PRIMARY KEY (movie_id, genre_id),
  FOREIGN KEY (movie_id)  REFERENCES movies(movie_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (genre_id)  REFERENCES genres(genre_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  15. movie_awards
-- -------------------------------------------------------------
CREATE TABLE movie_awards (
  award_id       INT UNSIGNED     PRIMARY KEY AUTO_INCREMENT,
  movie_id       INT UNSIGNED     NOT NULL,
  person_id      INT UNSIGNED     DEFAULT NULL,           -- NULL = film-level award
  award_body     VARCHAR(120)     NOT NULL,               -- Academy Awards, BAFTA, Filmfare …
  award_category VARCHAR(200)     NOT NULL,               -- Best Picture, Best Director …
  award_name     VARCHAR(200),                            -- specific trophy name
  ceremony_year  SMALLINT UNSIGNED NOT NULL,
  result         ENUM('Won','Nominated') NOT NULL,
  prestige_tier  TINYINT UNSIGNED  DEFAULT 3,             -- 1=Oscar, 2=BAFTA/GG, 3=National, 4=Regional

  FOREIGN KEY (movie_id)  REFERENCES movies(movie_id)   ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES persons(person_id) ON UPDATE CASCADE ON DELETE SET NULL,
  INDEX idx_awards_movie  (movie_id),
  INDEX idx_awards_person (person_id),
  INDEX idx_awards_result (result)
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  16. movie_reviews
-- -------------------------------------------------------------
CREATE TABLE movie_reviews (
  review_id      INT UNSIGNED     PRIMARY KEY AUTO_INCREMENT,
  movie_id       INT UNSIGNED     NOT NULL,
  reviewer_name  VARCHAR(200)     NOT NULL,
  publication    VARCHAR(200),
  review_type    ENUM('Critic','Audience','Industry') NOT NULL DEFAULT 'Critic',
  rating         DECIMAL(4,1)     NOT NULL,
  rating_scale   TINYINT UNSIGNED DEFAULT 10,             -- rating out of this value
  headline       VARCHAR(500),
  review_text    TEXT,
  sentiment      ENUM('Positive','Mixed','Negative'),
  review_date    DATE,
  helpful_votes  INT UNSIGNED     DEFAULT 0,

  FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON UPDATE CASCADE ON DELETE CASCADE,
  INDEX idx_mrev_movie (movie_id)
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  17. movie_streaming  (M:N  movies ↔ streaming_platforms)
-- -------------------------------------------------------------
CREATE TABLE movie_streaming (
  ms_id            INT UNSIGNED    PRIMARY KEY AUTO_INCREMENT,
  movie_id         INT UNSIGNED    NOT NULL,
  platform_id      TINYINT UNSIGNED NOT NULL,
  available_from   DATE,
  available_till   DATE            DEFAULT NULL,           -- NULL = indefinite
  stream_quality   SET('SD','HD','FHD','4K','HDR','Dolby Vision','Atmos'),
  is_exclusive     BOOLEAN         DEFAULT FALSE,
  region_available VARCHAR(300),                           -- comma-separated country codes

  UNIQUE KEY uq_movie_platform (movie_id, platform_id),
  FOREIGN KEY (movie_id)    REFERENCES movies(movie_id)             ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (platform_id) REFERENCES streaming_platforms(platform_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- =============================================================
--  DOMAIN 4 : MUSIC
--  Tables : music_labels, albums, tracks,
--           track_singers, music_genres, music_awards,
--           album_reviews, music_streaming
-- =============================================================

-- -------------------------------------------------------------
--  18. music_labels
-- -------------------------------------------------------------
CREATE TABLE music_labels (
  label_id      SMALLINT UNSIGNED  PRIMARY KEY AUTO_INCREMENT,
  label_name    VARCHAR(200)       NOT NULL UNIQUE,
  country_id    SMALLINT UNSIGNED,
  founded_year  SMALLINT UNSIGNED,
  is_major      BOOLEAN            DEFAULT FALSE,          -- Big-4 / indie
  FOREIGN KEY (country_id) REFERENCES countries(country_id) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  19. albums  (core music entity — 50+ attributes)
-- -------------------------------------------------------------
CREATE TABLE albums (
  album_id         INT UNSIGNED      PRIMARY KEY AUTO_INCREMENT,
  album_name       VARCHAR(255)      NOT NULL,
  album_type       ENUM('Film Soundtrack','Original Score','Studio Album',
                        'Live Album','Compilation','EP','Single') NOT NULL,

  -- Link to movie (NULL for standalone)
  movie_id         INT UNSIGNED      DEFAULT NULL,

  -- Key people
  composer_id      INT UNSIGNED      DEFAULT NULL,
  label_id         SMALLINT UNSIGNED DEFAULT NULL,

  -- Release
  release_date     DATE,
  release_year     SMALLINT UNSIGNED,

  -- Tracks
  total_tracks     TINYINT UNSIGNED  DEFAULT 0,
  total_duration_s INT UNSIGNED      DEFAULT 0,            -- total album length in seconds

  -- Streaming numbers
  spotify_streams      BIGINT UNSIGNED DEFAULT 0,
  apple_music_plays    BIGINT UNSIGNED DEFAULT 0,
  youtube_views        BIGINT UNSIGNED DEFAULT 0,
  jiosaavn_plays       BIGINT UNSIGNED DEFAULT 0,
  gaana_plays          BIGINT UNSIGNED DEFAULT 0,

  -- Charts
  peak_chart_position  TINYINT UNSIGNED DEFAULT NULL,
  weeks_on_chart       SMALLINT UNSIGNED DEFAULT 0,
  certified_copies_sold BIGINT UNSIGNED DEFAULT 0,

  -- Ratings
  allmusic_rating      DECIMAL(3,1)    DEFAULT NULL,
  pitchfork_score      DECIMAL(3,1)    DEFAULT NULL,
  cinesic_music_rating DECIMAL(3,1)    DEFAULT NULL,

  -- Production
  recording_studio     VARCHAR(200),
  mixing_engineer      VARCHAR(200),
  mastering_engineer   VARCHAR(200),
  language_id          TINYINT UNSIGNED,
  country_id           SMALLINT UNSIGNED,

  created_at  TIMESTAMP  DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (movie_id)    REFERENCES movies(movie_id)       ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (composer_id) REFERENCES persons(person_id)     ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (label_id)    REFERENCES music_labels(label_id) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (language_id) REFERENCES languages(language_id) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (country_id)  REFERENCES countries(country_id)  ON UPDATE CASCADE ON DELETE SET NULL,

  INDEX idx_albums_movie    (movie_id),
  INDEX idx_albums_composer (composer_id),
  FULLTEXT INDEX ft_album_search (album_name)
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  20. tracks
-- -------------------------------------------------------------
CREATE TABLE tracks (
  track_id          INT UNSIGNED     PRIMARY KEY AUTO_INCREMENT,
  album_id          INT UNSIGNED     NOT NULL,
  track_number      TINYINT UNSIGNED DEFAULT 1,
  track_title       VARCHAR(255)     NOT NULL,
  duration_seconds  SMALLINT UNSIGNED DEFAULT 0,
  bpm               SMALLINT UNSIGNED DEFAULT NULL,
  musical_key       VARCHAR(15)      DEFAULT NULL,          -- e.g. 'C Major', 'A Minor'
  time_signature    VARCHAR(10)      DEFAULT '4/4',
  mood              SET('Happy','Sad','Romantic','Intense',
                        'Melancholic','Energetic','Devotional',
                        'Patriotic','Peppy','Soulful'),
  lyricist_id       INT UNSIGNED     DEFAULT NULL,
  is_title_track    BOOLEAN          DEFAULT FALSE,
  is_single         BOOLEAN          DEFAULT FALSE,
  spotify_streams   BIGINT UNSIGNED  DEFAULT 0,
  youtube_views     BIGINT UNSIGNED  DEFAULT 0,
  spotify_track_id  VARCHAR(100)     DEFAULT NULL,
  youtube_video_id  VARCHAR(20)      DEFAULT NULL,

  FOREIGN KEY (album_id)    REFERENCES albums(album_id)      ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (lyricist_id) REFERENCES persons(person_id)    ON UPDATE CASCADE ON DELETE SET NULL,
  INDEX idx_tracks_album (album_id),
  FULLTEXT INDEX ft_track_search (track_title)
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  21. track_singers  (M:N  tracks ↔ persons)
-- -------------------------------------------------------------
CREATE TABLE track_singers (
  track_id    INT UNSIGNED  NOT NULL,
  person_id   INT UNSIGNED  NOT NULL,
  singer_role ENUM('Lead','Duet Partner','Chorus','Background','Featured') DEFAULT 'Lead',
  PRIMARY KEY (track_id, person_id),
  FOREIGN KEY (track_id)  REFERENCES tracks(track_id)   ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES persons(person_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  22. music_genres  (M:N  albums ↔ genres)
-- -------------------------------------------------------------
CREATE TABLE music_genres (
  album_id    INT UNSIGNED      NOT NULL,
  genre_id    SMALLINT UNSIGNED NOT NULL,
  is_primary  BOOLEAN           DEFAULT FALSE,
  PRIMARY KEY (album_id, genre_id),
  FOREIGN KEY (album_id)  REFERENCES albums(album_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (genre_id)  REFERENCES genres(genre_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  23. music_awards
-- -------------------------------------------------------------
CREATE TABLE music_awards (
  award_id       INT UNSIGNED     PRIMARY KEY AUTO_INCREMENT,
  album_id       INT UNSIGNED     DEFAULT NULL,
  track_id       INT UNSIGNED     DEFAULT NULL,
  person_id      INT UNSIGNED     DEFAULT NULL,
  award_body     VARCHAR(120)     NOT NULL,               -- Grammy, Billboard, MTV EMA …
  award_category VARCHAR(200)     NOT NULL,
  ceremony_year  SMALLINT UNSIGNED NOT NULL,
  result         ENUM('Won','Nominated') NOT NULL,
  prestige_tier  TINYINT UNSIGNED  DEFAULT 3,

  FOREIGN KEY (album_id)  REFERENCES albums(album_id)    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (track_id)  REFERENCES tracks(track_id)    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES persons(person_id)  ON UPDATE CASCADE ON DELETE SET NULL,
  INDEX idx_mawards_album (album_id)
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  (Also: album_reviews and music_streaming for completeness)
-- -------------------------------------------------------------

CREATE TABLE album_reviews (
  review_id      INT UNSIGNED     PRIMARY KEY AUTO_INCREMENT,
  album_id       INT UNSIGNED     NOT NULL,
  reviewer_name  VARCHAR(200)     NOT NULL,
  publication    VARCHAR(200),
  review_type    ENUM('Critic','Audience','Industry') DEFAULT 'Critic',
  rating         DECIMAL(4,1)     NOT NULL,
  rating_scale   TINYINT UNSIGNED DEFAULT 10,
  headline       VARCHAR(500),
  review_text    TEXT,
  sentiment      ENUM('Positive','Mixed','Negative'),
  review_date    DATE,
  FOREIGN KEY (album_id) REFERENCES albums(album_id) ON UPDATE CASCADE ON DELETE CASCADE,
  INDEX idx_arev_album (album_id)
) ENGINE=InnoDB;

CREATE TABLE music_streaming (
  ms_id          INT UNSIGNED     PRIMARY KEY AUTO_INCREMENT,
  album_id       INT UNSIGNED     NOT NULL,
  platform_id    TINYINT UNSIGNED NOT NULL,
  available_from DATE,
  is_exclusive   BOOLEAN          DEFAULT FALSE,
  total_streams  BIGINT UNSIGNED  DEFAULT 0,
  UNIQUE KEY uq_album_platform (album_id, platform_id),
  FOREIGN KEY (album_id)    REFERENCES albums(album_id)                 ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (platform_id) REFERENCES streaming_platforms(platform_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- =============================================================
--  DOMAIN 5 : BRIDGE  (cross-domain links)
--  Tables : movie_music_bridge, collaborations,
--           franchises, trending_charts
-- =============================================================

-- -------------------------------------------------------------
--  24. movie_music_bridge  (the key cross-domain table)
-- -------------------------------------------------------------
CREATE TABLE movie_music_bridge (
  bridge_id       INT UNSIGNED    PRIMARY KEY AUTO_INCREMENT,
  movie_id        INT UNSIGNED    NOT NULL,
  album_id        INT UNSIGNED    NOT NULL,
  bridge_type     ENUM('Original Soundtrack','Original Score',
                       'Item Number','Background Score',
                       'Featured Song','Theme') NOT NULL DEFAULT 'Original Soundtrack',
  is_primary_ost  BOOLEAN         DEFAULT FALSE,          -- main official soundtrack
  sequence_order  TINYINT UNSIGNED DEFAULT 1,

  UNIQUE KEY uq_bridge (movie_id, album_id, bridge_type),
  FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (album_id) REFERENCES albums(album_id) ON UPDATE CASCADE ON DELETE CASCADE,
  INDEX idx_bridge_movie (movie_id),
  INDEX idx_bridge_album (album_id)
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  Bonus: franchises  (for sequel analysis queries)
-- -------------------------------------------------------------
CREATE TABLE franchises (
  franchise_id    SMALLINT UNSIGNED  PRIMARY KEY AUTO_INCREMENT,
  franchise_name  VARCHAR(200)       NOT NULL,
  total_parts     TINYINT UNSIGNED   DEFAULT 1,
  origin_year     SMALLINT UNSIGNED,
  universe        VARCHAR(100)        -- MCU, DCEU, Rohit Shetty Cop Universe …
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  Bonus: collaborations  (director + composer pairs)
-- -------------------------------------------------------------
CREATE TABLE collaborations (
  collab_id       INT UNSIGNED    PRIMARY KEY AUTO_INCREMENT,
  director_id     INT UNSIGNED    NOT NULL,
  composer_id     INT UNSIGNED    NOT NULL,
  total_films     TINYINT UNSIGNED DEFAULT 0,
  first_film_id   INT UNSIGNED,
  last_film_id    INT UNSIGNED,
  avg_imdb        DECIMAL(3,1)    DEFAULT NULL,
  avg_gross_usd   BIGINT UNSIGNED DEFAULT 0,
  UNIQUE KEY uq_collab (director_id, composer_id),
  FOREIGN KEY (director_id) REFERENCES persons(person_id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (composer_id) REFERENCES persons(person_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- -------------------------------------------------------------
--  Bonus: trending_charts  (refreshed by MySQL Event Scheduler)
-- -------------------------------------------------------------
CREATE TABLE trending_charts (
  chart_id        INT UNSIGNED    PRIMARY KEY AUTO_INCREMENT,
  chart_type      ENUM('Movie','Album','Track','Person') NOT NULL,
  entity_id       INT UNSIGNED    NOT NULL,               -- polymorphic ID
  chart_period    ENUM('Daily','Weekly','Monthly','AllTime') NOT NULL,
  rank_position   SMALLINT UNSIGNED NOT NULL,
  score           DECIMAL(12,2)   DEFAULT 0,              -- composite trending score
  chart_date      DATE            NOT NULL,
  INDEX idx_chart_date (chart_date),
  INDEX idx_chart_type (chart_type, chart_period)
) ENGINE=InnoDB;

-- =============================================================
--  ADDITIONAL PERFORMANCE INDEXES
-- =============================================================

CREATE INDEX idx_persons_name      ON persons(full_name);
CREATE INDEX idx_albums_year       ON albums(release_year);
CREATE INDEX idx_albums_streams    ON albums(spotify_streams);
CREATE INDEX idx_tracks_streams    ON tracks(spotify_streams);
CREATE INDEX idx_awards_year       ON movie_awards(ceremony_year);
CREATE INDEX idx_awards_tier       ON movie_awards(prestige_tier, result);
CREATE INDEX idx_cast_role         ON movie_cast(role_type);
CREATE INDEX idx_bo_verdict        ON box_office(verdict);

-- =============================================================
--  VIEWS  (pre-built for frontend API queries)
-- =============================================================

-- View 1 : full movie details in one row (used by movie-detail page)
CREATE VIEW v_movie_full AS
SELECT
  m.movie_id, m.title, m.original_title, m.tagline, m.synopsis,
  m.release_year, m.release_date, m.runtime_minutes,
  l.language_name, c.country_name, cert.certificate_code,
  p.full_name        AS director_name,
  ph.house_name      AS studio_name,
  m.imdb_rating, m.rt_tomatometer, m.rt_audience, m.metacritic_score,
  m.is_imax, m.is_3d, m.is_4dx,
  m.is_100cr_club, m.is_200cr_club, m.is_500cr_club, m.is_billion_usd,
  b.budget_usd, b.worldwide_gross_usd, b.roi_pct, b.verdict,
  b.opening_weekend_usd, b.india_gross_inr
FROM movies m
LEFT JOIN languages          l    ON m.language_id    = l.language_id
LEFT JOIN countries          c    ON m.country_id     = c.country_id
LEFT JOIN certificates       cert ON m.certificate_id = cert.certificate_id
LEFT JOIN persons            p    ON m.director_id    = p.person_id
LEFT JOIN production_houses  ph   ON m.studio_id      = ph.house_id
LEFT JOIN box_office         b    ON m.movie_id       = b.movie_id;

-- View 2 : album details with composer and movie link
CREATE VIEW v_album_full AS
SELECT
  a.album_id, a.album_name, a.album_type, a.release_year,
  a.total_tracks, a.spotify_streams, a.youtube_views,
  a.cinesic_music_rating,
  p.full_name  AS composer_name,
  ml.label_name,
  m.title      AS movie_title,
  m.movie_id
FROM albums a
LEFT JOIN persons      p  ON a.composer_id = p.person_id
LEFT JOIN music_labels ml ON a.label_id    = ml.label_id
LEFT JOIN movies       m  ON a.movie_id    = m.movie_id;

-- View 3 : top actors by total box office carried
CREATE VIEW v_actor_boxoffice AS
SELECT
  p.person_id, p.full_name, p.nationality,
  COUNT(DISTINCT mc.movie_id)          AS total_films,
  SUM(b.worldwide_gross_usd)           AS total_gross_usd,
  ROUND(AVG(m.imdb_rating), 2)         AS avg_imdb,
  COUNT(DISTINCT ma.award_id)          AS total_award_wins
FROM persons p
JOIN movie_cast   mc ON p.person_id  = mc.person_id
JOIN movies       m  ON mc.movie_id  = m.movie_id
JOIN box_office   b  ON m.movie_id   = b.movie_id
LEFT JOIN movie_awards ma ON m.movie_id = ma.movie_id
  AND ma.person_id = p.person_id AND ma.result = 'Won'
WHERE p.is_actor = TRUE OR p.is_actress = TRUE
GROUP BY p.person_id;

-- View 4 : director performance summary
CREATE VIEW v_director_stats AS
SELECT
  p.person_id, p.full_name, p.nationality,
  COUNT(m.movie_id)               AS total_films,
  ROUND(AVG(m.imdb_rating), 2)    AS avg_imdb,
  SUM(b.worldwide_gross_usd)      AS total_gross_usd,
  ROUND(AVG(b.roi_pct), 2)        AS avg_roi,
  MAX(b.worldwide_gross_usd)      AS highest_gross,
  COUNT(DISTINCT ma.award_id)     AS awards_won
FROM persons p
JOIN movies        m  ON m.director_id  = p.person_id
JOIN box_office    b  ON m.movie_id     = b.movie_id
LEFT JOIN movie_awards ma ON m.movie_id = ma.movie_id AND ma.result = 'Won'
WHERE p.is_director = TRUE
GROUP BY p.person_id;

-- View 5 : movie-music connection (for bridge queries)
CREATE VIEW v_movie_music_link AS
SELECT
  m.movie_id, m.title AS movie_title, m.release_year,
  a.album_id, a.album_name, a.album_type,
  mmb.bridge_type, mmb.is_primary_ost,
  p.full_name           AS composer,
  a.spotify_streams     AS album_streams,
  b.worldwide_gross_usd AS movie_gross
FROM movie_music_bridge mmb
JOIN movies  m ON mmb.movie_id = m.movie_id
JOIN albums  a ON mmb.album_id = a.album_id
LEFT JOIN persons    p ON a.composer_id = p.person_id
LEFT JOIN box_office b ON m.movie_id    = b.movie_id;

-- =============================================================
--  STORED PROCEDURES
-- =============================================================

DELIMITER $$

-- Procedure 1 : update box-office club flags after insert/update
CREATE PROCEDURE update_club_flags(IN p_movie_id INT UNSIGNED)
BEGIN
  DECLARE v_india_gross BIGINT;
  DECLARE v_world_gross BIGINT;

  SELECT india_gross_inr, worldwide_gross_usd
    INTO v_india_gross, v_world_gross
    FROM box_office WHERE movie_id = p_movie_id;

  UPDATE movies SET
    is_100cr_club  = (v_india_gross  >= 1000000000),
    is_200cr_club  = (v_india_gross  >= 2000000000),
    is_300cr_club  = (v_india_gross  >= 3000000000),
    is_500cr_club  = (v_india_gross  >= 5000000000),
    is_1000cr_club = (v_india_gross  >= 10000000000),
    is_billion_usd = (v_world_gross  >= 1000000000)
  WHERE movie_id = p_movie_id;
END$$

-- Procedure 2 : refresh collaborations table
CREATE PROCEDURE refresh_collaborations()
BEGIN
  TRUNCATE TABLE collaborations;

  INSERT INTO collaborations
    (director_id, composer_id, total_films, first_film_id,
     last_film_id, avg_imdb, avg_gross_usd)
  SELECT
    m.director_id,
    a.composer_id,
    COUNT(DISTINCT m.movie_id),
    MIN(m.movie_id),
    MAX(m.movie_id),
    ROUND(AVG(m.imdb_rating), 1),
    ROUND(AVG(b.worldwide_gross_usd), 0)
  FROM movies m
  JOIN movie_music_bridge mmb ON m.movie_id   = mmb.movie_id
  JOIN albums             a   ON mmb.album_id = a.album_id AND a.composer_id IS NOT NULL
  JOIN box_office         b   ON m.movie_id   = b.movie_id
  WHERE m.director_id IS NOT NULL
  GROUP BY m.director_id, a.composer_id
  HAVING COUNT(DISTINCT m.movie_id) >= 1;
END$$

-- Procedure 3 : get full movie profile (used by API)
CREATE PROCEDURE get_movie_profile(IN p_movie_id INT UNSIGNED)
BEGIN
  -- Basic info
  SELECT * FROM v_movie_full WHERE movie_id = p_movie_id;

  -- Cast
  SELECT mc.role_type, mc.character_name, mc.billing_order,
         p.full_name, p.date_of_birth
  FROM movie_cast mc
  JOIN persons p ON mc.person_id = p.person_id
  WHERE mc.movie_id = p_movie_id
  ORDER BY mc.billing_order;

  -- Awards
  SELECT award_body, award_category, ceremony_year, result, prestige_tier,
         p.full_name AS awardee
  FROM movie_awards ma
  LEFT JOIN persons p ON ma.person_id = p.person_id
  WHERE ma.movie_id = p_movie_id
  ORDER BY prestige_tier, ceremony_year;

  -- Soundtrack
  SELECT * FROM v_movie_music_link WHERE movie_id = p_movie_id;

  -- Streaming
  SELECT sp.platform_name, ms.stream_quality, ms.is_exclusive, ms.available_from
  FROM movie_streaming ms
  JOIN streaming_platforms sp ON ms.platform_id = sp.platform_id
  WHERE ms.movie_id = p_movie_id;
END$$

DELIMITER ;

-- =============================================================
--  TRIGGERS
-- =============================================================

DELIMITER $$

-- Trigger 1 : after box_office INSERT → set club flags automatically
CREATE TRIGGER trg_bo_after_insert
AFTER INSERT ON box_office
FOR EACH ROW
BEGIN
  CALL update_club_flags(NEW.movie_id);
END$$

-- Trigger 2 : after box_office UPDATE → refresh club flags
CREATE TRIGGER trg_bo_after_update
AFTER UPDATE ON box_office
FOR EACH ROW
BEGIN
  IF OLD.india_gross_inr <> NEW.india_gross_inr
  OR OLD.worldwide_gross_usd <> NEW.worldwide_gross_usd THEN
    CALL update_club_flags(NEW.movie_id);
  END IF;
END$$

-- Trigger 3 : keep persons.total_movies in sync when cast entry is added
CREATE TRIGGER trg_cast_after_insert
AFTER INSERT ON movie_cast
FOR EACH ROW
BEGIN
  UPDATE persons
     SET total_movies = total_movies + 1
   WHERE person_id = NEW.person_id;
END$$

-- Trigger 4 : keep persons.total_movies in sync when cast entry is removed
CREATE TRIGGER trg_cast_after_delete
AFTER DELETE ON movie_cast
FOR EACH ROW
BEGIN
  UPDATE persons
     SET total_movies = GREATEST(total_movies - 1, 0)
   WHERE person_id = OLD.person_id;
END$$

-- Trigger 5 : auto-update albums.total_tracks when a track is inserted
CREATE TRIGGER trg_track_after_insert
AFTER INSERT ON tracks
FOR EACH ROW
BEGIN
  UPDATE albums
     SET total_tracks    = total_tracks + 1,
         total_duration_s = total_duration_s + NEW.duration_seconds
   WHERE album_id = NEW.album_id;
END$$

-- Trigger 6 : auto-update albums.total_tracks when a track is deleted
CREATE TRIGGER trg_track_after_delete
AFTER DELETE ON tracks
FOR EACH ROW
BEGIN
  UPDATE albums
     SET total_tracks    = GREATEST(total_tracks - 1, 0),
         total_duration_s = GREATEST(total_duration_s - OLD.duration_seconds, 0)
   WHERE album_id = OLD.album_id;
END$$

DELIMITER ;

-- =============================================================
--  MYSQL EVENT SCHEDULER  (auto-maintenance)
-- =============================================================

SET GLOBAL event_scheduler = ON;

DELIMITER $$

-- Weekly event : refresh collaborations table every Sunday midnight
CREATE EVENT IF NOT EXISTS evt_weekly_refresh_collaborations
  ON SCHEDULE EVERY 1 WEEK
  STARTS '2025-01-05 00:00:00'
  DO
  BEGIN
    CALL refresh_collaborations();
  END$$

DELIMITER ;

-- =============================================================
--  FOREIGN KEY : persons.debut_film_id  (added after movies exists)
-- =============================================================
ALTER TABLE persons
  ADD CONSTRAINT fk_person_debut
  FOREIGN KEY (debut_film_id) REFERENCES movies(movie_id)
  ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE directors
  ADD CONSTRAINT fk_dir_highest
  FOREIGN KEY (highest_grossing_id) REFERENCES movies(movie_id)
  ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE directors
  ADD CONSTRAINT fk_dir_debut
  FOREIGN KEY (debut_film_id) REFERENCES movies(movie_id)
  ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE movies
  ADD CONSTRAINT fk_movie_franchise
  FOREIGN KEY (franchise_id) REFERENCES franchises(franchise_id)
  ON UPDATE CASCADE ON DELETE SET NULL;

-- =============================================================
--  SCHEMA COMPLETE
--  Total : 24 tables  |  5 domains  |  6 triggers
--          3 stored procedures  |  5 views  |  1 scheduled event
--  Run next : seed/seed_meta.sql → seed_persons.sql
--             → seed_movies.sql → seed_music.sql → seed_boxoffice.sql
-- =============================================================
