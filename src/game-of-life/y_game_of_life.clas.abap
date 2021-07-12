"! <p class="shorttext synchronized">Game of Life</p>
CLASS y_game_of_life DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES BEGIN OF ty_grid.
    TYPES:
      y      TYPE i,
      x      TYPE i,
      status TYPE abap_bool.
    TYPES  END OF ty_grid.
    TYPES tt_grids TYPE HASHED TABLE OF ty_grid WITH UNIQUE KEY y x.

    DATA grid TYPE tt_grids.

    METHODS constructor
      IMPORTING y TYPE i
                x TYPE i.

    METHODS set_living_cell
      IMPORTING y TYPE i
                x TYPE i.

    METHODS is_alive
      IMPORTING y             TYPE i
                x             TYPE i
      RETURNING VALUE(result) TYPE abap_bool.

    METHODS is_death
      IMPORTING y             TYPE i
                x             TYPE i
      RETURNING VALUE(result) TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS create_empty_grid
      IMPORTING y TYPE i
                x TYPE i.

ENDCLASS.

CLASS y_game_of_life IMPLEMENTATION.

  METHOD constructor.
    create_empty_grid( y = y x = x ).
  ENDMETHOD.

  METHOD set_living_cell.
    grid[ y = y x = x ]-status = abap_true.
  ENDMETHOD.

  METHOD is_alive.
    result = grid[ y = y x = x ]-status.
  ENDMETHOD.

  METHOD is_death.
    result = grid[ y = y x = x ]-status.
  ENDMETHOD.

  METHOD create_empty_grid.
    DO y TIMES.
      DATA(count_y) = sy-index.
      DO x TIMES.
        DATA(count_x) = sy-index.
        INSERT VALUE #( y = count_y x = count_x status = abap_false ) INTO TABLE me->grid.
      ENDDO.
    ENDDO.
  ENDMETHOD.

ENDCLASS.
