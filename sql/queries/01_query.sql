--Query 1: For each city, calculating the percentage of "High Risk" individuals and ranking the cities from highest risk to lowest.
CREATE OR REPLACE VIEW vw_regional_risk_hotspots AS
WITH CityMetrics AS (
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
    SELECT 
        (SUM(high_risk_flag) * 100.0 / COUNT(*)) AS national_avg_pct
    FROM heart_health_project
)
SELECT 
    c.city_name,
    c.location_tier,
    ROUND(c.city_risk_pct, 2) AS city_risk_pct,
    ROUND(n.national_avg_pct, 2) AS national_avg_pct,
    ROUND((c.city_risk_pct - n.national_avg_pct), 2) AS variance_from_avg,
    RANK() OVER (ORDER BY c.city_risk_pct DESC) AS risk_rank
FROM CityMetrics c, NationalAvg n;
