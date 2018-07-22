DROP TABLE ships CASCADE;
DROP TABLE captains;

CREATE TABLE ships (
    id SERIAL8 PRIMARY KEY,
    model VARCHAR (255),
    class VARCHAR  (255),
    sales_status VARCHAR (255)
);

CREATE TABLE captains (
    id SERIAL8 PRIMARY KEY,
    first_name VARCHAR (255),
    last_name VARCHAR (255),
    ship_id INT8 REFERENCES ships(id)
);