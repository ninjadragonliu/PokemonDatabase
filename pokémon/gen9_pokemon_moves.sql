create table pokémon.gen9_pokemon_moves
(
    pokemon_id    int           not null,
    move_id       int           not null,
    generation    int default 9 null,
    level_learned int           null,
    evolution     varchar(256)  null
);

