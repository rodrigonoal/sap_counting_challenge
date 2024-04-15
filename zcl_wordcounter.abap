CLASS zcl_wordcounter DEFINITION
PUBLIC
  FINAL
  CREATE PUBLIC.
  PUBLIC SECTION.
      INTERFACES if_oo_adt_classrun .
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_wordcounter IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: my_string TYPE string VALUE 'ABAP4BTP is amazing '.
    DATA: lv_length   TYPE i,
          lv_offset   TYPE i,
          lv_char     TYPE c,
          word_count  TYPE i.

    lv_length = strlen( my_string ).
    word_count = 0. " Initialize word count

    DO lv_length TIMES.
      lv_char = my_string+lv_offset(1).
      out->write( lv_char ).
      IF lv_char = ' '. " Check if the character is a space
        word_count = word_count + 1. " Increment word count
      ENDIF.
      lv_offset = lv_offset + 1.
    ENDDO.

    " Print the word count at the end
    out->write( |Word count: { word_count }| ).
  ENDMETHOD.
ENDCLASS.