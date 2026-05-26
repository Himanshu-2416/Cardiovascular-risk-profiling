CREATE OR REPLACE VIEW vw_education_tech_adoption AS
SELECT 
    education_level,
    -- people in each educationn category
    COUNT(*) AS total_respondents,
    -- people who own an AQI device
    SUM(CASE WHEN aqi_device_available = 'Yes' THEN 1 ELSE 0 END) AS device_owners,
    -- percentage of adoption (Conversion Rate)
    ROUND(AVG(CASE WHEN aqi_device_available = 'Yes' THEN 1 ELSE 0 END) * 100, 2) AS adoption_rate_pct
FROM heart_health_project
GROUP BY education_level
ORDER BY adoption_rate_pct DESC;
