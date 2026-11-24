## SQL Data Exploration and Validation

After importing the Olist dataset into SQLite, I performed initial data validation by checking row counts, missing values, and order statuses.

The SQL results matched my earlier Excel findings, confirming consistency between the two analyses.

I also observed that the date columns were imported as `TEXT`, which SQLite supports for storing dates and timestamps.

Additionally, I confirmed that 8 orders marked as delivered had missing customer delivery dates. These records may represent data-quality inconsistencies and warrant further investigation.
