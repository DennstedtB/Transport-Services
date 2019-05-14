*"* use this source file for your ABAP unit test classes
CLASS ltc_trs_workbench DEFINITION FOR TESTING
                            DURATION SHORT
                            RISK LEVEL HARMLESS.

  PUBLIC SECTION.

    METHODS: not_empty_order FOR TESTING.
    METHODS: not_empty_task FOR TESTING.

  PRIVATE SECTION.


    METHODS: setup.
    METHODS: teardown.

    DATA: cut TYPE REF TO zcl_trs_request.


ENDCLASS.

CLASS ltc_trs_workbench IMPLEMENTATION.

  METHOD setup.
    cut = zcl_trs_tr_factory=>get_workbench_request( ).
  ENDMETHOD.

  METHOD teardown.
    CLEAR cut.
  ENDMETHOD.

  METHOD not_empty_order.
    DATA(order) = cut->get_order( ).

    cl_abap_unit_assert=>assert_not_initial( order ).
  ENDMETHOD.

  METHOD not_empty_task.
    DATA(task) = cut->get_task( ).

    cl_abap_unit_assert=>assert_not_initial( task ).
  ENDMETHOD.

ENDCLASS.
