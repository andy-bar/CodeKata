"! <p class="shorttext synchronized">CodeKata - Game Of Life</p>
CLASS y_game_of_life DEFINITION
  PUBLIC
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS launch
      IMPORTING testdouble_board TYPE REF TO y_gol_board OPTIONAL
      RETURNING VALUE(result)    TYPE REF TO y_game_of_life.

    METHODS constructor
      IMPORTING board TYPE REF TO y_gol_board.

    METHODS evolution
      RETURNING VALUE(result) TYPE REF TO y_game_of_life.

    METHODS display_as_string
      RETURNING VALUE(result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA board TYPE REF TO y_gol_board.

ENDCLASS.



CLASS y_game_of_life IMPLEMENTATION.

  METHOD launch.
    DATA(board) = COND #( WHEN testdouble_board IS BOUND THEN testdouble_board
                          ELSE NEW y_gol_board( row = 3 col = 3 )
                        ).
    board->become_alive( row = 2 col = 3 ).
    board->become_alive( row = 3 col = 2 ).
    board->become_alive( row = 3 col = 3 ).

    result = NEW y_game_of_life( board ).
  ENDMETHOD.

  METHOD constructor.
    me->board = board.
  ENDMETHOD.

  METHOD evolution.
    WHILE board->is_exists( row = sy-index col = 1 ).
      DATA(i) = sy-index.

      WHILE board->is_exists( row = 1 col = sy-index ).
        DATA(j) = sy-index.

        DATA(sum_living) = board->get_number_of_living_neighbors( row = i col = j ).
        DATA(sum_dead)   = board->get_number_of_dead_neighbors( row = i col = j ).

        IF board->is_dead( row = i col = i ) AND sum_living = 3.
          board->become_alive( row = i col = j ).
          CONTINUE.
        ENDIF.

        IF board->is_alive( row = i col = i ) AND sum_living > 3.
          board->become_dead( row = i col = j ).
          CONTINUE.
        ENDIF.


      ENDWHILE.
    ENDWHILE.
    result = me.
  ENDMETHOD.

  METHOD display_as_string.
    result = me->board->to_string( ).
  ENDMETHOD.

ENDCLASS.
