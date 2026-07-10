--Query 9: Classifying households into Traditional/Modern/Mixed infrastructure and comparing heart risk.
CREATE OR REPLACE VIEW vw_infrastructure_health_impact AS
WITH HouseholdCategories AS (
    SELECT 
        high_risk_flag,
        CASE 
            WHEN fuel_type_used IN ('Wood', 'Kerosene') 
                 AND water_source IN ('Borewell', 'Tap') THEN 'Traditional (High Risk)'
            WHEN fuel_type_used IN ('Lpg', 'Induction') 
                 AND water_source IN ('Filtered', 'Bottled') THEN 'Modern (Low Risk)'
            ELSE 'Mixed Infrastructure'
        END AS infra_type
    FROM heart_health_project
)
SELECT 
    infra_type,
    COUNT(*) AS household_count,
    ROUND(AVG(high_risk_flag) * 100, 2) AS heart_risk_pct
FROM HouseholdCategories
GROUP BY infra_type
ORDER BY heart_risk_pct DESC;
