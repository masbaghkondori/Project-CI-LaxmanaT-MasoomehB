*** Settings ***
Resource                                        bedroom_form_page_and_keywords.robot


*** Variables ***
${bedroom_element_left_menu}                     xpath=//*[@id="side-menu"]/li[3]/a
${bedroom_list_pg_label_on_page}                List
${bedroom_list_pg_button_create_bedroom}        xpath=//*[@id="j_idt50"]/a[1]
${bedroom_list_pg_button_index}                 xpath=//*[@id="j_idt50"]/a[2]
${bedroom_pg_edit_button}                       xpath= //*[@id="j_idt49"]/table/tbody/tr[3]/td[8]/a[2]
${bedroom_pg_price_field}                       xpath=//*[@id="priceDaily"]   
${bedroom_pg_price_input}                       270.o 
${bedroom_pg_status_field}                      xpath=//*[@id="bedroomStatusId"]
${bedroom_pg_status_submenue}                   xpath=//*[@id="bedroomStatusId"]
${bedroom_pg_status_option}                     xpath=//*[@class='form-control']//*[text()='BUSY']
${bedroom_number}                               200 
${bedroom_panel_in_center}                      xpath=//*[@id="messagePanel"]
 ${bedroom_panel_element}                        xpath=//*[@id="page-wrapper"]/div/div/div/div/div[2]/div/a/div/span[1] 


#${bedroom_list_pg_button_edit_bedroom}          xpath=//td[text()=${bedroom_number}]/following-sibling::td/a[text()=${bill_button_delete}]
                                                
#${bedroom_list_pg_button_delete_bedroom}          xpath=//td[text()=${reservation_code}]/following-sibling::td/a[text()=${bill_button_delete}]

# xpath=//*[@id="j_idt49"]/table/tbody/tr[6]/td[8]/a[2]
${bedroom_form_pg_edit_label_on_page}           Edit Bedroom
${bedroom_pg_element_on_the_edit_save}          xpath=//*[@id="j_idt50"]/a[1]
${bedroom_form_pg_edit_label_on_editpage}       Bedroom was successfully updated.
${bedroom_pg_new_price}                         110.00







*** keywords ***

navigate_to_bedroom_form
    Page should contain element                ${bedroom_element_left_menu}
    Click Element                              ${bedroom_element_left_menu}
    Wait until page contains                   ${bedroom_list_pg_label_on_page}
 
    
navigate_to_bedroom_panel_element
    Page should contain element              ${bedroom_panel_element}
    click element                              ${bedroom_panel_element}
    Wait until page contains                   ${bedroom_list_pg_label_on_page}  


    