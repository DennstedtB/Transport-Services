CLASS zcl_trs_workbench DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_trs_tr_factory.

  PUBLIC SECTION.

    INTERFACES: zif_trs_transport_request.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_trs_workbench IMPLEMENTATION.

  METHOD zif_trs_transport_request~add_key_to_request.

  ENDMETHOD.

  METHOD zif_trs_transport_request~delete_key_from_request.

  ENDMETHOD.

ENDCLASS.
