CLASS test_word_wrap DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA WordWrap TYPE REF TO y_word_wrap.

    METHODS setup.

    METHODS shouldReturn_Empty_String      FOR TESTING.
    METHODS textShouldBeSameWrapReturnText FOR TESTING.
    METHODS shouldReturn_BreakAfterEvery5  FOR TESTING.
    METHODS shouldReturn_BreakAfter27      FOR TESTING.
    METHODS shouldReturn_BreakAfterEvery25 FOR TESTING.


ENDCLASS.


CLASS test_word_wrap IMPLEMENTATION.

  METHOD setup.
    WordWrap = NEW y_word_wrap( ).
  ENDMETHOD.

  METHOD shouldReturn_BreakAfterEvery25.
    cl_abap_unit_assert=>assert_equals(
        exp = |Hansel and Gretel are|    && |{ cl_abap_char_utilities=>newline }| &&
              |young children whose|     && |{ cl_abap_char_utilities=>newline }| &&
              |father is a woodcutter.|  && |{ cl_abap_char_utilities=>newline }| &&
              |When a great famine|      && |{ cl_abap_char_utilities=>newline }| &&
              |settles over the land,|   && |{ cl_abap_char_utilities=>newline }| &&
              |the woodcutter's abusive| && |{ cl_abap_char_utilities=>newline }| &&
              |second wife decides to|   && |{ cl_abap_char_utilities=>newline }| &&
              |take the children into|   && |{ cl_abap_char_utilities=>newline }| &&
              |the woods...|
        act = WordWrap->wrap(
                 text   = |Hansel and Gretel are young children whose father is a woodcutter. When a great | &&
                          |famine settles over the land, the woodcutter's abusive second wife decides to |   &&
                          |take the children into the woods...|
                 length = 25
              )
    ).
  ENDMETHOD.

  METHOD shouldReturn_Empty_String.
    DATA(dummy) = ``.

    cl_abap_unit_assert=>assert_equals( exp = dummy act = WordWrap->wrap( text = dummy length = 10 ) ).
  ENDMETHOD.

  METHOD textShouldBeSameWrapReturnText.
    DATA(dummy) = `test`.

    cl_abap_unit_assert=>assert_equals( exp = dummy act = WordWrap->wrap( text = dummy length = 4 ) ).
  ENDMETHOD.

  METHOD shouldReturn_BreakAfterEvery5.
    DATA(test_text) = `test test test test test test`.
    DATA(expected_text) = |test| && |{ cl_abap_char_utilities=>newline }| &&
                          |test| && |{ cl_abap_char_utilities=>newline }| &&
                          |test| && |{ cl_abap_char_utilities=>newline }| &&
                          |test| && |{ cl_abap_char_utilities=>newline }| &&
                          |test| && |{ cl_abap_char_utilities=>newline }| &&
                          |test|.

    cl_abap_unit_assert=>assert_equals( exp = expected_text act = WordWrap->wrap( text = test_text length = 5 ) ).
  ENDMETHOD.

  METHOD shouldreturn_breakafter27.
    DATA(test_text) = `test test test test test test`.
    DATA(expected_text) = |test test test test test | && |{ cl_abap_char_utilities=>newline }| &&
                          |test|.

    "cl_abap_unit_assert=>assert_equals( exp = expected_text act = WordWrap->wrap( text = test_text length = 27 ) ).
  ENDMETHOD.

ENDCLASS.
