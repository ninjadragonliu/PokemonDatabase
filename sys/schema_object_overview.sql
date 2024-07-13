create definer = `mysql.sys`@localhost view sys.schema_object_overview as
select `information_schema`.`routines`.`ROUTINE_SCHEMA` AS `db`,
       `information_schema`.`routines`.`ROUTINE_TYPE`   AS `object_type`,
       count(0)                                         AS `count`
from `information_schema`.`ROUTINES`
group by `information_schema`.`routines`.`ROUTINE_SCHEMA`, `information_schema`.`routines`.`ROUTINE_TYPE`
union
select `information_schema`.`tables`.`TABLE_SCHEMA` AS `TABLE_SCHEMA`,
       `information_schema`.`tables`.`TABLE_TYPE`   AS `TABLE_TYPE`,
       count(0)                                     AS `COUNT(*)`
from `information_schema`.`TABLES`
group by `information_schema`.`tables`.`TABLE_SCHEMA`, `information_schema`.`tables`.`TABLE_TYPE`
union
select `information_schema`.`statistics`.`TABLE_SCHEMA`                       AS `TABLE_SCHEMA`,
       concat('INDEX (', `information_schema`.`statistics`.`INDEX_TYPE`, ')') AS `CONCAT('INDEX (', INDEX_TYPE, ')')`,
       count(0)                                                               AS `COUNT(*)`
from `information_schema`.`STATISTICS`
group by `information_schema`.`statistics`.`TABLE_SCHEMA`, `information_schema`.`statistics`.`INDEX_TYPE`
union
select `information_schema`.`triggers`.`TRIGGER_SCHEMA` AS `TRIGGER_SCHEMA`,
       'TRIGGER'                                        AS `TRIGGER`,
       count(0)                                         AS `COUNT(*)`
from `information_schema`.`TRIGGERS`
group by `information_schema`.`triggers`.`TRIGGER_SCHEMA`
union
select `information_schema`.`events`.`EVENT_SCHEMA` AS `EVENT_SCHEMA`, 'EVENT' AS `EVENT`, count(0) AS `COUNT(*)`
from `information_schema`.`EVENTS`
group by `information_schema`.`events`.`EVENT_SCHEMA`
order by `db`, `object_type`;

