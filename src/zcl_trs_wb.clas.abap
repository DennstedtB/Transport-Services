CLASS zcl_trs_wb DEFINITION
  PUBLIC
  INHERITING FROM zcl_trs_request
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      constructor.

    " redefinition of abstract public methods
    METHODS:
      add_object_key REDEFINITION,
      delete_object_key REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_trs_wb IMPLEMENTATION.

  METHOD constructor.

    super->constructor( ).

    order_type = 'K'.
    task_type = 'S'.
    category = 'SYST'.

  ENDMETHOD.

  METHOD add_object_key.

  ENDMETHOD.

  METHOD delete_object_key.

  ENDMETHOD.

ENDCLASS.
