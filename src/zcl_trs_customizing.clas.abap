CLASS zcl_trs_customizing DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_trs_tr_factory.

  PUBLIC SECTION.

    INTERFACES zif_trs_transport_request.

    ALIASES add_key_to_request FOR zif_trs_transport_request~add_key_to_request.

    METHODS:
      constructor.


  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: trs_fm_access TYPE REF TO zif_trs_fm_access,
          order         TYPE trkorr,
          task          TYPE trkorr.
    METHODS validate_e071k_input
      CHANGING
        l_e071k TYPE e071k
      RAISING
        zcx_trs_no_key
        zcx_trs_no_object_type
        zcx_trs_wrong_object_type.
    METHODS add_missing_e071k_input
      CHANGING
        l_e071k TYPE e071k.

ENDCLASS.



CLASS zcl_trs_customizing IMPLEMENTATION.

  METHOD constructor.

    " get transport order ( request ) and task
    trs_fm_access = zcl_trs_factory_facade=>get_trs_fm_access( ).

    trs_fm_access->get_request(
          EXPORTING
            i_order_type = 'W'
            i_task_type  = 'Q'
            i_category   = 'CUST'
          IMPORTING
            e_order = order
            e_task  = task ).


  ENDMETHOD.

  METHOD zif_trs_transport_request~add_key_to_request.

    " some data may need to be changed
    DATA(l_e071k) = i_e071k.

*********************************
* checks if everything is fine and the key can be added to the transport request

    me->validate_e071k_input( CHANGING l_e071k = l_e071k ).

*********************************
* Missing stuff can be added

    me->add_missing_e071k_input( changing l_e071k = l_e071k ).

    trs_fm_access->check_transport( VALUE ko200( trkorr     = space
                                                 as4pos     = 0
                                                 pgmid      = 'R3TR'
                                                 object     = l_e071k-object
                                                 objfunc    = 'K'
                                                 obj_name   = l_e071k-objname ) ).

    trs_fm_access->insert_key( l_e071k ).

  ENDMETHOD.

  METHOD zif_trs_transport_request~delete_key_from_request.

  ENDMETHOD.


  METHOD validate_e071k_input.

    IF l_e071k IS INITIAL.
      RAISE RESUMABLE EXCEPTION TYPE zcx_trs_no_key.
    ENDIF.

    IF l_e071k-objname IS INITIAL.
      IF l_e071k-mastername IS NOT INITIAL.
        l_e071k-objname = l_e071k-mastername.
      ELSE.
        RAISE RESUMABLE EXCEPTION TYPE zcx_trs_no_key.
      ENDIF.
    ELSEIF l_e071k-mastername IS INITIAL.
      l_e071k-mastername  = l_e071k-objname.
    ENDIF.

    IF l_e071k-tabkey IS INITIAL.
      RAISE RESUMABLE EXCEPTION TYPE zcx_trs_no_key.
    ENDIF.

    IF l_e071k-object IS INITIAL.
      IF l_e071k-mastertype IS NOT INITIAL.
        l_e071k-object = l_e071k-mastertype.
      ELSE.
        RAISE RESUMABLE EXCEPTION TYPE zcx_trs_no_object_type.
      ENDIF.
    ELSEIF l_e071k-mastertype IS INITIAL.
      l_e071k-mastertype = l_e071k-object.
    ENDIF.

    IF l_e071k-object NE 'TABU'.
      RAISE RESUMABLE EXCEPTION TYPE zcx_trs_wrong_object_type.
    ENDIF.

  ENDMETHOD.


  METHOD add_missing_e071k_input.

    IF l_e071k-pgmid NE 'R3TR'.
      l_e071k-pgmid = 'R3TR'.
    ENDIF.

    IF l_e071k-objfunc IS INITIAL.
      l_e071k-objfunc = 'K'.
    ENDIF.

    IF l_e071k-as4pos IS INITIAL.
      l_e071k-as4pos = 0.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
