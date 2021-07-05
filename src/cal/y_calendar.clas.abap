"! <p class="shorttext synchronized">Kalender</p>
CLASS y_calendar DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS cli.

    METHODS process_cli_argument
      IMPORTING arg           TYPE string
      RETURNING VALUE(result) TYPE string.

    METHODS current
      RETURNING VALUE(result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS y_calendar IMPLEMENTATION.

  METHOD cli.
    DATA arg TYPE string.

    cl_demo_input=>add_field(
      EXPORTING
        text        = `CLI arg`
      CHANGING
        field       = arg
    ).
    cl_demo_input=>request( ).
  ENDMETHOD.

  METHOD process_cli_argument.
    CASE arg.
      WHEN `cal`.
        DATA(month) = cl_epmh_dgut_date_calc=>get_monthname_long( sy-datum ).
        DATA(year)  = cl_epmh_dgut_date_calc=>get_year( sy-datum ).

        result =
      |     { month } { year }      | && cl_abap_char_utilities=>newline &&
      |Mo Di Mi Do Fr Sa So|      && cl_abap_char_utilities=>newline &&
      |          1  2  3  4|      && cl_abap_char_utilities=>newline &&
      | 5  6  7  8  9 10 11|      && cl_abap_char_utilities=>newline &&
      |12 13 14 15 16 17 18|      && cl_abap_char_utilities=>newline &&
      |19 20 21 22 23 24 25|      && cl_abap_char_utilities=>newline &&
      |26 27 28 29 30 31   |      && cl_abap_char_utilities=>newline.
    ENDCASE.
  ENDMETHOD.

  METHOD current.
    result =
        |    Februar 2014    |  && cl_abap_char_utilities=>newline &&
        |So Mo Di Mi Do Fr Sa|  && cl_abap_char_utilities=>newline &&
        |                   1|  && cl_abap_char_utilities=>newline &&
        | 2  3  4  5  6  7  8|  && cl_abap_char_utilities=>newline &&
        | 9 10 11 12 13 14 15|  && cl_abap_char_utilities=>newline &&
        |16 17 18 19 20 21 22|  && cl_abap_char_utilities=>newline &&
        |23 24 25 26 27 28   |  && cl_abap_char_utilities=>newline.

    cl_demo_output=>display( result ).
  ENDMETHOD.



ENDCLASS.
