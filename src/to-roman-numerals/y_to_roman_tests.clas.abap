"! <p class="shorttext synchronized">Test Class</p>
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
    METHODS setup.
    "! @testing y_number
    METHODS oneInRoman_I FOR TESTING.
    "! @testing y_number
    METHODS fiveInRoman_V FOR TESTING.
    "! @testing y_number
    METHODS tenInRoman_X FOR TESTING.
    "! @testing y_number
    METHODS sixteenInRoman_XVI FOR TESTING.
    "! @testing y_number
    METHODS fiftyInRoman_L FOR TESTING.
    "! @testing y_number
    METHODS hundredInRoman_C FOR TESTING.
    "! @testing y_number
    METHODS fiveHundredInRoman_D FOR TESTING.
    "! @testing y_number
    METHODS thousandInRoman_M FOR TESTING.

ENDCLASS.



CLASS y_to_roman_tests IMPLEMENTATION.

  METHOD setup.

  ENDMETHOD.

  METHOD oneInRoman_I.
    DATA(romanNumber) = NEW y_number( )->to_roman( 1 ).
    cl_abap_unit_assert=>assert_equals( exp = `I` act = romanNumber ).
  ENDMETHOD.

  METHOD fiveInRoman_V.
    DATA(romanNumber) = NEW y_number( )->to_roman( 5 ).
    cl_abap_unit_assert=>assert_equals( exp = `V` act = romanNumber ).
  ENDMETHOD.

  METHOD sixteenInRoman_XVI.
    DATA(romanNumber) = NEW y_number( )->to_roman( 16 ).
    cl_abap_unit_assert=>assert_equals( exp = `XVI` act = romanNumber ).
  ENDMETHOD.

  METHOD tenInRoman_X.
    DATA(romanNumber) = NEW y_number( )->to_roman( 10 ).
    cl_abap_unit_assert=>assert_equals( exp = `X` act = romanNumber ).
  ENDMETHOD.

  METHOD fiftyInRoman_L.
    DATA(romanNumber) = NEW y_number( )->to_roman( 50 ).
    cl_abap_unit_assert=>assert_equals( exp = `L` act = romanNumber ).
  ENDMETHOD.

  METHOD hundredInRoman_C.
    DATA(romanNumber) = NEW y_number( )->to_roman( 100 ).
    cl_abap_unit_assert=>assert_equals( exp = `C` act = romanNumber ).
  ENDMETHOD.

  METHOD fiveHundredInRoman_D.
    DATA(romanNumber) = NEW y_number( )->to_roman( 500 ).
    cl_abap_unit_assert=>assert_equals( exp = `D` act = romanNumber ).
  ENDMETHOD.

  METHOD thousandInRoman_M.
    DATA(romanNumber) = NEW y_number( )->to_roman( 1000 ).
    cl_abap_unit_assert=>assert_equals( exp = `M` act = romanNumber ).
  ENDMETHOD.

ENDCLASS.
