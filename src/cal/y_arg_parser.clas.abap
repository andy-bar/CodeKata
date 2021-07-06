"! <p class="shorttext synchronized">Argument Parser</p>
CLASS y_arg_parser DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS main
      IMPORTING input         TYPE string
      RETURNING VALUE(output) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS y_arg_parser IMPLEMENTATION.

  METHOD main.
    DATA(command) = `echo`.
    DATA(argument) = `input`.

    DATA args TYPE string_table.
    SPLIT input AT space INTO TABLE args.

    IF args[ 1 ] = command.
      IF line_exists( args[ 2 ] ).
        output = args[ 2 ].
        RETURN.
      ENDIF.
      output = command.
      RETURN.
    ENDIF.

    output = `no matching command found`.
  ENDMETHOD.

ENDCLASS.
