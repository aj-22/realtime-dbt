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

## Git Setup
```
git init
git add ReadMe.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/aj-22/realtime-dbt.git
git push -u origin main
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
4. Test if connection works `dbt debug`