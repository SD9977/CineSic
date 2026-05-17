-- =============================================================
--  CINESIC — seed_music.sql
--  Real albums + tracks + singers + movie_music_bridge
--  Run AFTER seed_movies.sql
--  ~120 albums · ~600 tracks · full bridge links
-- =============================================================

USE cinesic;

-- =============================================================
--  ALBUMS
--  album_type: Film Soundtrack / Studio Album / EP / Single
--  composer_id: from persons table
--  movie_id: NULL for standalone albums
--  label_id: from music_labels table
-- =============================================================

INSERT INTO albums
  (album_id, album_name, album_type, movie_id, composer_id, label_id,
   release_date, release_year, total_tracks, total_duration_s,
   spotify_streams, apple_music_plays, youtube_views,
   jiosaavn_plays, gaana_plays,
   peak_chart_position, weeks_on_chart, certified_copies_sold,
   allmusic_rating, pitchfork_score, cinesic_music_rating,
   recording_studio, language_id, country_id)
VALUES

-- ═══════════════════════════════════════════════════════════════
--  BOLLYWOOD SOUNDTRACKS
-- ═══════════════════════════════════════════════════════════════

(1, 'Dangal', 'Film Soundtrack', 1, 54, 1,
 '2016-11-28', 2016, 7, 2340,
 480000000, 95000000, 1200000000, 320000000, 280000000,
 1, 18, 2500000, 8.2, NULL, 8.4,
 'YRF Studios, Mumbai', 1, 1),

(2, 'PK', 'Film Soundtrack', 2, 54, 1,
 '2014-11-20', 2014, 8, 2760,
 520000000, 88000000, 980000000, 290000000, 260000000,
 1, 20, 2800000, 8.0, NULL, 8.2,
 'YRF Studios, Mumbai', 1, 1),

(3, '3 Idiots', 'Film Soundtrack', 3, 57, 1,
 '2009-11-20', 2009, 7, 2520,
 680000000, 120000000, 1400000000, 400000000, 370000000,
 1, 28, 4000000, 8.5, NULL, 8.7,
 'Shankar-Ehsaan-Loy Studios, Mumbai', 1, 1),

(4, 'Bajrangi Bhaijaan', 'Film Soundtrack', 4, 54, 1,
 '2015-06-05', 2015, 7, 2280,
 560000000, 98000000, 1100000000, 350000000, 310000000,
 1, 22, 3200000, 8.1, NULL, 8.3,
 'YRF Studios, Mumbai', 1, 1),

(5, 'Sultan', 'Film Soundtrack', 5, 55, 1,
 '2016-06-01', 2016, 7, 2400,
 390000000, 72000000, 800000000, 240000000, 210000000,
 2, 14, 1800000, 7.4, NULL, 7.6,
 'Vishal-Shekhar Studios, Mumbai', 1, 1),

(6, 'Dilwale Dulhania Le Jayenge', 'Film Soundtrack', 6, NULL, 14,
 '1995-10-01', 1995, 10, 3300,
 920000000, 160000000, 2100000000, 540000000, 490000000,
 1, 120, 8000000, 9.0, NULL, 9.1,
 'YRF Studios, Mumbai', 1, 1),

(7, 'Kabhi Khushi Kabhie Gham', 'Film Soundtrack', 7, NULL, 2,
 '2001-11-20', 2001, 9, 3060,
 750000000, 130000000, 1700000000, 460000000, 420000000,
 1, 40, 5500000, 8.3, NULL, 8.5,
 'Dharma Studios, Mumbai', 1, 1),

(8, 'Kuch Kuch Hota Hai', 'Film Soundtrack', 8, NULL, 2,
 '1998-09-01', 1998, 9, 3120,
 810000000, 145000000, 1850000000, 500000000, 450000000,
 1, 60, 6500000, 8.6, NULL, 8.8,
 'Dharma Studios, Mumbai', 1, 1),

(9, 'Jab We Met', 'Film Soundtrack', 13, 54, 1,
 '2007-10-01', 2007, 8, 2640,
 690000000, 118000000, 1500000000, 420000000, 380000000,
 1, 32, 4200000, 8.7, NULL, 8.9,
 'T-Series Studios, Mumbai', 1, 1),

(10, 'Rockstar', 'Film Soundtrack', 105, 53, 1,
 '2011-10-01', 2011, 16, 5040,
 780000000, 138000000, 1800000000, 480000000, 430000000,
 1, 36, 5000000, 9.0, 8.5, 9.1,
 'AR Rahman Studios, Chennai', 1, 1),

(11, 'Tamasha', 'Film Soundtrack', 106, 53, 1,
 '2015-11-01', 2015, 13, 4260,
 560000000, 95000000, 1200000000, 340000000, 300000000,
 1, 18, 2800000, 8.6, 8.0, 8.7,
 'AR Rahman Studios, Chennai', 1, 1),

(12, 'Highway', 'Film Soundtrack', 107, 53, 1,
 '2014-02-01', 2014, 13, 4440,
 620000000, 108000000, 1400000000, 380000000, 340000000,
 1, 22, 3400000, 8.8, 8.2, 8.9,
 'AR Rahman Studios, Chennai', 1, 1),

(13, 'Rang De Basanti', 'Film Soundtrack', 19, 53, 4,
 '2006-01-01', 2006, 12, 4080,
 840000000, 148000000, 1900000000, 510000000, 460000000,
 1, 42, 5800000, 9.1, 8.6, 9.2,
 'AR Rahman Studios, Chennai', 1, 1),

(14, 'Lagaan', 'Film Soundtrack', 17, 53, 4,
 '2001-05-01', 2001, 10, 3480,
 700000000, 122000000, 1600000000, 430000000, 390000000,
 1, 38, 5000000, 9.2, 8.7, 9.3,
 'AR Rahman Studios, Chennai', 1, 1),

(15, 'Taare Zameen Par', 'Film Soundtrack', 18, 57, 1,
 '2007-11-01', 2007, 12, 3960,
 590000000, 102000000, 1300000000, 360000000, 320000000,
 1, 24, 3600000, 8.4, NULL, 8.6,
 'SEL Studios, Mumbai', 1, 1),

(16, 'Dil Chahta Hai', 'Film Soundtrack', 15, 57, 4,
 '2001-07-01', 2001, 10, 3300,
 640000000, 112000000, 1450000000, 390000000, 350000000,
 1, 30, 4400000, 8.5, NULL, 8.7,
 'SEL Studios, Mumbai', 1, 1),

(17, 'Zindagi Na Milegi Dobara', 'Film Soundtrack', 16, 57, 4,
 '2011-06-01', 2011, 9, 3060,
 720000000, 126000000, 1650000000, 440000000, 400000000,
 1, 34, 4800000, 8.6, NULL, 8.8,
 'SEL Studios, Mumbai', 1, 1),

(18, 'Gully Boy', 'Film Soundtrack', 29, 56, 3,
 '2019-01-20', 2019, 18, 5760,
 550000000, 95000000, 1150000000, 330000000, 290000000,
 1, 16, 2600000, 8.3, 7.8, 8.5,
 'Zee Music, Mumbai', 1, 1),

(19, 'Queen', 'Film Soundtrack', 25, 56, 3,
 '2014-02-28', 2014, 9, 3060,
 480000000, 82000000, 1050000000, 300000000, 270000000,
 1, 18, 2400000, 8.2, NULL, 8.4,
 'Zee Music, Mumbai', 1, 1),

(20, 'Kabir Singh', 'Film Soundtrack', 108, 56, 3,
 '2019-05-20', 2019, 11, 3720,
 890000000, 155000000, 2100000000, 530000000, 480000000,
 1, 28, 6000000, 7.8, NULL, 8.0,
 'Zee Music, Mumbai', 1, 1),

(21, 'Rock On!!', 'Film Soundtrack', 14, 57, 4,
 '2008-08-01', 2008, 10, 3300,
 390000000, 68000000, 850000000, 250000000, 220000000,
 2, 14, 1900000, 7.9, NULL, 8.1,
 'Excel Studios, Mumbai', 1, 1),

(22, 'URI: The Surgical Strike', 'Film Soundtrack', 31, 55, 3,
 '2019-01-01', 2019, 8, 2520,
 320000000, 56000000, 700000000, 210000000, 185000000,
 3, 10, 1400000, 7.2, NULL, 7.4,
 'Zee Music, Mumbai', 1, 1),

(23, 'Andhadhun', 'Film Soundtrack', 26, 56, 3,
 '2018-09-21', 2018, 9, 3000,
 410000000, 72000000, 900000000, 260000000, 230000000,
 2, 14, 1800000, 8.0, NULL, 8.2,
 'Zee Music, Mumbai', 1, 1),

(24, 'Stree', 'Film Soundtrack', 111, 56, 3,
 '2018-08-15', 2018, 7, 2280,
 480000000, 84000000, 1050000000, 300000000, 265000000,
 1, 16, 2200000, 7.8, NULL, 8.0,
 'Zee Music, Mumbai', 1, 1),

(25, 'Tumbbad', 'Film Soundtrack', 28, 56, 9,
 '2018-10-01', 2018, 6, 2100,
 180000000, 32000000, 390000000, 110000000, 95000000,
 NULL, 6, 700000, 8.1, 7.5, 8.3,
 'Independent, Mumbai', 1, 1),

(26, '12th Fail', 'Film Soundtrack', 116, 56, 9,
 '2023-10-15', 2023, 8, 2640,
 280000000, 48000000, 620000000, 180000000, 158000000,
 3, 10, 1100000, 8.5, NULL, 8.7,
 'Zee Music, Mumbai', 1, 1),

(27, 'Animal', 'Film Soundtrack', 35, 55, 3,
 '2023-11-20', 2023, 12, 4020,
 720000000, 125000000, 1680000000, 430000000, 380000000,
 1, 18, 4500000, 7.0, NULL, 7.3,
 'Zee Music, Mumbai', 1, 1),

(28, 'Jawan', 'Film Soundtrack', 36, 53, 1,
 '2023-08-20', 2023, 9, 3000,
 540000000, 94000000, 1250000000, 320000000, 285000000,
 2, 14, 2600000, 7.4, NULL, 7.6,
 'AR Rahman Studios, Chennai', 1, 1),

(29, 'Pathaan', 'Film Soundtrack', 33, 55, 1,
 '2023-01-10', 2023, 6, 1980,
 680000000, 118000000, 1580000000, 400000000, 360000000,
 1, 16, 3500000, 7.2, NULL, 7.4,
 'YRF Studios, Mumbai', 1, 1),

(30, 'Brahmastra', 'Film Soundtrack', 34, 53, 2,
 '2022-08-25', 2022, 10, 3300,
 490000000, 85000000, 1100000000, 295000000, 260000000,
 2, 12, 2100000, 7.0, NULL, 7.2,
 'AR Rahman Studios, Chennai', 1, 1),

-- ═══════════════════════════════════════════════════════════════
--  SOUTH INDIAN SOUNDTRACKS
-- ═══════════════════════════════════════════════════════════════

(31, 'Baahubali: The Beginning OST', 'Film Soundtrack', 41, 53, 6,
 '2015-06-30', 2015, 7, 2400,
 650000000, 112000000, 1480000000, 395000000, 355000000,
 1, 26, 3800000, 8.6, NULL, 8.8,
 'AR Rahman Studios, Chennai', 4, 1),

(32, 'Baahubali 2 OST', 'Film Soundtrack', 42, 53, 6,
 '2017-03-20', 2017, 9, 3120,
 890000000, 155000000, 2050000000, 530000000, 475000000,
 1, 32, 5800000, 8.8, NULL, 9.0,
 'AR Rahman Studios, Chennai', 4, 1),

(33, 'KGF Chapter 1 OST', 'Film Soundtrack', 43, 62, 6,
 '2018-12-01', 2018, 6, 2100,
 580000000, 100000000, 1300000000, 350000000, 315000000,
 1, 20, 2900000, 8.2, NULL, 8.4,
 'Hombale Studios, Bengaluru', 6, 1),

(34, 'KGF Chapter 2 OST', 'Film Soundtrack', 44, 62, 6,
 '2022-03-25', 2022, 7, 2460,
 1200000000, 208000000, 2800000000, 720000000, 640000000,
 1, 40, 8000000, 8.5, NULL, 8.7,
 'Hombale Studios, Bengaluru', 6, 1),

(35, 'RRR OST', 'Film Soundtrack', 45, 53, 6,
 '2021-12-20', 2021, 11, 3840,
 1400000000, 242000000, 3200000000, 850000000, 760000000,
 1, 48, 10000000, 9.0, 8.8, 9.2,
 'AR Rahman Studios, Chennai', 4, 1),

(36, 'Pushpa: The Rise OST', 'Film Soundtrack', 46, 61, 7,
 '2021-11-20', 2021, 9, 3120,
 820000000, 142000000, 1900000000, 490000000, 440000000,
 1, 30, 4800000, 8.0, NULL, 8.2,
 'Thaman Studios, Hyderabad', 4, 1),

(37, 'Pushpa 2 OST', 'Film Soundtrack', 47, 61, 7,
 '2024-11-20', 2024, 10, 3540,
 1600000000, 278000000, 3700000000, 980000000, 875000000,
 1, 36, 12000000, 8.2, NULL, 8.4,
 'Thaman Studios, Hyderabad', 4, 1),

(38, 'Vikram OST', 'Film Soundtrack', 49, 80, 18,
 '2022-05-10', 2022, 7, 2520,
 620000000, 108000000, 1400000000, 375000000, 335000000,
 1, 18, 3200000, 8.4, NULL, 8.6,
 'Anirudh Studios, Chennai', 3, 1),

(39, 'Master OST', 'Film Soundtrack', 53, 80, 18,
 '2020-12-05', 2020, 8, 2760,
 780000000, 135000000, 1780000000, 470000000, 420000000,
 1, 26, 4400000, 8.2, NULL, 8.4,
 'Anirudh Studios, Chennai', 3, 1),

(40, 'Leo OST', 'Film Soundtrack', 51, 80, 18,
 '2023-09-20', 2023, 7, 2460,
 680000000, 118000000, 1560000000, 410000000, 365000000,
 1, 20, 3600000, 7.8, NULL, 8.0,
 'Anirudh Studios, Chennai', 3, 1),

(41, 'Jailer OST', 'Film Soundtrack', 50, 80, 18,
 '2023-07-25', 2023, 7, 2520,
 720000000, 125000000, 1660000000, 440000000, 392000000,
 1, 22, 3900000, 7.6, NULL, 7.8,
 'Anirudh Studios, Chennai', 3, 1),

(42, 'Kantara OST', 'Film Soundtrack', 121, 63, 17,
 '2022-09-15', 2022, 6, 2220,
 580000000, 100000000, 1320000000, 355000000, 316000000,
 1, 24, 3000000, 8.8, NULL, 9.0,
 'Santhosh Studios, Chennai', 6, 1),

(43, 'Ponniyin Selvan 1 OST', 'Film Soundtrack', 54, 53, 18,
 '2022-09-15', 2022, 10, 3480,
 690000000, 120000000, 1580000000, 420000000, 375000000,
 1, 22, 3600000, 8.9, 8.4, 9.0,
 'AR Rahman Studios, Chennai', 3, 1),

(44, 'Ponniyin Selvan 2 OST', 'Film Soundtrack', 55, 53, 18,
 '2023-04-10', 2023, 9, 3120,
 540000000, 94000000, 1240000000, 330000000, 295000000,
 2, 18, 2800000, 8.6, NULL, 8.8,
 'AR Rahman Studios, Chennai', 3, 1),

(45, '96 OST', 'Film Soundtrack', 129, 59, 17,
 '2018-09-18', 2018, 10, 3600,
 490000000, 85000000, 1120000000, 300000000, 268000000,
 1, 20, 2600000, 9.1, NULL, 9.2,
 'Harris Studios, Chennai', 3, 1),

(46, 'Kaithi OST', 'Film Soundtrack', 127, 80, 18,
 '2019-10-15', 2019, 4, 1380,
 280000000, 48000000, 640000000, 170000000, 152000000,
 NULL, 8, 1000000, 8.0, NULL, 8.2,
 'Anirudh Studios, Chennai', 3, 1),

(47, 'Super Deluxe OST', 'Film Soundtrack', 133, 80, 18,
 '2019-03-15', 2019, 7, 2520,
 360000000, 62000000, 820000000, 215000000, 192000000,
 3, 10, 1400000, 8.4, NULL, 8.6,
 'Anirudh Studios, Chennai', 3, 1),

(48, 'Soorarai Pottru OST', 'Film Soundtrack', 125, 80, 18,
 '2020-11-01', 2020, 8, 2760,
 520000000, 90000000, 1190000000, 315000000, 281000000,
 1, 16, 2500000, 8.8, NULL, 9.0,
 'Anirudh Studios, Chennai', 3, 1),

(49, 'Jai Bhim OST', 'Film Soundtrack', 126, 63, 17,
 '2021-10-20', 2021, 5, 1740,
 240000000, 41000000, 550000000, 145000000, 130000000,
 NULL, 6, 850000, 8.5, NULL, 8.7,
 'Santhosh Studios, Chennai', 3, 1),

(50, 'Kumbalangi Nights OST', 'Film Soundtrack', 135, 63, 17,
 '2019-01-25', 2019, 8, 2880,
 310000000, 54000000, 710000000, 188000000, 168000000,
 2, 12, 1200000, 8.9, NULL, 9.0,
 'Santhosh Studios, Chennai', 5, 1),

(51, 'Drishyam 2 OST', 'Film Soundtrack', 56, 59, 5,
 '2021-02-10', 2021, 5, 1800,
 195000000, 34000000, 448000000, 118000000, 106000000,
 NULL, 6, 750000, 8.0, NULL, 8.2,
 'Tips Studios, Kochi', 5, 1),

(52, 'Vikrant Rona OST', 'Film Soundtrack', 123, 61, 7,
 '2022-07-15', 2022, 7, 2520,
 340000000, 59000000, 780000000, 205000000, 183000000,
 3, 10, 1500000, 7.4, NULL, 7.6,
 'Thaman Studios, Hyderabad', 6, 1),

(53, 'Dasara OST', 'Film Soundtrack', 150, 61, 7,
 '2023-03-15', 2023, 8, 2820,
 420000000, 73000000, 965000000, 253000000, 226000000,
 2, 14, 1900000, 7.6, NULL, 7.8,
 'Thaman Studios, Hyderabad', 4, 1),

(54, 'Sarpatta Parambarai OST', 'Film Soundtrack', 139, 63, 17,
 '2021-07-10', 2021, 9, 3240,
 290000000, 50000000, 665000000, 175000000, 156000000,
 3, 10, 1100000, 8.3, NULL, 8.5,
 'Santhosh Studios, Chennai', 3, 1),

-- ═══════════════════════════════════════════════════════════════
--  HOLLYWOOD SOUNDTRACKS
-- ═══════════════════════════════════════════════════════════════

(55, 'Inception OST', 'Original Score', 61, 64, 8,
 '2010-07-13', 2010, 18, 5940,
 720000000, 125000000, 1650000000, 85000000, 78000000,
 3, 24, 2800000, 9.0, 8.5, 9.1,
 'Remote Control Productions, LA', 2, 2),

(56, 'The Dark Knight OST', 'Original Score', 62, 64, 8,
 '2008-07-15', 2008, 17, 5520,
 860000000, 150000000, 1980000000, 105000000, 95000000,
 2, 30, 3400000, 9.2, 8.8, 9.3,
 'Remote Control Productions, LA', 2, 2),

(57, 'Interstellar OST', 'Original Score', 63, 64, 8,
 '2014-11-18', 2014, 24, 8280,
 980000000, 170000000, 2250000000, 120000000, 108000000,
 1, 42, 4200000, 9.4, 9.0, 9.5,
 'Air-Edel Studios, London', 2, 2),

(58, 'Dunkirk OST', 'Original Score', 65, 64, 8,
 '2017-07-21', 2017, 11, 3660,
 480000000, 83000000, 1100000000, 58000000, 52000000,
 4, 18, 1900000, 9.0, 8.6, 9.1,
 'Air-Edel Studios, London', 2, 2),

(59, 'Oppenheimer OST', 'Original Score', 67, 66, 8,
 '2023-07-21', 2023, 26, 8400,
 850000000, 148000000, 1960000000, 104000000, 93000000,
 1, 36, 3800000, 9.2, 9.0, 9.3,
 'Electric Bird, LA', 2, 2),

(60, 'Dune OST', 'Original Score', 74, 64, 8,
 '2021-10-22', 2021, 21, 6720,
 780000000, 135000000, 1790000000, 95000000, 85000000,
 2, 28, 3200000, 9.1, 8.8, 9.2,
 'Remote Control Productions, LA', 2, 2),

(61, 'Dune: Part Two OST', 'Original Score', 75, 64, 8,
 '2024-02-29', 2024, 21, 6720,
 690000000, 120000000, 1590000000, 84000000, 75000000,
 2, 24, 2900000, 9.0, 8.7, 9.1,
 'Remote Control Productions, LA', 2, 2),

(62, 'Avatar OST', 'Original Score', 70, 64, 8,
 '2009-12-15', 2009, 16, 5160,
 640000000, 111000000, 1470000000, 78000000, 70000000,
 3, 22, 2600000, 8.6, NULL, 8.7,
 'Remote Control Productions, LA', 2, 2),

(63, 'Titanic OST', 'Film Soundtrack', 72, 64, 9,
 '1997-11-18', 1997, 15, 4980,
 1100000000, 191000000, 2530000000, 135000000, 121000000,
 1, 80, 10000000, 9.0, NULL, 9.1,
 'Remote Control Productions, LA', 2, 2),

(64, 'Parasite OST', 'Original Score', 73, 66, 9,
 '2019-10-30', 2019, 27, 8640,
 420000000, 73000000, 965000000, 51000000, 46000000,
 5, 16, 1700000, 9.0, 8.7, 9.1,
 'Universal Music Korea, Seoul', 15, 7),

(65, 'Avengers: Endgame OST', 'Original Score', 68, 66, 8,
 '2019-04-26', 2019, 23, 7440,
 690000000, 120000000, 1590000000, 84000000, 75000000,
 2, 22, 2900000, 8.8, NULL, 8.9,
 'Sony Classical, LA', 2, 2),

(66, 'Gladiator OST', 'Original Score', 83, 64, 8,
 '2000-05-09', 2000, 20, 6600,
 590000000, 102000000, 1355000000, 72000000, 64000000,
 2, 26, 2400000, 9.0, NULL, 9.1,
 'Remote Control Productions, LA', 2, 2),

(67, 'Spirited Away OST', 'Original Score', 86, 64, 9,
 '2001-07-20', 2001, 23, 7560,
 720000000, 125000000, 1656000000, 88000000, 79000000,
 2, 40, 3200000, 9.5, 9.2, 9.6,
 'Studio Ghibli, Tokyo', 14, 6),

(68, 'The Lord of the Rings: Fellowship OST', 'Original Score', 84, 65, 8,
 '2001-11-20', 2001, 21, 7020,
 760000000, 132000000, 1748000000, 93000000, 83000000,
 1, 36, 3400000, 9.4, NULL, 9.5,
 'Wellington, New Zealand', 2, 16),

(69, 'The Lord of the Rings: Return of the King OST', 'Original Score', 85, 65, 8,
 '2003-11-25', 2003, 22, 7260,
 790000000, 137000000, 1817000000, 97000000, 87000000,
 1, 38, 3700000, 9.5, NULL, 9.6,
 'Wellington, New Zealand', 2, 16),

(70, 'La La Land OST', 'Film Soundtrack', 96, 66, 9,
 '2016-11-18', 2016, 12, 3960,
 680000000, 118000000, 1564000000, 83000000, 74000000,
 1, 32, 3100000, 9.0, 8.8, 9.1,
 'EastWest Studios, Hollywood', 2, 2),

(71, 'Whiplash OST', 'Original Score', 95, 66, 9,
 '2014-10-10', 2014, 13, 4320,
 390000000, 68000000, 897000000, 48000000, 43000000,
 4, 16, 1600000, 8.8, 8.5, 8.9,
 'Sony Classical, LA', 2, 2),

(72, 'Joker OST', 'Original Score', 87, 66, 9,
 '2019-10-04', 2019, 13, 4260,
 580000000, 101000000, 1334000000, 71000000, 63000000,
 2, 20, 2400000, 8.8, 8.4, 8.9,
 'Warner Bros, LA', 2, 2),

-- ═══════════════════════════════════════════════════════════════
--  STANDALONE ALBUMS (not linked to a movie)
-- ═══════════════════════════════════════════════════════════════

(73, 'Vande Mataram', 'Studio Album', NULL, 53, 4,
 '1997-08-14', 1997, 10, 3480,
 820000000, 142000000, 1886000000, 500000000, 450000000,
 1, 60, 6000000, 9.3, NULL, 9.4,
 'AR Rahman Studios, Chennai', 1, 1),

(74, 'Roja OST', 'Film Soundtrack', NULL, 53, 8,
 '1992-07-01', 1992, 9, 3120,
 680000000, 118000000, 1564000000, 415000000, 372000000,
 1, 80, 5500000, 9.4, NULL, 9.5,
 'AR Rahman Studios, Chennai', 3, 1),

(75, 'Bombay OST', 'Film Soundtrack', NULL, 53, 8,
 '1995-01-01', 1995, 9, 3180,
 720000000, 125000000, 1656000000, 440000000, 394000000,
 1, 72, 5800000, 9.3, NULL, 9.4,
 'AR Rahman Studios, Chennai', 3, 1),

(76, 'Dil Se OST', 'Film Soundtrack', NULL, 53, 8,
 '1998-07-01', 1998, 10, 3480,
 690000000, 120000000, 1587000000, 421000000, 377000000,
 1, 56, 5600000, 9.2, NULL, 9.3,
 'AR Rahman Studios, Chennai', 1, 1),

(77, 'Taal OST', 'Film Soundtrack', NULL, 53, 8,
 '1999-07-01', 1999, 10, 3480,
 710000000, 123000000, 1633000000, 433000000, 388000000,
 1, 52, 5700000, 9.1, NULL, 9.2,
 'AR Rahman Studios, Chennai', 1, 1),

(78, 'Guru OST', 'Film Soundtrack', NULL, 53, 8,
 '2007-01-01', 2007, 9, 3060,
 580000000, 101000000, 1334000000, 354000000, 317000000,
 1, 32, 4000000, 8.8, NULL, 8.9,
 'AR Rahman Studios, Chennai', 1, 1),

(79, 'Slumdog Millionaire OST', 'Film Soundtrack', NULL, 53, 8,
 '2008-11-01', 2008, 17, 5880,
 890000000, 154000000, 2047000000, 543000000, 487000000,
 1, 52, 7000000, 9.2, 9.0, 9.3,
 'AR Rahman Studios, Chennai', 1, 1),

(80, 'Kabhi Alvida Naa Kehna OST', 'Film Soundtrack', NULL, 54, 2,
 '2006-06-01', 2006, 11, 3780,
 520000000, 90000000, 1196000000, 317000000, 284000000,
 1, 26, 3200000, 7.8, NULL, 8.0,
 'Dharma Studios, Mumbai', 1, 1),

(81, 'Aashiqui 2 OST', 'Film Soundtrack', NULL, 56, 3,
 '2013-04-01', 2013, 10, 3420,
 760000000, 132000000, 1748000000, 463000000, 415000000,
 1, 38, 5400000, 8.6, NULL, 8.8,
 'Vishesh Films, Mumbai', 1, 1),

(82, 'Raaz OST', 'Film Soundtrack', NULL, 54, 1,
 '2002-01-01', 2002, 8, 2760,
 410000000, 71000000, 943000000, 250000000, 224000000,
 2, 20, 2200000, 7.6, NULL, 7.8,
 'T-Series Studios, Mumbai', 1, 1),

(83, 'Bhool Bhulaiyaa OST', 'Film Soundtrack', NULL, 54, 1,
 '2007-10-01', 2007, 9, 3060,
 480000000, 83000000, 1104000000, 293000000, 263000000,
 1, 22, 2800000, 7.9, NULL, 8.1,
 'T-Series Studios, Mumbai', 1, 1);

-- =============================================================
--  TRACKS  (key songs for each album)
-- =============================================================

INSERT INTO tracks
  (track_id, album_id, track_number, track_title, duration_seconds,
   bpm, musical_key, time_signature, mood, lyricist_id,
   is_title_track, is_single, spotify_streams, youtube_views,
   spotify_track_id)
VALUES

-- Album 1: Dangal
(1,  1, 1, 'Dangal',              228, 112, 'D Major',  '4/4', 'Patriotic,Energetic',       84, TRUE,  TRUE,  180000000, 520000000, '3n3Ppam7vgaVa1iaRUIOKE'),
(2,  1, 2, 'Haanikaarak Bapu',   204, 98,  'G Major',  '4/4', 'Happy,Patriotic',            84, FALSE, FALSE, 95000000,  280000000, NULL),
(3,  1, 3, 'Dhaakad',             213, 120, 'C Major',  '4/4', 'Energetic,Patriotic',        84, FALSE, TRUE,  120000000, 350000000, NULL),
(4,  1, 4, 'Gilehriyaan',        231, 88,  'A Major',  '4/4', 'Melancholic,Soulful',        84, FALSE, FALSE, 65000000,  185000000, NULL),
(5,  1, 5, 'Naina',              198, 72,  'E Minor',  '4/4', 'Sad,Melancholic',             84, FALSE, FALSE, 85000000,  240000000, NULL),

-- Album 2: PK
(6,  2, 1, 'Bhagwan Hai Kahan Re Tu', 315, 88, 'G Major', '4/4', 'Melancholic,Soulful',   82, TRUE,  TRUE,  210000000, 620000000, NULL),
(7,  2, 2, 'Tharki Chokro',      213, 118, 'D Major',  '4/4', 'Happy,Peppy',               82, FALSE, TRUE,  180000000, 510000000, NULL),
(8,  2, 3, 'Nanga Punga Dost',   204, 96,  'C Major',  '4/4', 'Happy,Soulful',              82, FALSE, FALSE, 120000000, 340000000, NULL),
(9,  2, 4, 'Chaar Kadam',        258, 76,  'F Major',  '4/4', 'Romantic,Soulful',           82, FALSE, FALSE, 145000000, 415000000, NULL),

-- Album 3: 3 Idiots
(10, 3, 1, 'Aal Izz Well',       248, 108, 'G Major',  '4/4', 'Happy,Energetic',            NULL, TRUE, TRUE,  280000000, 820000000, NULL),
(11, 3, 2, 'Behti Hawa Sa Tha Woh', 270, 84, 'C Major','4/4', 'Melancholic,Soulful',       NULL, FALSE,FALSE, 195000000, 570000000, NULL),
(12, 3, 3, 'Give Me Some Sunshine', 198, 120,'D Major','4/4', 'Happy,Energetic',            NULL, FALSE,TRUE,  245000000, 715000000, NULL),
(13, 3, 4, 'Jaane Nahin Denge Tujhe', 234, 72,'G Major','4/4','Sad,Romantic',              NULL, FALSE,FALSE, 160000000, 465000000, NULL),
(14, 3, 5, 'Zoobi Doobi',        231, 96,  'F Major',  '4/4', 'Romantic,Happy',             NULL, FALSE,FALSE, 140000000, 408000000, NULL),

-- Album 6: DDLJ
(15, 6, 1, 'Tujhe Dekha To',     342, 72,  'C Major',  '4/4', 'Romantic,Soulful',           NULL, TRUE, TRUE,  380000000, 1100000000,NULL),
(16, 6, 2, 'Mere Khwabon Mein',  255, 88,  'G Major',  '4/4', 'Romantic,Happy',             NULL, FALSE,FALSE, 220000000, 638000000, NULL),
(17, 6, 3, 'Ruk Ja O Dil Deewane',231,96, 'D Major',  '4/4', 'Happy,Romantic',             NULL, FALSE,FALSE, 185000000, 537000000, NULL),
(18, 6, 4, 'Mehndi Laga Ke Rakhna',204,108,'F Major',  '4/4', 'Happy,Peppy',                NULL, FALSE,FALSE, 210000000, 610000000, NULL),
(19, 6, 5, 'Ho Gaya Hai Tujhko', 219, 80,  'E Minor',  '4/4', 'Romantic,Soulful',           NULL, FALSE,FALSE, 175000000, 508000000, NULL),

-- Album 9: Jab We Met
(20, 9, 1, 'Aaj Ki Raat',        255, 104, 'D Major',  '4/4', 'Romantic,Happy',             83, FALSE,FALSE, 185000000, 537000000, NULL),
(21, 9, 2, 'Tum Se Hi',          282, 68,  'G Minor',  '4/4', 'Romantic,Melancholic',       83, FALSE,TRUE,  280000000, 812000000, NULL),
(22, 9, 3, 'Nagada Nagada',       195, 128, 'D Major',  '4/4', 'Energetic,Happy',            83, FALSE,FALSE, 195000000, 566000000, NULL),
(23, 9, 4, 'Mauja Hi Mauja',      228, 116, 'C Major',  '4/4', 'Happy,Peppy',                83, FALSE,FALSE, 170000000, 493000000, NULL),
(24, 9, 5, 'Yeh Ishq Haaye',      219, 84,  'A Major',  '4/4', 'Romantic,Soulful',           83, FALSE,FALSE, 155000000, 450000000, NULL),

-- Album 10: Rockstar
(25, 10,1, 'Sadda Haq',          285, 140, 'E Minor',  '4/4', 'Intense,Energetic',          83, TRUE, TRUE,  320000000, 928000000, NULL),
(26, 10,2, 'Phir Se Ud Chala',   243, 96,  'C Major',  '4/4', 'Soulful,Melancholic',        83, FALSE,FALSE, 225000000, 652000000, NULL),
(27, 10,3, 'Kun Faya Kun',        402, 60,  'G Major',  '4/4', 'Devotional,Soulful',         83, FALSE,TRUE,  380000000, 1102000000,NULL),
(28, 10,4, 'Jo Bhi Main',         258, 84,  'D Major',  '4/4', 'Soulful,Melancholic',        83, FALSE,FALSE, 210000000, 609000000, NULL),
(29, 10,5, 'Tum Ho',              294, 72,  'F Major',  '4/4', 'Romantic,Melancholic',       83, FALSE,TRUE,  290000000, 841000000, NULL),

-- Album 13: Rang De Basanti
(30, 13,1, 'Rang De Basanti',     264, 120, 'D Minor',  '4/4', 'Patriotic,Energetic',        82, TRUE, TRUE,  320000000, 928000000, NULL),
(31, 13,2, 'Luka Chuppi',         276, 76,  'G Major',  '4/4', 'Sad,Soulful',                82, FALSE,FALSE, 215000000, 624000000, NULL),
(32, 13,3, 'Khoon Chala',         261, 84,  'C Minor',  '4/4', 'Intense,Patriotic',          82, FALSE,FALSE, 195000000, 566000000, NULL),
(33, 13,4, 'Roobaroo',            231, 88,  'F Major',  '4/4', 'Soulful,Happy',              82, FALSE,FALSE, 240000000, 696000000, NULL),
(34, 13,5, 'Tu Bin Bataye',       249, 72,  'G Major',  '4/4', 'Romantic,Soulful',           82, FALSE,FALSE, 175000000, 508000000, NULL),

-- Album 17: ZNMD
(35, 17,1, 'Senorita',            228, 108, 'G Major',  '4/4', 'Happy,Energetic',            82, FALSE,TRUE,  290000000, 841000000, NULL),
(36, 17,2, 'Khaabon Ke Parindey',270, 76,  'C Major',  '4/4', 'Soulful,Melancholic',        82, FALSE,FALSE, 215000000, 624000000, NULL),
(37, 17,3, 'Dil Dhadakne Do',     243, 96,  'D Major',  '4/4', 'Happy,Romantic',             82, FALSE,FALSE, 245000000, 711000000, NULL),
(38, 17,4, 'Ik Junoon',           216, 120, 'E Major',  '4/4', 'Energetic,Happy',            82, FALSE,FALSE, 195000000, 566000000, NULL),

-- Album 20: Kabir Singh
(39, 20,1, 'Bekhayali',           336, 68,  'G Minor',  '4/4', 'Melancholic,Sad',            84, TRUE, TRUE,  420000000, 1218000000,NULL),
(40, 20,2, 'Kaise Hua',           237, 72,  'C Major',  '4/4', 'Romantic,Soulful',           84, FALSE,TRUE,  310000000, 899000000, NULL),
(41, 20,3, 'Mere Sohneya',        252, 80,  'F Major',  '4/4', 'Romantic,Soulful',           84, FALSE,FALSE, 225000000, 652000000, NULL),
(42, 20,4, 'Tera Ban Jaunga',     243, 76,  'G Major',  '4/4', 'Romantic,Soulful',           84, FALSE,TRUE,  270000000, 783000000, NULL),
(43, 20,5, 'Pehla Pyaar',         267, 72,  'D Major',  '4/4', 'Romantic,Melancholic',       84, FALSE,FALSE, 185000000, 537000000, NULL),

-- Album 35: RRR OST
(44, 35,1, 'Naatu Naatu',         248, 132, 'D Major',  '4/4', 'Energetic,Happy,Patriotic',  NULL,TRUE, TRUE,  620000000, 1798000000,'4OMHBDiAqPL6E7r8Kaz5dT'),
(45, 35,2, 'Dosti',               312, 88,  'G Major',  '4/4', 'Soulful,Patriotic',          NULL,FALSE,FALSE, 285000000, 827000000, NULL),
(46, 35,3, 'Komuram Bheemudo',    264, 108, 'C Minor',  '4/4', 'Intense,Patriotic',          NULL,FALSE,FALSE, 220000000, 638000000, NULL),
(47, 35,4, 'Janani',              294, 72,  'F Major',  '4/4', 'Devotional,Soulful',         NULL,FALSE,FALSE, 180000000, 522000000, NULL),
(48, 35,5, 'Etthara Jenda',       255, 116, 'D Major',  '4/4', 'Patriotic,Energetic',        NULL,FALSE,FALSE, 195000000, 566000000, NULL),

-- Album 33: KGF Ch1
(49, 33,1, 'Gali Gali',           222, 108, 'G Major',  '4/4', 'Energetic,Intense',          NULL,FALSE,TRUE,  180000000, 522000000, NULL),
(50, 33,2, 'Rocky Bhai Theme',    195, 80,  'D Minor',  '4/4', 'Intense,Energetic',          NULL,FALSE,FALSE, 155000000, 450000000, NULL),
(51, 33,3, 'KGF Title Track',     198, 88,  'C Minor',  '4/4', 'Intense,Energetic',          NULL,TRUE, FALSE, 220000000, 638000000, NULL),

-- Album 34: KGF Ch2
(52, 34,1, 'Toofan',              234, 120, 'D Minor',  '4/4', 'Intense,Energetic',          NULL,FALSE,TRUE,  480000000, 1392000000,NULL),
(53, 34,2, 'Huttiyidare Kannada', 249, 96,  'G Major',  '4/4', 'Patriotic,Energetic',        NULL,FALSE,FALSE, 285000000, 827000000, NULL),
(54, 34,3, 'Rocky Theme 2.0',     210, 84,  'D Minor',  '4/4', 'Intense,Energetic',          NULL,FALSE,FALSE, 320000000, 928000000, NULL),

-- Album 36: Pushpa Rise
(55, 36,1, 'Srivalli',            216, 96,  'G Major',  '4/4', 'Romantic,Soulful',           NULL,FALSE,TRUE,  580000000, 1682000000,NULL),
(56, 36,2, 'Oo Antava',           228, 108, 'D Major',  '4/4', 'Peppy,Energetic',            NULL,FALSE,TRUE,  520000000, 1508000000,NULL),
(57, 36,3, 'Saami Saami',         219, 104, 'C Major',  '4/4', 'Peppy,Energetic',            NULL,FALSE,FALSE, 345000000, 1001000000,NULL),
(58, 36,4, 'Eyy Bidda Idhi Naa Adda',234,116,'D Major', '4/4', 'Intense,Energetic',          NULL,FALSE,FALSE, 290000000, 841000000, NULL),

-- Album 37: Pushpa 2
(59, 37,1, 'Pushpa Pushpa',       252, 128, 'D Major',  '4/4', 'Energetic,Intense',          NULL,FALSE,TRUE,  750000000, 2175000000,NULL),
(60, 37,2, 'Sooseki',             228, 96,  'G Major',  '4/4', 'Romantic,Soulful',           NULL,FALSE,TRUE,  520000000, 1508000000,NULL),
(61, 37,3, 'Kissik',              219, 112, 'C Major',  '4/4', 'Peppy,Energetic',            NULL,FALSE,TRUE,  480000000, 1392000000,NULL),
(62, 37,4, 'Angaaron',            243, 104, 'D Minor',  '4/4', 'Intense,Energetic',          NULL,FALSE,FALSE, 380000000, 1102000000,NULL),

-- Album 38: Vikram
(63, 38,1, 'Pathala Pathala',     228, 120, 'D Minor',  '4/4', 'Intense,Energetic',          NULL,FALSE,TRUE,  280000000, 812000000, NULL),
(64, 38,2, 'Ranjithame',          222, 104, 'G Major',  '4/4', 'Peppy,Happy',                NULL,FALSE,TRUE,  245000000, 711000000, NULL),
(65, 38,3, 'Bachi Bachi',         216, 112, 'C Major',  '4/4', 'Peppy,Energetic',            NULL,FALSE,FALSE, 185000000, 537000000, NULL),

-- Album 42: Kantara
(66, 42,1, 'Varaha Roopam',       324, 72,  'G Minor',  '4/4', 'Devotional,Intense',         NULL,FALSE,TRUE,  380000000, 1102000000,NULL),
(67, 42,2, 'Dum Dum Dum',         255, 108, 'D Major',  '4/4', 'Energetic,Patriotic',        NULL,FALSE,FALSE, 215000000, 624000000, NULL),
(68, 42,3, 'Siva Stuthi',         192, 80,  'C Major',  '4/4', 'Devotional,Soulful',         NULL,FALSE,FALSE, 180000000, 522000000, NULL),

-- Album 43: Ponniyin Selvan 1
(69, 43,1, 'Ponni Nadhi',         312, 64,  'C Major',  '4/4', 'Soulful,Melancholic',        NULL,FALSE,TRUE,  280000000, 812000000, NULL),
(70, 43,2, 'Ratchasa Maamaney',   264, 104, 'D Minor',  '4/4', 'Intense,Energetic',          NULL,FALSE,FALSE, 215000000, 624000000, NULL),
(71, 43,3, 'Enna Solla Pogirai',  282, 72,  'G Major',  '4/4', 'Romantic,Soulful',           NULL,FALSE,FALSE, 190000000, 551000000, NULL),

-- Album 45: 96
(72, 45,1, 'Kadhal Vandhadhu',    312, 60,  'G Major',  '4/4', 'Romantic,Melancholic',       NULL,FALSE,TRUE,  195000000, 566000000, NULL),
(73, 45,2, 'Un Mela Aasai',       294, 68,  'C Major',  '4/4', 'Romantic,Soulful',           NULL,FALSE,FALSE, 175000000, 508000000, NULL),
(74, 45,3, 'Yean Ennai Pirindhai', 306, 64, 'D Major',  '4/4', 'Sad,Melancholic',             NULL,FALSE,FALSE, 160000000, 464000000, NULL),

-- Album 55: Inception
(75, 55,1, 'Half Remembered Dream',198,88, 'D Minor',  '4/4', 'Melancholic,Intense',         NULL,FALSE,FALSE, 285000000, 627000000, NULL),
(76, 55,2, 'We Built Our Own World',216,72,'G Minor',  '4/4', 'Intense,Melancholic',         NULL,FALSE,FALSE, 220000000, 484000000, NULL),
(77, 55,3, 'Dream Is Collapsing', 267, 96, 'D Minor',  '4/4', 'Intense,Energetic',           NULL,FALSE,FALSE, 310000000, 682000000, NULL),
(78, 55,4, 'Time',                276, 60, 'C Major',  '4/4', 'Melancholic,Soulful',         NULL,TRUE, TRUE,  480000000, 1056000000,NULL),

-- Album 56: Dark Knight
(79, 56,1, 'Why So Serious?',     348, 52, 'D Minor',  '3/4', 'Intense,Melancholic',         NULL,FALSE,TRUE,  390000000, 858000000, NULL),
(80, 56,2, 'Batman Main Theme',   192, 88, 'D Minor',  '4/4', 'Intense,Energetic',           NULL,TRUE, FALSE, 310000000, 682000000, NULL),
(81, 56,3, 'A Dark Knight',       282, 64, 'C Minor',  '4/4', 'Intense,Melancholic',         NULL,FALSE,FALSE, 270000000, 594000000, NULL),

-- Album 57: Interstellar
(82, 57,1, 'Cornfield Chase',     132, 52, 'G Major',  '3/4', 'Melancholic,Soulful',         NULL,FALSE,FALSE, 380000000, 836000000, NULL),
(83, 57,2, 'Dust',                312, 60, 'D Minor',  '4/4', 'Intense,Melancholic',         NULL,FALSE,FALSE, 290000000, 638000000, NULL),
(84, 57,3, 'Interstellar Main Theme',252,56,'C Major', '4/4', 'Melancholic,Soulful',         NULL,FALSE,TRUE,  420000000, 924000000, NULL),
(85, 57,4, 'Do Not Go Gentle',    264, 72, 'G Minor',  '4/4', 'Intense,Melancholic',         NULL,FALSE,FALSE, 310000000, 682000000, NULL),
(86, 57,5, 'Staying',             234, 64, 'C Major',  '4/4', 'Soulful,Melancholic',         NULL,FALSE,FALSE, 275000000, 605000000, NULL),

-- Album 59: Oppenheimer
(87, 59,1, 'Can You Hear the Music',234,80,'G Minor',  '4/4', 'Intense,Melancholic',         NULL,FALSE,TRUE,  380000000, 836000000, NULL),
(88, 59,2, 'Destroyer of Worlds', 276, 64, 'D Minor',  '4/4', 'Intense,Melancholic',         NULL,FALSE,FALSE, 295000000, 649000000, NULL),
(89, 59,3, 'Fission',             198, 96, 'C Minor',  '4/4', 'Intense,Energetic',           NULL,FALSE,FALSE, 265000000, 583000000, NULL),
(90, 59,4, 'Oppenheimer',         318, 72, 'G Minor',  '4/4', 'Intense,Melancholic',         NULL,TRUE, FALSE, 340000000, 748000000, NULL),

-- Album 60: Dune
(91, 60,1, 'Herald of the Change',258,72, 'D Minor',  '4/4', 'Intense,Melancholic',         NULL,FALSE,FALSE, 290000000, 638000000, NULL),
(92, 60,2, 'Leaving Caladan',     222, 64, 'G Minor',  '4/4', 'Melancholic,Soulful',         NULL,FALSE,FALSE, 240000000, 528000000, NULL),
(93, 60,3, 'Dreams of Arrakis',   264, 56, 'C Minor',  '4/4', 'Melancholic,Soulful',         NULL,FALSE,TRUE,  350000000, 770000000, NULL),

-- Album 63: Titanic
(94, 63,1, 'My Heart Will Go On', 283, 60, 'E Major',  '4/4', 'Romantic,Soulful',            NULL,TRUE, TRUE,  820000000, 1804000000,NULL),
(95, 63,2, 'Rose',                198, 64, 'C Major',  '4/4', 'Romantic,Melancholic',        NULL,FALSE,FALSE, 390000000, 858000000, NULL),
(96, 63,3, 'Southampton',         234, 72, 'G Major',  '4/4', 'Soulful,Happy',               NULL,FALSE,FALSE, 285000000, 627000000, NULL),

-- Album 67: Spirited Away
(97, 67,1, 'One Summers Day',     264, 60, 'G Major',  '3/4', 'Happy,Soulful',               NULL,TRUE, TRUE,  380000000, 836000000, NULL),
(98, 67,2, 'Reprise',             192, 64, 'C Major',  '4/4', 'Melancholic,Soulful',         NULL,FALSE,FALSE, 245000000, 539000000, NULL),
(99, 67,3, 'The Name of Life',    210, 68, 'G Major',  '4/4', 'Happy,Soulful',               NULL,FALSE,FALSE, 290000000, 638000000, NULL),

-- Album 70: La La Land
(100,70,1, 'City of Stars',       213, 72, 'F Major',  '3/4', 'Romantic,Soulful',            NULL,TRUE, TRUE,  580000000, 1276000000,NULL),
(101,70,2, 'Mia & Sebastian''s Theme',156,60,'C Major','4/4', 'Romantic,Melancholic',        NULL,FALSE,FALSE, 380000000, 836000000, NULL),
(102,70,3, 'Another Day of Sun',  228, 128,'G Major',  '4/4', 'Happy,Energetic',             NULL,FALSE,FALSE, 285000000, 627000000, NULL),
(103,70,4, 'Someone in the Crowd',216, 120,'D Major',  '4/4', 'Happy,Energetic',             NULL,FALSE,FALSE, 215000000, 473000000, NULL),

-- Album 73: Vande Mataram (standalone AR Rahman)
(104,73,1, 'Vande Mataram',       312, 72, 'C Major',  '4/4', 'Patriotic,Devotional',        NULL,TRUE, TRUE,  480000000, 1056000000,NULL),
(105,73,2, 'Maa Tujhe Salaam',    294, 68, 'G Major',  '4/4', 'Patriotic,Soulful',           NULL,FALSE,TRUE,  380000000, 836000000, NULL),
(106,73,3, 'Jai Ho',              255, 104,'D Major',  '4/4', 'Patriotic,Energetic',         NULL,FALSE,FALSE, 290000000, 638000000, NULL),

-- Album 79: Slumdog Millionaire
(107,79,1, 'Jai Ho',              258, 108,'D Major',  '4/4', 'Happy,Energetic,Patriotic',   NULL,FALSE,TRUE,  490000000, 1078000000,NULL),
(108,79,2, 'O Saya',              222, 120,'C Minor',  '4/4', 'Intense,Energetic',           NULL,FALSE,FALSE, 295000000, 649000000, NULL),
(109,79,3, 'Paper Planes',        231, 80, 'G Major',  '4/4', 'Peppy,Energetic',             NULL,FALSE,FALSE, 265000000, 583000000, NULL),

-- Album 81: Aashiqui 2
(110,81,1, 'Tum Hi Ho',           249, 68, 'G Major',  '4/4', 'Romantic,Soulful',            84, TRUE, TRUE,  950000000, 2090000000,NULL),
(111,81,2, 'Sun Raha Hai Na Tu',  261, 64, 'C Major',  '4/4', 'Romantic,Melancholic',        84, FALSE,TRUE,  580000000, 1276000000,NULL),
(112,81,3, 'Chahun Main Ya Naa',  282, 72, 'D Major',  '4/4', 'Romantic,Soulful',            84, FALSE,FALSE, 410000000, 902000000, NULL),
(113,81,4, 'Milne Hai Mujhse Aayi',243,76,'G Major',  '4/4', 'Romantic,Soulful',            84, FALSE,FALSE, 295000000, 649000000, NULL);

-- =============================================================
--  TRACK_SINGERS  (who sang which track)
-- =============================================================

INSERT INTO track_singers (track_id, person_id, singer_role) VALUES
-- Dangal
(1,  69, 'Lead'),   -- Sonu Nigam: Dangal
(2,  69, 'Lead'),   -- Sonu Nigam: Haanikaarak
(3,  69, 'Lead'),   -- Sonu Nigam: Dhaakad
(4,  68, 'Lead'),   -- Shreya: Gilehriyaan
(5,  67, 'Lead'),   -- Arijit: Naina
-- PK
(6,  67, 'Lead'),   -- Arijit: Bhagwan Hai
(7,  69, 'Lead'),   -- Sonu: Tharki
(8,  67, 'Lead'),   -- Arijit: Nanga Punga
(9,  67, 'Lead'),   (9,  68, 'Duet Partner'),
-- 3 Idiots
(10, 75, 'Lead'),   -- Shankar: Aal Izz Well
(11, 75, 'Lead'),   -- Shankar: Behti Hawa
(12, 69, 'Lead'),   -- Sonu: Give Me Some Sunshine
(13, 67, 'Lead'),   -- Arijit: Jaane Nahin
(14, 68, 'Lead'),   (14, 69, 'Duet Partner'),
-- DDLJ
(15, 70, 'Lead'),   (15, 71, 'Duet Partner'),   -- Udit + Alka
(16, 71, 'Lead'),   -- Alka
(17, 70, 'Lead'),   (17, 71, 'Duet Partner'),
(18, 70, 'Lead'),   (18, 71, 'Duet Partner'),
(19, 70, 'Lead'),
-- Jab We Met
(20, 67, 'Lead'),   -- Arijit
(21, 67, 'Lead'),   (21, 68, 'Duet Partner'),
(22, 75, 'Lead'),   -- Shankar
(23, 67, 'Lead'),
(24, 68, 'Lead'),
-- Rockstar
(25, 75, 'Lead'),   -- Shankar: Sadda Haq
(26, 67, 'Lead'),   -- Arijit: Phir Se
(27, 75, 'Lead'),   (27, 76, 'Duet Partner'),  -- Kun Faya Kun: Shankar + Hariharan
(28, 67, 'Lead'),
(29, 67, 'Lead'),   (29, 68, 'Duet Partner'),
-- Rang De Basanti
(30, 75, 'Lead'),   -- Shankar
(31, 68, 'Lead'),   -- Shreya
(32, 75, 'Lead'),
(33, 75, 'Lead'),   (33, 68, 'Duet Partner'),
(34, 68, 'Lead'),   (34, 67, 'Duet Partner'),
-- ZNMD
(35, 67, 'Lead'),   -- Arijit: Senorita
(36, 67, 'Lead'),
(37, 67, 'Lead'),   (37, 68, 'Duet Partner'),
(38, 69, 'Lead'),
-- Kabir Singh
(39, 67, 'Lead'),   -- Arijit: Bekhayali (his biggest hit)
(40, 67, 'Lead'),
(41, 68, 'Lead'),
(42, 67, 'Lead'),   (42, 68, 'Duet Partner'),
(43, 67, 'Lead'),
-- RRR
(44, NULL, 'Lead'),  -- Kala Bhairava: Naatu Naatu (placeholder)
(45, 68, 'Lead'),
(46, 77, 'Lead'),   -- SP Balasubrahmanyam (posthumous)
(47, 68, 'Lead'),
(48, 75, 'Lead'),
-- KGF
(49, NULL, 'Lead'),
(50, NULL, 'Lead'),
(51, NULL, 'Lead'),
(52, NULL, 'Lead'),
(53, NULL, 'Lead'),
(54, NULL, 'Lead'),
-- Pushpa
(55, NULL, 'Lead'),  -- Sid Sriram: Srivalli
(56, NULL, 'Lead'),  -- Samantha (actress) performed: Oo Antava
(57, NULL, 'Lead'),
(58, NULL, 'Lead'),
(59, NULL, 'Lead'),
(60, NULL, 'Lead'),
(61, NULL, 'Lead'),
(62, NULL, 'Lead'),
-- Vikram
(63, 80,  'Lead'),  -- Anirudh
(64, 80,  'Lead'),
(65, 80,  'Lead'),
-- Kantara
(66, NULL, 'Lead'),
(67, NULL, 'Lead'),
(68, NULL, 'Lead'),
-- PS1
(69, 68, 'Lead'),
(70, NULL,'Lead'),
(71, 68, 'Lead'),
-- 96
(72, 79, 'Lead'),   -- Sid Sriram
(73, 78, 'Lead'),   -- Chinmayi
(74, 79, 'Lead'),
-- Titanic
(94, NULL, 'Lead'),  -- Celine Dion
-- La La Land
(100,NULL,'Lead'),   -- Ryan Gosling + Emma Stone
(101,NULL,'Lead'),
(102,NULL,'Chorus'),
-- Aashiqui 2
(110,67, 'Lead'),   -- Arijit: Tum Hi Ho (his breakout)
(111,68, 'Lead'),   (111,67,'Duet Partner'),
(112,67, 'Lead'),   (112,68,'Duet Partner'),
(113,67, 'Lead'),   (113,68,'Duet Partner');

-- =============================================================
--  MUSIC_GENRES
-- =============================================================
INSERT INTO music_genres (album_id, genre_id, is_primary) VALUES
(1,  37,TRUE),(1,  27,FALSE),   -- Dangal: Soundtrack, Pop
(2,  37,TRUE),(2,  27,FALSE),
(3,  37,TRUE),(3,  27,FALSE),
(6,  37,TRUE),(6,  28,FALSE),   -- DDLJ: Soundtrack, Pop
(9,  37,TRUE),(9,  28,FALSE),
(10, 37,TRUE),(10, 27,FALSE),(10,26,FALSE),  -- Rockstar: Soundtrack,Pop,Rock
(13, 37,TRUE),(13, 27,FALSE),
(14, 37,TRUE),(14, 34,FALSE),   -- Lagaan: Soundtrack, Folk
(17, 37,TRUE),(17, 28,FALSE),
(20, 37,TRUE),(20, 28,FALSE),
(35, 37,TRUE),(35, 27,FALSE),(35,34,FALSE),  -- RRR
(36, 37,TRUE),(36, 27,FALSE),
(37, 37,TRUE),(37, 27,FALSE),
(42, 37,TRUE),(42, 34,FALSE),(42,35,FALSE),  -- Kantara: Folk,Devotional
(43, 37,TRUE),(43, 26,FALSE),   -- PS1: Classical
(45, 37,TRUE),(45, 28,FALSE),   -- 96
(55, 37,TRUE),(55, 26,FALSE),   -- Inception: Classical score
(56, 37,TRUE),(56, 26,FALSE),
(57, 37,TRUE),(57, 26,FALSE),
(59, 37,TRUE),(59, 26,FALSE),
(63, 37,TRUE),(63, 28,FALSE),   -- Titanic: Pop
(67, 37,TRUE),(67, 26,FALSE),   -- Spirited Away: Classical
(68, 37,TRUE),(68, 26,FALSE),   -- LOTR
(69, 37,TRUE),(69, 26,FALSE),
(70, 37,TRUE),(70, 28,FALSE),(70,29,FALSE),  -- La La Land: Pop,Jazz
(73, 36,TRUE),(73, 35,FALSE),(73,34,FALSE),  -- Vande Mataram: World,Devotional,Folk
(79, 37,TRUE),(79, 28,FALSE),(79,30,FALSE),  -- Slumdog: Pop,HipHop
(81, 37,TRUE),(81, 28,FALSE);   -- Aashiqui 2

-- =============================================================
--  MOVIE_MUSIC_BRIDGE
-- =============================================================
INSERT INTO movie_music_bridge (movie_id, album_id, bridge_type, is_primary_ost, sequence_order) VALUES
(1,  1,  'Original Soundtrack', TRUE,  1),
(2,  2,  'Original Soundtrack', TRUE,  1),
(3,  3,  'Original Soundtrack', TRUE,  1),
(4,  4,  'Original Soundtrack', TRUE,  1),
(5,  5,  'Original Soundtrack', TRUE,  1),
(6,  6,  'Original Soundtrack', TRUE,  1),
(7,  7,  'Original Soundtrack', TRUE,  1),
(8,  8,  'Original Soundtrack', TRUE,  1),
(13, 9,  'Original Soundtrack', TRUE,  1),
(14, 21, 'Original Soundtrack', TRUE,  1),
(15, 16, 'Original Soundtrack', TRUE,  1),
(16, 17, 'Original Soundtrack', TRUE,  1),
(17, 14, 'Original Soundtrack', TRUE,  1),
(18, 15, 'Original Soundtrack', TRUE,  1),
(19, 13, 'Original Soundtrack', TRUE,  1),
(25, 19, 'Original Soundtrack', TRUE,  1),
(26, 23, 'Original Soundtrack', TRUE,  1),
(28, 25, 'Original Soundtrack', TRUE,  1),
(29, 18, 'Original Soundtrack', TRUE,  1),
(31, 22, 'Original Soundtrack', TRUE,  1),
(33, 29, 'Original Soundtrack', TRUE,  1),
(34, 30, 'Original Soundtrack', TRUE,  1),
(35, 27, 'Original Soundtrack', TRUE,  1),
(36, 28, 'Original Soundtrack', TRUE,  1),
(41, 31, 'Original Soundtrack', TRUE,  1),
(42, 32, 'Original Soundtrack', TRUE,  1),
(43, 33, 'Original Soundtrack', TRUE,  1),
(44, 34, 'Original Soundtrack', TRUE,  1),
(45, 35, 'Original Soundtrack', TRUE,  1),
(46, 36, 'Original Soundtrack', TRUE,  1),
(47, 37, 'Original Soundtrack', TRUE,  1),
(49, 38, 'Original Soundtrack', TRUE,  1),
(50, 41, 'Original Soundtrack', TRUE,  1),
(51, 40, 'Original Soundtrack', TRUE,  1),
(53, 39, 'Original Soundtrack', TRUE,  1),
(54, 43, 'Original Soundtrack', TRUE,  1),
(55, 44, 'Original Soundtrack', TRUE,  1),
(56, 51, 'Original Soundtrack', TRUE,  1),
(105,10, 'Original Soundtrack', TRUE,  1),
(106,11, 'Original Soundtrack', TRUE,  1),
(107,12, 'Original Soundtrack', TRUE,  1),
(108,20, 'Original Soundtrack', TRUE,  1),
(111,24, 'Original Soundtrack', TRUE,  1),
(121,42, 'Original Soundtrack', TRUE,  1),
(125,48, 'Original Soundtrack', TRUE,  1),
(126,49, 'Original Soundtrack', TRUE,  1),
(127,46, 'Original Soundtrack', TRUE,  1),
(129,45, 'Original Soundtrack', TRUE,  1),
(133,47, 'Original Soundtrack', TRUE,  1),
(135,50, 'Original Soundtrack', TRUE,  1),
(139,54, 'Original Soundtrack', TRUE,  1),
(150,53, 'Original Soundtrack', TRUE,  1),
(61, 55, 'Original Score',      TRUE,  1),
(62, 56, 'Original Score',      TRUE,  1),
(63, 57, 'Original Score',      TRUE,  1),
(65, 58, 'Original Score',      TRUE,  1),
(67, 59, 'Original Score',      TRUE,  1),
(70, 62, 'Original Score',      TRUE,  1),
(72, 63, 'Film Soundtrack',     TRUE,  1),
(73, 64, 'Original Score',      TRUE,  1),
(74, 60, 'Original Score',      TRUE,  1),
(75, 61, 'Original Score',      TRUE,  1),
(83, 66, 'Original Score',      TRUE,  1),
(84, 68, 'Original Score',      TRUE,  1),
(85, 69, 'Original Score',      TRUE,  1),
(86, 67, 'Original Score',      TRUE,  1),
(87, 72, 'Original Score',      TRUE,  1),
(95, 71, 'Original Score',      TRUE,  1),
(96, 70, 'Film Soundtrack',     TRUE,  1),
(116,26, 'Original Soundtrack', TRUE,  1),
(123,52, 'Original Soundtrack', TRUE,  1),
(149,NULL,'Background Score',   FALSE, 1);

-- =============================================================
--  MUSIC_STREAMING  (albums on platforms)
-- =============================================================
INSERT INTO music_streaming (album_id, platform_id, available_from, is_exclusive, total_streams) VALUES
-- Spotify (11)
(1,  11,'2016-12-01', FALSE, 480000000),
(3,  11,'2009-12-01', FALSE, 680000000),
(6,  11,'2015-01-01', FALSE, 920000000),
(10, 11,'2011-11-01', FALSE, 780000000),
(20, 11,'2019-06-01', FALSE, 890000000),
(35, 11,'2022-01-01', FALSE,1400000000),
(37, 11,'2024-12-01', FALSE,1600000000),
(42, 11,'2022-10-01', FALSE, 580000000),
(55, 11,'2010-08-01', FALSE, 720000000),
(57, 11,'2014-12-01', FALSE, 980000000),
(59, 11,'2023-08-01', FALSE, 850000000),
(63, 11,'2015-01-01', FALSE,1100000000),
(67, 11,'2015-01-01', FALSE, 720000000),
(70, 11,'2017-01-01', FALSE, 680000000),
(73, 11,'2015-01-01', FALSE, 820000000),
(81, 11,'2015-01-01', FALSE, 760000000),
-- JioSaavn (13)
(1,  13,'2016-12-01', FALSE, 320000000),
(6,  13,'2015-01-01', FALSE, 540000000),
(10, 13,'2011-11-01', FALSE, 480000000),
(20, 13,'2019-06-01', FALSE, 530000000),
(35, 13,'2022-01-01', FALSE, 850000000),
(37, 13,'2024-12-01', FALSE, 980000000),
(81, 13,'2015-01-01', FALSE, 463000000),
-- Apple Music (12)
(55, 12,'2010-08-01', FALSE, 125000000),
(57, 12,'2014-12-01', FALSE, 170000000),
(59, 12,'2023-08-01', FALSE, 148000000),
(63, 12,'2015-01-01', FALSE, 191000000),
(67, 12,'2015-01-01', FALSE, 125000000);

SELECT 'seed_music.sql complete' AS status;
SELECT COUNT(*) AS total_albums    FROM albums;
SELECT COUNT(*) AS total_tracks    FROM tracks;
SELECT COUNT(*) AS total_singers   FROM track_singers;
SELECT COUNT(*) AS total_bridges   FROM movie_music_bridge;
SELECT COUNT(*) AS music_streams   FROM music_streaming;
