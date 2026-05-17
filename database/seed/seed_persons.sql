-- =============================================================
--  CINESIC — seed_persons.sql
--  Populates persons + directors + composers + producers tables
--  Run AFTER seed_meta.sql
--  ~120 real persons covering Bollywood + Hollywood + South Indian
-- =============================================================

USE cinesic;

-- =============================================================
--  PERSONS  (universal hub)
-- =============================================================
-- Flags: is_actor, is_actress, is_director, is_producer,
--        is_composer, is_singer, is_lyricist
-- nationality uses country name string
-- =============================================================

INSERT INTO persons
  (person_id, full_name, birth_name, date_of_birth, birthplace, nationality,
   gender, is_actor, is_actress, is_director, is_producer,
   is_composer, is_singer, is_lyricist, career_start_year, imdb_id)
VALUES

-- ── DIRECTORS ─────────────────────────────────────────────────────────

(1,  'Christopher Nolan',    'Christopher Jonathan James Nolan',
     '1970-07-30', 'London, UK',       'British-American',
     'Male',   0,0,1,1, 0,0,0, 1989, 'nm0634240'),

(2,  'SS Rajamouli',         'Srinivasa Sarvothama Rajamouli',
     '1973-10-10', 'Amaravati, India', 'Indian',
     'Male',   0,0,1,0, 0,0,0, 1999, 'nm1307876'),

(3,  'Nitesh Tiwari',        NULL,
     '1977-01-01', 'Palampur, India',  'Indian',
     'Male',   0,0,1,0, 0,0,0, 2009, 'nm3428485'),

(4,  'Sanjay Leela Bhansali','Sanjay Leela Bhansali',
     '1963-02-24', 'Mumbai, India',    'Indian',
     'Male',   0,0,1,1, 1,0,0, 1996, 'nm0082279'),

(5,  'Rohit Shetty',         NULL,
     '1973-03-14', 'Mumbai, India',    'Indian',
     'Male',   0,0,1,1, 0,0,0, 1999, 'nm0793686'),

(6,  'Farhan Akhtar',        NULL,
     '1974-01-09', 'Mumbai, India',    'Indian',
     'Male',   1,0,1,1, 0,1,0, 2001, 'nm0014334'),

(7,  'Zoya Akhtar',          NULL,
     '1972-10-14', 'Mumbai, India',    'Indian',
     'Female', 0,0,1,0, 0,0,0, 2009, 'nm1521797'),

(8,  'Rajkumar Hirani',      NULL,
     '1962-11-20', 'Nagpur, India',    'Indian',
     'Male',   0,0,1,0, 0,0,0, 1994, 'nm1433492'),

(9,  'Shankar',              'S. Shankar',
     '1963-08-17', 'Kumbakonam, India','Indian',
     'Male',   0,0,1,1, 0,0,0, 1992, 'nm0788265'),

(10, 'Mani Ratnam',          'Gopala Ratnam Subramaniam',
     '1956-06-02', 'Madurai, India',   'Indian',
     'Male',   0,0,1,1, 0,0,0, 1983, 'nm0711009'),

(11, 'James Cameron',        NULL,
     '1954-08-16', 'Kapuskasing, Canada','Canadian',
     'Male',   0,0,1,1, 0,0,0, 1978, 'nm0000116'),

(12, 'Steven Spielberg',     NULL,
     '1946-12-18', 'Cincinnati, USA',  'American',
     'Male',   0,0,1,1, 0,0,0, 1959, 'nm0000229'),

(13, 'Denis Villeneuve',     NULL,
     '1967-10-03', 'Gentilly, Canada', 'Canadian',
     'Male',   0,0,1,0, 0,0,0, 1990, 'nm0898288'),

(14, 'Bong Joon-ho',         NULL,
     '1969-09-14', 'Daegu, South Korea','South Korean',
     'Male',   0,0,1,1, 0,0,0, 1994, 'nm0094435'),

(15, 'Prashanth Neel',       NULL,
     '1981-04-01', 'Shimoga, India',   'Indian',
     'Male',   0,0,1,0, 0,0,0, 2015, 'nm8188392'),

(16, 'Atlee Kumar',          'A. Atlee Kumar',
     '1986-09-04', 'Chennai, India',   'Indian',
     'Male',   0,0,1,0, 0,0,0, 2013, 'nm5533882'),

(17, 'Kabir Khan',           NULL,
     '1971-08-01', 'Delhi, India',     'Indian',
     'Male',   0,0,1,1, 0,0,0, 2006, 'nm1503674'),

(18, 'Siddharth Anand',      NULL,
     '1978-01-01', 'Mumbai, India',    'Indian',
     'Male',   0,0,1,0, 0,0,0, 2004, 'nm1583456'),

(19, 'Aditya Chopra',        NULL,
     '1971-05-21', 'Mumbai, India',    'Indian',
     'Male',   0,0,1,1, 0,0,0, 1995, 'nm0158764'),

(20, 'Imtiaz Ali',           NULL,
     '1971-06-16', 'Jamshedpur, India','Indian',
     'Male',   0,0,1,0, 0,0,0, 2005, 'nm1701154'),

-- ── ACTORS ────────────────────────────────────────────────────────────

(21, 'Shah Rukh Khan',       'Shah Rukh Khan',
     '1965-11-02', 'New Delhi, India', 'Indian',
     'Male',   1,0,0,1, 0,0,0, 1988, 'nm0451321'),

(22, 'Aamir Khan',           'Mohammad Aamir Hussain Khan',
     '1965-03-14', 'Mumbai, India',    'Indian',
     'Male',   1,0,1,1, 0,0,0, 1973, 'nm0446934'),

(23, 'Salman Khan',          'Abdul Rashid Salim Salman Khan',
     '1965-12-27', 'Mumbai, India',    'Indian',
     'Male',   1,0,0,1, 0,0,0, 1988, 'nm0447496'),

(24, 'Hrithik Roshan',       NULL,
     '1974-01-10', 'Mumbai, India',    'Indian',
     'Male',   1,0,0,0, 0,0,0, 2000, 'nm0745659'),

(25, 'Ranveer Singh',        NULL,
     '1985-07-06', 'Mumbai, India',    'Indian',
     'Male',   1,0,0,0, 0,0,0, 2010, 'nm3982559'),

(26, 'Ranbir Kapoor',        NULL,
     '1982-09-28', 'Mumbai, India',    'Indian',
     'Male',   1,0,0,0, 0,0,0, 2007, 'nm2428855'),

(27, 'Prabhas',              'Venkata Satyanarayana Prabhas Raju Uppalapati',
     '1979-10-23', 'Narsapuram, India','Indian',
     'Male',   1,0,0,0, 0,0,0, 2002, 'nm1335271'),

(28, 'Yash',                 'Naveen Kumar Gowda',
     '1986-01-08', 'Bhuvanahalli, India','Indian',
     'Male',   1,0,0,0, 0,0,0, 2008, 'nm3278210'),

(29, 'Jr NTR',               'Nandamuri Taraka Rama Rao Jr',
     '1983-05-20', 'Hyderabad, India', 'Indian',
     'Male',   1,0,0,0, 0,0,0, 1999, 'nm1016428'),

(30, 'Ram Charan',           'Konidela Ram Charan Teja',
     '1985-03-27', 'Chennai, India',   'Indian',
     'Male',   1,0,0,0, 0,0,0, 2007, 'nm2883512'),

(31, 'Vijay',                'Joseph Vijay Chandrasekhar',
     '1974-06-22', 'Chennai, India',   'Indian',
     'Male',   1,0,0,0, 0,0,0, 1984, 'nm0898641'),

(32, 'Rajinikanth',          'Shivaji Rao Gaekwad',
     '1950-12-12', 'Bengaluru, India', 'Indian',
     'Male',   1,0,0,1, 0,0,0, 1975, 'nm0707991'),

(33, 'Mohanlal',             'Mohanlal Viswanathan Nair',
     '1960-05-21', 'Thiruvananthapuram, India','Indian',
     'Male',   1,0,0,1, 0,0,0, 1978, 'nm0596265'),

(34, 'Mammootty',            'Muhammad Kutty Panaparambil Ismail',
     '1951-09-07', 'Chempu, India',    'Indian',
     'Male',   1,0,0,0, 0,0,0, 1971, 'nm0541827'),

(35, 'Dulquer Salmaan',      NULL,
     '1986-07-28', 'Kochi, India',     'Indian',
     'Male',   1,0,0,1, 0,0,0, 2012, 'nm4196192'),

(36, 'Leonardo DiCaprio',    NULL,
     '1974-11-11', 'Los Angeles, USA', 'American',
     'Male',   1,0,0,1, 0,0,0, 1989, 'nm0000138'),

(37, 'Tom Hanks',            NULL,
     '1956-07-09', 'Concord, USA',     'American',
     'Male',   1,0,0,1, 0,0,0, 1980, 'nm0000158'),

(38, 'Robert Downey Jr.',    'Robert John Downey Jr.',
     '1965-04-04', 'Manhattan, USA',   'American',
     'Male',   1,0,0,1, 0,0,0, 1970, 'nm0000375'),

(39, 'Chris Evans',          NULL,
     '1981-06-13', 'Boston, USA',      'American',
     'Male',   1,0,0,0, 0,0,0, 2000, 'nm0262635'),

(40, 'Keanu Reeves',         NULL,
     '1964-09-02', 'Beirut, Lebanon',  'Canadian',
     'Male',   1,0,0,0, 0,0,0, 1984, 'nm0000206'),

-- ── ACTRESSES ────────────────────────────────────────────────────────

(41, 'Deepika Padukone',     NULL,
     '1986-01-05', 'Copenhagen, Denmark','Indian',
     'Female', 0,1,0,1, 0,0,0, 2006, 'nm2368789'),

(42, 'Priyanka Chopra',      NULL,
     '1982-07-18', 'Jamshedpur, India','Indian',
     'Female', 0,1,0,1, 0,1,0, 2000, 'nm1231899'),

(43, 'Alia Bhatt',           NULL,
     '1993-03-15', 'Mumbai, India',    'British-Indian',
     'Female', 0,1,0,1, 0,0,0, 2012, 'nm4517183'),

(44, 'Katrina Kaif',         'Katrina Turquotte',
     '1983-07-16', 'Hong Kong',        'British-Indian',
     'Female', 0,1,0,0, 0,0,0, 2003, 'nm2113226'),

(45, 'Kareena Kapoor',       'Kareena Kapoor Khan',
     '1980-09-21', 'Mumbai, India',    'Indian',
     'Female', 0,1,0,0, 0,0,0, 2000, 'nm0438399'),

(46, 'Kangana Ranaut',       NULL,
     '1987-03-23', 'Bhambla, India',   'Indian',
     'Female', 0,1,0,1, 0,0,0, 2006, 'nm2196832'),

(47, 'Taapsee Pannu',        NULL,
     '1987-08-01', 'New Delhi, India', 'Indian',
     'Female', 0,1,0,0, 0,0,0, 2010, 'nm3600339'),

(48, 'Samantha Ruth Prabhu', 'Samantha Akkineni',
     '1987-04-28', 'Chennai, India',   'Indian',
     'Female', 0,1,0,0, 0,0,0, 2010, 'nm3532897'),

(49, 'Nayanthara',           'Diana Mariam Kurian',
     '1984-11-18', 'Thiruvalla, India','Indian',
     'Female', 0,1,0,1, 0,0,0, 2003, 'nm1872621'),

(50, 'Scarlett Johansson',   NULL,
     '1984-11-22', 'Manhattan, USA',   'American',
     'Female', 0,1,0,0, 0,0,0, 1994, 'nm0424060'),

(51, 'Meryl Streep',         'Mary Louise Streep',
     '1949-06-22', 'Summit, USA',      'American',
     'Female', 0,1,0,0, 0,0,0, 1977, 'nm0000658'),

(52, 'Cate Blanchett',       NULL,
     '1969-05-14', 'Melbourne, Australia','Australian',
     'Female', 0,1,0,1, 0,0,0, 1992, 'nm0000949'),

-- ── COMPOSERS ─────────────────────────────────────────────────────────

(53, 'A.R. Rahman',          'Allah Rakha Rahman',
     '1966-01-06', 'Chennai, India',   'Indian',
     'Male',   0,0,0,0, 1,0,0, 1988, 'nm0006246'),

(54, 'Pritam Chakraborty',   NULL,
     '1971-05-22', 'Kolkata, India',   'Indian',
     'Male',   0,0,0,0, 1,0,0, 2003, 'nm1888626'),

(55, 'Vishal-Shekhar',       'Vishal Dadlani & Shekhar Ravjiani',
     '1974-07-29', 'Mumbai, India',    'Indian',
     'Male',   0,0,0,0, 1,1,0, 2005, 'nm2111560'),

(56, 'Amit Trivedi',         NULL,
     '1979-08-29', 'Ahmedabad, India', 'Indian',
     'Male',   0,0,0,0, 1,1,0, 2007, 'nm3012671'),

(57, 'Shankar-Ehsaan-Loy',   'Shankar Mahadevan, Ehsaan Noorani, Loy Mendonsa',
     '1967-03-03', 'Mumbai, India',    'Indian',
     'Male',   0,0,0,0, 1,1,0, 1997, 'nm0788254'),

(58, 'Ilayaraja',            'Gnana Rajasekaran',
     '1943-06-02', 'Pannaipuram, India','Indian',
     'Male',   0,0,0,0, 1,0,1, 1976, 'nm0407088'),

(59, 'Harris Jayaraj',       NULL,
     '1975-08-22', 'Chennai, India',   'Indian',
     'Male',   0,0,0,0, 1,0,0, 1999, 'nm0413278'),

(60, 'Ravi Teja (composer)', 'Ravi Shankar Raju',
     '1975-01-01', 'Hyderabad, India', 'Indian',
     'Male',   0,0,0,0, 1,0,0, 2010, 'nm4765432'),

(61, 'Thaman S',             'Santhosh Narayanan Thaman',
     '1984-04-08', 'Hyderabad, India', 'Indian',
     'Male',   0,0,0,0, 1,0,0, 2006, 'nm3285976'),

(62, 'Ravi Basrur',          NULL,
     '1978-11-01', 'Bengaluru, India', 'Indian',
     'Male',   0,0,0,0, 1,0,0, 2012, 'nm6219852'),

(63, 'Santhosh Narayanan',   NULL,
     '1985-04-29', 'Coimbatore, India','Indian',
     'Male',   0,0,0,0, 1,0,0, 2011, 'nm5048976'),

(64, 'Hans Zimmer',          'Hans Florian Zimmer',
     '1957-09-12', 'Frankfurt, Germany','German-American',
     'Male',   0,0,0,0, 1,0,0, 1978, 'nm0000233'),

(65, 'John Williams',        'John Towner Williams',
     '1932-02-08', 'Floral Park, USA', 'American',
     'Male',   0,0,0,0, 1,0,0, 1956, 'nm0002353'),

(66, 'Ludwig Göransson',     NULL,
     '1984-09-01', 'Linköping, Sweden','Swedish-American',
     'Male',   0,0,0,0, 1,0,0, 2011, 'nm3733493'),

-- ── PLAYBACK SINGERS ──────────────────────────────────────────────────

(67, 'Arijit Singh',         NULL,
     '1987-04-25', 'Jiaganj, India',   'Indian',
     'Male',   0,0,0,0, 0,1,0, 2005, 'nm4327606'),

(68, 'Shreya Ghoshal',       NULL,
     '1984-03-12', 'Murshidabad, India','Indian',
     'Female', 0,0,0,0, 0,1,0, 2002, 'nm1540174'),

(69, 'Sonu Nigam',           NULL,
     '1973-07-30', 'Faridabad, India', 'Indian',
     'Male',   0,0,0,0, 0,1,0, 1990, 'nm0632083'),

(70, 'Udit Narayan',         NULL,
     '1955-12-01', 'Bihar, India',     'Indian',
     'Male',   0,0,0,0, 0,1,0, 1980, 'nm0621047'),

(71, 'Alka Yagnik',          NULL,
     '1966-03-02', 'Kolkata, India',   'Indian',
     'Female', 0,0,0,0, 0,1,0, 1981, 'nm0945231'),

(72, 'Kumar Sanu',           'Kedarnath Bhattacharya',
     '1957-10-20', 'Kolkata, India',   'Indian',
     'Male',   0,0,0,0, 0,1,0, 1986, 'nm0750234'),

(73, 'KK',                   'Krishnakumar Kunnath',
     '1968-08-23', 'New Delhi, India', 'Indian',
     'Male',   0,0,0,0, 0,1,0, 1999, 'nm3745123'),

(74, 'Sunidhi Chauhan',      NULL,
     '1983-08-14', 'New Delhi, India', 'Indian',
     'Female', 0,0,0,0, 0,1,0, 1996, 'nm1438723'),

(75, 'Shankar Mahadevan',    NULL,
     '1967-03-03', 'Mumbai, India',    'Indian',
     'Male',   0,0,0,0, 0,1,0, 1994, 'nm0788254'),

(76, 'Hariharan',            NULL,
     '1955-04-03', 'Mumbai, India',    'Indian',
     'Male',   0,0,0,0, 0,1,0, 1978, 'nm0362421'),

(77, 'S.P. Balasubrahmanyam','Sripathi Panditaradhyula Balasubrahmanyam',
     '1946-06-04', 'Nellore, India',   'Indian',
     'Male',   0,0,0,0, 0,1,0, 1966, 'nm0049476'),

(78, 'Chinmayi Sripada',     NULL,
     '1984-07-29', 'Chennai, India',   'Indian',
     'Female', 0,0,0,0, 0,1,0, 2005, 'nm2132453'),

(79, 'Sid Sriram',           'Siddharth Sriram',
     '1995-05-11', 'Chennai, India',   'Indian',
     'Male',   0,0,0,0, 0,1,0, 2019, 'nm10234567'),

(80, 'Anirudh Ravichander',  NULL,
     '1990-10-16', 'Chennai, India',   'Indian',
     'Male',   0,0,0,0, 1,1,0, 2012, 'nm5283987'),

-- ── LYRICISTS ────────────────────────────────────────────────────────

(81, 'Gulzar',               'Sampooran Singh Kalra',
     '1934-08-18', 'Dina, Pakistan',   'Indian',
     'Male',   0,0,1,0, 0,0,1, 1963, 'nm0347500'),

(82, 'Javed Akhtar',         NULL,
     '1945-01-17', 'Gwalior, India',   'Indian',
     'Male',   0,0,0,0, 0,0,1, 1970, 'nm0014307'),

(83, 'Irshad Kamil',         NULL,
     '1972-11-05', 'Gujranwala, Pakistan','Indian',
     'Male',   0,0,0,0, 0,0,1, 2004, 'nm2301987'),

(84, 'Amitabh Bhattacharya', NULL,
     '1981-07-21', 'Bhagalpur, India', 'Indian',
     'Male',   0,0,0,0, 0,0,1, 2007, 'nm3812456'),

(85, 'Varun Grover',         NULL,
     '1980-01-01', 'Saharanpur, India','Indian',
     'Male',   0,0,0,0, 0,0,1, 2009, 'nm4278912'),

-- ── CINEMATOGRAPHERS / MULTI-ROLE ─────────────────────────────────────

(86, 'Shankar Mahadevan',    NULL,   -- composer-singer (dup role)
     '1967-03-03', 'Mumbai, India',    'Indian',
     'Male',   0,0,0,0, 1,1,0, 1994, NULL),

(87, 'Anushka Sharma',       NULL,
     '1988-05-01', 'Ayodhya, India',   'Indian',
     'Female', 0,1,0,1, 0,0,0, 2008, 'nm4009560'),

(88, 'Vidya Balan',          NULL,
     '1978-01-01', 'Mumbai, India',    'Indian',
     'Female', 0,1,0,0, 0,0,0, 2003, 'nm1209169'),

(89, 'Tamannaah Bhatia',     NULL,
     '1989-12-21', 'Mumbai, India',    'Indian',
     'Female', 0,1,0,0, 0,0,0, 2005, 'nm2377701'),

(90, 'Dhanush',              'Venkatesh Prabhu Kasthuri Raja',
     '1983-07-28', 'Chennai, India',   'Indian',
     'Male',   1,0,0,1, 0,1,0, 2002, 'nm1732619'),

(91, 'Allu Arjun',           NULL,
     '1982-04-08', 'Chennai, India',   'Indian',
     'Male',   1,0,0,0, 0,0,0, 2003, 'nm1531580'),

(92, 'Mahesh Babu',          'Ghattamaneni Mahesh Babu',
     '1975-08-09', 'Chennai, India',   'Indian',
     'Male',   1,0,0,1, 0,0,0, 1999, 'nm0530129'),

(93, 'Fahadh Faasil',        NULL,
     '1983-08-08', 'Kozhikode, India', 'Indian',
     'Male',   1,0,0,0, 0,0,0, 2002, 'nm2130507'),

(94, 'Prithviraj Sukumaran', NULL,
     '1982-10-16', 'Thrissur, India',  'Indian',
     'Male',   1,0,1,1, 0,0,0, 2002, 'nm1802553'),

(95, 'Suriya',               'Saravanan Sivakumar',
     '1975-07-23', 'Chennai, India',   'Indian',
     'Male',   1,0,0,1, 0,0,0, 1997, 'nm0839991'),

(96, 'Karthi',               'Karthi Sivakumar',
     '1977-05-25', 'Chennai, India',   'Indian',
     'Male',   1,0,0,0, 0,0,0, 2007, 'nm2728720'),

(97, 'Rashmika Mandanna',    NULL,
     '1996-04-05', 'Virajpet, India',  'Indian',
     'Female', 0,1,0,0, 0,0,0, 2016, 'nm7784986'),

(98, 'Pooja Hegde',          NULL,
     '1990-10-13', 'Mumbai, India',    'Indian',
     'Female', 0,1,0,0, 0,0,0, 2012, 'nm5083357'),

(99, 'Sai Pallavi',          NULL,
     '1992-05-09', 'Kotagiri, India',  'Indian',
     'Female', 0,1,0,0, 0,0,0, 2014, 'nm8237562'),

(100,'Vijay Sethupathi',     NULL,
     '1978-01-16', 'Rajapalayam, India','Indian',
     'Male',   1,0,0,1, 0,0,0, 2004, 'nm3513076');

-- =============================================================
--  DIRECTORS sub-table
-- =============================================================
INSERT INTO directors (director_id, signature_style, preferred_genre_id, total_films_directed, awards_won) VALUES
(1,  'Non-linear narrative, practical effects, philosophical themes',           7,  12, 5),   -- Nolan: Sci-Fi
(2,  'Epic visual spectacle, mythology, grand action choreography',             9,   9, 8),   -- Rajamouli: Adventure
(3,  'Inspirational sports biopics, emotional underdog arcs',                  16,  5, 3),   -- Tiwari: Sports
(4,  'Lavish period drama, visual grandeur, intense emotions',                  2,  10, 7),   -- Bhansali: Drama
(5,  'Mass entertainers, action comedy, franchise world-building',              3,  18, 2),   -- Rohit: Comedy
(6,  'Coming-of-age, friendship, social themes with music integration',         2,   8, 4),   -- Farhan: Drama
(7,  'Urban youth, friendship, contemporary storytelling',                      2,   6, 3),   -- Zoya: Drama
(8,  'Feel-good, social satire, emotional drama',                               2,   9, 6),   -- Hirani: Drama
(9,  'High-concept sci-fi with Indian socio-political backdrop',                7,   8, 5),   -- Shankar: Sci-Fi
(10, 'Lyrical romance, political drama, South Indian culture',                 19,  20, 9),   -- Mani Ratnam: Romance
(11, 'Technological spectacle, deep-sea and space adventure',                   9,   9, 3),   -- Cameron: Adventure
(12, 'Sweeping adventure, emotional family drama',                              9,  35, 8),   -- Spielberg: Adventure
(13, 'Slow-burn atmospheric sci-fi, methodical world-building',                 7,  11, 2),   -- Villeneuve: Sci-Fi
(14, 'Social commentary wrapped in genre films, dark humour',                   2,  12, 4),   -- Bong: Crime
(15, 'Raw gritty action, revenge arcs, mass hero elevation',                    1,   4, 2),   -- Neel: Action
(16, 'Mass entertainers with slick action and emotional core',                  1,   6, 1),   -- Atlee: Action
(17, 'Patriotic themes, sports drama, feel-good nationalism',                  16,   8, 3),   -- Kabir: Sports
(18, 'Slick action, aerial sequences, patriotic thrillers',                     1,   7, 1),   -- Siddharth: Action
(19, 'Grand romantic dramas with Bollywood grandeur',                           6,   9, 4),   -- Aditya: Romance
(20, 'Unconventional romance, travel narratives, indie soul',                   6,   8, 2);   -- Imtiaz: Romance

-- =============================================================
--  COMPOSERS sub-table
-- =============================================================
INSERT INTO composers (composer_id, musical_style, instruments, total_film_scores, total_albums, grammy_wins, avg_album_rating) VALUES
(53, 'Orchestral fusion, Carnatic-Western blend, world music',    'Piano, Keyboard, Tabla, Strings',          100, 85, 2, 8.9),
(54, 'Contemporary Bollywood pop, melodic hooks',                 'Guitar, Keyboard, Synthesizer',              70, 62, 0, 7.8),
(55, 'Energetic pop-rock, club anthems, soulful ballads',         'Guitar, Drum Machine, Synthesizer',          60, 54, 0, 7.6),
(56, 'Indie-folk, experimental, deeply lyrical compositions',     'Guitar, Harmonium, Synth',                   40, 36, 0, 8.2),
(57, 'Versatile fusion, rock, classical and devotional blends',   'Guitar, Tabla, Keyboard',                    80, 72, 0, 8.0),
(58, 'Carnatic classical, orchestral film scores, melodic depth', 'Veena, Violin, Flute, Keyboard',            1000,800, 0, 9.1),
(59, 'Romantic ballads, electronic beats, Tamil film scoring',    'Keyboard, Synthesizer, Guitar',              40, 35, 0, 7.7),
(61, 'High-energy mass action beats, Telugu film scoring',        'Synthesizer, Percussion, Orchestra',         60, 55, 0, 7.5),
(62, 'Raw percussive beats, folk fusion, Kannada cinema',         'Percussion, Synthesizer, Folk instruments',  15, 12, 0, 8.3),
(63, 'Tamil indie, folk-electronic fusion',                       'Guitar, Synth, Traditional instruments',     30, 26, 0, 7.9),
(64, 'Epic orchestral, hybrid electronic, minimalist score',      'Piano, Orchestra, Synthesizer',              150,130, 4, 9.2),
(65, 'Classical orchestral, thematic motifs, jazz influences',    'Piano, Orchestra, Brass',                    200,180, 5, 9.5),
(66, 'Modern orchestral, African rhythms, electronic textures',   'Marimba, Orchestra, Synthesizer',            30, 25, 2, 8.7),
(80, 'Youthful Tamil pop, mass beats, emotional melodies',        'Keyboard, Synthesizer, Guitar',              30, 28, 0, 8.1);

-- =============================================================
--  PRODUCERS sub-table
-- =============================================================
INSERT INTO producers (producer_id, house_id, specialty, total_films, total_gross_usd) VALUES
(6,  4,  'Action dramas and social films',              8,  900000000),
(22, 1,  'Big-budget romance and drama',               15, 2100000000),
(37, 16, 'Epic adventure and drama',                   20, 8000000000),
(38, 13, 'Superhero and franchise films',              12, 5000000000),
(21, 3,  'Commercial entertainers',                    10,  700000000),
(32, 10, 'South Indian mass entertainers',              8,  600000000),
(33, 11, 'Malayalam cinema quality dramas',             6,  250000000),
(90, 12, 'Tamil and Pan-India films',                   5,  400000000),
(92, 12, 'Telugu commercial entertainers',              6,  500000000),
(95, 11, 'Tamil action and drama',                      4,  300000000),
(94, 11, 'Malayalam prestige and action',               5,  320000000),
(49, 11, 'South Indian female-led films',               3,  180000000),
(46, 24, 'Biographical films and drama',                4,  200000000);

-- =============================================================
--  Verification
-- =============================================================
SELECT 'seed_persons.sql complete' AS status;
SELECT 'persons'   AS tbl, COUNT(*) AS rows FROM persons
UNION ALL SELECT 'directors',  COUNT(*) FROM directors
UNION ALL SELECT 'composers',  COUNT(*) FROM composers
UNION ALL SELECT 'producers',  COUNT(*) FROM producers;
