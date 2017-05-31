*** Settings ***
Resource                                       user_form_page_and_keywords.robot


*** Variables **
${user_form_pg_label_on_page}                  List
${user_button_left_menu}                       xpath=//*[@id="side-menu"]/li[7]/a
#${bill_pg_label_element_on_page}               xpath=//*[@id="j_idt50"]/a[1]
#${bill_pg_reservation_code}                    xpath=//*[@id="j_idt49"]/table/tbody/tr[1]/td[3]
#${bill_pg_status_option}                       OPEN 
#${bill_pg_reservation_field}                   xpath=//*[@id="j_idt50:hotelReservationId"]
          






*** keywords ***  
  
 navigate_to_user_form
    Page should contain element               ${user_button_left_menu}
    Click element                             ${user_button_left_menu}
    Wait until page contains                  ${user_form_pg_label_on_page} 