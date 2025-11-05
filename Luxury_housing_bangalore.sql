SELECT * FROM luxury_housing_bangalore.housing_bangalore;
-- 1. View total sales by builder
SELECT Developer_Name, SUM(Ticket_Price_Cr) AS Total_Sales
FROM housing_bangalore
GROUP BY Developer_Name
ORDER BY Total_Sales DESC;

-- 2. Average ticket size by micro-market
SELECT Micro_Market, AVG(Ticket_Price_Cr) AS Avg_Ticket_Size
FROM housing_bangalore
GROUP BY Micro_Market;

-- 3. Quarterly booking trend
SELECT 
    Purchase_month,
    QUARTER(Purchase_month) AS Quarter,
    COUNT(*) AS Total_Bookings
FROM 
    housing_bangalore
GROUP BY 
    Purchase_month, Quarter
ORDER BY 
    Quarter
LIMIT 0, 1000;

-- Top 5 Locations by Total Projects
SELECT Micro_Market, 
       COUNT(Project_Name) AS Total_Projects
FROM housing_bangalore
GROUP BY Micro_Market
ORDER BY Total_Projects DESC
LIMIT 5;

-- Builder Performance: Average Ticket Size vs Project Count
SELECT Developer_Name,
       COUNT(Project_Name) AS Project_Count,
       AVG(Ticket_Price_Cr) AS Avg_Ticket_Price
FROM housing_bangalore
GROUP BY Developer_Name
ORDER BY Avg_Ticket_Price DESC;

-- Amenity Impact (if amenity data exists)
SELECT Amenity_Score,
       AVG(Ticket_Price_Cr) AS Avg_Price,
       COUNT(*) AS Project_Count
FROM housing_bangalore
GROUP BY Amenity_Score
ORDER BY Amenity_Score DESC;

-- Total Revenue by Year and Micro-Market
SELECT 
    YEAR(Purchase_month) AS Year,
    Micro_Market,
    SUM(Ticket_Price_Cr) AS Total_Revenue
FROM housing_bangalore
GROUP BY Year, Micro_Market
ORDER BY Year, Total_Revenue DESC;
 -- 2. Monthly Booking Trend
 SELECT 
    DATE_FORMAT(Purchase_month, '%Y-%m') AS Month,
    COUNT(*) AS Bookings
FROM housing_bangalore
GROUP BY Month
ORDER BY Month;

-- Top 10 Builders by Average Ticket Price
SELECT 
    Developer_Name,
    AVG(Ticket_Price_Cr) AS Avg_Ticket_Price
FROM housing_bangalore
GROUP BY Developer_Name
ORDER BY Avg_Ticket_Price DESC
LIMIT 10;

-- Most Popular Micro-Markets by Number of Projects
SELECT 
    Micro_Market,
    COUNT(DISTINCT Project_Name) AS Total_Projects
FROM housing_bangalore
GROUP BY Micro_Market
ORDER BY Total_Projects DESC;

-- Price Range Segmentation
SELECT 
    CASE 
        WHEN Ticket_Price_Cr < 1 THEN 'Below 1 Cr'
        WHEN Ticket_Price_Cr BETWEEN 1 AND 2 THEN '1-2 Cr'
        WHEN Ticket_Price_Cr BETWEEN 2 AND 3 THEN '2-3 Cr'
        WHEN Ticket_Price_Cr BETWEEN 3 AND 5 THEN '3-5 Cr'
        ELSE 'Above 5 Cr'
    END AS Price_Segment,
    COUNT(*) AS Total_Projects
FROM housing_bangalore
GROUP BY Price_Segment
ORDER BY Total_Projects DESC;

-- Builder Market Share (% of Total Sales)
SELECT 
    Developer_Name,
    ROUND((SUM(Ticket_Price_Cr) / (SELECT SUM(Ticket_Price_Cr) FROM housing_bangalore)) * 100, 2) AS Market_Share_Percent
FROM housing_bangalore
GROUP BY Developer_Name
ORDER BY Market_Share_Percent DESC;

-- Year-on-Year Growth in Total Sales
SELECT 
    YEAR(Purchase_month) AS Year,
    SUM(Ticket_Price_Cr) AS Total_Sales,
    LAG(SUM(Ticket_Price_Cr)) OVER (ORDER BY YEAR(Purchase_month)) AS Prev_Year_Sales,
    ROUND(((SUM(Ticket_Price_Cr) - LAG(SUM(Ticket_Price_Cr)) OVER (ORDER BY YEAR(Purchase_month))) / 
           LAG(SUM(Ticket_Price_Cr)) OVER (ORDER BY YEAR(Purchase_month))) * 100, 2) AS YoY_Growth_Percent
FROM housing_bangalore
GROUP BY Year
ORDER BY Year;

-- Average Price per Unit Area (if Area_Sqft column exists)
SELECT 
    Micro_Market,
    ROUND(AVG(Ticket_Price_Cr / Unit_Size_Sqft), 2) AS Avg_Price_Per_Sqft
FROM housing_bangalore
WHERE Unit_Size_Sqft IS NOT NULL AND Area_Sqft > 0
GROUP BY Micro_Market
ORDER BY Avg_Price_Per_Sqft DESC;

-- Top Builders by Number of Micro-Markets Present
SELECT 
    Developer_Name,
    COUNT(DISTINCT Micro_Market) AS Markets_Covered
FROM housing_bangalore
GROUP BY Developer_Name
ORDER BY Markets_Covered DESC
LIMIT 10;



