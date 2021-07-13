"! <p class="shorttext synchronized">CodeKata - Game Of Life</p>
CLASS y_game_of_life DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES BEGIN OF t_board.
    TYPES:
      row    TYPE i,
      column TYPE i,
      alive  TYPE abap_bool.
    TYPES END OF t_board.
    TYPES tt_board TYPE HASHED TABLE OF t_board WITH UNIQUE KEY row column.
    DATA board TYPE tt_board.

    METHODS constructor
      IMPORTING row    TYPE i
                column TYPE i.

    METHODS is_death
      IMPORTING row           TYPE i
                column        TYPE i
      RETURNING VALUE(result) TYPE abap_bool
      RAISING   cx_sy_itab_line_not_found.

    METHODS is_alive
      IMPORTING row           TYPE i
                column        TYPE i
      RETURNING VALUE(result) TYPE abap_bool
      RAISING   cx_sy_itab_line_not_found.

    METHODS comes_alive
      IMPORTING
        row    TYPE i
        column TYPE i.
    METHODS clone
      RETURNING
        VALUE(result) TYPE REF TO y_game_of_life.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS create_dead_board
      IMPORTING row    TYPE i
                column TYPE i.


ENDCLASS.



CLASS y_game_of_life IMPLEMENTATION.

  METHOD constructor.
    create_dead_board( row = row column = column ).
  ENDMETHOD.

  METHOD comes_alive.
    me->board[ row = row column = column ]-alive = abap_true.
  ENDMETHOD.

  METHOD is_death.
    result = xsdbool( me->board[ row = row column = column ]-alive = abap_false ).
  ENDMETHOD.

  METHOD is_alive.
    result = me->board[ row = row column = column ]-alive.
  ENDMETHOD.

  METHOD clone.
    DATA(gol_clone) = NEW y_game_of_life( row = 1 column = 1 ).
    gol_clone->board = me->board.
    result = gol_clone.
  ENDMETHOD.

  METHOD create_dead_board.
    DO row TIMES.
      DATA(row_index) = sy-index.
      DO column TIMES.
        DATA(column_index) = sy-index.
        INSERT VALUE #( row = row_index column = column_index ) INTO TABLE board.
      ENDDO.
    ENDDO.
  ENDMETHOD.

ENDCLASS.
