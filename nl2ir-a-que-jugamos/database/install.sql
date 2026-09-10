-- NL2IR Spanish board-game laboratory
-- Creates and seeds only objects prefixed with NL2IR_.
-- Safe to rerun against a compatible laboratory schema.
-- This script intentionally contains no teardown operations.

set define off
set serveroutput on

declare
    l_count number;
begin
    select count(*)
      into l_count
      from user_tables
     where table_name = 'NL2IR_GAMES';

    if l_count = 0 then
        execute immediate q'[
            create table nl2ir_games (
                game_id                 number(4)         not null,
                title                   varchar2(100 char) not null,
                edition_ruleset         varchar2(200 char) not null,
                cultural_scope          varchar2(20 char)  not null,
                game_type_code          varchar2(20 char)  not null,
                play_mode_code          varchar2(20 char)  not null,
                min_players             number(2)          not null,
                max_players             number(2)          not null,
                best_player_count       number(2)          not null,
                reference_duration_min  number(4)          not null,
                complexity_code         varchar2(20 char)  not null,
                language_dep_code       varchar2(20 char)  not null,
                acquired_on             date,
                purchase_price_eur      number(8,2),
                source_url              varchar2(500 char),
                active_yn               char(1 char) default 'Y' not null,
                constraint nl2ir_games_pk primary key (game_id),
                constraint nl2ir_games_title_uk unique (title, edition_ruleset),
                constraint nl2ir_games_scope_ck check (
                    cultural_scope in ('ES', 'LATAM', 'GLOBAL')
                ),
                constraint nl2ir_games_type_ck check (
                    game_type_code in (
                        'TRAD_CARD', 'TRAD_BOARD', 'FAMILY',
                        'STRATEGY', 'PARTY', 'FILLER'
                    )
                ),
                constraint nl2ir_games_mode_ck check (
                    play_mode_code in ('COMP', 'COOP', 'TEAM', 'MIXED')
                ),
                constraint nl2ir_games_complex_ck check (
                    complexity_code in ('LIGHT', 'MEDIUM', 'HEAVY')
                ),
                constraint nl2ir_games_language_ck check (
                    language_dep_code in ('NONE', 'LOW', 'MEDIUM', 'HIGH')
                ),
                constraint nl2ir_games_players_ck check (
                    min_players >= 1
                    and max_players >= min_players
                    and best_player_count between min_players and max_players
                ),
                constraint nl2ir_games_duration_ck check (
                    reference_duration_min > 0
                ),
                constraint nl2ir_games_active_ck check (
                    active_yn in ('Y', 'N')
                )
            )
        ]';
    end if;
end;
/

declare
    l_count number;
begin
    select count(*)
      into l_count
      from user_tables
     where table_name = 'NL2IR_PLAY_SESSIONS';

    if l_count = 0 then
        execute immediate q'[
            create table nl2ir_play_sessions (
                session_id          number(6) not null,
                game_id             number(4) not null,
                played_on           date      not null,
                player_count        number(2) not null,
                actual_duration_min number(4) not null,
                completed_yn        char(1 char) default 'Y' not null,
                constraint nl2ir_sessions_pk primary key (session_id),
                constraint nl2ir_sessions_game_fk foreign key (game_id)
                    references nl2ir_games (game_id),
                constraint nl2ir_sessions_players_ck check (player_count > 0),
                constraint nl2ir_sessions_duration_ck check (actual_duration_min > 0),
                constraint nl2ir_sessions_done_ck check (completed_yn in ('Y', 'N'))
            )
        ]';
    end if;
end;
/

merge into nl2ir_games t
using (
    select 1 game_id, 'Brisca' title,
           'Reglamento del laboratorio, baraja española' edition_ruleset,
           'ES' cultural_scope, 'TRAD_CARD' game_type_code, 'COMP' play_mode_code,
           2 min_players, 4 max_players, 4 best_player_count,
           30 reference_duration_min, 'LIGHT' complexity_code, 'NONE' language_dep_code,
           cast(null as date) acquired_on, cast(null as number) purchase_price_eur,
           cast(null as varchar2(500)) source_url, 'Y' active_yn
      from dual
    union all select 2, 'Mus', 'Reglamento del laboratorio, cuatro jugadores por parejas',
           'ES', 'TRAD_CARD', 'TEAM', 4, 4, 4, 45, 'MEDIUM', 'LOW',
           null, null, null, 'Y' from dual
    union all select 3, 'Tute', 'Reglamento del laboratorio para baraja española',
           'ES', 'TRAD_CARD', 'MIXED', 2, 4, 4, 45, 'MEDIUM', 'NONE',
           null, null, null, 'Y' from dual
    union all select 4, 'Chinchón', 'Reglamento del laboratorio, baraja española de 40 cartas',
           'ES', 'TRAD_CARD', 'COMP', 2, 8, 4, 40, 'LIGHT', 'NONE',
           null, null, null, 'Y' from dual
    union all select 5, 'Escoba', 'Reglamento del laboratorio, escoba de quince',
           'LATAM', 'TRAD_CARD', 'COMP', 2, 4, 2, 30, 'LIGHT', 'NONE',
           null, null, null, 'Y' from dual
    union all select 6, 'Truco rioplatense', 'Reglamento del laboratorio por parejas',
           'LATAM', 'TRAD_CARD', 'TEAM', 2, 6, 4, 45, 'MEDIUM', 'LOW',
           null, null, null, 'Y' from dual
    union all select 7, 'Dominó latino', 'Reglamento del laboratorio, doble seis por parejas',
           'LATAM', 'TRAD_BOARD', 'TEAM', 2, 4, 4, 35, 'LIGHT', 'NONE',
           null, null, null, 'Y' from dual
    union all select 8, 'Parchís', 'Reglamento del laboratorio, tablero de cuatro colores',
           'ES', 'TRAD_BOARD', 'COMP', 2, 4, 4, 60, 'LIGHT', 'NONE',
           null, null, null, 'Y' from dual
    union all select 9, 'Parqués colombiano', 'Reglamento del laboratorio, tablero de cuatro puestos',
           'LATAM', 'TRAD_BOARD', 'COMP', 2, 4, 4, 60, 'LIGHT', 'NONE',
           null, null, null, 'Y' from dual
    union all select 10, 'Lotería mexicana', 'Reglamento del laboratorio con cantor y tablas',
           'LATAM', 'PARTY', 'COMP', 3, 12, 6, 30, 'LIGHT', 'LOW',
           null, null, null, 'Y' from dual
    union all select 11, 'UNO', 'Edición clásica Mattel, referencia W2085',
           'GLOBAL', 'FAMILY', 'COMP', 2, 10, 4, 30, 'LIGHT', 'LOW',
           date '2024-01-15', 12.99,
           'https://m.service.mattel.com/us/Technical/productDetail?prodno=W2085&siteid=27', 'Y' from dual
    union all select 12, 'Monopoly', 'Edición clásica Hasbro, referencia C1009',
           'GLOBAL', 'FAMILY', 'COMP', 2, 6, 4, 90, 'MEDIUM', 'MEDIUM',
           date '2023-12-20', 29.95,
           'https://consumercare.hasbro.com/en-us/product/monopoly-game/7EABAF97-5056-9047-F577-8F4663C79E75', 'Y' from dual
    union all select 13, 'Risk', 'Edición clásica Hasbro, referencia 00044',
           'GLOBAL', 'STRATEGY', 'COMP', 2, 6, 4, 120, 'HEAVY', 'LOW',
           date '2025-11-10', 39.95,
           'https://instructions.hasbro.com/en-us/instruction/risk-board-game', 'Y' from dual
    union all select 14, 'Cluedo', 'Edición clásica en español del laboratorio',
           'GLOBAL', 'FAMILY', 'COMP', 2, 6, 4, 45, 'MEDIUM', 'MEDIUM',
           date '2024-05-06', 24.95, null, 'Y' from dual
    union all select 15, 'Carcassonne', 'Edición base Devir, segunda edición',
           'GLOBAL', 'FAMILY', 'COMP', 2, 5, 3, 35, 'MEDIUM', 'NONE',
           date '2025-02-02', 31.95,
           'https://devir.mx/producto/carcassonne/', 'Y' from dual
    union all select 16, 'Catán', 'Edición base Devir, 3 a 4 jugadores',
           'GLOBAL', 'STRATEGY', 'COMP', 3, 4, 4, 75, 'MEDIUM', 'LOW',
           date '2024-09-21', 44.95,
           'https://devir.mx/producto/catan-el-juego/', 'Y' from dual
    union all select 17, 'Aventureros al Tren', 'Edición base, mapa de Estados Unidos',
           'GLOBAL', 'FAMILY', 'COMP', 2, 5, 4, 45, 'MEDIUM', 'LOW',
           date '2025-07-19', 42.95,
           'https://www.asmodee.es/product/aventureros-al-tren/', 'Y' from dual
    union all select 18, 'Dobble', 'Edición clásica Asmodee',
           'GLOBAL', 'FILLER', 'COMP', 2, 8, 4, 15, 'LIGHT', 'NONE',
           date '2024-03-11', 14.99,
           'https://www.asmodee.es/product/dobble/', 'Y' from dual
    union all select 19, 'Virus!', 'Edición clásica Tranjis Games',
           'ES', 'FILLER', 'COMP', 2, 6, 4, 20, 'LIGHT', 'LOW',
           date '2025-01-07', 14.95,
           'https://tranjisgames.com/shop/trg-001vir-virus-1104', 'Y' from dual
    union all select 20, 'Dixit', 'Edición base actual en español del laboratorio',
           'GLOBAL', 'PARTY', 'COMP', 3, 8, 6, 30, 'LIGHT', 'HIGH',
           date '2024-08-17', 32.95, null, 'Y' from dual
    union all select 21, 'Código Secreto', 'Edición base en español del laboratorio',
           'GLOBAL', 'PARTY', 'TEAM', 2, 8, 6, 15, 'MEDIUM', 'HIGH',
           date '2026-02-14', 22.95, null, 'Y' from dual
    union all select 22, 'Azul', 'Edición base en español del laboratorio',
           'GLOBAL', 'STRATEGY', 'COMP', 2, 4, 3, 40, 'MEDIUM', 'NONE',
           date '2025-06-01', 39.95, null, 'Y' from dual
    union all select 23, 'Sushi Go!', 'Edición base en español del laboratorio',
           'GLOBAL', 'FILLER', 'COMP', 2, 5, 4, 20, 'LIGHT', 'LOW',
           date '2024-11-25', 12.95, null, 'Y' from dual
    union all select 24, 'Saboteur', 'Edición base en español del laboratorio',
           'GLOBAL', 'PARTY', 'MIXED', 3, 10, 6, 30, 'LIGHT', 'LOW',
           date '2025-10-31', 14.95, null, 'Y' from dual
    union all select 25, 'The Mind', 'Edición base en español del laboratorio',
           'GLOBAL', 'FILLER', 'COOP', 2, 4, 4, 20, 'LIGHT', 'NONE',
           date '2025-04-12', 13.95, null, 'Y' from dual
    union all select 26, 'Pandemic', 'Edición base en español del laboratorio',
           'GLOBAL', 'STRATEGY', 'COOP', 2, 4, 4, 45, 'MEDIUM', 'MEDIUM',
           date '2026-03-18', 39.95, null, 'Y' from dual
    union all select 27, 'Hanabi', 'Edición base en español del laboratorio',
           'GLOBAL', 'FILLER', 'COOP', 2, 5, 4, 25, 'MEDIUM', 'LOW',
           date '2025-08-09', 12.95, null, 'Y' from dual
    union all select 28, 'Exploding Kittens', 'Edición base en español del laboratorio',
           'GLOBAL', 'FILLER', 'COMP', 2, 5, 4, 15, 'LIGHT', 'MEDIUM',
           date '2026-01-05', 19.95, null, 'Y' from dual
) s
on (t.game_id = s.game_id)
when matched then update set
    t.title                  = s.title,
    t.edition_ruleset        = s.edition_ruleset,
    t.cultural_scope         = s.cultural_scope,
    t.game_type_code         = s.game_type_code,
    t.play_mode_code         = s.play_mode_code,
    t.min_players            = s.min_players,
    t.max_players            = s.max_players,
    t.best_player_count      = s.best_player_count,
    t.reference_duration_min = s.reference_duration_min,
    t.complexity_code        = s.complexity_code,
    t.language_dep_code      = s.language_dep_code,
    t.acquired_on            = s.acquired_on,
    t.purchase_price_eur     = s.purchase_price_eur,
    t.source_url             = s.source_url,
    t.active_yn              = s.active_yn
when not matched then insert (
    game_id, title, edition_ruleset, cultural_scope, game_type_code,
    play_mode_code, min_players, max_players, best_player_count,
    reference_duration_min, complexity_code, language_dep_code,
    acquired_on, purchase_price_eur, source_url, active_yn
) values (
    s.game_id, s.title, s.edition_ruleset, s.cultural_scope, s.game_type_code,
    s.play_mode_code, s.min_players, s.max_players, s.best_player_count,
    s.reference_duration_min, s.complexity_code, s.language_dep_code,
    s.acquired_on, s.purchase_price_eur, s.source_url, s.active_yn
);

merge into nl2ir_play_sessions t
using (
    select 1001 session_id, 1 game_id, date '2026-01-10' played_on,
           4 player_count, 35 actual_duration_min, 'Y' completed_yn from dual
    union all select 1002, 1, date '2026-05-02', 4, 32, 'Y' from dual
    union all select 1003, 2, date '2026-02-14', 4, 78, 'Y' from dual
    union all select 1004, 2, date '2026-06-20', 4, 82, 'Y' from dual
    union all select 1005, 4, date '2026-03-05', 5, 50, 'Y' from dual
    union all select 1006, 5, date '2026-04-18', 2, 25, 'Y' from dual
    union all select 1007, 6, date '2026-01-24', 4, 55, 'Y' from dual
    union all select 1008, 7, date '2026-07-03', 4, 40, 'Y' from dual
    union all select 1009, 8, date '2026-03-19', 4, 75, 'Y' from dual
    union all select 1010, 10, date '2026-05-15', 7, 28, 'Y' from dual
    union all select 1011, 11, date '2026-01-03', 6, 38, 'Y' from dual
    union all select 1012, 11, date '2026-07-12', 4, 30, 'Y' from dual
    union all select 1013, 12, date '2026-02-07', 4, 135, 'Y' from dual
    union all select 1014, 12, date '2026-05-30', 5, 145, 'Y' from dual
    union all select 1015, 14, date '2026-04-04', 5, 55, 'Y' from dual
    union all select 1016, 15, date '2026-01-17', 3, 42, 'Y' from dual
    union all select 1017, 15, date '2026-06-06', 4, 48, 'Y' from dual
    union all select 1018, 16, date '2026-03-28', 4, 110, 'Y' from dual
    union all select 1019, 16, date '2026-07-25', 4, 120, 'Y' from dual
    union all select 1020, 17, date '2026-02-21', 4, 60, 'Y' from dual
    union all select 1021, 18, date '2026-01-31', 6, 12, 'Y' from dual
    union all select 1022, 18, date '2026-06-13', 4, 15, 'Y' from dual
    union all select 1023, 19, date '2026-04-11', 5, 25, 'Y' from dual
    union all select 1024, 20, date '2026-05-09', 6, 45, 'Y' from dual
    union all select 1025, 22, date '2026-07-18', 3, 50, 'Y' from dual
    union all select 1026, 23, date '2026-03-14', 4, 22, 'Y' from dual
    union all select 1027, 24, date '2026-02-28', 7, 62, 'Y' from dual
    union all select 1028, 24, date '2026-08-01', 6, 68, 'Y' from dual
    union all select 1029, 25, date '2026-06-27', 4, 18, 'Y' from dual
    union all select 1030, 27, date '2026-05-23', 4, 30, 'Y' from dual
    union all select 1031, 28, date '2026-04-25', 4, 48, 'Y' from dual
    union all select 1032, 28, date '2026-08-08', 5, 52, 'Y' from dual
) s
on (t.session_id = s.session_id)
when matched then update set
    t.game_id             = s.game_id,
    t.played_on           = s.played_on,
    t.player_count        = s.player_count,
    t.actual_duration_min = s.actual_duration_min,
    t.completed_yn        = s.completed_yn
when not matched then insert (
    session_id, game_id, played_on, player_count,
    actual_duration_min, completed_yn
) values (
    s.session_id, s.game_id, s.played_on, s.player_count,
    s.actual_duration_min, s.completed_yn
);

create or replace view nl2ir_v_library as
select g.game_id,
       g.title,
       g.edition_ruleset,
       g.cultural_scope,
       g.game_type_code,
       g.play_mode_code,
       g.min_players,
       g.max_players,
       g.best_player_count,
       g.reference_duration_min,
       g.complexity_code,
       g.language_dep_code,
       g.acquired_on,
       count(s.session_id) as play_count,
       max(s.played_on) as last_played_on,
       round(avg(s.actual_duration_min)) as avg_duration_min,
       round(avg(s.actual_duration_min) - g.reference_duration_min) as duration_drift_min,
       case when count(s.session_id) > 0 then 'Y' else 'N' end as played_yn
  from nl2ir_games g
  left join nl2ir_play_sessions s
    on s.game_id = g.game_id
   and s.completed_yn = 'Y'
 where g.active_yn = 'Y'
 group by g.game_id,
          g.title,
          g.edition_ruleset,
          g.cultural_scope,
          g.game_type_code,
          g.play_mode_code,
          g.min_players,
          g.max_players,
          g.best_player_count,
          g.reference_duration_min,
          g.complexity_code,
          g.language_dep_code,
          g.acquired_on;

commit;

prompt Installed rows
select count(*) as game_count from nl2ir_games;
select count(*) as session_count from nl2ir_play_sessions;
select count(*) as report_row_count from nl2ir_v_library;

prompt Deliberately unplayed games
select game_id, title
  from nl2ir_v_library
 where played_yn = 'N'
 order by game_id;

prompt Games whose observed duration exceeds the reference by more than 30 minutes
select game_id, title, reference_duration_min, avg_duration_min, duration_drift_min
  from nl2ir_v_library
 where duration_drift_min > 30
 order by duration_drift_min desc, title;
