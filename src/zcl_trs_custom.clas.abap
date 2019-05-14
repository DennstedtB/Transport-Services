CLASS zcl_trs_custom DEFINITION
  PUBLIC
  INHERITING FROM zcl_trs_request
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      constructor IMPORTING tabl_nam TYPE trobj_name.

    " redefinition of abstract public methods
    METHODS:
      add_object_key REDEFINITION,
      delete_object_key REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA table TYPE trobj_name.



ENDCLASS.



CLASS zcl_trs_custom IMPLEMENTATION.

  METHOD constructor.

    super->constructor( ).
    table = tabl_nam.

    TRANSLATE table TO UPPER CASE.

    order_type = 'W'.
    task_type = 'Q'.
    category = 'CUST'.

    ko200-trkorr = space.
    ko200-as4pos = 0.
    ko200-pgmid = 'R3TR'.
    ko200-object = 'TABU'.
    ko200-obj_name = table.
    ko200-objfunc = 'K'.

  ENDMETHOD.

  METHOD add_object_key.
    DATA: s_e071k  TYPE e071k,
          lt_e071k TYPE TABLE OF e071k.

    s_e071k-trkorr = s_e071k-viewname = s_e071k-objfunc = space.
    s_e071k-pgmid = 'R3TR'.
    s_e071k-object = s_e071k-mastertype = 'TABU'.
    s_e071k-objname = s_e071k-mastername = object.
    s_e071k-as4pos = 0.
    s_e071k-objfunc = 'K'.
    s_e071k-tabkey = key.

    APPEND s_e071k TO lt_e071k.

    CALL FUNCTION 'TR_OBJECT_INSERT'
      EXPORTING
        wi_order                = task    " vorgeschlagener Auftrag (Prio vor Auftragssuche)
        wi_ko200                = ko200    " Eingabe editiertes Objekt
      TABLES
        wt_e071k                = lt_e071k    " Eingabetabelle editierter Objekt-keys
      EXCEPTIONS
        cancel_edit_other_error = 1
        show_only_other_error   = 2
        OTHERS                  = 3.

    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDMETHOD.

  METHOD delete_object_key.

    DATA e071 TYPE e071.

    MOVE-CORRESPONDING ko200 TO e071.
    e071-trkorr = task.

    CALL FUNCTION 'TR_DELETE_COMM_OBJECT_KEYS'
      EXPORTING
        is_e071_delete = e071    " E071-Struktur mit dem zu löschenden Objekt
      CHANGING
        cs_request     = task.

    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
