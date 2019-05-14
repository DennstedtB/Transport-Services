INTERFACE zif_trs_transport_request
  PUBLIC .

  METHODS:
    add_key_to_request IMPORTING i_e071k TYPE e071k RAISING zcx_trs_no_key zcx_trs_wrong_object_type zcx_trs_no_object_type,
    delete_key_from_request IMPORTING e071 TYPE e071 RAISING zcx_trs_wrong_object_type.

ENDINTERFACE.
