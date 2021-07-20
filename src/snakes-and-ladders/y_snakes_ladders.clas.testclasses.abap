CLASS test_game DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CLASS-DATA game TYPE REF TO y_snakes_ladders.

    CLASS-METHODS class_setup.
    METHODS Game_should_start_with_Player1 FOR TESTING.
    METHODS next_round_should_be_player_2  FOR TESTING.
    METHODS player1_has_doubles_roll_again FOR TESTING.

ENDCLASS.


CLASS test_game IMPLEMENTATION.

  METHOD class_setup.
    game = NEW y_snakes_ladders( ).
  ENDMETHOD.

  METHOD Game_should_start_with_Player1.
    cl_abap_unit_assert=>assert_equals( exp = |Player 1 is on square 3| act = game->play( square1 = 1 square2 = 2 ) ).
  ENDMETHOD.

  METHOD next_round_should_be_player_2.
    cl_abap_unit_assert=>assert_equals( exp = |Player 2 is on square 6| act = game->play( square1 = 1 square2 = 5 ) ).
  ENDMETHOD.

  METHOD player1_has_doubles_roll_again.
    cl_abap_unit_assert=>assert_equals( exp = |Player 1 is on square 5| act = game->play( square1 = 1 square2 = 1 ) ).
    cl_abap_unit_assert=>assert_equals( exp = |Player 1 is on square 8| act = game->play( square1 = 2 square2 = 1 ) ).
  ENDMETHOD.

ENDCLASS.
