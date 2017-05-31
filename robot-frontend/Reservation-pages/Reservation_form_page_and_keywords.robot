*** Settings ***
Resource                                               Reservation_list_page_and_keywords.robot

*** variables ***
${reservation_form_pg_delete_button}                   xpath=//*[@id="j_idt50"]/table/tbody/tr[4]/td[8]/a[3]
${reservation_form_pg_delete_success_message}          HotelReservation was successfully deleted.




*** keywords ***
    
 Delete_an_existing_reservation
    navigate_to_reservation_form 
    Click element                                      ${reservation_form_pg_delete_button}
    Wait Until Page Contains                           ${reservation_form_pg_delete_success_message}  


   