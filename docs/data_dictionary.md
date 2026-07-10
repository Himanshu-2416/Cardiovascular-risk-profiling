# Data Dictionary

Reference for every column in `data/processed/heart_health_FINAL_CLEANED.csv`
and the `heart_health_project` MySQL table.

## Raw Survey Fields

| Column | Type | Description | Example Values |
|---|---|---|---|
| `age` | int | Respondent age in years | 18–84 |
| `gender` | string | Self-reported gender | Male, Female, Other |
| `location_tier` | string | Indian city tier classification | Tier 1, Tier 2, Tier 3 |
| `city_name` | string | City of residence | Delhi, Mumbai, Kanpur, ... |
| `living_area_type` | string | Urban or rural residence | Urban, Rural |
| `air_quality_level` | string | Self-reported / regional air quality band | Good, Moderate, Poor, Very Poor |
| `aqi_device_available` | string | Whether the household owns an AQI monitoring device | Yes, No |
| `education_level` | string | Highest education attained (imputed where missing — see notebook §2.2) | Primary, Secondary, Graduate, Postgraduate |
| `occupation_type` | string | Primary occupation | Desk Job, Field Job, Student, Homemaker, Unemployed |
| `family_size` | int | Number of people in the household | 1+ |
| `family_income_per_year` | string | Annual household income bracket | < 3L, 3–6L, 6–10L, 10L+ |
| `smoker_in_house` | string | Whether any household member smokes | Yes, No |
| `fuel_type_used` | string | Primary cooking fuel | Wood, Kerosene, Lpg, Induction |
| `water_source` | string | Primary drinking water source | Borewell, Tap, Filtered, Bottled |
| `diet_type` | string | Dietary pattern | Vegetarian, Non-Veg |
| `exercise_level` | string | Self-reported physical activity level | Low, Moderate, High |
| `known_diabetes` | string | Existing diabetes diagnosis | Yes, No |
| `known_hypertension` | string | Existing hypertension diagnosis | Yes, No |
| `family_history_heart_disease` | string | Family history of heart disease | Yes, No |
| `heart_symptoms_past_year` | string | Reported cardiac symptoms in the last 12 months | Yes, No |

> Two administrative columns present in the raw survey — `consent_for_use` and
> `data_sharing_consent` — are dropped during cleaning since they carry no
> analytical value.

## Engineered Fields

| Column | Type | Description | Logic |
|---|---|---|---|
| `income_rank` | int (1–4) | Ordinal encoding of `family_income_per_year` for numeric/correlation analysis | `< 3L`→1, `3–6L`→2, `6–10L`→3, `10L+`→4 |
| `high_risk_flag` | int (0/1) | Composite cardiovascular risk indicator | 1 if the respondent has **≥2 of 4** clinical red flags: `known_hypertension`, `known_diabetes`, `heart_symptoms_past_year`, `family_history_heart_disease` — else 0 |
| `age_group` | string | Generational cohort bucket | Young (≤30), Adult (31–50), Mid-Senior (51–75), Senior (76+) |

## Notes on Data Quality

- **Missing values:** `education_level` had ~1,990 nulls in the raw file, imputed
  using the most frequent education level within the same `occupation_type`
  (not a global mode — see notebook §2.2 for rationale).
- **Encoding:** the raw CSV originally exhibited a UTF-8 BOM prefix on the first
  header (`age` appearing as `ï»¿age`), which broke direct SQL imports and one
  window-function query. Cleaned in the export step; see `sql/schema.sql` for
  the fix if you re-encounter it.
- **Outlier audit:** ages outside 0–110 and household sizes below 1 were checked
  and removed (0 found in this dataset, but the check remains in the pipeline
  for future data drops).
- **Text normalization:** all string columns are stripped and Title-Cased so
  `"mumbai"`, `" Mumbai "`, and `"MUMBAI"` collapse to a single consistent value.
