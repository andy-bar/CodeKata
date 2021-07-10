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

    "! @testing Y_ARG
    METHODS ECHO_withoutParameter FOR TESTING.

    "! @testing Y_ARG
    METHODS ECHO_withInput FOR TESTING.

    "! @testing Y_ARG
    METHODS CAL_withInput_MM_YYYY FOR TESTING.

ENDCLASS.



CLASS y_argparser_test IMPLEMENTATION.

  METHOD ECHO_withoutParameter.
    DATA(arg) = NEW y_arg( ).
    arg->add_command( `echo` ).

    cl_abap_unit_assert=>assert_equals( exp = |{ sy-datlo DATE = USER } - { sy-uzeit TIME = USER }| act = arg->main( `echo` ) ).
  ENDMETHOD.

  METHOD ECHO_withInput.
    DATA(arg) = NEW y_arg( ).

    cl_abap_unit_assert=>assert_equals( exp = |TestOutput| act = arg->main( `echo TestOutput` ) ).
  ENDMETHOD.

  METHOD CAL_withInput_MM_YYYY.
    DATA(arg) = NEW y_arg( ).

    cl_abap_unit_assert=>assert_equals( exp = |Februar 2014| act = arg->main( `cal 2 2014` ) ).
  ENDMETHOD.

ENDCLASS.
