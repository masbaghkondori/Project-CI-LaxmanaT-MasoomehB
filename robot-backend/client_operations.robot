#MAKING A REQUEST WITH CURL
#sudo apt install curl
# curl  http://rbt-course:8080/hotel-rest/webresources/client/6
# curl  http://rbt-course:8080/hotel-rest/webresources/client/
# curl  http://rbt-course:8080/hotel-rest/webresources/client/count
# curl -i -X PUT -H 'Content-Type: application/json' -d '{"id": "6", "name": "rafael_curl", "createDate": "1473633063279", "email": "rafael@email.com", "gender": "M", "socialSecurityNumber": "1234445"}' http://rbt-course:8080/hotel-rest/webresources/client/6
#https://tools.ietf.org/html/draft-pbryan-zyp-json-pointer-02

*** Settings ***
Library                              HttpLibrary.HTTP
Library                              Collections
Library                              String
Library                              json

*** variables ***

#Http context
${http_context}=                     localhost:8080
${http_variable}=                    http


#Headers

${header_content_json}               application/json
${header_accept_all}                 */*         

#GET endpoints
${get_all_clients_endpoint}=         /hotel-rest/webresources/client/
${get_clients_counter_endpoint}=     /hotel-rest/webresources/client/count

#POST endpoints
${create_a_client_endpoint}=         /hotel-rest/webresources/client/

#PUT endpoints
${edit_a_client_endpoint}=          /hotel-rest/webresources/client/   #the id should be included

#Delete endpoint
${delete_a_client_endpoint}=         /hotel-rest/webresources/client/   #the id should be included



*** keywords ***
Generate a random client
    ${id}=                           Set Variable                   100
    ${name}=                         Generate random String         10                  [LOWER]
    ${createDate}=                   Set Variable                   1473633063279
    ${email}=                        Catenate                       SEPARATOR=          ${name}        @email.com
    ${socialSecurityNumber}=         Generate Random String         9                   [NUMBERS]
    ${gender}=                       Generate Random String         1                   MF
    ${dictionary}=                   Create Dictionary  id=${id}    name=${name}  createDate=${createDate}   email=${email}   gender=${gender}   socialSecurityNumber=${socialSecurityNumber}
    ${client_json}=                  Stringify Json                 ${dictionary}
    [return]                         ${client_json}
    

## Method using the GET   /webresources/client/count
Get the total of clients                      
    Create Http Context              ${http_context}     ${http_variable}     
    Set Request Header               Content-Type        ${header_content_json}
    Set Request Header               Accept              ${header_accept_all}
    HttpLibrary.HTTP.GET             ${get_clients_counter_endpoint}    
    ${response_status}=              Get response Status
    ${total_clients}=                Get response body      
    log to console                   ${\n}Getting the total of clients:${total_clients}
    log to console                   ${\n}Status code:${response_status}   
    Should contain                   ${response_status}	                      200 
    #log to console                   ${total_clients}
    [Return]                         ${total_clients}             
    
        
Get id last client        
    Create Http Context              ${http_context}     ${http_variable}   
    Set Request Header               Content-Type        ${header_content_json}
    Set Request Header               Accept              ${header_accept_all}  
    HttpLibrary.HTTP.GET             ${get_all_clients_endpoint}
    ${response_status}=              Get response Status   
    log to console                   ${response_status}   
    Should contain                   ${response_status}	                      200    
    ${body}=                         Get Response Body    
    ${total_of_clients}=             Get the total of clients  
    ${last_index}=                   Evaluate    ${total_of_clients} - 1
    ${json_id}=                      Get Json Value             ${body}        /${last_index}/id
    #log to console  ${json_id}
    [return]                         ${json_id}



## Method using  POST  /webresources/client/count
Create a client    
    ${request_body} =                Generate a random client
    Create Http Context              ${http_context}     ${http_variable}    
    Set Request Header               Content-Type        ${header_content_json}
    Set Request Header               Accept              ${header_accept_all}        
    Set request body                 ${request_body}
        
    Log to console                   ${\n}Creating a new client${\n}DATA:${request_body}
    
    HttpLibrary.HTTP.POST            ${create_a_client_endpoint}
    ${response_status}=              Get response Status    
    log to console                   ${\n}Status code:${response_status}  
    Should contain                   ${response_status}	                      204  
    

Delete a client   
    Create a client    
    ${id_to_delete}=                 Get id last client       
    #log to console                   ${id_to_delete} 
    Create Http Context              ${http_context}     ${http_variable}    
    Set Request Header               Content-Type        ${header_content_json}
    Set Request Header               Accept              ${header_accept_all} 
    Log to console                   ${\n}Deleting a client${\n}ID:${id_to_delete}
    HttpLibrary.HTTP.DELETE          ${delete_a_client_endpoint}${id_to_delete}
    ${response_status}=              Get response Status   
    log to console                   ${\n}Status code:${response_status}   
    Should contain                   ${response_status}	                      204

Edit a client   
    Create a client     
    ${id_to_delete}=                 Get id last client       
    ${request_body} =                Generate a random client
    Create Http Context              ${http_context}     ${http_variable}    
    Set Request Header               Content-Type        ${header_content_json}
    Set Request Header               Accept              ${header_accept_all} 
    Set request body                 ${request_body}
        
    Log to console                   ${\n}Editing a client${\n}DATA:${request_body}
    
    HttpLibrary.HTTP.PUT             ${edit_a_client_endpoint}${id_to_delete}
    ${response_status}=              Get response Status   
    log to console                   ${\n}Status code:${response_status}   
    Should contain                   ${response_status}	                      204

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
*** comments ***    
Get all clients        
    Create Http Context              localhost:8080     http     
    Set Request Header               Content-Type    application/json
    Set Request Header               Accept    */*   
    HttpLibrary.HTTP.GET             /hotel-rest/webresources/client/
    ${response_status}=              Get response Status   
    log to console                   ${response_status}   
    Should contain                   ${response_status}	                      200
    ${body}=                         Get Response Body
    log to console   ${body}
    
    
Get a specific client by id          [Arguments]                              ${client_id}      
    Create Http Context              localhost:8080     http     
    Set Request Header               Content-Type    application/json
    Set Request Header               Accept    */*   
    HttpLibrary.HTTP.GET             /hotel-rest/webresources/client/${client_id}
    ${response_status}=              Get response Status   
    log to console                   ${response_status}   
    Should contain                   ${response_status}	                      200
      
Edit a client  
    ${dictionary}=                   Create Dictionary  id=6   name=rafael_new  createDate=1473633063279   email=rafael@email.com   gender=M   socialSecurityNumber=1234445  
    Create Http Context              localhost:8080     http     
    Set Request Header               Content-Type    application/json
    Set Request Header               Accept    */*   
    ${value}=    Stringify Json      ${dictionary}
    Set Request Body                 ${value}
    HttpLibrary.HTTP.PUT             /hotel-rest/webresources/client/6
    ${response_status}=              Get response Status   
    log to console                   ${response_status}   
    Should contain                   ${response_status}	                      204
   
Get the total of clients                      
    Create Http Context              localhost:8080     http     
    Set Request Header               Content-Type    application/json
    Set Request Header               Accept    */*   
    HttpLibrary.HTTP.GET             /hotel-rest/webresources/client/count
    ${response_status}=              Get response Status
    ${total_clients}=                Get response body      
    log to console                   ${response_status}   
    Should contain                   ${response_status}	                      200 
    [Return]                         ${total_clients}             
  
      

   

Delete a client                      [Arguments]                              ${client_id}   
    Create Http Context              localhost:8080     http     
    Set Request Header               Content-Type    application/json
    Set Request Header               Accept    */*   
    HttpLibrary.HTTP.DELETE          /hotel-rest/webresources/client/${client_id}
    ${response_status}=              Get response Status   
    log to console                   ${response_status}   
    Should contain                   ${response_status}	                      204
  
 Create a client                      
    ${dictionary}=                   Create Dictionary  id=102   name=namecreatetwo  createDate=1473633063279   email=namecreatetwo@email.com   gender=M   socialSecurityNumber=09882
    Create Http Context              localhost:8080     http     
    Set Request Header               Content-Type    application/json
    Set Request Header               Accept    */*   
    ${value}=    Stringify Json      ${dictionary}
    Set Request Body                 ${value}
    HttpLibrary.HTTP.POST            /hotel-rest/webresources/client/
    ${response_status}=              Get response Status    
    log to console                   ${response_status}   
    Should contain                   ${response_status}	                      204   

  
   
       