CLASS y_sl_player DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING id TYPE i.

    METHODS id
      RETURNING VALUE(id) TYPE i.

    METHODS score
      RETURNING VALUE(score) TYPE i.

    METHODS change_score
      IMPORTING score TYPE i.

    METHODS is_playing
      RETURNING VALUE(result) TYPE abap_bool.

    METHODS start_round.
    METHODS end_round.


  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA me_id          TYPE i.
    DATA me_score       TYPE i.
    DATA me_is_playing  TYPE abap_bool.

ENDCLASS.



CLASS y_sl_player IMPLEMENTATION.

  METHOD constructor.
    me_id = id.
  ENDMETHOD.

  METHOD id.
    id = me_id.
  ENDMETHOD.

  METHOD score.
    score = me_score.
  ENDMETHOD.

  METHOD change_score.
    me_score = score.
  ENDMETHOD.

  METHOD is_playing.
    result = me_is_playing.
  ENDMETHOD.

  METHOD start_round.
    me_is_playing = abap_true.
  ENDMETHOD.

  METHOD end_round.
    me_is_playing = abap_false.
  ENDMETHOD.

ENDCLASS.
