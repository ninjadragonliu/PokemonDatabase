create table pokémon.pokemon_forms
(
    form_id              int auto_increment
        primary key,
    species_id           bigint unsigned not null,
    form_name            varchar(256)    not null,
    primary_type         varchar(10)     null,
    secondary_type       varchar(10)     null,
    base_hp              int             null,
    base_attack          int             null,
    base_defense         int             null,
    base_special_attack  int             null,
    base_special_defense int             null,
    base_speed           int             null,
    gender_ratio_male    decimal(4, 3)   null,
    gender_ratio_female  decimal(4, 3)   null,
    average_height_m     decimal(5, 2)   null,
    average_weight_kg    decimal(5, 2)   null,
    current_generation   int             null
);

