

CLASS ycl_hello DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PRIVATE SECTION.
ENDCLASS.

CLASS ycl_hello IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: my_string   TYPE string VALUE 'ABAP4BTP is amazing ',
          lv_length   TYPE i,
          lv_offset   TYPE i,
          lv_char     TYPE c,
          lv_word     TYPE string,
          word_count  TYPE i,
          words       TYPE TABLE OF string,
          unique_chars TYPE TABLE OF c,
          unique_count TYPE i.

    lv_length = strlen( my_string ).
    word_count = 0. " Initialize word count

    DO lv_length TIMES.
      lv_char = my_string+lv_offset(1).
      IF lv_char = ' '. " Check if the character is a space
        " Count unique characters in the word
        SORT unique_chars.
        DELETE ADJACENT DUPLICATES FROM unique_chars.
        unique_count = lines( unique_chars ).
        APPEND unique_count TO words.
        CLEAR unique_chars.
        CLEAR lv_word. " Clear the word variable for the next word
        word_count = word_count + 1. " Increment word count
      ELSE.
        APPEND lv_char TO unique_chars. " Add the character to the unique characters table
        CONCATENATE lv_word lv_char INTO lv_word. " Add the character to the current word
      ENDIF.
      lv_offset = lv_offset + 1.
    ENDDO.

    " Count unique characters in the last word
    SORT unique_chars.
    DELETE ADJACENT DUPLICATES FROM unique_chars.
    unique_count = lines( unique_chars ).
    APPEND unique_count TO words.

    " Print each word and its unique character count
    LOOP AT words INTO unique_count.
      out->write( unique_count ).
      out->write( | | ).
    ENDLOOP.

    " Print the word count at the end
    out->write( |Word count: { word_count }| ).
  ENDMETHOD.
ENDCLASS.