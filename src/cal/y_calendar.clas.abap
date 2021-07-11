"! <p class="shorttext synchronized">Kalender</p>
CLASS y_calendar DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING date TYPE d.

    METHODS month_name
      RETURNING VALUE(result) TYPE string.

    METHODS day_of_the_week
      RETURNING VALUE(result) TYPE string.

    METHODS last_day_of_month
      RETURNING VALUE(result) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA cal  TYPE REF TO cl_i18_calendar_greg.
    DATA date TYPE REF TO cl_i18_datec.

ENDCLASS.



CLASS y_calendar IMPLEMENTATION.

  METHOD constructor.
    me->cal  = NEW cl_i18_calendar_greg( ).
    me->date = NEW cl_i18_datec( calend = cal date = date ).
  ENDMETHOD.

  METHOD month_name.
    cal->getMonthName_long(
      EXPORTING
        im_month      = date->getmonth( )
      IMPORTING
        ex_month_name = DATA(month_name)
    ).

    result = month_name.
  ENDMETHOD.

  METHOD day_of_the_week.
    cal->getDayOfWeek(
      EXPORTING
        im_date    = date
      IMPORTING
        ex_day_num = DATA(day_number)
    ).
    cal->getShortDayName(
      EXPORTING
        im_day      = day_number
      IMPORTING
        ex_day_name = DATA(text)
    ).
    result = text.
  ENDMETHOD.

  METHOD last_day_of_month.
    result = cal->getDaysOfMonth( me->date ).
  ENDMETHOD.

ENDCLASS.
