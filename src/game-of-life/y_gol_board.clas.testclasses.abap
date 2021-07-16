CLASS test_board DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA board TYPE REF TO y_gol_board.

    METHODS setup.

    METHODS should_create_blank_board    FOR TESTING.
    METHODS should_create_3x3_board      FOR TESTING.
    METHODS cell_should_not_exist        FOR TESTING.
    METHODS cell_should_become_dead      FOR TESTING.
    METHODS shouldGive_8_LivingNeighbors FOR TESTING.
    METHODS shouldGive_3_LivingNeighbors FOR TESTING.
    METHODS shouldGive_5_LivingNeighbors FOR TESTING.
    METHODS shouldGive_8_DeadNeighbors   FOR TESTING.
    METHODS shouldGive_3_DeadNeighbors   FOR TESTING.
    METHODS shouldGive_5_DeadNeighbors   FOR TESTING.

ENDCLASS.


CLASS test_board IMPLEMENTATION.

  METHOD setup.
    board = NEW y_gol_board( row = 3 col = 3 ).
  ENDMETHOD.

  METHOD should_create_blank_board.
    DATA(blank_board) = NEW y_gol_board( row = 0 col = 0 ).
    DO 3 TIMES.
      DATA(row) = sy-index.
      DO 3 TIMES.
        DATA(col) = sy-index.

        cl_abap_unit_assert=>assert_false( blank_board->is_exists( row = row col = col ) ).

      ENDDO.
    ENDDO.
  ENDMETHOD.

  METHOD should_create_3x3_board.
    DO 3 TIMES.
      DATA(row) = sy-index.
      DO 3 TIMES.
        DATA(col) = sy-index.

        cl_abap_unit_assert=>assert_true( board->is_exists( row = row col = col ) ).

      ENDDO.
    ENDDO.
  ENDMETHOD.

  METHOD cell_should_not_exist.
    cl_abap_unit_assert=>assert_false( board->is_exists( row = 3 col = 4 ) ).
  ENDMETHOD.

  METHOD cell_should_become_dead.
    DO 3 TIMES.
      DATA(row) = sy-index.
      DO 3 TIMES.
        DATA(col) = sy-index.
        board->come_alive( row = row col = col ).
      ENDDO.
    ENDDO.

    board->become_dead( row = 1 col = 2 ).
    board->become_dead( row = 2 col = 1 ).
    board->become_dead( row = 2 col = 2 ).

    cl_abap_unit_assert=>assert_equals( exp = 0 act = board->get_number_of_living_neighbors( row = 1 col = 1 ) ).
  ENDMETHOD.

  METHOD shouldGive_8_LivingNeighbors.
    DO 3 TIMES.
      DATA(row) = sy-index.
      DO 3 TIMES.
        DATA(col) = sy-index.
        board->come_alive( row = row col = col ).
      ENDDO.
    ENDDO.

    cl_abap_unit_assert=>assert_equals( exp = 8 act = board->get_number_of_living_neighbors( row = 2 col = 2 ) ).
  ENDMETHOD.

  METHOD shouldGive_3_LivingNeighbors.
    DO 3 TIMES.
      DATA(row) = sy-index.
      DO 3 TIMES.
        DATA(col) = sy-index.
        board->come_alive( row = row col = col ).
      ENDDO.
    ENDDO.

    cl_abap_unit_assert=>assert_equals( exp = 3 act = board->get_number_of_living_neighbors( row = 1 col = 1 ) ).
  ENDMETHOD.

  METHOD shouldGive_5_LivingNeighbors.
    DO 3 TIMES.
      DATA(row) = sy-index.
      DO 3 TIMES.
        DATA(col) = sy-index.
        board->come_alive( row = row col = col ).
      ENDDO.
    ENDDO.

    cl_abap_unit_assert=>assert_equals( exp = 5 act = board->get_number_of_living_neighbors( row = 3 col = 2 ) ).
  ENDMETHOD.

  METHOD shouldGive_8_DeadNeighbors.
    cl_abap_unit_assert=>assert_equals( exp = 8 act = board->get_number_of_dead_neighbors( row = 2 col = 2 ) ).
  ENDMETHOD.

  METHOD shouldGive_3_DeadNeighbors.
    cl_abap_unit_assert=>assert_equals( exp = 3 act = board->get_number_of_dead_neighbors( row = 1 col = 1 ) ).
  ENDMETHOD.

  METHOD shouldGive_5_DeadNeighbors.
    cl_abap_unit_assert=>assert_equals( exp = 5 act = board->get_number_of_dead_neighbors( row = 3 col = 2 ) ).
  ENDMETHOD.

ENDCLASS.
