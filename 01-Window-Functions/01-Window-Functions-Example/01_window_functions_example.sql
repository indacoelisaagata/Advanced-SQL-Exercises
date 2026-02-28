/* * PROJECT: Advanced SQL Portfolio
 * SETUP SCRIPT: 01_setup.sql
 * TOPIC: Sales Analysis using Window Functions
 * GOAL: Rank movies by rental popularity within each category
 * TECHNIQUE: Common Table Expressions (CTE) & DENSE_RANK()
 * AUTHOR: Elisa Agata Indaco 
 *
 * DATABASE SCHEMA:
 * - category (category_id, name): Master data for movie genres.
 * - film (film_id, title): Master data for movie titles.
 * - film_category (film_id, category_id): Mapping table (N:M relationship).
 * - inventory (inventory_id, film_id): Individual physical/digital copies of films.
 * - rental (rental_id, rental_date, inventory_id): Transactional data for rentals.
 */
 

-- Step 1: Create a CTE to aggregate total rentals per movie and category
WITH CategoryRentals AS (
    SELECT 
        c.name AS category_name,
        f.title AS movie_title,
        COUNT(r.rental_id) AS total_rentals
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.name, f.title
)
-- Step 2: Apply DENSE_RANK to create a partitioned ranking
SELECT 
    category_name,
    movie_title,
    total_rentals,
    /* * DENSE_RANK() is used to ensure no gaps in ranking values if there's a tie.
     * PARTITION BY category_name resets the rank for each specific category.
     * ORDER BY total_rentals DESC ensures the most rented movies are #1.
     */
    DENSE_RANK() OVER (
        PARTITION BY category_name 
        ORDER BY total_rentals DESC
    ) AS category_rank
FROM CategoryRentals
ORDER BY category_name, category_rank;

/* * ENGINEERING NOTES:
 * 1. CTE Usage: Improves readability and maintainability compared to nested subqueries.
 * 2. Window Functions: Perform calculations across a set of table rows that are 
 * related to the current row, without collapsing them into a single output row.
 * 3. Performance: In a production environment, ensure indexes exist on foreign keys 
 * (category_id, film_id, inventory_id) to optimize JOIN operations.
 */

/* * DESIGN CHOICE: DENSE_RANK() vs RANK()
 * I chose DENSE_RANK() to ensure a continuous ranking sequence. 
 * If two movies share the same rental count, the next rank will not be skipped, 
 * providing a more readable leaderboard for business stakeholders.
 */
