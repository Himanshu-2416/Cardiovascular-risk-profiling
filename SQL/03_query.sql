--Question 3: Creating a matrix showing the high_risk_flag rate for every combination of air_quality_level and exercise_level.
-- Create a View for the Risk Matrix
CREATE OR REPLACE VIEW vw_env_exercise_risk_matrix AS
SELECT 
    air_quality_level, 
    exercise_level, 
    -- Count of people in this specific category
    COUNT(*) as group_size,
    -- The average risk flag multiplied by 100 gives us the percentage
    ROUND(AVG(high_risk_flag) * 100, 2) as risk_prevalence_pct
FROM heart_health_project
GROUP BY air_quality_level, exercise_level
ORDER BY 
    -- This helps keep the output organized logically
    FIELD(air_quality_level, 'Good', 'Poor', 'Very Poor'),
    FIELD(exercise_level, 'Low', 'Moderate', 'High');

