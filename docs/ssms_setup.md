# Database Execution Guide (SSMS)

To run the database setup script in SQL Server Management Studio:
1. Open SSMS and connect to your SQL Server instance.
2. Open `docs/RaceDay_Database_Setup.sql`.
3. Click **Execute** (`F5`).
4. Ensure the output message confirms successful table creation and data insertion.

## Verification Steps
Run `SELECT * FROM TableName;` on all 6 tables to verify seed data population.
