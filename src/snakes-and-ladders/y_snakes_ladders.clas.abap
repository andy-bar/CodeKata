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
    DATA player_1            TYPE i.
    DATA player_2            TYPE i.
    DATA next_player         TYPE i VALUE 1.

    METHODS calculate_player_score
      IMPORTING square1       TYPE i
                square2       TYPE i
      RETURNING VALUE(result) TYPE i.

    METHODS get_next_player
      IMPORTING square1 TYPE i
                square2 TYPE i.

    METHODS get_current_player_score
      RETURNING VALUE(result) TYPE i.


ENDCLASS.



CLASS y_snakes_ladders IMPLEMENTATION.

  METHOD constructor.
    list_snakes_ladders = VALUE #(
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

  METHOD play.
    calculate_player_score( square1 = square1 square2 = square2 ).

    result = |Player { next_player } is on square { get_current_player_score( ) }|.

    get_next_player( square1 = square1 square2 = square2 ).
  ENDMETHOD.

  METHOD calculate_player_score.
    DATA(player_x) = |player_{ next_player }|.
    ASSIGN me->(player_x) TO FIELD-SYMBOL(<player>) CASTING TYPE i.

    DATA(square) = square1 + square2.
    <player> += square.

    IF line_exists( list_snakes_ladders[ field = <player> ] ).
      <player> = list_snakes_ladders[ field = <player> ]-go_to.
    ENDIF.
  ENDMETHOD.

  METHOD get_next_player.
    IF square1 <> square2.
      IF next_player = 1.
        next_player = 2.
      ELSE.
        next_player = 1.
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD get_current_player_score.
    DATA(player_x) = |player_{ next_player }|.
    ASSIGN me->(player_x) TO FIELD-SYMBOL(<player>) CASTING TYPE i.
    IF <player> IS ASSIGNED.
      result = <player>.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
