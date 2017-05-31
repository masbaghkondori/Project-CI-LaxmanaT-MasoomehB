
*** Settings ***
Resource                                       ./bill_list_page_and_keywords.robot

*** variables ***    
${reservation_code}                              7
${bill_button_delete}                           xpath=//*[@id="j_idt50"]/table/tbody/tr[3]/td[7]/a[3] 
${bill_pg_delete_button}                        xpath= //*[@id="j_idt50"]/table/tbody/tr[4]/td[7]/a[3]
${bill_form_pg_label_on_page}                   List
${bill_pg_create_button}                        xpath=//*[@id="j_idt50"]/a[1]
${bill_create_form_pg_button_save}              xpath=//*[@id="saveBtn"]
${bill_create_form_pg_button_show_bills}        xpath=//*[@id="j_idt51"]/a[4]  
${bill_create_form_pg_field_status}             id=billStatusId
${bill_create_form_pg_status_option}            xpath=//*[@id="billStatusId"]/option[2]
${bill_create_form_pg_field_ Reservation}       id=hotelReservationId
${bill_create_form_pg_ Reservation_option}      xpath=//*[@id="hotelReservationId"]/option[4]
${bill_form_pg_bill_created_message}            Bill was successfully created. 
${bill_view_pg_label_on_page}                   List
${bill_create_label_on_page}                    Create New Bill



*** keywords ***  
  
 Create_new_pay_bill
    navigate_to_bills_form
    click Element                                 ${bill_pg_create_button}
    Wait until page contains                      ${bill_create_label_on_page}
    click Element                                 ${bill_create_form_pg_field_status}             
    click Element                                 ${bill_create_form_pg_status_option}
    click Element                                 ${bill_create_form_pg_field_ Reservation}            
    click Element                                 ${bill_create_form_pg_ Reservation_option}
    click element                                 ${bill_create_form_pg_button_save} 
    Wait until page contains                      ${bill_form_pg_bill_created_message}    
    click element                                 ${bill_create_form_pg_button_show_bills}
    Wait until page contains                   	  ${bill_view_pg_label_on_page}
    Page should contain                           ${reservation_code} 
    
 Delete_an_existing_bill 
    navigate_to_bills_form 
    Click element                                 ${bill_pg_delete_button}
    Wait Until Page Does Not Contain Element      ${bill_pg_delete_button}
    
    
 