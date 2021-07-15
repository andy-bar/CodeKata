"! <p class="shorttext synchronized">Game of Life Board</p>
CLASS y_gol_board DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING row    TYPE i OPTIONAL
                column TYPE i OPTIONAL.

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

    METHODS comes_dead
      IMPORTING row    TYPE i
                column TYPE i
      RAISING   cx_sy_itab_line_not_found.

    METHODS comes_alive
      IMPORTING row    TYPE i
                column TYPE i
      RAISING   cx_sy_itab_line_not_found.

    METHODS get_number_of_living_neighbors
      IMPORTING row           TYPE i
                column        TYPE i
      RETURNING VALUE(result) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES BEGIN OF t_board.
    TYPES:
      row    TYPE i,
      column TYPE i,
      alive  TYPE abap_bool.
    TYPES END OF t_board.
    TYPES tt_board TYPE HASHED TABLE OF t_board WITH UNIQUE KEY row column.

    DATA board      TYPE tt_board.
    DATA row_end    TYPE i.
    DATA column_end TYPE i.

    METHODS create_dead_board
      IMPORTING row    TYPE i
                column TYPE i.

ENDCLASS.


CLASS y_gol_board IMPLEMENTATION.

  METHOD constructor.
    me->row_end    = row.
    me->column_end = column.

    create_dead_board( row = row column = column ).
  ENDMETHOD.

  METHOD is_death.
    result = xsdbool( me->board[ row = row column = column ]-alive = abap_false ).
  ENDMETHOD.

  METHOD is_alive.
    result = me->board[ row = row column = column ]-alive.
  ENDMETHOD.

  METHOD comes_dead.
    me->board[ row = row column = column ]-alive = abap_false.
  ENDMETHOD.

  METHOD comes_alive.
    me->board[ row = row column = column ]-alive = abap_true.
  ENDMETHOD.

  METHOD get_number_of_living_neighbors.
    DATA(row_index) = row - 1.

    WHILE row_index <= row + 1.

      IF row_index = 0 OR row_index >= row_end.
        row_index += 1.
        CONTINUE.
      ENDIF.

      DATA(col_index) = column - 1.
      WHILE col_index <= column + 1.
        IF row_index = row AND col_index = column.
          col_index += 1.
          CONTINUE.
        ENDIF.

        IF col_index = 0 OR col_index > column_end.
          col_index += 1.
          CONTINUE.
        ENDIF.

        IF me->board[ row = row_index column = col_index ]-alive = abap_true.
          result += 1.
        ENDIF.

        col_index += 1.
      ENDWHILE.

      row_index += 1.
    ENDWHILE.
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
