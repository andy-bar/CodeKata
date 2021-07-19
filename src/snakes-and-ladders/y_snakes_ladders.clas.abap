CLASS y_snakes_ladders DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS play
      IMPORTING die1          TYPE i
                die2          TYPE i
      RETURNING VALUE(result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES BEGIN OF map_of_snake_and_ladder.
    TYPES:
      field TYPE i,
      go_to TYPE i.
    TYPES END OF map_of_snake_and_ladder.
    TYPES map_of_snakes_and_ladders TYPE HASHED TABLE OF map_of_snake_and_ladder WITH UNIQUE KEY field.

    DATA player_1_square TYPE i.

ENDCLASS.



CLASS y_snakes_ladders IMPLEMENTATION.

  METHOD play.
    DATA snakes_and_ladders TYPE map_of_snakes_and_ladders.
    snakes_and_ladders = VALUE #(
        ( field = 2  go_to = 38 )
        ( field = 64 go_to = 60 )
    ).

    DATA(dice_score) = die1 + die2.

    player_1_square += dice_score.

    IF line_exists( snakes_and_ladders[ field = player_1_square ] ).
      player_1_square = snakes_and_ladders[ field = player_1_square ]-go_to.
    ENDIF.

    result = |Player 1 is on square { player_1_square }|.
  ENDMETHOD.

ENDCLASS.
