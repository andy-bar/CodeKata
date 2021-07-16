"! <p class="shorttext synchronized">Game of Life - Board</p>
CLASS y_gol_board DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING row TYPE i
                col TYPE i.

    METHODS is_exists
      IMPORTING row           TYPE i
                col           TYPE i
      RETURNING VALUE(result) TYPE abap_bool.

    METHODS come_alive
      IMPORTING row TYPE i
                col TYPE i.

    METHODS become_dead
      IMPORTING row TYPE i
                col TYPE i.

    METHODS get_number_of_living_neighbors
      IMPORTING row           TYPE i
                col           TYPE i
      RETURNING VALUE(result) TYPE i.

    METHODS get_number_of_dead_neighbors
      IMPORTING row           TYPE i
                col           TYPE i
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

    DATA board   TYPE tt_board.
    DATA row_end TYPE i.
    DATA col_end TYPE i.

    METHODS create_initial_board
      IMPORTING row TYPE i
                col TYPE i.

    METHODS provide_neighbors
      IMPORTING row           TYPE i
                col           TYPE i
      RETURNING VALUE(result) TYPE tt_board.

ENDCLASS.


CLASS y_gol_board IMPLEMENTATION.

  METHOD constructor.
    me->row_end = row.
    me->col_end = col.
    create_initial_board( row = row col = col ).
  ENDMETHOD.

  METHOD create_initial_board.
    DO row TIMES.
      DATA(row_index) = sy-index.
      DO col TIMES.
        DATA(col_index) = sy-index.

        INSERT VALUE t_board( row = row_index column = col_index ) INTO TABLE board.

      ENDDO.
    ENDDO.
  ENDMETHOD.

  METHOD is_exists.
    result = xsdbool( line_exists( board[ row = row column = col ] ) ).
  ENDMETHOD.

  METHOD come_alive.
    me->board[ row = row column = col ]-alive = abap_true.
  ENDMETHOD.

  METHOD become_dead.
    me->board[ row = row column = col ]-alive = abap_false.
  ENDMETHOD.

  METHOD get_number_of_living_neighbors.
    LOOP AT provide_neighbors( row = row col = col ) REFERENCE INTO DATA(neighbor)
     WHERE alive = abap_true.
      result += 1.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_number_of_dead_neighbors.
    LOOP AT provide_neighbors( row = row col = col ) REFERENCE INTO DATA(neighbor)
     WHERE alive = abap_false.
      result += 1.
    ENDLOOP.
  ENDMETHOD.

  METHOD provide_neighbors.
    DATA(row_index) = row - 1.
    WHILE row_index <= row + 1.

      IF row_index = 0 OR row_index > row_end.
        row_index += 1.
        CONTINUE.
      ENDIF.

      DATA(col_index) = col - 1.
      WHILE col_index <= col + 1.
        IF row_index = row AND col_index = col.
          col_index += 1.
          CONTINUE.
        ENDIF.

        IF col_index = 0 OR col_index > col_end.
          col_index += 1.
          CONTINUE.
        ENDIF.

        INSERT VALUE t_board( me->board[ row = row_index column = col_index ] ) INTO TABLE result.

        col_index += 1.
      ENDWHILE.

      row_index += 1.
    ENDWHILE.
  ENDMETHOD.

ENDCLASS.
