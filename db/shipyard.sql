DROP TABLE captains;
DROP TABLE ships;

CREATE TABLE captains (
    id SERIAL8 PRIMARY KEY,
    first_name VARCHAR (255),
    last_name VARCHAR (255)
);

CREATE TABLE ships (
    id SERIAL8 PRIMARY KEY,
    model VARCHAR (255),
    class VARCHAR  (255),
    arrival_date VARCHAR (255),
    sales_status VARCHAR (255),
    captain_id INT8 REFERENCES captains(id)
);