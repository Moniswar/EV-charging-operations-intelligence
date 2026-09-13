-- ============================================================================
-- PROJECT TITLE: EV CHARGING STATION OPERATIONS INTELLIGENCE
-- LEVEL: Beginner to Intermediate Data Analyst SQL Script
-- TARGET TABLE: EV_Charging (Single Flat Transactional Table)
-- ============================================================================

-- ============================================================================
-- SECTION 1 — CREATE TABLE
-- ============================================================================
-- Creates the single flat transactional table matching the Excel dataset columns.

CREATE TABLE EV_Charging (
    Session_ID VARCHAR(20) PRIMARY KEY,
    Session_Date DATE NOT NULL,
    Session_Time TIME NOT NULL,
    Station_ID VARCHAR(20) NOT NULL,
    Station_Location VARCHAR(50) NOT NULL,
    Vehicle_Type VARCHAR(30) NOT NULL,
    Connector_Type VARCHAR(30) NOT NULL,
    Battery_Start_Percent INT NOT NULL,
    Battery_End_Percent INT NOT NULL,
    Charging_Duration_Min INT NOT NULL,
    Energy_Consumed_kWh DECIMAL(10, 2) NOT NULL,
    Charging_Status VARCHAR(30) NOT NULL,
    Failure_Reason VARCHAR(50) NOT NULL,
    Station_Status VARCHAR(30) NOT NULL,
    Payment_Status VARCHAR(30) NOT NULL,
    Charging_Cost DECIMAL(10, 2) NOT NULL
);


-- ============================================================================
-- SECTION 2 — BASIC DATA CHECKS
-- ============================================================================
-- Initial queries to verify data loading, structure, and date range.

-- 1. View all records in the table
SELECT * 
FROM EV_Charging;

-- 2. Check total row count to ensure all 5,000 records imported successfully
SELECT COUNT(*) AS Total_Records 
FROM EV_Charging;

-- 3. Check the date range covered by the dataset (should cover one full year)
SELECT 
    MIN(Session_Date) AS Start_Date, 
    MAX(Session_Date) AS End_Date
FROM EV_Charging;


-- ============================================================================
-- SECTION 3 — BASIC BUSINESS ANALYSIS
-- ============================================================================
-- Simple, interview-ready analytical queries using SELECT, WHERE, GROUP BY, 
-- ORDER BY, aggregate functions (COUNT, SUM, AVG, MIN, MAX), and basic CASE WHEN.

-- 1. Total charging sessions
SELECT COUNT(Session_ID) AS Total_Charging_Sessions
FROM EV_Charging;

-- 2. Sessions by vehicle type
SELECT 
    Vehicle_Type, 
    COUNT(Session_ID) AS Session_Count
FROM EV_Charging
GROUP BY Vehicle_Type
ORDER BY Session_Count DESC;

-- 3. Sessions by connector type
SELECT 
    Connector_Type, 
    COUNT(Session_ID) AS Session_Count
FROM EV_Charging
GROUP BY Connector_Type
ORDER BY Session_Count DESC;

-- 4. Sessions by charging status
SELECT 
    Charging_Status, 
    COUNT(Session_ID) AS Session_Count
FROM EV_Charging
GROUP BY Charging_Status
ORDER BY Session_Count DESC;

-- 5. Sessions by station
SELECT 
    Station_ID, 
    COUNT(Session_ID) AS Session_Count
FROM EV_Charging
GROUP BY Station_ID
ORDER BY Session_Count DESC;

-- 6. Sessions by location
SELECT 
    Station_Location, 
    COUNT(Session_ID) AS Session_Count
FROM EV_Charging
GROUP BY Station_Location
ORDER BY Session_Count DESC;

-- 7. Average charging duration (in minutes)
SELECT 
    AVG(Charging_Duration_Min) AS Avg_Charging_Duration_Min
FROM EV_Charging;

-- 8. Average energy consumed (in kWh)
SELECT 
    AVG(Energy_Consumed_kWh) AS Avg_Energy_Consumed_kWh
FROM EV_Charging;

-- 9. Total energy consumed across all sessions
SELECT 
    SUM(Energy_Consumed_kWh) AS Total_Energy_Consumed_kWh
FROM EV_Charging;

-- 10. Total charging revenue generated
SELECT 
    SUM(Charging_Cost) AS Total_Charging_Revenue
FROM EV_Charging;

-- 11. Average charging cost per session
SELECT 
    AVG(Charging_Cost) AS Avg_Charging_Cost
FROM EV_Charging;

-- 12. Failure reasons breakdown (filtered for failed sessions)
SELECT 
    Failure_Reason, 
    COUNT(Session_ID) AS Failure_Count
FROM EV_Charging
WHERE Charging_Status = 'Failed'
GROUP BY Failure_Reason
ORDER BY Failure_Count DESC;

-- 13. Failed sessions grouped by station
SELECT 
    Station_ID, 
    Station_Location,
    COUNT(Session_ID) AS Failed_Session_Count
FROM EV_Charging
WHERE Charging_Status = 'Failed'
GROUP BY Station_ID, Station_Location
ORDER BY Failed_Session_Count DESC;

-- 14. Charging sessions by hour of the day
SELECT 
    EXTRACT(HOUR FROM Session_Time) AS Charging_Hour,
    COUNT(Session_ID) AS Session_Count
FROM EV_Charging
GROUP BY EXTRACT(HOUR FROM Session_Time)
ORDER BY Charging_Hour;

-- 15. Average charging duration by connector type
SELECT 
    Connector_Type, 
    AVG(Charging_Duration_Min) AS Avg_Duration_Min
FROM EV_Charging
GROUP BY Connector_Type
ORDER BY Avg_Duration_Min DESC;

-- 16. Total and average energy consumption by vehicle type
SELECT 
    Vehicle_Type, 
    COUNT(Session_ID) AS Session_Count,
    SUM(Energy_Consumed_kWh) AS Total_Energy_kWh,
    AVG(Energy_Consumed_kWh) AS Avg_Energy_kWh
FROM EV_Charging
GROUP BY Vehicle_Type
ORDER BY Total_Energy_kWh DESC;

-- 17. Total revenue generated by city location
SELECT 
    Station_Location, 
    SUM(Charging_Cost) AS Total_Revenue
FROM EV_Charging
GROUP BY Station_Location
ORDER BY Total_Revenue DESC;

-- 18. Station operational status distribution
SELECT 
    Station_Status, 
    COUNT(Session_ID) AS Status_Count
FROM EV_Charging
GROUP BY Station_Status
ORDER BY Status_Count DESC;

-- 19. Payment status distribution
SELECT 
    Payment_Status, 
    COUNT(Session_ID) AS Payment_Count
FROM EV_Charging
GROUP BY Payment_Status
ORDER BY Payment_Count DESC;

-- 20. Top 5 stations by total charging sessions
SELECT 
    Station_ID, 
    Station_Location,
    COUNT(Session_ID) AS Total_Sessions
FROM EV_Charging
GROUP BY Station_ID, Station_Location
ORDER BY Total_Sessions DESC
LIMIT 5;

-- 21. Top 5 stations by total revenue
SELECT 
    Station_ID, 
    Station_Location,
    SUM(Charging_Cost) AS Total_Revenue
FROM EV_Charging
GROUP BY Station_ID, Station_Location
ORDER BY Total_Revenue DESC
LIMIT 5;

-- 22. Stations with highest average charging duration
SELECT 
    Station_ID, 
    Station_Location,
    AVG(Charging_Duration_Min) AS Avg_Duration_Min
FROM EV_Charging
GROUP BY Station_ID, Station_Location
ORDER BY Avg_Duration_Min DESC;

-- 23. Analysis of cancelled sessions
SELECT 
    Station_Location,
    COUNT(Session_ID) AS Cancelled_Sessions
FROM EV_Charging
WHERE Charging_Status = 'Cancelled'
GROUP BY Station_Location
ORDER BY Cancelled_Sessions DESC;

-- 24. Failed payment transactions analysis
SELECT 
    Vehicle_Type,
    COUNT(Session_ID) AS Failed_Payment_Count
FROM EV_Charging
WHERE Payment_Status = 'Failed'
GROUP BY Vehicle_Type
ORDER BY Failed_Payment_Count DESC;

-- 25. Completed versus failed sessions comparison (using CASE WHEN)
SELECT 
    Station_Location,
    SUM(CASE WHEN Charging_Status = 'Completed' THEN 1 ELSE 0 END) AS Completed_Sessions,
    SUM(CASE WHEN Charging_Status = 'Failed' THEN 1 ELSE 0 END) AS Failed_Sessions,
    COUNT(Session_ID) AS Total_Sessions
FROM EV_Charging
GROUP BY Station_Location
ORDER BY Total_Sessions DESC;
