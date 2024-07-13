create definer = `mysql.sys`@localhost view sys.metrics as
select lower(`performance_schema`.`global_status`.`VARIABLE_NAME`) AS `Variable_name`,
       `performance_schema`.`global_status`.`VARIABLE_VALUE`       AS `Variable_value`,
       'Global Status'                                             AS `Type`,
       'YES'                                                       AS `Enabled`
from `performance_schema`.`global_status`
union all
select `information_schema`.`innodb_metrics`.`NAME`                                   AS `Variable_name`,
       `information_schema`.`innodb_metrics`.`COUNT`                                  AS `Variable_value`,
       concat('InnoDB Metrics - ', `information_schema`.`innodb_metrics`.`SUBSYSTEM`) AS `Type`,
       if((`information_schema`.`innodb_metrics`.`STATUS` = 'enabled'), 'YES', 'NO')  AS `Enabled`
from `information_schema`.`INNODB_METRICS`
where (`information_schema`.`innodb_metrics`.`NAME` not in
       ('lock_row_lock_time', 'lock_row_lock_time_avg', 'lock_row_lock_time_max', 'lock_row_lock_waits',
        'buffer_pool_reads', 'buffer_pool_read_requests', 'buffer_pool_write_requests', 'buffer_pool_wait_free',
        'buffer_pool_read_ahead', 'buffer_pool_read_ahead_evicted', 'buffer_pool_pages_total', 'buffer_pool_pages_misc',
        'buffer_pool_pages_data', 'buffer_pool_bytes_data', 'buffer_pool_pages_dirty', 'buffer_pool_bytes_dirty',
        'buffer_pool_pages_free', 'buffer_pages_created', 'buffer_pages_written', 'buffer_pages_read',
        'buffer_data_reads', 'buffer_data_written', 'file_num_open_files', 'os_log_bytes_written', 'os_log_fsyncs',
        'os_log_pending_fsyncs', 'os_log_pending_writes', 'log_waits', 'log_write_requests', 'log_writes',
        'innodb_dblwr_writes', 'innodb_dblwr_pages_written', 'innodb_page_size'))
union all
select 'memory_current_allocated'                                                                            AS `Variable_name`,
       sum(`performance_schema`.`memory_summary_global_by_event_name`.`CURRENT_NUMBER_OF_BYTES_USED`)        AS `Variable_value`,
       'Performance Schema'                                                                                  AS `Type`,
       if(((select count(0)
            from `performance_schema`.`setup_instruments`
            where ((`performance_schema`.`setup_instruments`.`NAME` like 'memory/%') and
                   (`performance_schema`.`setup_instruments`.`ENABLED` = 'YES'))) = 0), 'NO', if(((select count(0)
                                                                                                   from `performance_schema`.`setup_instruments`
                                                                                                   where ((`performance_schema`.`setup_instruments`.`NAME` like 'memory/%') and
                                                                                                          (`performance_schema`.`setup_instruments`.`ENABLED` = 'NO'))) =
                                                                                                  0), 'YES',
                                                                                                 'PARTIAL')) AS `Enabled`
from `performance_schema`.`memory_summary_global_by_event_name`
union all
select 'memory_total_allocated'                                                                              AS `Variable_name`,
       sum(`performance_schema`.`memory_summary_global_by_event_name`.`SUM_NUMBER_OF_BYTES_ALLOC`)           AS `Variable_value`,
       'Performance Schema'                                                                                  AS `Type`,
       if(((select count(0)
            from `performance_schema`.`setup_instruments`
            where ((`performance_schema`.`setup_instruments`.`NAME` like 'memory/%') and
                   (`performance_schema`.`setup_instruments`.`ENABLED` = 'YES'))) = 0), 'NO', if(((select count(0)
                                                                                                   from `performance_schema`.`setup_instruments`
                                                                                                   where ((`performance_schema`.`setup_instruments`.`NAME` like 'memory/%') and
                                                                                                          (`performance_schema`.`setup_instruments`.`ENABLED` = 'NO'))) =
                                                                                                  0), 'YES',
                                                                                                 'PARTIAL')) AS `Enabled`
from `performance_schema`.`memory_summary_global_by_event_name`
union all
select 'NOW()' AS `Variable_name`, now(3) AS `Variable_value`, 'System Time' AS `Type`, 'YES' AS `Enabled`
union all
select 'UNIX_TIMESTAMP()'               AS `Variable_name`,
       round(unix_timestamp(now(3)), 3) AS `Variable_value`,
       'System Time'                    AS `Type`,
       'YES'                            AS `Enabled`
order by `Type`, `Variable_name`;

