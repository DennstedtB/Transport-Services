CLASS ZCL_TRS_INJECT_REQUEST DEFINITION
  PUBLIC
  FOR TESTING
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    CLASS-METHODS:
      inject_workbench IMPORTING test_double TYPE REF TO zif_trs_transport_request,
      inject_customizing IMPORTING test_double TYPE REF TO zif_trs_transport_request.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TRS_INJECT_REQUEST IMPLEMENTATION.

  METHOD inject_workbench.
    zcl_trs_tr_factory=>workbench_request = test_double.
  ENDMETHOD.

  METHOD inject_customizing.
    zcl_trs_tr_factory=>custuomizing_request = test_double.
  ENDMETHOD.

ENDCLASS.
