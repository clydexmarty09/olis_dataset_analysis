## Initial Data Exploration — Excel

I initially explored the Olist Orders dataset using Microsoft Excel to understand its structure, identify missing values, and examine order fulfillment statuses.

Using PivotTables and basic data validation, I identified:

- **99,441 total orders**, of which **96,478 (97.02%)** were marked as delivered.
- **4,908 missing date values** across the dataset's date columns, including 2,965 missing customer delivery dates, 1,783 missing carrier delivery dates, and 160 missing approval dates.
- **8 orders marked as delivered** despite having no recorded customer delivery date, indicating potential data-quality inconsistencies.

Missing delivery dates were not necessarily errors, as orders in other statuses may not have completed the delivery process.

These initial findings informed the subsequent SQL-based analysis.
