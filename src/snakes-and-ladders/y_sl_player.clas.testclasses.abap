CLASS test_player DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA player TYPE REF TO y_sl_player.

    METHODS setup.
    METHODS id_should_be_set_with_1       FOR TESTING.
    METHODS player_score_should_be_set_10 FOR TESTING.
    METHODS player_should_start_round     FOR TESTING.
    METHODS player_should_finish_round    FOR TESTING.

ENDCLASS.


CLASS test_player IMPLEMENTATION.

  METHOD setup.
    player = NEW y_sl_player( 1 ).
  ENDMETHOD.

  METHOD id_should_be_set_with_1.
    cl_abap_unit_assert=>assert_equals( exp = 1 act = player->id( ) ).
  ENDMETHOD.

  METHOD player_score_should_be_set_10.
    player->change_score( 10 ).
    cl_abap_unit_assert=>assert_equals( exp = 10 act = player->score( ) ).
  ENDMETHOD.

  METHOD player_should_start_round.
    player->start_round( ).
    cl_abap_unit_assert=>assert_true( player->is_playing( ) ).
  ENDMETHOD.

  METHOD player_should_finish_round.
    player->start_round( ).
    player->end_round( ).
    cl_abap_unit_assert=>assert_false( player->is_playing( ) ).
  ENDMETHOD.

ENDCLASS.
