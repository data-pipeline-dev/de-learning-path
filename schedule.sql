-- Створення схеми
CREATE SCHEMA IF NOT EXISTS schedule;

-- Таблиця Class (Клас)[cite: 1]
CREATE TABLE schedule.class (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Таблиця Timepair (Часові пари)[cite: 1]
CREATE TABLE schedule.timepair (
    id SERIAL PRIMARY KEY,
    start_pair TIME NOT NULL,
    end_pair TIME NOT NULL
);

-- Таблиця Teacher (Викладач)[cite: 1]
CREATE TABLE schedule.teacher (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL
);

-- Таблиця Subject (Предмет)[cite: 1]
CREATE TABLE schedule.subject (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Таблиця Student (Учень)[cite: 1]
CREATE TABLE schedule.student (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    birthday DATE,
    address VARCHAR(255)
);

-- Таблиця Student_in_class (Зв'язок учнів з класами)[cite: 1]
CREATE TABLE schedule.student_in_class (
    id SERIAL PRIMARY KEY,
    class INT REFERENCES schedule.class(id) ON DELETE CASCADE,
    student INT REFERENCES schedule.student(id) ON DELETE CASCADE
);

-- Таблиця Schedule (Розклад)[cite: 1]
CREATE TABLE schedule.schedule (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    class INT REFERENCES schedule.class(id) ON DELETE CASCADE,
    number_pair INT REFERENCES schedule.timepair(id) ON DELETE CASCADE,
    teacher INT REFERENCES schedule.teacher(id) ON DELETE CASCADE,
    subject INT REFERENCES schedule.subject(id) ON DELETE CASCADE,
    classroom INT NOT NULL
);

-- 1. Вставка класів (з 1 по 11, літери A та B)
INSERT INTO schedule.class (name) VALUES
('1-A'), ('1-B'),
('2-A'), ('2-B'),
('3-A'), ('3-B'),
('4-A'), ('4-B'),
('5-A'), ('5-B'),
('6-A'), ('6-B'),
('7-A'), ('7-B'),
('8-A'), ('8-B'),
('9-A'), ('9-B'),
('10-A'), ('10-B'),
('11-A'), ('11-B');

-- 2. Вставка часових пар
INSERT INTO schedule.timepair (start_pair, end_pair) VALUES
('08:30:00', '10:00:00'),
('10:15:00', '11:45:00'),
('12:15:00', '13:45:00'),
('14:00:00', '15:30:00'),
('15:45:00', '17:15:00');

-- 3. Вставка розширеного списку викладачів
INSERT INTO schedule.teacher (first_name, middle_name, last_name) VALUES
('Alexander', 'Petrovich', 'Ivanov'),       -- Math
('Maria', 'Ivanovna', 'Kovalenko'),         -- Physics / Chemistry
('Andriy', 'Mykolayovych', 'Shevchenko'),   -- History
('Svitlana', 'Volodymyrivna', 'Bondarenko'),-- English
('Dmytro', 'Olegovych', 'Tkachenko'),       -- Computer Science
('Tetiana', 'Mykhailivna', 'Melnyk'),        -- Biology / Literature
('Oksana', 'Petrivna', 'Koval'),            -- Primary School Teacher (1-4)
('Serhii', 'Viktorovych', 'Boyko'),          -- Physical Education
('Olena', 'Ihorivna', 'Vasylenko'),         -- Primary School Teacher (1-4)
('Yuri', 'Anatoliyovych', 'Kravchenko');     -- Geography

-- 4. Вставка предметів (середні, старші та початкові класи)
INSERT INTO schedule.subject (name) VALUES
('Mathematics'),
('Physics'),
('History of Ukraine'),
('English Language'),
('Computer Science'),
('Chemistry'),
('Biology'),
('World Literature'),
('Geography'),
('Physical Education'),
('Primary Reading'),
('Primary Writing'),
('Art and Crafts');

-- 5. Вставка учнів різного віку
INSERT INTO schedule.student (first_name, middle_name, last_name, birthday, address) VALUES
-- Primary school (1-4 classes)
('Liam', 'James', 'Smith', '2019-04-12', '12 Maple St.'),
('Emma', 'Rose', 'Johnson', '2019-08-25', '45 Oak Ave.'),
('Noah', 'Alexander', 'Williams', '2018-02-10', '8 Pine Rd.'),
('Olivia', 'Grace', 'Brown', '2017-11-05', '99 Elm St.'),
('Ethan', 'David', 'Jones', '2016-06-30', '14 Cedar St.'),

-- Middle school (5-9 classes)
('Ivan', 'Olegovych', 'Petrenko', '2014-05-12', '10 Kyivska St.'),
('Olena', 'Serhiivna', 'Melnyk', '2014-09-23', '15 Shevchenka St.'),
('Kateryna', 'Vasylivna', 'Tkachuk', '2012-02-15', '12 Independence Sq.'),
('Artem', 'Mykolayovych', 'Hnatyuk', '2011-08-20', '33 Franko St.'),
('Bohdan', 'Olexandrovych', 'Lysenko', '2010-06-18', '9 Sichovykh Streltsiv St.'),

-- High school (10-11 classes)
('Maksym', 'Andriiovych', 'Boyko', '2009-01-14', '42 Peremohy Ave.'),
('Anna', 'Viktorivna', 'Koval', '2009-03-30', '8 Lesi Ukrainky St.'),
('Dmytro', 'Ihorovych', 'Klymenko', '2009-07-19', '5 Centralna St.'),
('Yuliia', 'Dmytrivna', 'Shevchuk', '2008-11-05', '19 Hrushevskoho St.'),
('Denys', 'Volodymyrovych', 'Piven', '2008-04-11', '77 Sadova St.');

-- 6. Вставка зв'язків учнів з класами (Student_in_class)
INSERT INTO schedule.student_in_class (class, student) VALUES
(1, 1),   -- Liam Smith -> 1-A (class id = 1)
(2, 2),   -- Emma Johnson -> 1-B (class id = 2)
(3, 3),   -- Noah Williams -> 2-A (class id = 3)
(5, 4),   -- Olivia Brown -> 3-A (class id = 5)
(7, 5),   -- Ethan Jones -> 4-A (class id = 7)
(9, 6),   -- Ivan Petrenko -> 5-A (class id = 9)
(10, 7),  -- Olena Melnyk -> 5-B (class id = 10)
(13, 8),  -- Kateryna Tkachuk -> 7-A (class id = 13)
(15, 9),  -- Artem Hnatyuk -> 8-A (class id = 15)
(17, 10), -- Bohdan Lysenko -> 9-A (class id = 17)
(19, 11), -- Maksym Boyko -> 10-A (class id = 19)
(19, 12), -- Anna Koval -> 10-A (class id = 19)
(20, 13), -- Dmytro Klymenko -> 10-B (class id = 20)
(21, 14), -- Yuliia Shevchuk -> 11-A (class id = 21)
(22, 15); -- Denys Piven -> 11-B (class id = 22)

-- 7. Вставка розкладу для різних класів на декілька днів
INSERT INTO schedule.schedule (date, class, number_pair, teacher, subject, classroom) VALUES
-- 1-A (Primary School)
('2026-11-02', 1, 1, 7, 11, 101), -- Reading, Koval, Room 101
('2026-11-02', 1, 2, 7, 12, 101), -- Writing, Koval, Room 101
('2026-11-02', 1, 3, 7, 13, 101), -- Art, Koval, Room 101

-- 1-B (Primary School)
('2026-11-02', 2, 1, 9, 12, 102), -- Writing, Vasylenko, Room 102
('2026-11-02', 2, 2, 9, 11, 102), -- Reading, Vasylenko, Room 102
('2026-11-02', 2, 3, 8, 10, 100), -- Gym, Boyko, Gym Hall

-- 5-A (Middle School)
('2026-11-02', 9, 1, 1, 1, 201),  -- Mathematics, Ivanov, Room 201
('2026-11-02', 9, 2, 4, 4, 410),  -- English Language, Bondarenko, Room 410
('2026-11-02', 9, 3, 10, 9, 215), -- Geography, Kravchenko, Room 215

-- 9-A (Middle School)
('2026-11-02', 17, 1, 2, 2, 305), -- Physics, Kovalenko, Room 305
('2026-11-02', 17, 2, 3, 3, 108), -- History of Ukraine, Shevchenko, Room 108
('2026-11-02', 17, 3, 5, 5, 112), -- Computer Science, Tkachenko, Room 112

-- 10-A (High School)
('2026-11-02', 19, 1, 1, 1, 201), -- Mathematics, Ivanov, Room 201
('2026-11-02', 19, 2, 2, 6, 302), -- Chemistry, Kovalenko, Room 302
('2026-11-02', 19, 3, 4, 4, 410), -- English Language, Bondarenko, Room 410

-- 11-A (High School)
('2026-11-02', 21, 1, 3, 3, 108), -- History of Ukraine, Shevchenko, Room 108
('2026-11-02', 21, 2, 5, 5, 112), -- Computer Science, Tkachenko, Room 112
('2026-11-02', 21, 3, 6, 8, 220), -- World Literature, Melnyk, Room 220

-- 11-B (High School)
('2026-11-02', 22, 1, 6, 7, 305), -- Biology, Melnyk, Room 305
('2026-11-02', 22, 2, 1, 1, 201), -- Mathematics, Ivanov, Room 201
('2026-11-02', 22, 3, 8, 10, 100);-- Physical Education, Boyko, Gym Hall