CLASS Test_Game_of_life DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS createEmpty_3x3_Grid FOR TESTING.
    METHODS cell_is_alive FOR TESTING.
    METHODS cell_is_dead FOR TESTING.

ENDCLASS.


CLASS Test_Game_of_life IMPLEMENTATION.

  METHOD createEmpty_3x3_Grid.
    DATA(gol) = NEW y_game_of_life( y = 3 x = 3 ).

    DATA(exp) = VALUE gol->tt_grids(
        ( y = 1 x = 1 )
        ( y = 1 x = 2 )
        ( y = 1 x = 3 )
        ( y = 2 x = 1 )
        ( y = 2 x = 2 )
        ( y = 2 x = 3 )
        ( y = 3 x = 1 )
        ( y = 3 x = 2 )
        ( y = 3 x = 3 )
    ).
    cl_abap_unit_assert=>assert_equals( exp = exp act = gol->grid ).
  ENDMETHOD.

  METHOD cell_is_alive.
    DATA(gol) = NEW y_game_of_life( y = 3 x = 3 ).

    gol->set_living_cell( y = 2 x = 3 ).

    cl_abap_unit_assert=>assert_true( gol->is_alive( y = 2 x = 3 ) ).
  ENDMETHOD.

  METHOD cell_is_dead.
    DATA(gol) = NEW y_game_of_life( y = 3 x = 3 ).

    cl_abap_unit_assert=>assert_false( gol->is_death( y = 2 x = 3 ) ).
  ENDMETHOD.

ENDCLASS.
