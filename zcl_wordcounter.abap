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
    DATA: my_string   TYPE string VALUE 'ABAP4BTP is amazing '.
    DATA: lv_length   TYPE i,
          lv_offset   TYPE i,
          lv_char     TYPE c,
          lv_word     TYPE string,
          word_count  TYPE i,
          words       TYPE TABLE OF string.

    lv_length = strlen( my_string ).
    word_count = 1. " Initialize word count with 1 for the last word

    DO lv_length TIMES.
      lv_char = my_string+lv_offset(1).
      IF lv_char = ' '. " Check if the character is a space
        APPEND lv_word TO words. " Add the word to the array
        CLEAR lv_word. " Clear the word variable for the next word
        word_count = word_count + 1. " Increment word count
      ELSE.
        CONCATENATE lv_word lv_char INTO lv_word. " Add the character to the current word
      ENDIF.
      lv_offset = lv_offset + 1.
    ENDDO.

    " Add the last word if it exists
    IF lv_word IS NOT INITIAL.
      APPEND lv_word TO words.
    ENDIF.

    " Print each word in the array
    LOOP AT words INTO lv_word.
      out->write( lv_word ).
      out->write( | | ). " Print a space between words
    ENDLOOP.

    " Print the word count at the end
    out->write( |Word count: { word_count }| ).
  ENDMETHOD.
ENDCLASS.