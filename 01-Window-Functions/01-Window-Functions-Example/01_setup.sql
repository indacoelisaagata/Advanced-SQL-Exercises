/* * SETUP FILE: 01_setup.sql
 * PROJECT: Sales Analysis using Window Functions
 * TARGET QUERY FILE: 01_window_functions_example.sql
 * DESCRIPTION: Initializes tables and populates data for movie rental analysis.
 * AUTHOR: Elisa Agata Indaco
 */

-- Disable foreign key checks to facilitate table recreation
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS rental, inventory, film_category, film, category;
SET FOREIGN_KEY_CHECKS = 1;

-- Table: category
CREATE TABLE category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(25) NOT NULL
);

-- Table: film
CREATE TABLE film (
    film_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);

-- Table: film_category (Mapping Table)
CREATE TABLE film_category (
    film_id INT,
    category_id INT,
    PRIMARY KEY (film_id, category_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE CASCADE
);

-- Table: inventory (Physical copies)
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    film_id INT,
    FOREIGN KEY (film_id) REFERENCES film(film_id) ON DELETE CASCADE
);

-- Table: rental
CREATE TABLE rental (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_date DATETIME NOT NULL,
    inventory_id INT,
    FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id) ON DELETE CASCADE
);

-- POPULATING DATA
INSERT INTO category (name) VALUES ('Action'), ('Sci-Fi'), ('Drama');

INSERT INTO film (title) VALUES ('Mad Max'), ('Die Hard'), ('Interstellar'), ('Inception'), ('The Godfather');

INSERT INTO film_category (film_id, category_id) VALUES 
(1, 1), (2, 1), -- Mad Max, Die Hard (Action)
(3, 2), (4, 2), -- Interstellar, Inception (Sci-Fi)
(5, 3);         -- The Godfather (Drama)

-- Inserting inventory items
INSERT INTO inventory (film_id) VALUES (1), (1), (2), (3), (3), (3), (4), (4), (5);

-- Simulating rentals (Populating rental counts)
INSERT INTO rental (rental_date, inventory_id) VALUES 
-- Action: Mad Max (3 rentals), Die Hard (1 rental)
('2023-01-01', 1), ('2023-01-02', 1), ('2023-01-03', 2), ('2023-01-04', 3),
-- Sci-Fi: Interstellar (4 rentals), Inception (2 rentals)
('2023-01-05', 4), ('2023-01-06', 5), ('2023-01-07', 6), ('2023-01-08', 4), ('2023-01-09', 7), ('2023-01-10', 8),
-- Drama: The Godfather (1 rental)
('2023-01-11', 9);
