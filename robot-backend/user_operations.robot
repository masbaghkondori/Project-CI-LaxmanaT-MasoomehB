*** Settings ***

Library                              json
Library                              HttpLibrary.HTTP
Library                              String
Library                              Collections


*** Variables ***
#Http context
${http_context}=                     localhost:8080
${http_variable}=                    http

#Headers
${header_content_json}               application/json
${header_accept_all}                 */*         
${status_code_OK}=                    200
${status_code_No_Content}=            204

#GET endpoints
${get_all_userrooms_endpoint}=         /hotel-rest/webresources/user
${get_userroom_endpoint}=              /hotel-rest/webresources/user/            #the id should be included
${get_userrooms_counter_endpoint}=     /hotel-rest/webresources/user/count

#POST endpoint
${post_create_new_userroom_endpoint}=    /hotel-rest/webresources/user

#PUT endpoint
${put_update_userroom_endpoint}=         /hotel-rest/webresources/user/          #the id should be included   

#DELETE endpoint
${delete_userroom_endpoint}=            /hotel-rest/webresources/user/          #the id should be included

*** Keywords ***

  {
        "id": 13,
        "login": "Yanne",
        "password": "1966e694bad90686516f99cdf432800fdca39290",
        "typeUser": 2,
        "clientId": {
            "id": 5,
            "name": "YANNE",
            "createDate": 1473249124445,
            "email": "yanne_alencar@hotmail.com",
            "gender": "F",
            "socialSecurityNumber": "5374855"
        },
        "userStatusId": {
            "id": 1,
            "code": 1,
            "name": "ACTIVE"
        }   
Create User Data 
    ${userStatusId}=                  Set Variable                  2
    ${userStatusCode}=                Set Variable                  1  
    ${userStatusName}=                Set Variable                  ACTIVE
    
    ${userClientId}=                    Set Variable                  4
    ${userClientName}=                  Set Variable                  YANNE
    ${userCreateDate}=                Set Variable                 1473249124445
     ${email}=                        Catenate                       SEPARATOR=          ${userClientName}        @email.com
        ${gender}=                       Generate Random String         1                   MF
      ${socialSecurityNumber}=         Generate Random String         9                   [NUMBERS] 
      
    ${id}=                            Set Variable                  50
    ${login}=                          Set Variable                 Yanne
    ${password}=                    Set Variable                 1966e694bad90686516f99cdf432800fdca39290
    ${typeUser}=                    Set Variable                  2
    
   
  
    ${userStatusDict}=         Create Dictionary     id=${userStatusId}    code=${userStatusCode}    name=${userStatusName}
    ${userClientDict}=             Create Dictionary     id=${userClientId}    name=${userClientName}   createDate=${userCreateDate}  email= ${email}  gender= ${gender}  socialSecurityNumber=${socialSecurityNumber}
    ${dictionary}=                Create Dictionary     id=${id}    login=${login}    password=${password}    typeUser=${typeUser}   
    ${user_json}=               Stringify Json        ${dictionary}
    Log to Console                 ${user_json}
    [Return]                       ${user_json}             

    
 Create A New user
   ${request_body} =                Create User Data 
    Create Http Context              ${http_context}     ${http_variable}    
    Set Request Header               Content-Type        ${header_content_json}
    Set Request Header               Accept              ${header_accept_all}        
    Set request body                 ${request_body}
        
    Log to console                   ${\n}Creating a new user${\n}DATA:${request_body}
    
    HttpLibrary.HTTP.POST            ${post_create_new_userroom_endpoint}
    ${response_status}=              Get response Status    
    log to console                   ${\n}Status code:${response_status}  
    Should contain                   ${response_status}	                      204  
    
    
        ${request_body}=           Create User Data Active Common
    Create Http Context        ${http_context}                  ${http_variable}
    Set Request Header         Content-Type                     ${header_content_json}
    Set Request Header         Accept                           ${header_accept_all}        
    Set Request Body           ${request_body}        
    POST                       ${post_create_new_user_endpoint}
    ${status_code}=            Get Response Status
    Log to Console             ${status_code}
    Should contain             ${status_code}	                      ${status_code_No_Content} 
    # Assert that last created user contains the correct login
    ${newUser}=               Get Last Created User
    Should contain            ${newUser}                 ${user_login_suite}  
    
    
    
    
    
      