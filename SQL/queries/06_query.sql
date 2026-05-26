CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `heart_health_project`.`vw_double_burden_hotspots` AS
    SELECT 
        `heart_health_project`.`heart_health_project`.`city_name` AS `city_name`,
        `heart_health_project`.`heart_health_project`.`location_tier` AS `location_tier`,
        COUNT(0) AS `total_respondents`,
        SUM((CASE
            WHEN
                ((`heart_health_project`.`heart_health_project`.`income_rank` = 1)
                    AND (`heart_health_project`.`heart_health_project`.`air_quality_level` = 'Very Poor'))
            THEN
                1
            ELSE 0
        END)) AS `vulnerable_count`,
        ROUND(((SUM((CASE
                    WHEN
                        ((`heart_health_project`.`heart_health_project`.`income_rank` = 1)
                            AND (`heart_health_project`.`heart_health_project`.`air_quality_level` = 'Very Poor'))
                    THEN
                        1
                    ELSE 0
                END)) * 100.0) / COUNT(0)),
                2) AS `double_burden_pct`
    FROM
        `heart_health_project`.`heart_health_project`
    GROUP BY `heart_health_project`.`heart_health_project`.`city_name` , `heart_health_project`.`heart_health_project`.`location_tier`
    HAVING (`double_burden_pct` > 5)
    ORDER BY `double_burden_pct` DESC
