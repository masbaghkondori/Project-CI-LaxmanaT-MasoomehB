*** Settings ***
Library                            HttpLibrary.HTTP 
Library                            String
Library                            Collections

*** Variables ***
${host}                            localhost:8080
${schema}                          http
${id}                              1

#Endpoints
${get_client_endpoint}             /hotel-rest/webresources/client/count
${get_all_clients_endpoint}        /hotel-rest/webresources/client
#To get the id as a parameter when we invoke request
${get_specific_client_endpoint}    /hotel-rest/webresources/client/ 
${get_from_to_client_endpoint}     /hotel-rest/webresources/client/{from}/{to}
#To get the id as a parameter when we invoke request
${post_client_by_id_endpoint}      /hotel-rest/webresources/client
#To get the id as a parameter when we invoke request
${delete_client_endpoint}          /hotel-rest/webresources/client/
#To get the id as a parameter when we invoke request
${put_client_endpoint}             /hotel-rest/webresources/client/

*** Keywords ***

Create Json data For a Client
    ${id}=	                       Set Variable              100
    ${name}=	                   Generate Random String    10                            [LOWER]
    ${createDate}=	               Set Variable              1451602800000
    ${email}=	                   Catenate   SEPARATOR=     ${name}@gmail.com"
    ${gender}=	                   Generate Random String    1                             MF
    ${socialSecurityNumber}=	   Generate Random String    9                             [NUMBERS]
    
    
    ${dictionary}=                 Create Dictionary         id=${id}        name=${name}     createDate=${createDate}        email=${email}   gender=${gender}    socialSecurityNumber=${socialSecurityNumber}
    ${client_json}=                Stringify Json            ${dictionary}
    [Return]                       ${client_json}
    
Modify Json data For a Client      [Arguments]               ${last_id} 
    ${id}=	                       Set Variable              ${last_id}
    ${name}=	                   Generate Random String    10                            [LOWER]
    ${createDate}=	               Set Variable              1451602800000
    ${email}=	                   Catenate   SEPARATOR=     ${name}@gmail.com"
    ${gender}=	                   Generate Random String    1                             MF
    ${socialSecurityNumber}=	   Generate Random String    9                             [NUMBERS]
    
    
    ${dictionary}=                 Create Dictionary         id=${id}        name=${name}     createDate=${createDate}        email=${email}   gender=${gender}    socialSecurityNumber=${socialSecurityNumber}
    ${client_json}=                Stringify Json            ${dictionary}
    [Return]                       ${client_json}

Get The ID of The Last Client
    Create Http Context                        ${host}      ${schema}
    
    #Get all clients - First request
    Get                                        ${get_all_clients_endpoint}    
    ${response_status_first_request}=          Get Response Status
    Should Contain                             ${response_status_first_request}     200
    ${body_first_request}=                     Get Response Body
    #Log to Console                             ${body_first_request}
    
    # Get client Counter - Second request
    Get                                        ${get_client_endpoint}
    ${response_status_second_request}=         Get Response Status
    Should Contain                             ${response_status_second_request}          200
    ${body_second_request}=                    Get Response Body
    #Log to Console                             ${body_second_request}
    ${last_index}=                             Evaluate      ${body_second_request}-1
    #Log to Console                             ${last_index}
    ${json_id}=                                Get Json Value        ${body_first_request}         /${last_index}/id        
    #Log to Console                             ${json_id}         
    [Return]                                   ${json_id}

Get Random ID of Client
    Create Http Context                        ${host}      ${schema}
    
    #Get all clients - First request
    Get                                        ${get_all_clients_endpoint}    
    ${response_status_first_request}=          Get Response Status
    Should Contain                             ${response_status_first_request}     200
    ${body_first_request}=                     Get Response Body
    Log to Console                             ${body_first_request}
    
    # Get client Counter - Second request
    Get                                        ${get_client_counter_endpoint}
    ${response_status_second_request}=         Get Response Status
    Should Contain                             ${response_status_second_request}          200
    ${body_second_request}=                    Get Response Body
    Log to Console                             ${body_second_request}
   # ${last_index}=                             Evaluate      ${body_second_request}-1
    #Log to Console                             ${last_index}
    #${json_id}=                                Get Json Value        ${body_first_request}         /${last_index}/id        
    #Log to Console                             ${json_id}         
    #[Return]                                   ${json_id}

Create New Client
    ${request_body}=                           Create Json data For a Client
    
    Create Http Context                        ${host}            ${schema}
    Set Request Header                         Content-Type             application/json
    Set Request Header                         Accept                    */*
    Set Request Body                           ${request_body}
    Post                                       ${post_client_by_id_endpoint} 
    ${request_body}=                           Get Response Status                  
    Log to Console                             ${request_body}
    #Log to Console                             ${\n}${data}
    Should Contain                             ${request_body}             204
    
    
Get Total Number of Clients
    Create Http Context                        ${host}                    ${schema}
    Get                                        ${get_client_counter_endpoint}
    ${status_code}=                            Get Response Status
    ${body}=                                   Get Response Body
    Log to Console                             ${body}
    Log to Console                             ${status_code} 
    Should Contain                             ${status_code}             200
       
    
Get All Clients
    Create Http Context                        ${host}                    ${schema}
    Get                                        ${get_all_clients_endpoint}
    ${status_code}=                            Get Response Status
    ${body}=                                   Get Response Body
    Log to Console                             ${body}
    Log to Console                             ${status_code} 
    Should Contain                             ${status_code}             200
    
    
    
Get Specific Client
    ${id}=                                     Get The ID of The Last Client     
    Create Http Context                        ${host}                    ${schema}
    Get                                        ${get_Specific_client_endpoint}${id}
    ${status_code}=                            Get Response Status
    ${body}=                                   Get Response Body
    #Log to Console                             ${body}
    #Log to Console                             ${status_code} 
    Should Contain                             ${status_code}             200
    
Modify Last Client
    ${id}=                                     Get The ID of The Last Client
    ${request_body}=                           Modify Json data For a Client         ${id}
    
    Create Http Context                        ${host}            ${schema}
    Set Request Header                         Content-Type             application/json
    Set Request Header                         Accept                    */*
    Set Request Body                           ${request_body}
    Put                                        ${put_client_endpoint}${id} 
    ${request_body}=                           Get Response Status                  
    Log to Console                             ${request_body}
    #Log to Console                             ${\n}${data}
    Should Contain                             ${request_body}             204


Delete Last Client
    ${id}=                                     Get The ID of The Last Client
    Create Http Context                        ${host}                    ${schema}
    Delete                                     ${delete_client_endpoint}${id}
    ${status_code}=                            Get Response Status
    ${body}=                                   Get Response Body
    #Log to Console                             ${body}
    #Log to Console                             ${status_code} 
    Should Contain                             ${status_code}             204 