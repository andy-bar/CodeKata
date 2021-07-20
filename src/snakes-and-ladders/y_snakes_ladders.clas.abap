CLASS y_snakes_ladders DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS play
      IMPORTING square1       TYPE i
                square2       TYPE i
      RETURNING VALUE(result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA player_1    TYPE i.
    DATA player_2    TYPE i.
    DATA next_player TYPE i.

    METHODS move_to_do
      IMPORTING square          TYPE i
      RETURNING VALUE(r_result) TYPE string.

    METHODS is_double
      IMPORTING square1       TYPE i
                square2       TYPE i
      RETURNING VALUE(result) TYPE abap_bool.

ENDCLASS.



CLASS y_snakes_ladders IMPLEMENTATION.

  METHOD play.
    DATA(square) = square1 + square2.

    IF player_1 = 0.
      next_player = 1.
    ENDIF.

    result = move_to_do( square ).

    IF is_double( square1 = square1 square2 = square2 ).
      RETURN.
    ENDIF.

    IF next_player = 1.
      next_player = 2.
    ELSE.
      next_player = 1.
    ENDIF.
  ENDMETHOD.

  METHOD is_double.
    result = xsdbool( square1 = square2 ).
  ENDMETHOD.

  METHOD move_to_do.
    DATA(player_x) = |player_{ next_player }|.
    ASSIGN me->(player_x) TO FIELD-SYMBOL(<player>).

    <player> += square.

    r_result = |Player { next_player  } is on square { <player> }|.
  ENDMETHOD.

ENDCLASS.
