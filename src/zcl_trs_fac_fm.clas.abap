CLASS zcl_trs_fac_fm DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_trs_factory_facade.

  PUBLIC SECTION.

    INTERFACES: zif_trs_fm_access.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA s_e071 TYPE e071.
    DATA t_e071 TYPE TABLE OF e071.
    DATA s_e071k TYPE e071k.
    DATA t_e071k TYPE TABLE OF e071k.
    DATA s_ko200 TYPE ko200.
    DATA order TYPE e071-trkorr.
    DATA task TYPE e071-trkorr.

ENDCLASS.



CLASS zcl_trs_fac_fm IMPLEMENTATION.

  METHOD zif_trs_fm_access~get_request.

    CALL FUNCTION 'TRINT_ORDER_CHOICE'
      EXPORTING
        wi_order_type          = i_order_type    " gewünschter Auftragstyp ('K','L',' ')
        wi_task_type           = i_task_type    " gewünschter Aufgabentyp ('S','R',' ')
        wi_category            = i_category    " gew. Auftr.kategorie ('CUST','CUSY','SYST')
      IMPORTING
        we_order               = e_order    " gewählter Auftrag
        we_task                = e_task    " gewählte Aufgabe
      TABLES
        wt_e071                = t_e071    " Zu bearbeitende Objekttabelle (bei Massenverarb)
        wt_e071k               = t_e071k    " Zu bearbeitende Key-Tabelle (bei Massenverarb.)
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

    me->order = e_order.
    me->task  = e_task.

  ENDMETHOD.

  METHOD zif_trs_fm_access~check_transport.
    CALL FUNCTION 'TR_OBJECT_CHECK'
      EXPORTING
        wi_ko200 = ko200.

    me->s_ko200 = ko200.
  ENDMETHOD.

  METHOD zif_trs_fm_access~insert_key.

    CLEAR t_e071k.

    APPEND i_e071k TO t_e071k.

    CALL FUNCTION 'TR_OBJECT_INSERT'
      EXPORTING
        wi_order                = me->task    " vorgeschlagener Auftrag (Prio vor Auftragssuche)
        wi_ko200                = s_ko200    " Eingabe editiertes Objekt
      TABLES
        wt_e071k                = t_e071k    " Eingabetabelle editierter Objekt-keys
      EXCEPTIONS
        cancel_edit_other_error = 1
        show_only_other_error   = 2
        OTHERS                  = 3.

    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDMETHOD.



ENDCLASS.
