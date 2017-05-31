*** Settings ***
Resource                                       Reservation_form_page_and_keywords.robot


*** Variables **
${reservation_form_pg_label_on_page}                  List
${reservation_element_left_menu}                       xpath=//*[@id="side-menu"]/li[6]/a 

*** keywords ***  
  
 navigate_to_reservation_form
    Page should contain element               ${reservation_element_left_menu}
    Click element                             ${reservation_element_left_menu}
    Wait until page contains                  ${reservation_form_pg_label_on_page}
    
 
    