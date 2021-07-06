"! <p class="shorttext synchronized">CLI Argument Parser Test Class</p>
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

    "! @testing Y_ARG_PARSER
    METHODS matchEchoAndProcessCommand FOR TESTING.

    "! @testing Y_ARG_PARSER
    METHODS unknownCommand FOR TESTING.

    "! @testing Y_ARG_PARSER
    METHODS matchEchoWithInputProcCommand FOR TESTING.

ENDCLASS.



CLASS y_argparser_test IMPLEMENTATION.

  METHOD matchEchoAndProcessCommand.
    DATA(parser) = NEW y_arg_parser( ).
    cl_abap_unit_assert=>assert_equals( exp = |echo| act = parser->main( `echo` ) ).
  ENDMETHOD.

  METHOD matchEchoWithInputProcCommand.
    DATA(parser) = NEW y_arg_parser( ).
    cl_abap_unit_assert=>assert_equals( exp = |TestEingabe| act = parser->main( `echo TestEingabe` ) ).
  ENDMETHOD.

  METHOD unknownCommand.
    DATA(parser) = NEW y_arg_parser( ).
    cl_abap_unit_assert=>assert_equals( exp = |no matching command found| act = parser->main( `unknownCommand` ) ).
  ENDMETHOD.

ENDCLASS.
