*** Settings ***
Resource                                       ../credentials/environment_credentials.robot       
Resource                                       login_page_and_keywords.robot                  

*** Keywords ***
Setup
    Set Environment Variable                   ${chrome_webdriver_name}           ${chrome_webdriver_location}    
    Open Browser                               ${base_url}                        ${chrome_browser} 
    Maximize Browser Window  
    Set Selenium Speed                         .2
    Set Selenium Timeout                       20
    Delete All Cookies
    Wait Until Page Contains                   ${login_pg_login_label}    
    Location Should be                         ${base_url}   
    Title Should be                            ${login_pg_title}                         
   
Teardown    
    Close All Browsers 