## SQL Data Exploration and Validation

After importing the Olist dataset into SQLite, I performed initial data validation by checking row counts, missing values, and order statuses.

The SQL results matched my earlier Excel findings, confirming consistency between the two analyses.

I also observed that the date columns were imported as `TEXT`, which SQLite supports for storing dates and timestamps.

Additionally, I confirmed that 8 orders marked as delivered had missing customer delivery dates. These records may represent data-quality inconsistencies and warrant further investigation.

Of the 99,441 orders, 775 had no matching records in the order items table. About 99% of these unmatched orders were eitrher cancelled or unavailable, suggesting that a missing item records are strongly associated with unsuccesfful order fulfillment.

Of the 96,478 orders marked as 'delivred,' 6,534 (6.77%) arrived **after** their estimated delivered dates. Late deliveries were identified by comparing the actual customer delivery date against the estimated delivery date using SQLite's date() function.
