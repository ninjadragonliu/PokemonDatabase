create table pokémon.evolutions
(
    evolution_id        bigint unsigned auto_increment
        primary key,
    pokemon_id          int          null,
    evolved_species_id  int          null,
    evolution_method    varchar(256) not null,
    evolution_condition varchar(256) null,
    constraint evolution_id
        unique (evolution_id)
);

