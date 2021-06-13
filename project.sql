CREATE TABLE categories (
    id NUMBER PRIMARY KEY,
    name VARCHAR(30),
    description VARCHAR,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE games (
    id NUMBER PRIMARY KEY,
    name VARCHAR(30),
    description VARCHAR,
    is_active BOOLEAN DEFAULT TRUE,
    average_score NUMERIC(5, 2),
    is_adult_only BOOLEAN NOT NULL,
    category_id NUMBER NOT NULL
);


ALTER TABLE games ADD FOREIGN KEY(category_id) REFERENCES categories(id);