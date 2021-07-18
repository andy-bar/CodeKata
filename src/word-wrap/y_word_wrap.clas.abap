"! <p class="shorttext synchronized">CodeKata - WordWrap</p>
CLASS y_word_wrap DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS wrap
      IMPORTING text          TYPE string
                length        TYPE i
      RETURNING VALUE(result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS y_word_wrap IMPLEMENTATION.

  METHOD wrap.
    IF strlen( text ) = 0.
      RETURN.
    ENDIF.

    IF strlen( text ) <= length.
      result = text.
      RETURN.
    ENDIF.

    DATA remaining TYPE string.

    DATA(next) = substring( val = text off = 0 len = length ).
    IF next CA space.

      DATA(find_position) = find( val = next sub = ` ` occ = -1 ).
      next = substring( val = text off = 0 len = find_position ).
      remaining = substring( val = text off = find_position + 1 ).

    ELSE.

      remaining = substring( val = text off = length ).

    ENDIF.

    result = next.

    WHILE strlen( remaining ) > length.

      next = substring( val = remaining off = 0 len = length ).
      IF next CA space.

        find_position = find( val = next sub = ` ` occ = -1 ).
        result = result && cl_abap_char_utilities=>newline && substring( val = next off = 0 len = find_position ).
        remaining = substring( val = remaining off = find_position + 1 ).

      ELSE.

        result = result && cl_abap_char_utilities=>newline && next.
        remaining = substring( val = remaining off = length ).

      ENDIF.

    ENDWHILE.

    result = result && cl_abap_char_utilities=>newline && remaining.

  ENDMETHOD.

ENDCLASS.
