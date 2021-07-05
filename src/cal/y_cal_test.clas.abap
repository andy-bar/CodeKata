"! <p class="shorttext synchronized">Test Class</p>
CLASS y_cal_test DEFINITION
  PUBLIC
  CREATE PRIVATE
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PUBLIC SECTION.
  PROTECTED SECTION.
  PRIVATE SECTION.

    "! GIVEN Gebe den Befehl CAL ohne Parameter ein  <br/>
    "! WHEN  Befehl wird ausgeführt                  <br/>
    "! THEN  Aktueller Monat in der CLI Ausgaben
    "!
    "! @testing Y_CALENDER
    METHODS command_cal_withoutParameters FOR TESTING.

    "! @testing Y_CALENDER
    METHODS shouldSpendCurrentMonth FOR TESTING.

ENDCLASS.



CLASS y_cal_test IMPLEMENTATION.

  METHOD command_cal_withoutParameters.
    DATA(calendar) = NEW y_calendar( ).
    DATA(exp_cli_cal) =
        |     Juli 2021      |  && cl_abap_char_utilities=>newline &&
        |Mo Di Mi Do Fr Sa So|  && cl_abap_char_utilities=>newline &&
        |          1  2  3  4|  && cl_abap_char_utilities=>newline &&
        | 5  6  7  8  9 10 11|  && cl_abap_char_utilities=>newline &&
        |12 13 14 15 16 17 18|  && cl_abap_char_utilities=>newline &&
        |19 20 21 22 23 24 25|  && cl_abap_char_utilities=>newline &&
        |26 27 28 29 30 31   |  && cl_abap_char_utilities=>newline.

    cl_abap_unit_assert=>assert_equals( exp = exp_cli_cal act = calendar->process_cli_argument( `cal` ) ).
  ENDMETHOD.

  METHOD shouldSpendCurrentMonth.
    DATA(calendar) = NEW y_calendar( ).

    DATA(exp_cli_cal) =
        |    Februar 2014    |  && cl_abap_char_utilities=>newline &&
        |So Mo Di Mi Do Fr Sa|  && cl_abap_char_utilities=>newline &&
        |                   1|  && cl_abap_char_utilities=>newline &&
        | 2  3  4  5  6  7  8|  && cl_abap_char_utilities=>newline &&
        | 9 10 11 12 13 14 15|  && cl_abap_char_utilities=>newline &&
        |16 17 18 19 20 21 22|  && cl_abap_char_utilities=>newline &&
        |23 24 25 26 27 28   |  && cl_abap_char_utilities=>newline.

    cl_abap_unit_assert=>assert_equals( exp = exp_cli_cal act = calendar->current( ) ).
  ENDMETHOD.


ENDCLASS.
