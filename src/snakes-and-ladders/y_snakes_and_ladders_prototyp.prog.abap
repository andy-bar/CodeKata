REPORT y_snakes_and_ladders_prototyp.



CLASS sl_player DEFINITION CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING id TYPE i.

    METHODS id
      RETURNING VALUE(id) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA me_id TYPE i.

ENDCLASS.
CLASS sl_player IMPLEMENTATION.

  METHOD constructor.
    me_id = id.
  ENDMETHOD.

  METHOD id.
    id = me_id.
  ENDMETHOD.

ENDCLASS.



CLASS sl_players_collection DEFINITION DEFERRED.
CLASS sl_players_collection_iterator DEFINITION CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_object_collection_iterator.
    METHODS constructor
      IMPORTING collection TYPE REF TO sl_players_collection.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA collection TYPE REF TO sl_players_collection.
    DATA next_player TYPE i VALUE 1.

ENDCLASS.


CLASS sl_players_collection DEFINITION CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_object_collection.
    METHODS constructor.
    METHODS get_player_iterator
      RETURNING VALUE(iterator) TYPE REF TO if_object_collection_iterator.
    METHODS clear.
    METHODS remove
      IMPORTING element TYPE REF TO object.
    METHODS add
      IMPORTING element TYPE REF TO object.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA collection TYPE REF TO cl_object_collection.

ENDCLASS.
CLASS sl_players_collection IMPLEMENTATION.

  METHOD constructor.
    collection = NEW cl_object_collection( ).
  ENDMETHOD.

  METHOD if_object_collection~get.
    object = collection->get( index ).
  ENDMETHOD.

  METHOD if_object_collection~get_iterator.
    collection->get_iterator( ).
  ENDMETHOD.

  METHOD if_object_collection~is_empty.
    is_empty = collection->is_empty( ).
  ENDMETHOD.

  METHOD if_object_collection~size.
    size = collection->size( ).
  ENDMETHOD.

  METHOD clear.
    collection->clear( ).
  ENDMETHOD.

  METHOD remove.
    collection->remove( element ).
  ENDMETHOD.

  METHOD add.
    collection->add( element ).
  ENDMETHOD.

  METHOD get_player_iterator.
    iterator = NEW sl_players_collection_iterator( me ).
  ENDMETHOD.

ENDCLASS.


CLASS sl_players_collection_iterator IMPLEMENTATION.

  METHOD constructor.
    me->collection = collection.
  ENDMETHOD.

  METHOD if_object_collection_iterator~get_index.

  ENDMETHOD.

  METHOD if_object_collection_iterator~get_next.
    IF collection->if_object_collection~size( ) = next_player.
      object = collection->if_object_collection~get( next_player ).
      next_player -= 1.
    ELSE.
      object = collection->if_object_collection~get( next_player ).
      next_player += 1.
    ENDIF.
  ENDMETHOD.

  METHOD if_object_collection_iterator~has_next.

  ENDMETHOD.

ENDCLASS.



CLASS sl_players_map DEFINITION CREATE PUBLIC
  INHERITING FROM cl_object_map.

  PUBLIC SECTION.
    METHODS if_object_map~get_values REDEFINITION.
    METHODS if_object_map~get_values_iterator REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.
CLASS sl_players_map IMPLEMENTATION.

  METHOD if_object_map~get_values.
    DATA(collection) = NEW sl_players_collection( ).
    LOOP AT map ASSIGNING FIELD-SYMBOL(<player>).
      collection->add( <player>-value ).
    ENDLOOP.
    values = collection.
  ENDMETHOD.

  METHOD if_object_map~get_values_iterator.
    DATA(collection) = CAST sl_players_collection( get_values( ) ).
    value_iterator = collection->get_player_iterator( ).
  ENDMETHOD.

ENDCLASS.






CLASS test_snakes_ladders DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA players TYPE REF TO sl_players_map.

    METHODS setup.

    METHODS player_ID_1_should_be_created FOR TESTING.
    METHODS two_players_should_in_map     FOR TESTING.
    METHODS should_return_players_as_coll FOR TESTING.
    METHODS should_provide_iterator       FOR TESTING.
    METHODS should_switch_between_players FOR TESTING.

ENDCLASS.


CLASS test_snakes_ladders IMPLEMENTATION.

  METHOD setup.
    players = NEW sl_players_map( ).
    DO 2 TIMES.
      DATA(player) = NEW sl_player( sy-index ).
      players->put( key = player->id( ) value = player ).
    ENDDO.
  ENDMETHOD.

  METHOD player_ID_1_should_be_created.
    DATA(player) = NEW sl_player( 1 ).

    cl_abap_unit_assert=>assert_equals( exp = 1 act = player->id( ) ).
  ENDMETHOD.

  METHOD two_players_should_in_map.
    cl_abap_unit_assert=>assert_equals( exp = 1 act = CAST sl_player( players->get( 1 ) )->id( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 2 act = CAST sl_player( players->get( 2 ) )->id( ) ).
  ENDMETHOD.

  METHOD should_return_players_as_coll.
    DATA(collection) = players->get_values( ).

    cl_abap_unit_assert=>assert_true( xsdbool( collection IS INSTANCE OF sl_players_collection ) ).
    cl_abap_unit_assert=>assert_equals( exp = 2 act = collection->size( ) ).
  ENDMETHOD.

  METHOD should_provide_iterator.
    DATA(iterator) = players->get_values_iterator( ).

    cl_abap_unit_assert=>assert_true( xsdbool( iterator IS INSTANCE OF sl_players_collection_iterator ) ).
  ENDMETHOD.

  METHOD should_switch_between_players.
    DATA(iterator) = players->get_values_iterator( ).

    DATA(player) = CAST sl_player( iterator->get_next( ) ).

    cl_abap_unit_assert=>assert_equals( msg = `Should return: Iteration 1 Player 1`
        exp = 1 act = player->id( )
    ).

    player ?= iterator->get_next( ).

    cl_abap_unit_assert=>assert_equals( msg = `Should return: Iteration 2 Player 2`
        exp = 2 act = player->id( )
    ).

    player ?= iterator->get_next( ).

    cl_abap_unit_assert=>assert_equals( msg = `Should return: Iteration 3 Player 1`
        exp = 1 act = player->id( )
    ).

    player ?= iterator->get_next( ).

    cl_abap_unit_assert=>assert_equals( msg = `Should return: Iteration 4 Player 2`
        exp = 2 act = player->id( )
    ).
  ENDMETHOD.

ENDCLASS.
