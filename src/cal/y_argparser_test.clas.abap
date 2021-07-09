CLASS y_argparser_test DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PUBLIC SECTION.
  PROTECTED SECTION.
  PRIVATE SECTION.

    "! @testing Y_ARGS
    METHODS ECHO_withoutParameter FOR TESTING.

    "! @testing Y_ARGS
    METHODS ECHO_withParameter FOR TESTING.

    "! @testing Y_ARGS
    METHODS ECHO_input_uppercase FOR TESTING.

ENDCLASS.



CLASS y_argparser_test IMPLEMENTATION.

  METHOD ECHO_withoutParameter.
    DATA(arg) = NEW y_args( ).

    DATA(value) = arg->main( `echo TestEcho` ).

    cl_abap_unit_assert=>assert_equals( exp = `TestEcho` act = value ).
  ENDMETHOD.

  METHOD echo_input_uppercase.
    DATA(arg) = NEW y_args( ).

    DATA(value) = arg->main( `echo TestEcho --uppercase` ).

    cl_abap_unit_assert=>assert_equals( exp = `TESTECHO` act = value ).
  ENDMETHOD.

  METHOD ECHO_withParameter.
    DATA(arg) = NEW y_args( ).

    DATA(value) = arg->main( `echo` ).

    cl_abap_unit_assert=>assert_equals( exp = |{ sy-datum DATE = USER } - { sy-uzeit TIME = USER }| act = value ).
  ENDMETHOD.

ENDCLASS.
