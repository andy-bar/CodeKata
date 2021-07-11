CLASS cal_test DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA cal TYPE REF TO y_calendar.

    METHODS setup.

    METHODS giveTo_01_12_2021_monthAsText FOR TESTING.
    METHODS giveTo_01_12_2021_dayOfTheWeek FOR TESTING.
    METHODS giveLastDayTo_February_2021 FOR TESTING.

ENDCLASS.


CLASS cal_test IMPLEMENTATION.

  METHOD setup.
    me->cal = NEW y_calendar( `20210228` ).
  ENDMETHOD.

  METHOD giveTo_01_12_2021_monthAsText.
    cl_abap_unit_assert=>assert_equals( exp = `Februar` act = cal->month_name( ) ).
  ENDMETHOD.

  METHOD giveTo_01_12_2021_dayOfTheWeek.
    cl_abap_unit_assert=>assert_equals( exp = `MO` act = cal->day_of_the_week( ) ).
  ENDMETHOD.

  METHOD giveLastDayTo_February_2021.
    cl_abap_unit_assert=>assert_equals( exp = 28 act = cal->last_day_of_month( ) ).
  ENDMETHOD.

ENDCLASS.
