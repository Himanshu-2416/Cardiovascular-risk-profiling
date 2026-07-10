-- ============================================================
-- Cardiovascular Risk Profiling — MySQL Schema
-- Table: heart_health_project
-- Source: data/processed/heart_health_FINAL_CLEANED.csv
-- ============================================================

CREATE DATABASE IF NOT EXISTS cardiovascular_risk_db;
USE cardiovascular_risk_db;

DROP TABLE IF EXISTS heart_health_project;

CREATE TABLE heart_health_project (
    age                             SMALLINT UNSIGNED NOT NULL,
    gender                          VARCHAR(10)  NOT NULL,
    location_tier                   VARCHAR(10)  NOT NULL,
    city_name                       VARCHAR(50)  NOT NULL,
    living_area_type                VARCHAR(10)  NOT NULL,
    air_quality_level               VARCHAR(15)  NOT NULL,
    aqi_device_available            VARCHAR(5)   NOT NULL,
    education_level                 VARCHAR(20)  NOT NULL,
    occupation_type                 VARCHAR(20)  NOT NULL,
    family_size                     SMALLINT UNSIGNED NOT NULL,
    family_income_per_year          VARCHAR(10)  NOT NULL,
    smoker_in_house                 VARCHAR(5)   NOT NULL,
    fuel_type_used                  VARCHAR(15)  NOT NULL,
    water_source                    VARCHAR(15)  NOT NULL,
    diet_type                       VARCHAR(15)  NOT NULL,
    exercise_level                  VARCHAR(10)  NOT NULL,
    known_diabetes                  VARCHAR(5)   NOT NULL,
    known_hypertension              VARCHAR(5)   NOT NULL,
    family_history_heart_disease    VARCHAR(5)   NOT NULL,
    heart_symptoms_past_year        VARCHAR(5)   NOT NULL,
    income_rank                     TINYINT UNSIGNED NOT NULL,
    high_risk_flag                  TINYINT UNSIGNED NOT NULL,
    age_group                       VARCHAR(15)  NOT NULL,

    -- Helpful indexes for the KPI queries in /sql/queries
    INDEX idx_city (city_name),
    INDEX idx_age_group (age_group),
    INDEX idx_high_risk (high_risk_flag),
    INDEX idx_income_rank (income_rank)
);

-- ============================================================
-- Loading the data
-- ------------------------------------------------------------
-- The raw CSV originally carried a UTF-8 BOM prefix on the first
-- header (age -> shown as ï»¿age), which broke direct LOAD DATA
-- imports and column references. The cleaned CSV in
-- data/processed/ no longer has this issue, but if you re-export
-- from Excel/Colab and hit it again, re-save the file as
-- "CSV UTF-8" without BOM, or strip it with:
--   sed -i '1s/^\xEF\xBB\xBF//' heart_health_FINAL_CLEANED.csv
-- ============================================================

LOAD DATA LOCAL INFILE 'data/processed/heart_health_FINAL_CLEANED.csv'
INTO TABLE heart_health_project
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Sanity check after load
SELECT COUNT(*) AS total_rows FROM heart_health_project;
