-- =============================================================
--  CINESIC — seed_meta.sql
--  Populates all 5 metadata / lookup tables
--  Run FIRST before any other seed file
--  languages · countries · certificates · genres · streaming_platforms
-- =============================================================

USE cinesic;

-- =============================================================
--  1. languages
-- =============================================================
INSERT INTO languages (language_name, language_code, script, region, is_indian) VALUES
('Hindi',       'hi',    'Devanagari',  'South Asia',       TRUE),
('English',     'en',    'Latin',       'Global',           FALSE),
('Tamil',       'ta',    'Tamil',       'South India',      TRUE),
('Telugu',      'te',    'Telugu',      'South India',      TRUE),
('Malayalam',   'ml',    'Malayalam',  'South India',      TRUE),
('Kannada',     'kn',    'Kannada',    'South India',      TRUE),
('Bengali',     'bn',    'Bengali',    'East India',       TRUE),
('Marathi',     'mr',    'Devanagari', 'West India',       TRUE),
('Punjabi',     'pa',    'Gurmukhi',   'North India',      TRUE),
('Gujarati',    'gu',    'Gujarati',   'West India',       TRUE),
('French',      'fr',    'Latin',      'Europe',           FALSE),
('Spanish',     'es',    'Latin',      'Europe/Americas',  FALSE),
('German',      'de',    'Latin',      'Europe',           FALSE),
('Japanese',    'ja',    'Kanji',      'East Asia',        FALSE),
('Korean',      'ko',    'Hangul',     'East Asia',        FALSE),
('Mandarin',    'zh',    'Hanzi',      'East Asia',        FALSE),
('Italian',     'it',    'Latin',      'Europe',           FALSE),
('Portuguese',  'pt',    'Latin',      'Europe/Americas',  FALSE),
('Russian',     'ru',    'Cyrillic',   'Europe/Asia',      FALSE),
('Arabic',      'ar',    'Arabic',     'Middle East',      FALSE);

-- =============================================================
--  2. countries
-- =============================================================
INSERT INTO countries (country_name, country_code, continent, currency_code, is_major_film_market) VALUES
('India',               'IND', 'Asia',          'INR', TRUE),
('United States',       'USA', 'North America',  'USD', TRUE),
('United Kingdom',      'GBR', 'Europe',         'GBP', TRUE),
('France',              'FRA', 'Europe',         'EUR', TRUE),
('Germany',             'DEU', 'Europe',         'EUR', FALSE),
('Japan',               'JPN', 'Asia',           'JPY', TRUE),
('South Korea',         'KOR', 'Asia',           'KRW', TRUE),
('China',               'CHN', 'Asia',           'CNY', TRUE),
('Italy',               'ITA', 'Europe',         'EUR', FALSE),
('Spain',               'ESP', 'Europe',         'EUR', FALSE),
('Australia',           'AUS', 'Oceania',        'AUD', FALSE),
('Canada',              'CAN', 'North America',  'CAD', FALSE),
('Brazil',              'BRA', 'South America',  'BRL', FALSE),
('Mexico',              'MEX', 'North America',  'MXN', FALSE),
('Russia',              'RUS', 'Europe',         'RUB', FALSE),
('New Zealand',         'NZL', 'Oceania',        'NZD', FALSE),
('Ireland',             'IRL', 'Europe',         'EUR', FALSE),
('Sweden',              'SWE', 'Europe',         'SEK', FALSE),
('Denmark',             'DNK', 'Europe',         'DKK', FALSE),
('Norway',              'NOR', 'Europe',         'NOK', FALSE);

-- =============================================================
--  3. certificates
-- =============================================================
INSERT INTO certificates (certificate_code, board, country_id, minimum_age, description) VALUES
-- India (CBFC) — country_id 1
('U',      'CBFC', 1,  0,  'Universal — suitable for all ages'),
('U/A',    'CBFC', 1,  12, 'Parental guidance for children under 12'),
('A',      'CBFC', 1,  18, 'Restricted to adults'),
('S',      'CBFC', 1,  0,  'Restricted to specialised audiences'),
-- USA (MPAA) — country_id 2
('G',      'MPAA', 2,  0,  'General audiences — all ages admitted'),
('PG',     'MPAA', 2,  0,  'Parental guidance suggested'),
('PG-13',  'MPAA', 2,  13, 'Parents strongly cautioned — may be inappropriate for under 13'),
('R',      'MPAA', 2,  17, 'Restricted — under 17 requires parent or guardian'),
('NC-17',  'MPAA', 2,  18, 'Adults only'),
-- UK (BBFC) — country_id 3
('U',      'BBFC', 3,  0,  'Universal'),
('PG',     'BBFC', 3,  0,  'Parental guidance'),
('12A',    'BBFC', 3,  12, 'Suitable for 12 and over'),
('15',     'BBFC', 3,  15, 'Suitable only for 15 and over'),
('18',     'BBFC', 3,  18, 'Suitable only for adults');

-- =============================================================
--  4. genres
-- =============================================================
INSERT INTO genres (genre_name, genre_type, parent_id, description) VALUES
-- Top-level film genres
('Action',          'Film', NULL, 'High-energy sequences, fights, chases'),
('Drama',           'Film', NULL, 'Character-driven emotional narratives'),
('Comedy',          'Film', NULL, 'Humour, wit, and light-hearted storytelling'),
('Thriller',        'Film', NULL, 'Suspense and tension-driven narratives'),
('Horror',          'Film', NULL, 'Fear, dread, and supernatural elements'),
('Romance',         'Film', NULL, 'Love stories and relationships'),
('Science Fiction', 'Film', NULL, 'Futuristic technology and speculative concepts'),
('Fantasy',         'Film', NULL, 'Magic, mythical creatures, and imagined worlds'),
('Adventure',       'Film', NULL, 'Journeys, exploration, and quests'),
('Animation',       'Film', NULL, 'Animated films for all audiences'),
('Biographical',    'Film', NULL, 'Stories based on real people and events'),
('Historical',      'Film', NULL, 'Period pieces set in the past'),
('Crime',           'Film', NULL, 'Criminal investigations and heists'),
('Mystery',         'Film', NULL, 'Puzzles, whodunits, and investigations'),
('War',             'Film', NULL, 'Military conflicts and battlefield stories'),
('Sports',          'Film', NULL, 'Stories centred around athletic competition'),
('Family',          'Film', NULL, 'Suitable and enjoyable for all family members'),
('Documentary',     'Film', NULL, 'Non-fiction factual filmmaking'),
('Musical',         'Film', NULL, 'Films where songs drive the narrative'),
('Superhero',       'Film', NULL, 'Characters with extraordinary abilities'),
-- Film sub-genres (with parent)
('Heist',           'Film', 13, 'Elaborate robbery or theft plots'),
('Psychological',   'Film', 4,  'Mind-bending suspense and mental manipulation'),
('Disaster',        'Film', 1,  'Large-scale catastrophic events'),
('Spy',             'Film', 1,  'Espionage and intelligence operations'),
('Martial Arts',    'Film', 1,  'Hand-to-hand combat as central theme'),
-- Music genres
('Classical',       'Music', NULL, 'Orchestral and composed formal music'),
('Rock',            'Music', NULL, 'Guitar-driven energetic music'),
('Pop',             'Music', NULL, 'Mainstream popular music'),
('Hip Hop',         'Music', NULL, 'Rap, beats, and urban culture'),
('Jazz',            'Music', NULL, 'Improvisation and swing'),
('Electronic',      'Music', NULL, 'Synthesizer and computer-produced music'),
('Folk',            'Music', NULL, 'Traditional regional music'),
('R&B',             'Music', NULL, 'Rhythm and blues'),
('Devotional',      'Music', NULL, 'Spiritual and religious music'),
('Indie',           'Music', NULL, 'Independent artist music'),
-- Shared genres
('World Music',     'Both', NULL, 'Fusion of global musical traditions'),
('Soundtrack',      'Both', NULL, 'Film and TV background scores');

-- =============================================================
--  5. streaming_platforms
-- =============================================================
INSERT INTO streaming_platforms (platform_name, platform_type, hq_country_id, monthly_users_m, founded_year, website, has_4k, has_dolby, is_subscription) VALUES
('Netflix',         'Video', 2,  260.0, 1997, 'netflix.com',       TRUE,  TRUE,  TRUE),
('Amazon Prime',    'Video', 2,  200.0, 2006, 'primevideo.com',    TRUE,  TRUE,  TRUE),
('Disney+ Hotstar', 'Video', 2,  157.6, 2019, 'hotstar.com',       TRUE,  FALSE, TRUE),
('Apple TV+',       'Video', 2,   50.0, 2019, 'tv.apple.com',      TRUE,  TRUE,  TRUE),
('HBO Max',         'Video', 2,   95.0, 2020, 'max.com',           TRUE,  TRUE,  TRUE),
('Hulu',            'Video', 2,   50.4, 2008, 'hulu.com',          TRUE,  FALSE, TRUE),
('Zee5',            'Video', 1,   72.6, 2018, 'zee5.com',          FALSE, FALSE, TRUE),
('SonyLIV',         'Video', 1,   40.0, 2013, 'sonyliv.com',       FALSE, FALSE, TRUE),
('MX Player',       'Video', 1,  280.0, 2011, 'mxplayer.in',       FALSE, FALSE, FALSE),
('Aha',             'Video', 1,    3.5, 2020, 'aha.video',         FALSE, FALSE, TRUE),
('Spotify',         'Music', 2,  602.0, 2006, 'spotify.com',       FALSE, TRUE,  TRUE),
('Apple Music',     'Music', 2,   88.0, 2015, 'music.apple.com',   FALSE, TRUE,  TRUE),
('JioSaavn',        'Music', 1,  150.0, 2007, 'jiosaavn.com',      FALSE, FALSE, TRUE),
('Gaana',           'Music', 1,  185.0, 2010, 'gaana.com',         FALSE, FALSE, TRUE),
('YouTube Music',   'Music', 2,  100.0, 2018, 'music.youtube.com', FALSE, FALSE, TRUE),
('Wynk Music',      'Music', 1,   30.0, 2014, 'wynk.in',           FALSE, FALSE, TRUE),
('Tidal',           'Music', 18,   3.0, 2014, 'tidal.com',         FALSE, TRUE,  TRUE),
('Deezer',          'Music', 4,   16.0, 2007, 'deezer.com',        FALSE, FALSE, TRUE);

-- =============================================================
--  6. music_labels
-- =============================================================
INSERT INTO music_labels (label_name, country_id, founded_year, is_major) VALUES
('T-Series',           1, 1983, TRUE),
('Sony Music India',   1, 1994, TRUE),
('Zee Music Company',  1, 2014, TRUE),
('Saregama',           1, 1901, TRUE),
('Tips Music',         1, 1975, FALSE),
('Lahari Music',       1, 1975, FALSE),
('Aditya Music',       1, 1994, FALSE),
('Sony Music Global',  2, 1929, TRUE),
('Universal Music',    3, 1934, TRUE),
('Warner Music',       2, 1958, TRUE),
('Atlantic Records',   2, 1947, TRUE),
('Republic Records',   2, 1995, TRUE),
('Interscope',         2, 1989, TRUE),
('YRF Music',          1, 1970, FALSE),
('Eros Music',         1, 1977, FALSE),
('Junglee Music',      1, 2019, FALSE),
('Divo Music',         1, 2010, FALSE),
('Think Music',        1, 2009, FALSE);

-- =============================================================
--  7. production_houses
-- =============================================================
INSERT INTO production_houses (house_name, country_id, founded_year, founder_name, hq_city, is_active) VALUES
('Yash Raj Films',              1, 1970, 'Yash Chopra',        'Mumbai',    TRUE),
('Dharma Productions',          1, 1976, 'Yash Johar',         'Mumbai',    TRUE),
('Red Chillies Entertainment',  1, 2002, 'Shah Rukh Khan',     'Mumbai',    TRUE),
('Excel Entertainment',         1, 2001, 'Farhan Akhtar',      'Mumbai',    TRUE),
('Aamir Khan Productions',      1, 1999, 'Aamir Khan',         'Mumbai',    TRUE),
('Hombale Films',               1, 2009, 'Vijay Kiragandur',   'Bangalore', TRUE),
('Mythri Movie Makers',         1, 2015, 'Naveen Yerneni',     'Hyderabad', TRUE),
('DVV Entertainment',           1, 2015, 'D. V. V. Danayya',   'Hyderabad', TRUE),
('Pen Marudhar',                1, 2000, 'Jayantilal Gada',    'Mumbai',    TRUE),
('T-Series Films',              1, 1983, 'Gulshan Kumar',      'Mumbai',    TRUE),
('Lyca Productions',            1, 2012, 'Subaskaran',         'Chennai',   TRUE),
('UV Creations',                1, 2012, 'Vaman Udandanad',    'Hyderabad', TRUE),
('Marvel Studios',              2, 1993, 'Avi Arad',           'Burbank',   TRUE),
('Warner Bros.',                2, 1923, 'Warner Brothers',    'Burbank',   TRUE),
('Universal Pictures',          2, 1912, 'Carl Laemmle',       'Universal City', TRUE),
('Paramount Pictures',          2, 1912, 'Adolph Zukor',       'Los Angeles', TRUE),
('Sony Pictures',               2, 1987, 'Coca-Cola Company',  'Culver City', TRUE),
('Legendary Entertainment',     2, 2000, 'Thomas Tull',        'Burbank',   TRUE),
('Syncopy Inc.',                3, 2000, 'Christopher Nolan',  'London',    TRUE),
('Working Title Films',         3, 1983, 'Tim Bevan',          'London',    TRUE),
('Blumhouse Productions',       2, 2000, 'Jason Blum',         'Los Angeles', TRUE),
('A24',                         2, 2012, 'Daniel Katz',        'New York',  TRUE),
('Baahubali Films',             1, 2012, 'Shobu Yarlagadda',   'Hyderabad', TRUE),
('Maddock Films',               1, 2001, 'Dinesh Vijan',       'Mumbai',    TRUE),
('Jio Studios',                 1, 2016, 'Reliance Industries','Mumbai',    TRUE);

-- done
SELECT 'seed_meta.sql complete' AS status;
SELECT 'languages'           AS tbl, COUNT(*) AS rows FROM languages
UNION ALL SELECT 'countries',          COUNT(*) FROM countries
UNION ALL SELECT 'certificates',       COUNT(*) FROM certificates
UNION ALL SELECT 'genres',             COUNT(*) FROM genres
UNION ALL SELECT 'streaming_platforms',COUNT(*) FROM streaming_platforms
UNION ALL SELECT 'music_labels',       COUNT(*) FROM music_labels
UNION ALL SELECT 'production_houses',  COUNT(*) FROM production_houses;
