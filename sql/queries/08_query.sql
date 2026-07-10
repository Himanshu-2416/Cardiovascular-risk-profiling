--Query 8: Building an Occupational Stress Index (Risk % relative to average income rank) per occupation type.
CREATE OR REPLACE VIEW vw_occupation_stress_index AS
SELECT 
    occupation_type,
    ROUND(AVG(high_risk_flag) * 100, 2) AS risk_pct,
    ROUND(AVG(income_rank), 2) AS avg_income_rank,
    ROUND((AVG(high_risk_flag) * 100) / NULLIF(AVG(income_rank), 0), 2) AS stress_index
FROM heart_health_project
GROUP BY occupation_type
ORDER BY stress_index DESC;
