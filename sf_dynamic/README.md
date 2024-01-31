Welcome to your new dbt project!

## Create Staging Table and Copy Into Task

Must be executed at the start of the project once  

```cmd
dbt run-operation task_copy_into
```

## Dynamic Table Refresh Control

This command can be run in dbt to control dynamic table auto refresh along with copy into task state  

To Suspend:
```cmd
dbt run-operation dynamic_refresh --args "{refresh_state: SUSPEND}"
```


To Resume:
```cmd
dbt run-operation dynamic_refresh --args "{refresh_state: RESUME}"
```


To Manually Refresh:
```cmd
dbt run-operation dynamic_refresh --args "{refresh_state: REFRESH}"
```
