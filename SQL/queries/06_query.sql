CREATE OR REPLACE VIEW vw_double_burden_hotspots AS
SELECT 
    city_name,
    location_tier,
    COUNT(*) AS total_respondents,
    -- Using TRIM and UPPER to avoid matching issues
    SUM(CASE WHEN income_rank = 1 AND TRIM(UPPER(air_quality_level)) = 'VERY POOR' THEN 1 ELSE 0 END) AS vulnerable_count,
    ROUND((SUM(CASE WHEN income_rank = 1 AND TRIM(UPPER(air_quality_level)) = 'VERY POOR' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)),2) AS double_burden_pct
FROM heart_health_project
GROUP BY city_name, location_tier
HAVING double_burden_pct > 10
ORDER BY double_burden_pct DESC;
