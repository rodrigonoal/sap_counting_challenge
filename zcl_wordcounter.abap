
CLASS zcl_wordcounter DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_wordcounter IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: my_string   TYPE string VALUE 'ABАP4BTP is amazing ',
          lv_length   TYPE i,
          lv_offset   TYPE i,
          lv_char     TYPE c,
          lv_word     TYPE string,
          word_count  TYPE i,
          unique_count TYPE string,
          words       TYPE TABLE OF string,
          unique_chars TYPE TABLE OF c.

    lv_length = strlen( my_string ).

    DO lv_length TIMES.
      lv_char = my_string+lv_offset(1).
      IF lv_char = ' '. " Check if the character is a space
        IF lv_offset NE 1 AND unique_chars IS NOT INITIAL AND lv_word IS NOT INITIAL. " Skip consecutive spaces and empty words
          SORT unique_chars.
          DELETE ADJACENT DUPLICATES FROM unique_chars.
          unique_count = lines( unique_chars ).
          CONCATENATE 'Number of unique characters in the word' lv_word ':' unique_count INTO lv_word SEPARATED BY space.
          APPEND lv_word TO words.
        ENDIF.
        CLEAR unique_chars.
        CLEAR lv_word. " Clear the word variable for the next word
      ELSE.
        APPEND lv_char TO unique_chars. " Add the character to the unique characters table
        CONCATENATE lv_word lv_char INTO lv_word. " Add the character to the current word
      ENDIF.
      lv_offset = lv_offset + 1.
    ENDDO.

    " Count unique characters in the last word
    IF lv_word IS NOT INITIAL. " Check if the last word is not empty
      SORT unique_chars.
      DELETE ADJACENT DUPLICATES FROM unique_chars.
      unique_count = lines( unique_chars ).
      CONCATENATE 'Number of unique characters in the word' lv_word ':' unique_count INTO lv_word SEPARATED BY space.
      APPEND lv_word TO words.
    ENDIF.

    " Print the word count at the end
    word_count = lines( words ).
    out->write( |Number of words of this sentence: { word_count }| ).

    " Print each word and its unique character count
    LOOP AT words INTO lv_word.
      out->write( lv_word ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.