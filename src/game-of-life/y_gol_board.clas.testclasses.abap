CLASS test_board DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA board TYPE REF TO y_gol_board.

    METHODS setup.

    METHODS create_empty_3x3_board         FOR TESTING.
    METHODS throwErrorOutsideByIs_Dead     FOR TESTING.
    METHODS throwErrorOutsideByIs_Alive    FOR TESTING.
    METHODS throwErrorOutsideByComes_Dead  FOR TESTING.
    METHODS throwErrorOutsideByComes_Alive FOR TESTING.
    METHODS cell_should_be_death           FOR TESTING.
    METHODS cell_should_be_alive           FOR TESTING.
    METHODS shouldBeThreeLivingNeigbhors   FOR TESTING.
    METHODS shouldBeOneLivingNeigbhors     FOR TESTING.

ENDCLASS.


CLASS test_board IMPLEMENTATION.

  METHOD setup.
    board = NEW y_gol_board( row = 4 column = 4 ).
  ENDMETHOD.

  METHOD create_empty_3x3_board.
    DO 3 TIMES.
      DATA(row_index) = sy-index.
      DO 3 TIMES.
        DATA(column_index) = sy-index.
        cl_abap_unit_assert=>assert_true( board->is_death( row = row_index column = column_index ) ).
      ENDDO.
    ENDDO.
  ENDMETHOD.

  METHOD throwErrorOutsideByIs_Dead.
    TRY.
        board->is_death( row = 4 column = 6 ).
        cl_abap_unit_assert=>fail( `Liegt der Zugriff ausserhalb vom definiertem Bereich sollte ein Fehler geworfen werden!` ).
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.

  METHOD throwErrorOutsideByIs_Alive.
    TRY.
        board->is_alive( row = 4 column = 6 ).
        cl_abap_unit_assert=>fail( `Liegt der Zugriff ausserhalb vom definiertem Bereich sollte ein Fehler geworfen werden!` ).
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.

  METHOD throwErrorOutsideByComes_Dead.
    TRY.
        board->comes_dead( row = 4 column = 6 ).
        cl_abap_unit_assert=>fail( `Liegt der Zugriff ausserhalb vom definiertem Bereich sollte ein Fehler geworfen werden!` ).
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.

  METHOD throwErrorOutsideByComes_Alive.
    TRY.
        board->comes_alive( row = 4 column = 6 ).
        cl_abap_unit_assert=>fail( `Liegt der Zugriff ausserhalb vom definiertem Bereich sollte ein Fehler geworfen werden!` ).
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.

  METHOD cell_should_be_alive.
    board->comes_alive( row = 1 column = 1 ).
    board->comes_dead( row = 1 column = 1 ).
    cl_abap_unit_assert=>assert_true( board->is_death( row = 1 column = 1 ) ).
  ENDMETHOD.

  METHOD cell_should_be_death.
    board->comes_alive( row = 1 column = 1 ).
    cl_abap_unit_assert=>assert_true( board->is_alive( row = 1 column = 1 ) ).
  ENDMETHOD.

  METHOD shouldBeThreeLivingNeigbhors.
    board->comes_alive( row = 2 column = 3 ).
    board->comes_alive( row = 3 column = 2 ).
    board->comes_alive( row = 3 column = 3 ).

    cl_abap_unit_assert=>assert_equals( exp = 3 act = board->get_number_of_living_neighbors( row = 2 column = 2 ) ).
  ENDMETHOD.

  METHOD shouldbeonelivingneigbhors.
    board->comes_alive( row = 2 column = 2 ).
    board->comes_alive( row = 3 column = 2 ).

    cl_abap_unit_assert=>assert_equals( exp = 1 act = board->get_number_of_living_neighbors( row = 1 column = 1 ) ).
  ENDMETHOD.

ENDCLASS.
