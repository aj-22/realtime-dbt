# Inspiration

The dbt Engineers wrote community blog post on achieving realtime analytics with dbt. This project attempts to replicate what has been done by dbt engineers. The link to the blog post is posted below:

https://discourse.getdbt.com/t/how-to-create-near-real-time-models-with-just-dbt-sql/1457

# Steps:

## Initial Setup - Directory, Python
1. Create directory `./realtime-dbt`
2. Create virtual environment for Python
   `python -m venv env`
3. Install dbt and dbt adapter for sql server
   `python -m pip install dbt-sqlserver`
4. Install pyodbc and faker library
5. `pip install faker pyodbc`

## Git Setup
```
git init
git add ReadMe.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/aj-22/realtime-dbt.git
git push -u origin main
```

## Database Setup
1. Download SSMS and SQL Server Developer Edition 2022
2. Ensure installation in Integrated Mode or change the security settings later to enable "SQL Server and WIndows Authentication Mode"
3. Run the following query to get port number and ip address
   ```sql
   USE MASTER
   GO
   xp_readerrorlog 0, 1, N'Server is listening on'
   GO
   ```
   By default the port number is 1433. But since I have multiple instances running, my port number is 1435
4. Run this query to create database 
   ```sql
   CREATE DATABASE analytics
   ```

## Initialize and set-up dbt
1. Initialize: `dbt init`
2. Get location of `profiles.yml`: `dbt debug --config-dir`
3. Enter connection parameters
```yml
analytics:
  target: dev
  outputs:
    dev:
      type: sqlserver
      driver: ODBC Driver 18 for SQL Server
      server: localhost
      port: 1435
      database: analytics
      schema: dev
      user: sa
      password: ********
      encrypt: false
      trust_cert: false
```
4. Test if connection works: `dbt debug`

