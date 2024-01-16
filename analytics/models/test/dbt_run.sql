{% set run_time = run_started_at %}

select 
cast( '{{ run_time }}' as varchar(50)) as current_dbt_run
