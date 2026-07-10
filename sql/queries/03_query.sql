--Query 3: Creating a matrix showing the high_risk_flag rate for every combination of air_quality_level and exercise_level.
CREATE OR REPLACE VIEW vw_env_exercise_risk_matrix AS
SELECT 
    air_quality_level, 
    exercise_level, 
    COUNT(*) as group_size,
    ROUND(AVG(high_risk_flag) * 100, 2) as risk_prevalence_pct
FROM heart_health_project
GROUP BY air_quality_level, exercise_level
ORDER BY 
    FIELD(air_quality_level, 'Good', 'Poor', 'Very Poor'),
    FIELD(exercise_level, 'Low', 'Moderate', 'High');
