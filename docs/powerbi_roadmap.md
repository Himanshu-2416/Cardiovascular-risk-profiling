# Power BI Dashboard — Roadmap

**Status: Not yet built.** This document specs out the planned dashboard so
the design is captured before implementation — treat it as the build plan,
not a description of an existing deliverable.

## Planned Structure (3 pages)

### Page 1 — National Overview
- KPI cards: overall high-risk %, total respondents, national avg risk
- Choropleth/bubble map of India using `city_name` (KPI 1: regional risk hotspots)
- Tile slicers: `location_tier`, `gender`, `age_group` for cross-filtering the whole page

### Page 2 — Risk Drivers
- Heatmap matrix: air quality × exercise level (KPI 3)
- Bar chart: risk gap by income rank per location tier (KPI 4)
- Bar chart: second-hand smoke risk multiplier by age group (KPI 5)
- Bar chart: infrastructure type vs heart risk % (KPI 9)

### Page 3 — Screening & Equity
- Line chart: smoothed risk trend by age, highlighting the critical screening
  age band (KPI 10)
- Table/bar: undiagnosed symptom prevalence by age group and gender (KPI 2)
- Bar chart: occupational stress index (KPI 8)
- Table: double burden hotspot cities (KPI 6)

## Data Model Plan
- Import the 10 KPI CSVs from `sql/query_soln/` as separate tables
- Relationships: join on shared keys (`city_name`, `age_group`, `location_tier`)
  where tables overlap, to avoid "isolated data island" warnings
- `city_name` needs its Data Category set to **City** to activate map visuals

## Known Setup Steps (from the original project notes)
- Map `city_name` strings to Power BI's geographic data category manually if
  auto-detection misclassifies any city
- Use Tile Slicers (not standard slicers) for the demographic filters to match
  the intended cross-filtering UX

## Next Steps
1. Load the 10 CSVs into Power BI Desktop
2. Build Page 1, validate the map renders correctly against `city_name`
3. Build Pages 2–3
4. Export a static PDF and add screenshots to `docs/images/` for the README
5. Publish the `.pbix` file (or a link to Power BI Service) and update this doc
   from "Roadmap" to "Live Dashboard"
