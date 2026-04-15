--Question 2: Identifing the count and demographic profile (Age Group & Gender) of individuals who reported heart_symptoms_past_year but have NO known_diabetes and NO known_hypertension.
CREATE OR REPLACE VIEW vw_undiagnosed_symptoms_profile AS
WITH TargetGroup AS (
    SELECT 
        age_group, 
        gender,
        COUNT(*) as undiagnosed_count
    FROM heart_health_project
    -- Changed from 1/0 to 'Yes'/'No'
    WHERE heart_symptoms_past_year = 'Yes' 
      AND known_diabetes = 'No' 
      AND known_hypertension = 'No'
    GROUP BY age_group, gender
),
DemographicTotals AS (
    SELECT 
        age_group, 
        gender, 
        COUNT(*) as total_in_group
    FROM heart_health_project
    GROUP BY age_group, gender
)
SELECT 
    t.age_group,
    t.gender,
    t.undiagnosed_count,
    ROUND((t.undiagnosed_count * 100.0 / d.total_in_group), 2) AS prevalence_pct
FROM TargetGroup t
JOIN DemographicTotals d ON t.age_group = d.age_group AND t.gender = d.gender
ORDER BY prevalence_pct DESC;

