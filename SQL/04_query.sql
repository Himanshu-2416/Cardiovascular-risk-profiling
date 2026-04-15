--Question 4: For each location_tier, finding the difference in high_risk_flag percentage between the highest income rank (4) and the lowest income rank (1).
-- Creating a View to measure the Health Gap between Income Classes
CREATE OR REPLACE VIEW vw_socio_economic_health_gap AS
SELECT 
    location_tier,
    -- Calculate risk for the lowest income rank (1)
    ROUND(AVG(CASE WHEN income_rank = 1 THEN high_risk_flag END) * 100, 2) AS low_income_risk_pct,
    -- Calculate risk for the highest income rank (4)
    ROUND(AVG(CASE WHEN income_rank = 4 THEN high_risk_flag END) * 100, 2) AS high_income_risk_pct,
    -- The "Gap": Difference between the two
    ROUND(
        (AVG(CASE WHEN income_rank = 1 THEN high_risk_flag END) - 
         AVG(CASE WHEN income_rank = 4 THEN high_risk_flag END)) * 100, 2
    ) AS risk_gap_percentage
FROM heart_health_project
GROUP BY location_tier
ORDER BY location_tier ASC;


