create table mysql.replication_asynchronous_connection_failover
(
    Channel_name      char(64)                not null comment 'The replication channel name that connects source and replica.',
    Host              char(255) charset ascii not null comment 'The source hostname that the replica will attempt to switch over the replication connection to in case of a failure.',
    Port              int unsigned            not null comment 'The source port that the replica will attempt to switch over the replication connection to in case of a failure.',
    Network_namespace char(64)                not null comment 'The source network namespace that the replica will attempt to switch over the replication connection to in case of a failure. If its value is empty, connections use the default (global) namespace.',
    Weight            tinyint unsigned        not null comment 'The order in which the replica shall try to switch the connection over to when there are failures. Weight can be set to a number between 1 and 100, where 100 is the highest weight and 1 the lowest.',
    Managed_name      char(64) default ''     not null comment 'The name of the group which this server belongs to.',
    primary key (Channel_name, Host, Port, Network_namespace, Managed_name)
)
    comment 'The source configuration details' charset = utf8mb3
                                               row_format = DYNAMIC
                                               stats_persistent = 0;

create index Channel_name
    on mysql.replication_asynchronous_connection_failover (Channel_name, Managed_name);

