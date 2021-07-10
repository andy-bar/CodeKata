"! <p class="shorttext synchronized">Arg Parser</p>
CLASS y_arg DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS main
      IMPORTING input         TYPE string
      RETURNING VALUE(result) TYPE string.
    METHODS add_command
      IMPORTING
        command TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES BEGIN OF command.
    TYPES name TYPE string.
    TYPES END OF command.
    DATA commands TYPE HASHED TABLE OF command WITH UNIQUE KEY name.

    METHODS tell_me_command
      IMPORTING input         TYPE string
      RETURNING VALUE(result) TYPE string.

    METHODS tell_me_parameters
      IMPORTING input         TYPE string
      RETURNING VALUE(result) TYPE string_table.

    METHODS split_into_args
      IMPORTING input         TYPE string
      RETURNING VALUE(result) TYPE string_table.

ENDCLASS.



CLASS y_arg IMPLEMENTATION.

  METHOD main.
    DATA(current_command)    = tell_me_command( input ).
    DATA(parameters) = tell_me_parameters( input ).

    IF line_exists( commands[ name = current_command ] ).

      result = |{ sy-datlo DATE = USER } - { sy-uzeit TIME = USER }|.
      RETURN.
    ENDIF.

    IF current_command = `echo`.
      IF line_exists( parameters[ 1 ] ).
        result = parameters[ 1 ].
        RETURN.
      ENDIF.
    ENDIF.

    IF current_command = `cal`.
      DATA(cal)  = NEW cl_i18_calendar_greg( ).
      cal->getmonthname_long(
        EXPORTING
          im_month      = CONV i( parameters[ 1 ] )
        IMPORTING
          ex_month_name = DATA(month_name)
      ).

      result = |{ month_name } { parameters[ 2 ] }|.
    ENDIF.
  ENDMETHOD.

  METHOD add_command.
    INSERT VALUE #( name = command ) INTO TABLE commands.
  ENDMETHOD.

  METHOD tell_me_command.
    DATA(args) = split_into_args( input ).
    result = args[ 1 ].
  ENDMETHOD.

  METHOD tell_me_parameters.
    DATA(args) = split_into_args( input ).
    DELETE args INDEX 1.
    result = args.
  ENDMETHOD.

  METHOD split_into_args.
    SPLIT input AT space INTO TABLE result.
  ENDMETHOD.

ENDCLASS.
