create table gameslist.game_list
(
    game_id            int auto_increment
        primary key,
    title              varchar(256) not null,
    stat               varchar(100) not null,
    GoBack             varchar(20)  null,
    playAgain          varchar(20)  null,
    oneHundredPercent  varchar(20)  null,
    notes              varchar(256) null,
    version            varchar(20)  null,
    fanmade            varchar(20)  null,
    watchedPlaythrough varchar(256) null,
    tag                varchar(256) null
);

