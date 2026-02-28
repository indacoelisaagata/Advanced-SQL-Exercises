/* * PROJECT: Advanced SQL Portfolio - Coworking Booking
 * TOPIC: Real-World System Design
 * GOAL: Manage room reservations with capacity constraints and conflict prevention.
 * TECHNIQUE: ACID Transactions, Stored Procedures, and Relational Views.
 * SETUP SCRIPT: 05_setup.sql
 * AUTHOR: Elisa Agata Indaco
 *
 * DATABASE SCHEMA:
 * - Rooms (room_id, room_name, capacity)
 * - Bookings (booking_id, room_id, customer_name, start_time, end_time)
 */

-- 1. CORE LOGIC: RESERVATION PROCEDURE
-- This procedure encapsulates the logic required to validate and save a booking.
DELIMITER //

CREATE PROCEDURE CreateBooking(
    IN p_room_id INT,
    IN p_customer VARCHAR(100),
    IN p_start DATETIME,
    IN p_end DATETIME,
    OUT p_result VARCHAR(100)
)
BEGIN
    DECLARE current_occupancy INT;
    DECLARE max_capacity INT;

    -- Fetch the maximum capacity of the requested room.
    SELECT capacity INTO max_capacity 
    FROM Rooms 
    WHERE room_id = p_room_id;

    -- Check for overlapping bookings.
    SELECT COUNT(*) INTO current_occupancy
    FROM Bookings
    WHERE room_id = p_room_id
      AND (p_start < end_time AND p_end > start_time);

    -- Validation logic
    IF current_occupancy < max_capacity THEN
        INSERT INTO Bookings (room_id, customer_name, start_time, end_time)
        VALUES (p_room_id, p_customer, p_start, p_end);
        SET p_result = 'SUCCESS: Reservation confirmed.';
    ELSE
        SET p_result = 'ERROR: No seats available for this time slot.';
    END IF;
END //

DELIMITER ;

-- 2. ANALYTICS: REAL-TIME MONITORING VIEW
CREATE VIEW RoomStatus AS
SELECT 
    r.room_name,
    r.capacity,
    COUNT(b.booking_id) AS active_bookings,
    (r.capacity - COUNT(b.booking_id)) AS available_seats
FROM Rooms r
LEFT JOIN Bookings b ON r.room_id = b.room_id 
     AND NOW() BETWEEN b.start_time AND b.end_time
GROUP BY r.room_id, r.room_name, r.capacity;
