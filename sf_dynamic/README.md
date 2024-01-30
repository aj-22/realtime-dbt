Welcome to your new dbt project!

## Dynamic Table Refresh Control

To Suspend:
```
dbt run-operation dynamic_refresh --args "{refresh_state: SUSPEND}"
```


To Resume:
```
dbt run-operation dynamic_refresh --args "{refresh_state: RESUME}"
```
