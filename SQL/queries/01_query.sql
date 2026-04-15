--Query 1: For each city, calculating the percentage of "High Risk" individuals and ranking the cities from highest risk to lowest.
-- 1. Creating the View
CREATE OR REPLACE VIEW vw_regional_risk_hotspots AS
WITH CityMetrics AS (
    -- Step A: Calculate basic counts per city
    SELECT 
        city_name,
        location_tier,
        COUNT(*) AS total_respondents,
        SUM(high_risk_flag) AS high_risk_count,
        (SUM(high_risk_flag) * 100.0 / COUNT(*)) AS city_risk_pct
    FROM heart_health_project
    GROUP BY city_name, location_tier
),
NationalAvg AS (
    -- Step B: Calculate the single national average percentage
    SELECT 
        (SUM(high_risk_flag) * 100.0 / COUNT(*)) AS national_avg_pct
    FROM heart_health_project
)
-- Step C: Combine them to create the final ranking and variance
SELECT 
    c.city_name,
    c.location_tier,
    ROUND(c.city_risk_pct, 2) AS city_risk_pct,
    ROUND(n.national_avg_pct, 2) AS national_avg_pct,
    -- Variance: How much higher/lower is this city than the national average?
    ROUND((c.city_risk_pct - n.national_avg_pct), 2) AS variance_from_avg,
    -- Rank cities from highest risk % to lowest
    RANK() OVER (ORDER BY c.city_risk_pct DESC) AS risk_rank
FROM CityMetrics c, NationalAvg n;

