--Query 5: Calculateing the "Risk Multiplier"—the ratio of high_risk_flag prevalence in houses with a smoker vs. houses without a smoker, partitioned by age_group.
--  a View to analyze the impact of second-hand smoking environments
CREATE OR REPLACE VIEW vw_smoking_risk_multiplier AS
WITH RiskByHouseType AS (
    SELECT 
        age_group,
        -- Average risk for households WITH a smoker
        AVG(CASE WHEN smoker_in_house = 'Yes' THEN high_risk_flag END) as smoker_house_risk,
        -- Average risk for households WITHOUT a smoker
        AVG(CASE WHEN smoker_in_house = 'No' THEN high_risk_flag END) as non_smoker_house_risk
    FROM heart_health_project
    GROUP BY age_group
)
SELECT 
    age_group,
    ROUND(smoker_house_risk * 100, 2) as smoking_house_risk_pct,
    ROUND(non_smoker_house_risk * 100, 2) as non_smoking_house_risk_pct,
    -- The Multiplier: (Smoking Risk / Non-Smoking Risk)
    -- We use NULLIF to avoid division by zero errors
    ROUND(smoker_house_risk / NULLIF(non_smoker_house_risk, 0), 2) as risk_multiplier
FROM RiskByHouseType
ORDER BY risk_multiplier DESC;

