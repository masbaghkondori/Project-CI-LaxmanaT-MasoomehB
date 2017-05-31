*** Settings ***
Library                                        Selenium2Library
Library                                        OperatingSystem
Library                                        String
#Resource                                       ./pages-and-keywords/test_setup_and_teardown.robot
#Resource                                       ./pages-and-keywords/login_page_and_keywords.robot  
#                                       ./pages-and-keywords/dashboard_page_and_keywords.robot
#Resource                                       ./pages-and-keywords/client-pages/client_list_page_and_keywords.robot
#Resource                                       ./pages-and-keywords/client-pages/client_form_page_and_keywords.robot
Resource                                       ./bedroom-pages/bedroom_form_page_and_keywords.robot
Resource                                       ./bedroom-pages/bedroom_list_page_and_keywords.robot
Resource                                       ./user-pages/user_list_page_and_keywords.robot
Resource                                       ./user-pages/user_form_page_and_keywords.robot
Resource                                       ./Reservation-pages/Reservation_list_page_and_keywords.robot
Resource                                       ./Reservation-pages/Reservation_form_page_and_keywords.robot
Resource                                       ./bill-pages/bill_form_page_and_keywords.robot
Resource                                       ./bill-pages/bill_list_page_and_keywords.robot
Resource                                       ./login_page_and_keywords.robot
Resource                                       ./credentials/login_credentials.robot  
Resource                                       ./dashboard_page_and_keywords.robot

Test Setup                                     Setup
Test Teardown                                  Teardown                     

*** Keywords ***
Setup
    Set Environment Variable                   webdriver.chrome.driver                                     /usr/local/bin/chromedriver    
    Open Browser                               http://localhost:8080/hotel/faces/login/login.xhtml         browser=chrome  
    Maximize Browser Window  
    Set Selenium Speed                         .2
    Set Selenium Timeout                       30
    Delete All Cookies
    Wait Until Page Contains                   Login    
    Location Should be                         http://localhost:8080/hotel/faces/login/login.xhtml  
    Title Should be                            Hotel Accomodation - login page                        
   
Teardown    
    Close All Browsers 


*** Test Cases ***
Test1_create_a_new_bedroom_logging_in_as_admin_user
    perform_login_admin_user
   navigate_to_bedroom_form
    create_new_bedroom
    perform_logout_admin_user
  
 Test2_delete_bedroom_logging_in_as_admin_user 
     perform_login_admin_user
    navigate_to_bedroom_form 
    Delete_an_existing_bedroom
    perform_logout_admin_user
    
 Test3_bedroom_panel_menu_navigation_as_admin_user 
    perform_login_admin_user
    navigate_to_bedroom_panel_element
    perform_logout_admin_user

 
 Test4_create_bill_logging_in_as_admin_user 
   perform_login_admin_user
    navigate_to_bills_form
   Create_new_pay_bill 
   perform_logout_admin_user 
 
 
 
 Test5_delete_bill_logging_in_as_admin_user 
    perform_login_admin_user
    navigate_to_bills_form 
    Delete_an_existing_bill
    perform_logout_admin_user
    
Test6_bill_panel_menu_navigation_as_admin_user 
    perform_login_admin_user
    navigate_to_bill_panel_element
    perform_logout_admin_user
    
 Test7_delete_user_logging_in_as_admin_user     
    perform_login_admin_user
    navigate_to_user_form
   Delete_an_existing_common_user
   perform_logout_admin_user 
   


 Test8_create_user_logging_in_as_admin_user
    perform_login_admin_user
    navigate_to_user_form
    Create_a_new_common_user 
    perform_logout_admin_user     



 Test9_delete_reservation_logging_in_as_admin_user     
    perform_login_admin_user
    navigate_to_reservation_form
   Delete_an_existing_reservation
   perform_logout_admin_user 




                                            