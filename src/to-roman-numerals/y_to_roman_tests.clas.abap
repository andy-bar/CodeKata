"! <p class="shorttext synchronized">Test Class</p>
"!
"! https://ccd-school.de/coding-dojo/function-katas/to-roman-numerals/
"! https://www.mathetreff-online.de/wissen/mathelexikon/roemisches-zahlensystem
"! https://roemische-zahlen.info/
"!
CLASS y_to_roman_tests DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PUBLIC SECTION.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA number TYPE REF TO y_number.

    METHODS setup.

    "! @testing y_number
    METHODS oneInRoman_I FOR TESTING.

    "! @testing y_number
    METHODS fourInRoman_IV FOR TESTING.

    "! @testing y_number
    METHODS fiveInRoman_V FOR TESTING.

    "! @testing y_number
    METHODS nineInRoman_IX FOR TESTING.

    "! @testing y_number
    METHODS tenInRoman_X FOR TESTING.

    "! @testing y_number
    METHODS sixteenInRoman_XVI FOR TESTING.

    "! @testing y_number
    METHODS fortyFourInRoman_XLIV FOR TESTING.

    "! @testing y_number
    METHODS fiftyInRoman_L FOR TESTING.

    "! @testing y_number
    METHODS ninetyNinceInRoman_XCIX FOR TESTING.

    "! @testing y_number
    METHODS hundredInRoman_C FOR TESTING.

    "! @testing y_number
    METHODS fiveHundredInRoman_D FOR TESTING.

    "! @testing y_number
    METHODS thousandInRoman_M FOR TESTING.

ENDCLASS.



CLASS y_to_roman_tests IMPLEMENTATION.

  METHOD setup.
    number = NEW y_number( ).
  ENDMETHOD.

  METHOD oneInRoman_I.
    DATA(romanNumber) = number->to_roman( 1 ).
    cl_abap_unit_assert=>assert_equals( exp = `I` act = romanNumber ).
  ENDMETHOD.

  METHOD fourInRoman_IV.
    DATA(romanNumber) = number->to_roman( 4 ).
    cl_abap_unit_assert=>assert_equals( exp = `IV` act = romanNumber ).
  ENDMETHOD.

  METHOD fiveInRoman_V.
    DATA(romanNumber) = number->to_roman( 5 ).
    cl_abap_unit_assert=>assert_equals( exp = `V` act = romanNumber ).
  ENDMETHOD.

  METHOD sixteenInRoman_XVI.
    DATA(romanNumber) = number->to_roman( 16 ).
    cl_abap_unit_assert=>assert_equals( exp = `XVI` act = romanNumber ).
  ENDMETHOD.

  METHOD nineInRoman_IX.
    DATA(romanNumber) = number->to_roman( 9 ).
    cl_abap_unit_assert=>assert_equals( exp = `IX` act = romanNumber ).
  ENDMETHOD.

  METHOD tenInRoman_X.
    DATA(romanNumber) = number->to_roman( 10 ).
    cl_abap_unit_assert=>assert_equals( exp = `X` act = romanNumber ).
  ENDMETHOD.

  METHOD fortyFourInRoman_XLIV.
    DATA(romanNumber) = number->to_roman( 44 ).
    cl_abap_unit_assert=>assert_equals( exp = `XLIV` act = romanNumber ).
  ENDMETHOD.

  METHOD fiftyInRoman_L.
    DATA(romanNumber) = number->to_roman( 50 ).
    cl_abap_unit_assert=>assert_equals( exp = `L` act = romanNumber ).
  ENDMETHOD.

  METHOD ninetyNinceInRoman_XCIX.
    DATA(romanNumber) = number->to_roman( 99 ).
    cl_abap_unit_assert=>assert_equals( exp = `XCIX` act = romanNumber ).
  ENDMETHOD.

  METHOD hundredInRoman_C.
    DATA(romanNumber) = number->to_roman( 100 ).
    cl_abap_unit_assert=>assert_equals( exp = `C` act = romanNumber ).
  ENDMETHOD.

  METHOD fiveHundredInRoman_D.
    DATA(romanNumber) = number->to_roman( 500 ).
    cl_abap_unit_assert=>assert_equals( exp = `D` act = romanNumber ).
  ENDMETHOD.

  METHOD thousandInRoman_M.
    DATA(romanNumber) = number->to_roman( 1000 ).
    cl_abap_unit_assert=>assert_equals( exp = `M` act = romanNumber ).
  ENDMETHOD.

ENDCLASS.
