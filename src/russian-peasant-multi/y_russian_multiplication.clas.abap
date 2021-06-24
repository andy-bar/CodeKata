"! <p class="shorttext synchronized">Russian multiplication</p>
CLASS y_russian_multiplication DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES BEGIN OF array_of_integer.
    TYPES:
      x TYPE i,
      y TYPE i.
    TYPES END OF array_of_integer.
    TYPES array_of_integers TYPE STANDARD TABLE OF array_of_integer WITH DEFAULT KEY.

    METHODS mul
      IMPORTING x             TYPE i
                y             TYPE i
      RETURNING VALUE(result) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS half
      IMPORTING number        TYPE i
      RETURNING VALUE(result) TYPE i.

    METHODS double
      IMPORTING number        TYPE i
      RETURNING VALUE(result) TYPE i.

    METHODS is_even_number
      IMPORTING number        TYPE i
      RETURNING VALUE(result) TYPE abap_bool.

    METHODS half_to_one
      IMPORTING x             TYPE i
                y             TYPE i
      RETURNING VALUE(result) TYPE array_of_integers.

ENDCLASS.



CLASS y_russian_multiplication IMPLEMENTATION.

  METHOD mul.
    DATA(array_of_integers) = half_to_one( x = x y = y ).
    LOOP AT array_of_integers REFERENCE INTO DATA(lr_integer).
      IF NOT is_even_number( lr_integer->x ).
        result += lr_integer->y.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD double.
    result = number * 2.
  ENDMETHOD.

  METHOD half.
    DATA tmp TYPE p.
    tmp = number.
    result = trunc( tmp / 2 ).
  ENDMETHOD.

  METHOD is_even_number.
    result = xsdbool( number MOD 2 = 0 ).
  ENDMETHOD.

  METHOD half_to_one.
    DATA(tmp_x) = x.
    DATA(tmp_y) = y.
    WHILE tmp_x <> 0.
      APPEND VALUE array_of_integer( x = tmp_x y = tmp_y ) TO result.
      tmp_x = half( tmp_x ).
      tmp_y = double( tmp_y ).
    ENDWHILE.
  ENDMETHOD.

ENDCLASS.
