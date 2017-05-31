*** Settings ***
Resource                 client_operations.robot
*** Settings ***
Library                                        HttpLibrary.HTTP
Library                                        String
Library                                        Collections

***Variables***
${host}            localhost:8080
${scheme}          http

#Endpoints
${get_all_users_endpoint}            /hotel-rest/webresources/user
${post_create_new_user_endpoint}          /hotel-rest/webresources/user
${get_user_counter_endpoint}              /hotel-rest/webresources/user/count
${get_user_by_id_endpoint}                /hotel-rest/webresources/user/
${delete_user_endpoint}                   /hotel-rest/webresources/user/
${put_user_endpoint}                      /hotel-rest/webresources/user/

${status_name}                            ACTIVE
***Keywords***
Create User Data
    ${id}               set Variable                  200
    ${login}            Generate Random String        5        [LOWER]    
    ${password}         Generate Random String        20       [NUMBERS]
    ${typeUser}         Generate Random String       1   12
    ${userStatusId}     Generate Random String       1   12
    
    ${client_id}=        Get The ID of The Last Client
    ${name}=	                   Generate Random String    5                            [LOWER]
    ${createDate}=	               Set Variable              15431609200000
    ${email}=	                   Catenate   SEPARATOR=     ${name}@gmail.com"
    ${gender}=	                   Generate Random String    1                             MF
    ${socialSecurityNumber}=	   Generate Random String    9                             [NUMBERS]
    
    ${status_id}           Generate Random String    1        10
    ${code}                Generate Random String    1        10
    
    ${dictionary1}=        Create Dictionary        id=${clientId}   name=${name}    createDate= ${createDate}   email=${email}    gender=${gender}    socialSecurityNumber=${socialSecurityNumber}
    ${dictionary2}=        Create Dictionary        id=${status_id}    code=${code}  name=${status_name}
    ${dictionary}=        Create Dictionary        id=${id}   login=${login}    password=${password}   typeUser=${typeUser}   clientId=${dictionary1}  userStatusId=${dictionary2}
    ${client_json}        Stringify JSON                  ${dictionary}
    Log to Console        ${client_json}
    [return]              ${client_json}
    
    

    
 Modify Json data For a User      [Arguments]               ${last_id} 
    ${id}=	                       Set Variable              ${last_id}
    ${login}            Generate Random String        5        [LOWER]    
    ${password}         Generate Random String        20       [NUMBERS]
    ${typeUser}         Generate Random String       1   10
    ${userStatusId}     Generate Random String       1   10
    
    ${client_id}=        Get The ID of The Last Client
    ${name}=	                   Generate Random String    5                            [LOWER]
    ${createDate}=	               Set Variable              15431609200000
    ${email}=	                   Catenate   SEPARATOR=     ${name}@gmail.com"
    ${gender}=	                   Generate Random String    1                             MF
    ${socialSecurityNumber}=	   Generate Random String    9                             [NUMBERS]
    
    ${status_id}           Generate Random String    1        10
    ${code}                Generate Random String    1        10
    
    ${dictionary1}=        Create Dictionary        id=${clientId}   name=${name}    createDate= ${createDate}   email=${email}    gender=${gender}    socialSecurityNumber=${socialSecurityNumber}
    ${dictionary2}=        Create Dictionary        id=${status_id}    code=${code}  name=${status_name}
    ${dictionary}=        Create Dictionary        id=${id}   login=${login}    password=${password}   typeUser=${typeUser}   clientId=${dictionary1}  userStatusId=${dictionary2}
    ${client_json}        Stringify JSON                  ${dictionary}
    Log to Console        ${client_json}
    [return]              ${client_json}
    
    
Create New User
    ${request_body}=               Create User Data
    Create Http Context            ${host}        ${scheme}
    Set Request Header             Content-Type        application/json
    Set Request Header             Accept              */*
    Set Request Body               ${request_body} 
    
    Post                           ${post_create_new_user_endpoint} 
    ${status_code}                 Get Response Status
    Should contain        ${status_code}        204
    
Get All Users   
    Create Http Context            ${host}        ${scheme}
    Get                            ${get_all_users_endpoint} 
    ${body}                        Get Response Body
    Log To Console                 ${body}
    ${status_code}                 Get Response Status  
    Should Contain                 ${status_code}        200
    
Get Total Numbers of Users
    Create Http Context                        ${host}      ${schema}
    Get                                        ${get_user_counter_endpoint}
    ${response_status}=                        Get Response Status
    ${response_body}=                          Get Response Body    
    Log To Console                             ${response_body}
    Should Contain          	               ${response_status}          200
    
Get The ID of Last User
    Create Http Context                        ${host}      ${schema}
    
    #Get all clients - First request
    Get                                        ${get_all_users_endpoint}    
    ${response_status_first_request}=          Get Response Status
    Should Contain                             ${response_status_first_request}     200
    ${body_first_request}=                     Get Response Body
    #Log to Console                             ${body_first_request}
    
    # Get client Counter - Second request
    Get                                        ${get_user_counter_endpoint}
    ${response_status_second_request}=         Get Response Status
    Should Contain                             ${response_status_second_request}          200
    ${body_second_request}=                    Get Response Body
    #Log to Console                             ${body_second_request}
    ${last_index}=                             Evaluate      ${body_second_request}-1
    #Log to Console                             ${last_index}
    ${json_id}=                                Get Json Value        ${body_first_request}         /${last_index}/id        
    Log to Console                             ${json_id}         
    [Return]                                   ${json_id}
    
Get User By ID        
    ${id}=     Get The ID of The Last User
       
    Create Http Context                        ${host}      ${schema}
    Get                                        ${get_user_by_id_endpoint}${id}
    ${response_status}=                        Get Response Status
    ${response_body}=                          Get Response Body
    Log To Console                             ${response_status}      
    Log To Console                             ${response_body}
    Should Contain          	               ${response_status}          200
    
Delete User By ID
      ${id}=                                     Get The ID of The Last User
    Create Http Context                        ${host}                    ${schema}
    Delete                                     ${delete_user_endpoint}${id}
    ${status_code}=                            Get Response Status
    ${body}=                                   Get Response Body
    #Log to Console                             ${body}
    #Log to Console                             ${status_code} 
    Should Contain                             ${status_code}             204 
    
Modify Last User
    ${id}=                                     Get The ID of The Last User
    ${request_body}=                           Modify Json data For a User         ${id}
    
    Create Http Context                        ${host}            ${schema}
    Set Request Header                         Content-Type             application/json
    Set Request Header                         Accept                    */*
    Set Request Body                           ${request_body}
    Put                                        ${put_user_endpoint}${id} 
    ${request_body}=                           Get Response Status                  
    Log to Console                             ${request_body}
    Should Contain                             ${request_body}             204
    