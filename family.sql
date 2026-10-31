-- =====================================================
-- 1. Створення схеми
-- =====================================================

DROP SCHEMA IF EXISTS family CASCADE;
CREATE SCHEMA family;

SET search_path TO family;
-- =====================================================
-- 2. Таблиця family_members
-- =====================================================

CREATE TABLE family.family_members (
    member_id INTEGER PRIMARY KEY,
    status VARCHAR(20) NOT NULL,
    member_name VARCHAR(100) NOT NULL,
    birthday DATE NOT NULL
);

INSERT INTO family.family_members
    (member_id, status, member_name, birthday)
VALUES
    (1, 'father',   'Headley Quincey',   '1960-05-13'),
    (2, 'mother',   'Flavia Quincey',    '1963-02-16'),
    (3, 'son',      'Andie Quincey',     '1983-06-05'),
    (4, 'daughter', 'Lela Quincey',      '1985-06-07'),
    (5, 'daughter', 'Annie Quincey',     '1988-04-10'),
    (6, 'father',   'Ernest Forrest',    '1961-09-11'),
    (7, 'mother',   'Constance Forrest', '1968-09-06'),
    (8, 'daughter', 'Wednesday Addams',  '2005-01-13');

-- =====================================================
-- 3. Таблиця good_types
-- =====================================================

CREATE TABLE family.good_types (
    good_type_id INTEGER PRIMARY KEY,
    good_type_name VARCHAR(100) NOT NULL
);

INSERT INTO family.good_types
    (good_type_id, good_type_name)
VALUES
    (1, 'communal payments'),
    (2, 'food'),
    (3, 'delicacies'),
    (4, 'entertainment'),
    (5, 'treatment'),
    (6, 'education'),
    (7, 'clothes'),
    (8, 'equipment');

-- =====================================================
-- 4. Таблиця goods
-- =====================================================

CREATE TABLE family.goods (
    good_id INTEGER PRIMARY KEY,
    good_name VARCHAR(100) NOT NULL,
    type INTEGER NOT NULL,

    CONSTRAINT fk_goods_good_types
        FOREIGN KEY (type)
        REFERENCES family.good_types(good_type_id)
);

INSERT INTO family.goods
    (good_id, good_name, type)
VALUES
    (1,  'apartment fee',        1),
    (2,  'phone fee',            1),
    (3,  'bread',                2),
    (4,  'milk',                 2),
    (5,  'red caviar',           3),
    (6,  'cinema',               4),
    (7,  'black caviar',         3),
    (8,  'cough tablets',        5),
    (9,  'potato',               2),
    (10, 'pineapples',            3),
    (11, 'television',            8),
    (12, 'vacuum cleaner',        8),
    (13, 'jacket',                7),
    (14, 'fur coat',              7),
    (15, 'music school fee',      6),
    (16, 'english school fee',    6),
    (17, 'airsoft game session',  4),
    (18, 'netflix subscription',  4);

-- =====================================================
-- 5. Таблиця payments
-- =====================================================

CREATE TABLE family.payments (
    payment_id INTEGER PRIMARY KEY,
    date DATE NOT NULL,
    family_member INTEGER NOT NULL,
    good INTEGER NOT NULL,
    amount INTEGER NOT NULL,
    unit_price NUMERIC(12, 2) NOT NULL,

    CONSTRAINT fk_payments_family_members
        FOREIGN KEY (family_member)
        REFERENCES family.family_members(member_id),

    CONSTRAINT fk_payments_goods
        FOREIGN KEY (good)
        REFERENCES family.goods(good_id)
);

INSERT INTO family.payments
    (payment_id, date, family_member, good, amount, unit_price)
VALUES
    (1,  '2005-02-12', 1,  1,  1,  2000),
    (2,  '2005-03-23', 2,  1,  1,  2100),
    (3,  '2005-05-14', 3,  4,  5,  20),
    (4,  '2005-07-22', 4,  5,  1,  350),
    (5,  '2005-07-26', 4,  7,  2,  150),
    (6,  '2005-02-20', 5,  6,  1,  100),
    (7,  '2005-07-30', 2,  6,  1,  120),
    (8,  '2005-09-12', 2,  16, 1,  5500),
    (9,  '2005-09-30', 5,  15, 1,  230),
    (10, '2005-10-27', 5,  15, 1,  230),
    (11, '2005-11-28', 5,  15, 1,  250),
    (12, '2005-12-22', 5,  15, 1,  250),
    (13, '2005-08-11', 3,  13, 1,  2200),
    (14, '2005-10-23', 2,  14, 1,  66000),
    (15, '2005-02-03', 1,  9,  5,  8),
    (16, '2005-03-11', 1,  9,  5,  7),
    (17, '2005-03-18', 2,  9,  3,  8),
    (18, '2005-04-20', 1,  9,  8,  8),
    (19, '2005-05-13', 1,  9,  5,  7),
    (20, '2005-06-11', 2,  9,  3,  150),
    (21, '2006-01-12', 3,  10, 1,  100),
    (22, '2006-03-12', 1,  5,  3,  10),
    (23, '2005-06-05', 1,  8,  1,  300),
    (24, '2005-06-20', 3,  6,  8,  150),
    (25, '2005-06-21', 2,  9,  3,  150),
    (26, '2005-06-22', 5,  18, 1,  16),
    (27, '2005-06-22', 3,  17, 1,  59),
    (28, '2006-01-15', 1,  11, 1,  10000);

-- =====================================================
-- 6. Індекси для зовнішніх ключів
-- =====================================================

CREATE INDEX idx_goods_type
    ON family.goods(type);

CREATE INDEX idx_payments_family_member
    ON family.payments(family_member);

CREATE INDEX idx_payments_good
    ON family.payments(good);

CREATE INDEX idx_payments_date
    ON family.payments(date);