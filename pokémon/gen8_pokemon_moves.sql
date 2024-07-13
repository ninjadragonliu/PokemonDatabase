create table pokémon.gen8_pokemon_moves
(
    pokemon_id    int           not null,
    move_id       int           not null,
    generation    int default 8 null,
    level_learned int           null,
    evolution     varchar(256)  null
);

