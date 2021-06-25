"! <p class="shorttext synchronized">Zahl</p>
CLASS y_number DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS to_roman
      IMPORTING number        TYPE int4
      RETURNING VALUE(result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.

    ##TODO "Member in eine eigene Collection
    TYPES BEGIN OF ENUM enum_roman STRUCTURE roman BASE TYPE i.
    TYPES:
      "! Nicht verwenden, wird aus technischen Gründen benötigt
      null VALUE IS INITIAL,
      i    VALUE 1,
      iv   VALUE 4,
      v    VALUE 5,
      ix   VALUE 9,
      x    VALUE 10,
      xl   VALUE 40,
      l    VALUE 50,
      xcix VALUE 99,
      c    VALUE 100,
      d    VALUE 500,
      m    VALUE 1000.
    TYPES END OF ENUM enum_roman STRUCTURE roman.

    ##TODO "Naming bei Member ändern Bsp. Mapping
    TYPES BEGIN OF member.
    TYPES:
      name  TYPE string,
      value TYPE int8.
    TYPES END OF member.
    TYPES members TYPE STANDARD TABLE OF member WITH DEFAULT KEY.

ENDCLASS.



CLASS y_number IMPLEMENTATION.

  METHOD to_roman.
    DATA(tmp) = number.
    DATA(enumMembers) = CORRESPONDING members( CAST cl_abap_enumdescr( cl_abap_typedescr=>describe_by_name( `enum_roman` ) )->members ).
    SORT enumMembers BY value DESCENDING.

    WHILE tmp > 0.
      LOOP AT enumMembers ASSIGNING FIELD-SYMBOL(<member>)
        WHERE name <> `NULL`.

        IF tmp >= CONV i( <member>-value ).
          result = |{ result }{ <member>-name }|.
          tmp -= CONV i( <member>-value ).
        ENDIF.

      ENDLOOP.
    ENDWHILE.
  ENDMETHOD.

ENDCLASS.
