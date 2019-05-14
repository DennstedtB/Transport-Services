CLASS zcl_trs_request DEFINITION
  PUBLIC
  CREATE PUBLIC
  ABSTRACT.

  PUBLIC SECTION.

    " Abstract Public Methods
    METHODS:
      add_object_key ABSTRACT IMPORTING object type TABNAME
                                        key    type TROBJ_NAME,
      delete_object_key ABSTRACT.

    METHODS:
      check_tr_object.

    METHODS:
      get_order RETURNING VALUE(r_order) TYPE trkorr,
      get_task  RETURNING VALUE(r_task)  TYPE trkorr.

  PROTECTED SECTION.

    METHODS:
      ask_for_request.

    DATA: order TYPE trkorr,
          task  TYPE trkorr.

    DATA: ko200 TYPE ko200.

    DATA: t_e071  TYPE TABLE OF e071,
          t_e071k TYPE TABLE OF e071k.

    DATA: order_type TYPE trfunction,
          task_type  TYPE trfunction,
          category   TYPE trcateg.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_trs_request IMPLEMENTATION.

  METHOD get_order.
    r_order = order.
  ENDMETHOD.

  METHOD get_task.
    r_task = task.
  ENDMETHOD.

  METHOD ask_for_request.

    CALL FUNCTION 'TRINT_ORDER_CHOICE'
      EXPORTING
        wi_order_type          = me->order_type
        wi_task_type           = me->task_type
        wi_category            = me->category
*       wi_order               = COND trkorr( WHEN order IS NOT INITIAL THEN order ELSE '' )
      IMPORTING
        we_order               = order
        we_task                = task
      TABLES
        wt_e071                = t_e071
        wt_e071k               = t_e071k
      EXCEPTIONS
        no_correction_selected = 1
        display_mode           = 2
        object_append_error    = 3
        recursive_call         = 4
        wrong_order_type       = 5
        OTHERS                 = 6.

    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDMETHOD.

  METHOD check_tr_object.
    CALL FUNCTION 'TR_OBJECT_CHECK'
      EXPORTING
        wi_ko200 = ko200.
  ENDMETHOD.

ENDCLASS.
