"! <p class="shorttext synchronized">Snakes and Ladders</p>
CLASS y_snakes_ladders DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor.
    METHODS play
      IMPORTING square1       TYPE i
                square2       TYPE i
      RETURNING VALUE(result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES BEGIN OF snake_and_ladder.
    TYPES:
      field TYPE i,
      go_to TYPE i.
    TYPES END OF snake_and_ladder.
    TYPES snakes_and_ladders TYPE HASHED TABLE OF snake_and_ladder WITH UNIQUE KEY field.

    DATA list_snakes_ladders TYPE snakes_and_ladders.
    DATA players             TYPE REF TO if_object_map.
    DATA next_player         TYPE REF TO y_sl_player.

    METHODS setup_game_board.
    METHODS create_players.
    METHODS set_starting_player.

    METHODS toggle
      IMPORTING square1 TYPE i
                square2 TYPE i.
ENDCLASS.


CLASS y_snakes_ladders IMPLEMENTATION.

  METHOD constructor.
    setup_game_board( ).
    create_players( ).
    set_starting_player( ).
  ENDMETHOD.

  METHOD play.
    toggle( square1 = square1 square2 = square2 ).

    DATA(square) = square1 + square2.

    next_player->change_score( next_player->score( ) + square ).

    IF line_exists( list_snakes_ladders[ field = next_player->score( ) ] ).
      next_player->change_score( list_snakes_ladders[ field = next_player->score( ) ]-go_to ).
    ENDIF.

    result = |Player { next_player->id( ) } is on square { next_player->score( ) }|.
  ENDMETHOD.

  METHOD setup_game_board.
    me->list_snakes_ladders = VALUE #(
        ( field = 2  go_to = 38 )
        ( field = 7  go_to = 14 )
        ( field = 8  go_to = 31 )
        ( field = 15 go_to = 26 )
        ( field = 16 go_to = 6  )
        ( field = 21 go_to = 42 )
        ( field = 28 go_to = 84 )
        ( field = 36 go_to = 44 )
        ( field = 46 go_to = 25 )
        ( field = 49 go_to = 11 )
        ( field = 51 go_to = 67 )
        ( field = 62 go_to = 19 )
        ( field = 64 go_to = 60 )
        ( field = 71 go_to = 91 )
        ( field = 74 go_to = 53 )
        ( field = 78 go_to = 98 )
        ( field = 87 go_to = 94 )
        ( field = 89 go_to = 68 )
        ( field = 92 go_to = 88 )
        ( field = 95 go_to = 75 )
        ( field = 99 go_to = 80 )
    ).
  ENDMETHOD.

  METHOD create_players.
    DATA(players) = NEW cl_object_map( ).

    players->put( key = 1 value = NEW y_sl_player( 1 ) ).
    players->put( key = 2 value = NEW y_sl_player( 2 ) ).

    me->players = players.
  ENDMETHOD.

  METHOD set_starting_player.
    next_player ?= players->get( 1 ).
  ENDMETHOD.

  METHOD toggle.
    IF square1 <> square2.
      IF next_player->id( ) = 1.
        next_player ?= players->get( 2 ).
      ELSE.
        next_player ?= players->get( 1 ).
      ENDIF.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
