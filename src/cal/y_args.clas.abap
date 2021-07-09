"! <p class="shorttext synchronized">Generic Arg</p>
CLASS y_args DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS main
      IMPORTING input         TYPE string
      RETURNING VALUE(result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA echo_input TYPE string.
    DATA echo_uppercase TYPE abap_bool.

    METHODS split_into_arguments
      IMPORTING input         TYPE string
      RETURNING VALUE(result) TYPE string_table.

    METHODS tell_me_command
      IMPORTING args           TYPE string_table
      RETURNING VALUE(command) TYPE string.

    METHODS tell_me_parameters
      IMPORTING args          TYPE string_table
      RETURNING VALUE(result) TYPE string_table.

ENDCLASS.



CLASS y_args IMPLEMENTATION.

  METHOD main.
    DATA(args) = split_into_arguments( input ).

    DATA(currentCommand)   = tell_me_command( args ).
    DATA(currentParameter) = tell_me_parameters( args ).

    IF currentCommand = `echo`.

      IF echo_input IS NOT INITIAL.
        IF echo_uppercase = abap_true.
          result = to_upper( echo_input ).
          RETURN.
        ENDIF.

        result = echo_input.
        RETURN.
      ENDIF.

      result = |{ sy-datum DATE = USER } - { sy-uzeit TIME = USER }|.
      RETURN.
    ENDIF.
  ENDMETHOD.

  METHOD split_into_arguments.
    SPLIT input AT space INTO TABLE result.
  ENDMETHOD.

  METHOD tell_me_command.
    IF line_exists( args[ 1 ] ).
      command = args[ 1 ].
    ENDIF.
  ENDMETHOD.

  METHOD tell_me_parameters.
    DATA(arg_parameters) = args.
    DELETE arg_parameters INDEX 1.

    LOOP AT arg_parameters INTO DATA(parameter).
      IF parameter = `--uppercase`.
        echo_uppercase = abap_true.
        CONTINUE.
      ENDIF.

      IF parameter IS NOT INITIAL.
        echo_input = parameter.
        CONTINUE.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
