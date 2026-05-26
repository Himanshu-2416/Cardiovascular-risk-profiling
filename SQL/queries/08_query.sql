CREATE OR REPLACE VIEW vw_occupation_stress_index AS
SELECT 
    occupation_type,
    -- Heart Risk Percentage for this job type
    ROUND(AVG(high_risk_flag) * 100, 2) AS risk_pct,
    -- Average Income Rank for this job type (Scale 1-4)
    ROUND(AVG(income_rank), 2) AS avg_income_rank,
    -- Stress Index calculation
    ROUND((AVG(high_risk_flag) * 100) / NULLIF(AVG(income_rank), 0), 2) AS stress_index
FROM heart_health_project
GROUP BY occupation_type
ORDER BY stress_index DESC;
