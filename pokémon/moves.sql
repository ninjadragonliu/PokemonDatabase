create table pokémon.moves
(
    move_id       bigint unsigned auto_increment
        primary key,
    move_name     varchar(256) not null,
    move_type     varchar(20)  not null,
    move_category varchar(20)  not null,
    power         int          null,
    accuracy      int          null,
    pp            int          null,
    constraint move_id
        unique (move_id)
);

