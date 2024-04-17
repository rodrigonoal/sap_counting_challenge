
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
    DATA: my_string    TYPE string VALUE 'ABAP4BTP is amazing ',
          words        TYPE TABLE OF string,
          word_count   TYPE i,
          lv_word      TYPE string,
          lv_offset    TYPE i,
          lv_char      TYPE c,
          unique_count TYPE string,
          unique_chars TYPE TABLE OF c.

    CONDENSE my_string.

    IF strlen( my_string ) = 0.
      out->write( 'No sentence provided' ).
    ELSE.
      DO strlen( my_string ) TIMES.
        lv_char = my_string+lv_offset(1).

        IF lv_char = ' '.
          SORT unique_chars.
          DELETE ADJACENT DUPLICATES FROM unique_chars.
          unique_count = lines( unique_chars ).
          CONCATENATE 'Number of unique characters in the word' lv_word ':' unique_count INTO lv_word SEPARATED BY space.
          APPEND lv_word TO words.

          CLEAR unique_chars.
          CLEAR lv_word.
        ELSE.
          APPEND lv_char TO unique_chars.
        ENDIF.

        lv_offset = lv_offset + 1.
      ENDDO.


      SORT unique_chars.
      DELETE ADJACENT DUPLICATES FROM unique_chars.
      unique_count = lines( unique_chars ).
      CONCATENATE 'Number of unique characters in the word' lv_word ':' unique_count INTO lv_word SEPARATED BY space.
      APPEND lv_word TO words.

      " Print the word count
      word_count = lines( words ).
      out->write( |Number of words in this sentence: { word_count }| ).


      LOOP AT words INTO lv_word.
        out->write( lv_word ).
      ENDLOOP.
    ENDIF.
  ENDMETHOD.
ENDCLASS.