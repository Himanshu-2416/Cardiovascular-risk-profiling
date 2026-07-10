--Query 7: Measuring AQI device adoption rate by education level.
CREATE OR REPLACE VIEW vw_education_tech_adoption AS
SELECT 
    education_level,
    COUNT(*) AS total_respondents,
    SUM(CASE WHEN aqi_device_available = 'Yes' THEN 1 ELSE 0 END) AS device_owners,
    ROUND(AVG(CASE WHEN aqi_device_available = 'Yes' THEN 1 ELSE 0 END) * 100, 2) AS adoption_rate_pct
FROM heart_health_project
GROUP BY education_level
ORDER BY adoption_rate_pct DESC;
