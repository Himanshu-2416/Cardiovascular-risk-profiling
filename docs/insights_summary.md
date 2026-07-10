# Key Findings & Insights

Synthesis of the 10 SQL KPI views in `sql/query_soln/`. Full query logic lives
in `sql/queries/`; raw outputs are the accompanying CSVs.

## 1. Regional Risk Hotspots
Ahmedabad (Tier 2) has the highest cardiovascular risk prevalence at 27.88% —
6.6 points above the 21.31% national average. Delhi appears twice in the top 3
(both Tier 1 and Tier 3 segments), suggesting risk in Delhi isn't purely a
tier/infrastructure effect. Patna (Tier 2), by contrast, sits nearly 6 points
**below** the national average — the lowest-risk segment in the dataset.

## 2. Undiagnosed Symptom Prevalence
Mid-Senior Males report the highest rate (9.64%) of cardiac symptoms with
**no** existing diabetes or hypertension diagnosis — a population that looks
healthy on paper but is symptomatic. Senior Males show the lowest undiagnosed
rate (5.57%), possibly reflecting more consistent medical monitoring at
older ages.

## 3. Air Quality × Exercise Interaction
Very Poor air quality combined with Low exercise produces the single highest
risk cell in the matrix (25.68%) — worse than Very Poor air quality alone,
confirming air quality and inactivity compound rather than substitute for
each other.

## 4. Socio-Economic Health Gap
The income-risk relationship **reverses by tier**: in Tier 1 cities, high-income
respondents are *slightly* more at risk than low-income ones (+1.06 gap toward
high income) — but in Tier 2 and Tier 3 cities, low income carries meaningfully
higher risk (+1.98 and +0.55 respectively). This says the "wealth protects
health" pattern doesn't hold uniformly across urban tiers.

## 5. Second-Hand Smoke Risk Multiplier
Adults in smoking households carry 1.14x the cardiovascular risk of
non-smoking households — the strongest multiplier in the dataset. Notably,
the Mid-Senior group shows a multiplier just under 1.0, meaning household
smoking isn't a meaningfully elevated risk factor for that cohort specifically.

## 6. Double Burden Hotspots
25 city/tier combinations show more than 10% of respondents facing both
low income **and** very poor air quality simultaneously. Kanpur (Tier 1) and
Delhi (Tier 1 and Tier 2) top this list — these are the clearest targets for
combined economic and environmental public health interventions.

## 7. Education & AQI Device Adoption
Adoption of AQI monitoring devices is low across the board (under 11%
everywhere) and **does not scale with education level** — Secondary
education respondents (10.96%) out-adopt Postgraduates (9.47%). This
suggests device cost or awareness campaigns, not education level, are the
binding constraint.

## 8. Occupational Stress Index
Unemployed respondents carry both the highest risk percentage (22.01%) and
the highest stress index (8.88) when risk is weighted against income. Desk
Job holders have the lowest stress index (8.06) — despite a sedentary
lifestyle, higher and more stable income appears to offset some risk.

## 9. Infrastructure Health Impact
Counterintuitively, "Traditional" infrastructure households (wood/kerosene
fuel, borewell/tap water) show *nearly identical* risk (21.12%) to "Modern"
households (20.96%) — under a 1-point gap. Infrastructure type alone is a
weak predictor; it likely needs to be combined with income or air quality
(see KPI 6) to surface a real effect.

## 10. Critical Screening Age
The 5-year rolling risk trend shows the smoothed risk curve climbing from
the low-20s in the 20s/30s age bracket toward a clear peak around the
mid-70s to late-70s (with a local high near age 78 at 23.4% smoothed risk),
before volatility increases in the sparser 80+ tail. This supports
recommending intensified screening protocols starting in the early-to-mid
70s age bracket, rather than a single "magic number" screening age.

---

**How these were used downstream:** these 10 result sets are the direct
data source for the Power BI dashboard (see `docs/powerbi_roadmap.md`) —
each CSV maps to a specific visual (choropleth map, matrix heatmap, KPI
cards, and trend line respectively).
