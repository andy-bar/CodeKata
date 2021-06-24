"! <p class="shorttext synchronized">Zahl</p>
CLASS y_number DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS to_roman
      IMPORTING number       TYPE int4
      RETURNING VALUE(roman) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS y_number IMPLEMENTATION.

  METHOD to_roman.
    CASE number.
      WHEN 1.
        roman = `I`.
      WHEN 5.
        roman = `V`.
      WHEN 10.
        roman = `X`.
      WHEN 50.
        roman = `L`.
      WHEN 100.
        roman = `C`.
      WHEN 500.
        roman = `D`.
      WHEN 1000.
        roman = `M`.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
