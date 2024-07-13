create definer = `mysql.sys`@localhost view sys.x$schema_flattened_keys as
select `information_schema`.`statistics`.`TABLE_SCHEMA`                                 AS `TABLE_SCHEMA`,
       `information_schema`.`statistics`.`TABLE_NAME`                                   AS `TABLE_NAME`,
       `information_schema`.`statistics`.`INDEX_NAME`                                   AS `INDEX_NAME`,
       max(`information_schema`.`statistics`.`NON_UNIQUE`)                              AS `non_unique`,
       max(if((`information_schema`.`statistics`.`SUB_PART` is null), 0, 1))            AS `subpart_exists`,
       group_concat(`information_schema`.`statistics`.`COLUMN_NAME` order by
                    `information_schema`.`statistics`.`SEQ_IN_INDEX` ASC separator ',') AS `index_columns`
from `information_schema`.`STATISTICS`
where ((`information_schema`.`statistics`.`INDEX_TYPE` = 'BTREE') and
       (`information_schema`.`statistics`.`TABLE_SCHEMA` not in
        ('mysql', 'sys', 'INFORMATION_SCHEMA', 'PERFORMANCE_SCHEMA')))
group by `information_schema`.`statistics`.`TABLE_SCHEMA`, `information_schema`.`statistics`.`TABLE_NAME`,
         `information_schema`.`statistics`.`INDEX_NAME`;

