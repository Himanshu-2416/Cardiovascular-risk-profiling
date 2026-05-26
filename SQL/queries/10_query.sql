CREATE OR REPLACE VIEW vw_critical_screening_age AS
WITH AgeRisk AS (
    SELECT 
        `ï»¿age` AS age_val, 
        COUNT(*) AS respondents_at_age,
        AVG(high_risk_flag) * 100 AS raw_risk_pct
    FROM heart_health_project
    GROUP BY `ï»¿age`
)
SELECT 
    age_val AS age,
    ROUND(raw_risk_pct, 2) AS raw_risk_pct,
    -- 5 year rolling average to identify the inflection point
    ROUND(
        AVG(raw_risk_pct) OVER (ORDER BY age_val ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING), 2) AS smoothed_risk_trend
FROM AgeRisk;
