/* * SETUP FILE: 05_setup.sql
 * PROJECT: Real-World Booking System
 * TARGET QUERY FILE: 05_coworking_booking_system.sql
 * DESCRIPTION: Initializes Rooms and Bookings tables with sample assets and reservations.
 * AUTHOR: Elisa Agata Indaco
 */

-- Cleanup
SET FOREIGN_KEY_CHECKS = 0;
DROP VIEW IF EXISTS RoomStatus;
DROP PROCEDURE IF EXISTS CreateBooking;
DROP TABLE IF EXISTS Bookings, Rooms;
SET FOREIGN_KEY_CHECKS = 1;

-- Table: Rooms
CREATE TABLE Rooms (
    room_id INT PRIMARY KEY,
    room_name VARCHAR(50) NOT NULL,
    capacity INT NOT NULL CHECK (capacity > 0)
);

-- Table: Bookings
CREATE TABLE Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id) ON DELETE CASCADE,
    CONSTRAINT chk_time_order CHECK (end_time > start_time)
);

-- POPULATING DATA
-- Room 1: Small office (Capacity 1) | Room 2: Conference Hall (Capacity 10)
INSERT INTO Rooms (room_id, room_name, capacity) VALUES 
(1, 'Private Office A', 1),
(2, 'Main Conference Hall', 10);

-- Existing booking for Jan 1st, 10:00 to 12:00 in Room 1
INSERT INTO Bookings (room_id, customer_name, start_time, end_time) VALUES 
(1, 'John Doe', '2026-01-01 10:00:00', '2026-01-01 12:00:00');

/* * TEST CASE SCENARIOS:
 * 1. Booking Room 1 during the same slot -> Should FAIL (Capacity reached).
 * 2. Booking Room 1 in a different slot -> Should SUCCEED.
 * 3. Booking Room 2 during any slot -> Should SUCCEED (High capacity).
 */
