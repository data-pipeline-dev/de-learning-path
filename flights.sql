-- Створення схеми flights
CREATE SCHEMA IF NOT EXISTS flights;

-- 1. Таблиця Company (Авіакомпанія)
CREATE TABLE flights.company (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 2. Таблиця Passenger (Пасажир)
CREATE TABLE flights.passenger (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 3. Таблиця Trip (Рейс / Політ)
CREATE TABLE flights.trip (
    id SERIAL PRIMARY KEY,
    company INT REFERENCES flights.company(id) ON DELETE CASCADE,
    plane VARCHAR(50) NOT NULL,
    town_from VARCHAR(100) NOT NULL,
    town_to VARCHAR(100) NOT NULL,
    time_out TIMESTAMP NOT NULL,
    time_in TIMESTAMP NOT NULL
);

-- 4. Таблиця Pass_in_trip (Реєстрація пасажира на рейс)
CREATE TABLE flights.pass_in_trip (
    id SERIAL PRIMARY KEY,
    trip INT REFERENCES flights.trip(id) ON DELETE CASCADE,
    passenger INT REFERENCES flights.passenger(id) ON DELETE CASCADE,
    place VARCHAR(10) NOT NULL
);

-- 1. Вставка 5 компаній (Company)
INSERT INTO flights.company (name) VALUES
('Delta Air Lines'),
('Lufthansa'),
('Ryanair'),
('Emirates'),
('United Airlines');

-- 2. Вставка 38 пасажирів (Passenger)
INSERT INTO flights.passenger (name) VALUES
('John Smith'), ('Emily Johnson'), ('Michael Brown'), ('Sophia Martinez'), ('David Wilson'),
('Emma Taylor'), ('James Anderson'), ('Olivia Thomas'), ('Daniel White'), ('Sophia Harris'),
('Alexander Martin'), ('Mia Jackson'), ('William Thompson'), ('Charlotte Garcia'), ('Benjamin Martinez'),
('Amelia Robinson'), ('Lucas Clark'), ('Harper Rodriguez'), ('Henry Lewis'), ('Evelyn Lee'),
('Jack Walker'), ('Abigail Hall'), ('Sebastian Allen'), ('Emily Young'), ('Logan Hernandez'),
('Elizabeth King'), ('Jackson Wright'), ('Avery Lopez'), ('Levi Hill'), ('Ella Scott'),
('Mateo Green'), ('Scarlett Adams'), ('David Baker'), ('Grace Gonzalez'), ('Joseph Nelson'),
('Chloe Carter'), ('Samuel Mitchell'), ('Victoria Perez');

-- 3. Вставка 22 подорожей / рейсів (Trip)
INSERT INTO flights.trip (company, plane, town_from, town_to, time_out, time_in) VALUES
(1, 'Boeing 737', 'New York', 'London', '2026-11-10 08:00:00', '2026-11-10 20:00:00'),
(1, 'Boeing 777', 'London', 'New York', '2026-11-11 10:00:00', '2026-11-11 22:30:00'),
(1, 'Airbus A330', 'New York', 'Paris', '2026-11-12 18:30:00', '2026-11-13 07:45:00'),
(1, 'Boeing 737', 'Atlanta', 'Chicago', '2026-11-13 09:15:00', '2026-11-13 11:30:00'),
(2, 'Airbus A320', 'Frankfurt', 'Paris', '2026-11-10 10:30:00', '2026-11-10 12:00:00'),
(2, 'Airbus A321', 'Munich', 'Rome', '2026-11-11 13:00:00', '2026-11-11 14:30:00'),
(2, 'Airbus A350', 'Frankfurt', 'Tokyo', '2026-11-12 20:00:00', '2026-11-13 14:10:00'),
(2, 'Airbus A320', 'Berlin', 'Vienna', '2026-11-14 07:00:00', '2026-11-14 08:15:00'),
(3, 'Boeing 737-800', 'Warsaw', 'Barcelona', '2026-11-11 14:15:00', '2026-11-11 17:30:00'),
(3, 'Boeing 737-800', 'Dublin', 'Madrid', '2026-11-12 06:45:00', '2026-11-12 10:15:00'),
(3, 'Boeing 737-800', 'Milan', 'Lisbon', '2026-11-13 11:20:00', '2026-11-13 13:50:00'),
(3, 'Boeing 737 MAX', 'Krakow', 'Oslo', '2026-11-15 16:00:00', '2026-11-15 18:25:00'),
(4, 'Airbus A380', 'Dubai', 'Tokyo', '2026-11-12 02:45:00', '2026-11-12 17:20:00'),
(4, 'Boeing 777-300ER', 'Dubai', 'London', '2026-11-13 07:45:00', '2026-11-13 12:15:00'),
(4, 'Airbus A380', 'Dubai', 'Sydney', '2026-11-14 22:00:00', '2026-11-15 18:30:00'),
(4, 'Boeing 777-300ER', 'Singapore', 'Dubai', '2026-11-16 01:30:00', '2026-11-16 05:00:00'),
(5, 'Boeing 787', 'Chicago', 'Los Angeles', '2026-11-12 18:00:00', '2026-11-12 20:30:00'),
(5, 'Boeing 737-900', 'San Francisco', 'Seattle', '2026-11-13 08:30:00', '2026-11-13 10:45:00'),
(5, 'Boeing 777', 'Washington', 'Frankfurt', '2026-11-14 17:15:00', '2026-11-15 06:50:00'),
(5, 'Boeing 787', 'Houston', 'Miami', '2026-11-15 12:00:00', '2026-11-15 15:30:00'),
(5, 'Boeing 737', 'Denver', 'Las Vegas', '2026-11-16 19:10:00', '2026-11-16 20:25:00'),
(1, 'Boeing 767', 'Boston', 'Amsterdam', '2026-11-17 21:00:00', '2026-11-18 10:15:00');

-- 4. Вставка посадкові місця пасажирів на рейси (Pass_in_trip)
INSERT INTO flights.pass_in_trip (trip, passenger, place) VALUES
-- Trip 1 (New York - London)
(1, 1, '12A'), (1, 2, '12B'), (1, 3, '14C'),
-- Trip 2 (London - New York)
(2, 4, '02A'), (2, 5, '02B'),
-- Trip 3 (New York - Paris)
(3, 6, '18D'), (3, 7, '18E'),
-- Trip 4 (Atlanta - Chicago)
(4, 8, '05F'),
-- Trip 5 (Frankfurt - Paris)
(5, 9, '04C'), (5, 10, '04D'), (5, 11, '05A'),
-- Trip 6 (Munich - Rome)
(6, 12, '10A'), (6, 13, '10B'),
-- Trip 7 (Frankfurt - Tokyo)
(7, 14, '01A'), (7, 15, '01K'),
-- Trip 8 (Berlin - Vienna)
(8, 16, '08C'),
-- Trip 9 (Warsaw - Barcelona)
(9, 17, '18F'), (9, 18, '18E'), (9, 19, '19A'),
-- Trip 10 (Dublin - Madrid)
(10, 20, '22B'), (10, 21, '22C'),
-- Trip 11 (Milan - Lisbon)
(11, 22, '15D'), (11, 23, '15E'),
-- Trip 12 (Krakow - Oslo)
(12, 24, '07A'),
-- Trip 13 (Dubai - Tokyo)
(13, 25, '03K'), (13, 26, '03J'), (13, 27, '04K'),
-- Trip 14 (Dubai - London)
(14, 28, '11A'), (14, 29, '11B'),
-- Trip 15 (Dubai - Sydney)
(15, 30, '02E'), (15, 31, '02F'),
-- Trip 16 (Singapore - Dubai)
(16, 32, '16C'),
-- Trip 17 (Chicago - Los Angeles)
(17, 33, '10F'), (17, 34, '10E'),
-- Trip 18 (San Francisco - Seattle)
(18, 35, '06A'), (18, 36, '06B'),
-- Trip 19 (Washington - Frankfurt)
(19, 37, '21D'),
-- Trip 20 (Houston - Miami)
(20, 38, '09A'),
-- Trip 21 (Denver - Las Vegas)
(21, 1, '14A'), (21, 5, '14B'),
-- Trip 22 (Boston - Amsterdam)
(22, 10, '03A'), (22, 15, '03B');