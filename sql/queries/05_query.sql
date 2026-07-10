--Query 5: Calculating the "Risk Multiplier"-the ratio of high_risk_flag prevalence in houses with a smoker vs. houses without a smoker, partitioned by age_group.
CREATE OR REPLACE VIEW vw_smoking_risk_multiplier AS
WITH RiskByHouseType AS (
    SELECT 
        age_group,
        AVG(CASE WHEN smoker_in_house = 'Yes' THEN high_risk_flag END) as smoker_house_risk,
        AVG(CASE WHEN smoker_in_house = 'No' THEN high_risk_flag END) as non_smoker_house_risk
    FROM heart_health_project
    GROUP BY age_group
)
SELECT 
    age_group,
    ROUND(smoker_house_risk * 100, 2) as smoking_house_risk_pct,
    ROUND(non_smoker_house_risk * 100, 2) as non_smoking_house_risk_pct,
    ROUND(smoker_house_risk / NULLIF(non_smoker_house_risk, 0), 2) as risk_multiplier
FROM RiskByHouseType
ORDER BY risk_multiplier DESC;
