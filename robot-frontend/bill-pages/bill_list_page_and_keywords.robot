
*** Settings ***
Resource                                      ./bill_form_page_and_keywords.robot


*** Variables **

${bill_button_left_menu}                       xpath=//*[@id="side-menu"]/li[4]/a 
${bill_panel_element}                          xpath=//*[@id="page-wrapper"]/div/div/div/div/div[3]/div/a/div/span[1]
${bill_list_pg_label_on_page}                  List


*** keywords ***  
  
navigate_to_bills_form
    Page should contain element               ${bill_button_left_menu}
    Click element                             ${bill_button_left_menu}
    Wait until page contains                  ${bill_form_pg_label_on_page} 
    
   
navigate_to_bill_panel_element
    Page should contain element                ${bill_panel_element}
    click element                              ${bill_panel_element}
    Wait until page contains                   ${bill_list_pg_label_on_page} 