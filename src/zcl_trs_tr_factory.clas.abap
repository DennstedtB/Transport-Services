CLASS zcl_trs_tr_factory DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_trs_inject_request.

  PUBLIC SECTION.

    CLASS-METHODS:
      get_workbench_request RETURNING VALUE(r_request) TYPE REF TO zif_trs_transport_request,
      get_customizing_request RETURNING VALUE(r_request) TYPE REF TO zif_trs_transport_request.

  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-DATA:
      workbench_request    TYPE REF TO zif_trs_transport_request,
      custuomizing_request TYPE REF TO zif_trs_transport_request.

ENDCLASS.



CLASS zcl_trs_tr_factory IMPLEMENTATION.


  METHOD get_customizing_request.

    IF custuomizing_request IS NOT BOUND.
      " create customizing request
      custuomizing_request = NEW zcl_trs_customizing( ).
    ENDIF.

    r_request = custuomizing_request.

  ENDMETHOD.


  METHOD get_workbench_request.

    IF workbench_request IS NOT BOUND.
      " create workbench request
      workbench_request = NEW zcl_trs_workbench( ).
    ENDIF.

    r_request = workbench_request.

  ENDMETHOD.
ENDCLASS.
