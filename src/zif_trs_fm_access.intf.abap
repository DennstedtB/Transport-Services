INTERFACE zif_trs_fm_access
  PUBLIC .

  METHODS:
    get_request IMPORTING i_order_type TYPE trfunction
                          i_task_type  TYPE trfunction
                          i_category   TYPE trcateg
                EXPORTING e_order      TYPE e071-trkorr
                          e_task       TYPE e071-trkorr,

    "! this method adds a key to the transport request <br>
    "! The method "check_transport" needs to get called before this method gets called
    insert_key IMPORTING i_e071k TYPE e071k,

    "! this method needs to get called before the insert_key method
    check_transport IMPORTING ko200 TYPE ko200.

  " delete_key importing e071 type e071
  " task type trkorr optional.

ENDINTERFACE.
