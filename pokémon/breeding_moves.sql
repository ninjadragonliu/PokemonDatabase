create table pokémon.breeding_moves
(
    breeding_id bigint unsigned auto_increment
        primary key,
    pair_id     int null,
    move_id     int null
);

