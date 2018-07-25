DROP TABLE crews;
DROP TABLE ships;
DROP TABLE captains;


CREATE TABLE captains (
    id SERIAL8 PRIMARY KEY,
    first_name VARCHAR (255),
    last_name VARCHAR (255)
);

CREATE TABLE ships (
    id SERIAL8 PRIMARY KEY,
    ship_name VARCHAR (255),    
    model VARCHAR (255),
    class VARCHAR  (255),
    arrival_date DATE,
    sales_status VARCHAR (255),
    captain_id INT8 REFERENCES captains(id)
);

CREATE TABLE crews (
    id SERIAL8 PRIMARY KEY,
    first_name VARCHAR (255),
    last_name VARCHAR (255),
    ROLE VARCHAR (255),
    ship_id INT8 REFERENCES ships(id),
    captain_id INT8 REFERENCES captains(id)
);