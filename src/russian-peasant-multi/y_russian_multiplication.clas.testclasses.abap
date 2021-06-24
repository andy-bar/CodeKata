CLASS testRussianMultiplication DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA russian TYPE REF TO y_russian_multiplication.

    METHODS setup.
    METHODS Multiplication FOR TESTING.

ENDCLASS.


CLASS testRussianMultiplication IMPLEMENTATION.

  METHOD setup.
    russian = NEW y_russian_multiplication( ).
  ENDMETHOD.

  METHOD Multiplication.
    cl_abap_unit_assert=>assert_equals( exp = 1974 act = russian->mul( x = 47 y = 42 ) ).
  ENDMETHOD.

ENDCLASS.
