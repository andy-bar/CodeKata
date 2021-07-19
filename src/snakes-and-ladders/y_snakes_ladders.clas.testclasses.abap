CLASS test_game DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS Game_with_only_one_player FOR TESTING.

ENDCLASS.


CLASS test_game IMPLEMENTATION.

  METHOD Game_with_only_one_player.
    DATA(game) = NEW y_snakes_ladders( ).
    cl_abap_unit_assert=>assert_equals( exp = |Player 1 is on square 38| act = game->play( die1 = 1 die2 = 1 ) ).
    cl_abap_unit_assert=>assert_equals( exp = |Player 1 is on square 44| act = game->play( die1 = 1 die2 = 5 ) ).
    cl_abap_unit_assert=>assert_equals( exp = |Player 1 is on square 52| act = game->play( die1 = 6 die2 = 2 ) ).
    cl_abap_unit_assert=>assert_equals( exp = |Player 1 is on square 58| act = game->play( die1 = 4 die2 = 2 ) ).
    cl_abap_unit_assert=>assert_equals( exp = |Player 1 is on square 60| act = game->play( die1 = 3 die2 = 3 ) ).
  ENDMETHOD.

ENDCLASS.
