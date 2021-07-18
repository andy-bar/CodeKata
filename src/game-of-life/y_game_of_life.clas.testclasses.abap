CLASS test_gol DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA board TYPE REF TO y_gol_board.
    DATA gol TYPE REF TO y_game_of_life.

    METHODS setup.
    METHODS start_3x3_game_of_life FOR TESTING.

    "! Dead cell comes alive WHEN three living neighbors
    METHODS When_Three_Living_neighbors    FOR TESTING.

    "! living cell with more than three living neighbors should die.
    METHODS threeLivingNeighborsShould_die FOR TESTING.

ENDCLASS.


CLASS test_gol IMPLEMENTATION.

  METHOD setup.
    board = NEW y_gol_board( row = 3 col = 3 ).
    gol = y_game_of_life=>launch( board ).
  ENDMETHOD.

  METHOD start_3x3_game_of_life.
    DATA(gol_default) = y_game_of_life=>launch( ).
    cl_abap_unit_assert=>assert_equals(
        exp = |---| && cl_abap_char_utilities=>newline &&
              |--+| && cl_abap_char_utilities=>newline &&
              |-++|
        act = gol_default->display_as_string( )
    ).
  ENDMETHOD.

  METHOD When_Three_Living_neighbors.
    cl_abap_unit_assert=>assert_equals(
        exp = |---| && cl_abap_char_utilities=>newline &&
              |-++| && cl_abap_char_utilities=>newline &&
              |-++|
        act = gol->evolution( )->display_as_string( )
    ).
  ENDMETHOD.

  METHOD threeLivingNeighborsShould_die.
    board->become_alive( row = 2 col = 2 ).
    board->become_alive( row = 3 col = 1 ).

    cl_abap_unit_assert=>assert_equals(
        exp = |---| && cl_abap_char_utilities=>newline &&
              |--+| && cl_abap_char_utilities=>newline &&
              |+++|
        act = gol->evolution( )->display_as_string( )
    ).
  ENDMETHOD.

ENDCLASS.
