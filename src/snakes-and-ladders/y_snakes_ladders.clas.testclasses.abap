CLASS test_game DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS game_round_player1_should_win FOR TESTING.

ENDCLASS.


CLASS test_game IMPLEMENTATION.

  METHOD game_round_player1_should_win.
    DATA(game) = NEW y_snakes_ladders( ).

    cl_abap_unit_assert=>assert_equals( msg = `Should return: 'Player 1 is on square 38'`
        exp = `Player 1 is on square 38`
        act = game->play( square1 = 1 square2 = 1 )
    ).

    cl_abap_unit_assert=>assert_equals( msg = `Should return: 'Player 2 is on square 31'`
        exp = `Player 2 is on square 31`
        act = game->play( square1 = 6 square2 = 2 )
    ).
  ENDMETHOD.

ENDCLASS.
