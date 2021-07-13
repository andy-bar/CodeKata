CLASS test_game_of_life DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA gol TYPE REF TO y_game_of_life.

    METHODS setup.
    METHODS create_empty_3x3_board   FOR TESTING.
    METHODS cell_should_be_death     FOR TESTING.
    METHODS cell_should_be_alive     FOR TESTING.
    METHODS throwErrorCellOutOfBoard FOR TESTING.
    METHODS board_should_be_cloned   FOR TESTING.

ENDCLASS.


CLASS test_game_of_life IMPLEMENTATION.

  METHOD setup.
    me->gol = NEW y_game_of_life( row = 3 column = 3 ).
  ENDMETHOD.

  METHOD create_empty_3x3_board.
    DO 3 TIMES.
      DATA(row_index) = sy-index.
      DO 3 TIMES.
        DATA(column_index) = sy-index.
        cl_abap_unit_assert=>assert_true( gol->is_death( row = row_index column = column_index ) ).
      ENDDO.
    ENDDO.
  ENDMETHOD.

  METHOD cell_should_be_death.
    cl_abap_unit_assert=>assert_true( gol->is_death( row = 1 column = 1 ) ).
  ENDMETHOD.

  METHOD cell_should_be_alive.
    gol->comes_alive( row = 1 column = 1 ).
    cl_abap_unit_assert=>assert_true( gol->is_alive( row = 1 column = 1 ) ).
  ENDMETHOD.

  METHOD throwerrorcelloutofboard.
    TRY.
        gol->is_death( row = 4 column = 4 ).
        cl_abap_unit_assert=>fail( `Liegt die Zelle ausserhalb vom definiertem Bereich sollte ein Fehler geworfen werden!` ).
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.

    TRY.
        gol->is_alive( row = 4 column = 4 ).
        cl_abap_unit_assert=>fail( `Liegt die Zelle ausserhalb vom definiertem Bereich sollte ein Fehler geworfen werden!` ).
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.

  METHOD board_should_be_cloned.
    DATA(gol_clone) = gol->clone( ).

    cl_abap_unit_assert=>assert_bound( gol_clone ).
    cl_abap_unit_assert=>assert_equals( exp = gol->board act = gol_clone->board ).
  ENDMETHOD.

ENDCLASS.
