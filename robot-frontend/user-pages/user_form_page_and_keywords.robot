*** Settings ***
Resource                                       user_list_page_and_keywords.robot

*** variables ***
${user_form_pg_delete_button}                   xpath=//*[@id="j_idt50"]/table/tbody/tr[5]/td[7]/a[3]
${user_form_pg_delete_success_message}          User was successfully deleted.
${user_form_pg_create_button}                   xpath=//*[@id="j_idt50"]/a[1]
${user_form_pg_type_of_user_field}              xpath=//*[@id="typeUser"]   
${user_form_pg_type_of_user_input}              xpath=//*[@id="typeUser"]/option[2]
${user_form_pg_login_field_input}               Yuri
${user_form_pg_login_field}                     xpath=//*[@id="login"]
${user_form_pg_password_field}                  xpath=//*[@id="password"] 
${user_form_pg_password_input}                  e46c0d2084e477027b58a339f8ffe8eb0e470d84
${user_form_pg_rePassword_field}                xpath=//*[@id="retypingPassword"]
${user_form_pg_client_field}                    xpath=//*[@id="clientId"]
${user_form_pg_client_input}                    xpath= //*[@id="clientId"]/option[5]  
${user_form_pg_status-field}                    xpath=//*[@id="userStatusId"]/option[2]
${user_create_form_pg_button_save}              xpath=//*[@id="j_idt51"]/a[1]
${user_form_pg_create_success_message}          User was successfully created.
${user_form_pg_status-input}                    xpath=//*[@id="userStatusId"]/option[2]
${user_form_pg_label_on_create_page}            Create New User


${user_form_pg_label_on_pageShow}                    List
${userom_form_pg_user_created_message}            user was successfully created.                   x 
${user_create_form_pg_button_show_user}           xpath=//a[text()='Show All users']
${user_create_form_pg_button_index}                  xpath=//*[@id="j_idt50"]/a[3]
${user_create_form_pg_textfield_description}        xpath=//*[@id="description"] 
${user_create_form_pg_textfield_floor}               id=floor
${user_create_form_pg_textfield_number}              id=number
${user_create_form_pg_textfield_priceDaily}          id=priceDaily
${user_create_form_pg_user_status_dropdn}         id=userStatusId
${user_create_form_pg_user_status_dropdn_vacant}  xpath=//*[@id="userStatusId"]/option[2]
${user_create_form_pg_user_userType_dropdn}    id=typeuserId
${user_create_form_pg_user_userType_dropdn_king}  xpath= //*[@id="typeuserId"]/option[2]
${user_description}                                  20kvm with river view 


*** keywords ***
    
 Delete_an_existing_common_user
    navigate_to_user_form 
    Click element                                      ${user_form_pg_delete_button}
    Wait Until Page Contains                           ${user_form_pg_delete_success_message}  

 Create_a_new_common_user 
    navigate_to_user_form
    click Element                           ${user_form_pg_create_button}
    Wait until page contains                ${user_form_pg_label_on_create_page}
    click Element                           ${user_form_pg_type_of_user_field}
    click Element                           ${user_form_pg_type_of_user_input} 
    input text                              ${user_form_pg_login_field}                    ${user_form_pg_login_field_input}              
    input text                              ${user_form_pg_password_field}                 ${user_form_pg_password_input} 
    input text                              ${user_form_pg_rePassword_field}               ${user_form_pg_password_input}
    click Element                           ${user_form_pg_rePassword_field}   
    click Element                           ${user_form_pg_client_field} 
    click Element                           ${user_form_pg_client_input} 
    click Element                           ${user_form_pg_status-field} 
    click Element                           ${user_form_pg_status-input} 
    click Element                           ${user_create_form_pg_button_save}
    Wait Until Page Contains                ${user_form_pg_create_success_message} 
    
    
    
    
     
    
    

    
   