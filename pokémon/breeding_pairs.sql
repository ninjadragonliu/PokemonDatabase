create table pokémon.breeding_pairs
(
    pair_id            bigint unsigned auto_increment
        primary key,
    parent_species1_id int null,
    parent_species2_id int null,
    constraint unique_breeding_pair
        unique (parent_species1_id, parent_species2_id)
);

