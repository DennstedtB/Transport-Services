CLASS zcl_trs_inject_facade DEFINITION FOR TESTING
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS:
      inject_fm_access IMPORTING i_test_double TYPE REF TO zif_trs_fm_access.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_trs_inject_facade IMPLEMENTATION.

  METHOD inject_fm_access.
    zcl_trs_factory_facade=>facade_fm_class = i_test_double.
  ENDMETHOD.

ENDCLASS.
