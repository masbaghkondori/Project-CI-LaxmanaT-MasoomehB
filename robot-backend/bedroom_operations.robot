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
${get_all_bedrooms_endpoint}=         /hotel-rest/webresources/bedroom
${get_bedroom_endpoint}=              /hotel-rest/webresources/bedroom/            #the id should be included
${get_bedrooms_counter_endpoint}=     /hotel-rest/webresources/bedroom/count

#POST endpoint
${post_create_new_bedroom_endpoint}=    /hotel-rest/webresources/bedroom

#PUT endpoint
${put_edit_bedroom_endpoint}=         /hotel-rest/webresources/bedroom/          #the id should be included   

#DELETE endpoint
${delete_bedroom_endpoint}=            /hotel-rest/webresources/bedroom/          #the id should be included

*** Keywords ***

    
Create Bedroom Data 
    ${bedStatusId}=                  Set Variable                  2
    ${bedStatusCode}=                Set Variable                  1  
    ${bedStatusName}=                Set Variable                  VACANT
    
    ${bedTypeId}=                    Set Variable                  4
    ${bedTypeName}=                  Set Variable                  TOP BED TWIN
    
    ${id}=                           Set Variable                 200 
    ${description}=                  Generate Random String        15          [UPPER]
    Set Suite Variable            ${room_description_suite}                   ${description}       
    ${floor}=                     Generate Random String            1          [NUMBERS]
    ${number}=                    Generate Random String            4          123456789
    ${priceDaily} =             Generate Random String              2          [NUMBERS]
  
 
    ${bedStatusDict}=         Create Dictionary     id=${bedStatusId}    code=${bedStatusCode}    name=${bedStatusName}
    ${typeIdDict}=             Create Dictionary     id=${bedTypeId}    name=${bedTypeName}
    ${dictionary}=                Create Dictionary     id=${id}    description=${description}    floor=${floor}    number=${number}    priceDaily=${priceDaily}    bedroomStatusId=${bedStatusDict}   typeBedroomId=${typeIdDict}
    ${bedroom_json}=               Stringify Json        ${dictionary}
    Log to Console                 ${bedroom_json}
    [Return]                       ${bedroom_json}             

    
 Create A New bedroom
    ${request_body}=           Create Bedroom Data
    Create Http Context        ${http_context}                  ${http_variable}
    Set Request Header         Content-Type                     ${header_content_json}
    Set Request Header         Accept                           ${header_accept_all}        
    Set Request Body           ${request_body}        
    POST                       ${post_create_new_bedroom_endpoint}
    ${status_code}=            Get Response Status
    Log to Console             ${status_code}
    Should contain             ${status_code}	                 ${status_code_No_Content} 
    # Check that last created bedroom contains the correct description
    ${newBedroom}=             Get Last Created Bedroom
    Should contain             ${newBedroom}                     ${room_description_suite}   
    
 
Delete A Bedroom   
   # Create A New bedroom
    ${id_to_delete}=                 Get ID Of The Last Bedroom       
    #log to console                   ${id_to_delete} 
    Create Http Context              ${http_context}     ${http_variable}    
    Set Request Header               Content-Type        ${header_content_json}
    Set Request Header               Accept              ${header_accept_all} 
    Log to console                   ${\n}Deleting a bedroom${\n}ID:${id_to_delete}
    HttpLibrary.HTTP.DELETE          ${delete_a_bedroom_endpoint}${id_to_delete}
    ${response_status}=              Get response Status   
    log to console                   ${\n}Status code:${response_status}   
    Should contain                   ${response_status}	                      204
    
           
Get ID Of The Last Bedroom     
  Create Http Context                        ${http_context}      ${http_variable}
    Set Request Header               Content-Type        ${header_content_json}
    Set Request Header               Accept              ${header_accept_all}  
      HttpLibrary.HTTP.GET                                     ${get_all_bedrooms_endpoint}    
    ${responseStatus}=          Get Response Status
    Should Contain                             ${responseStatus}     200
    ${bodyRequest}=                     Get Response Body
    # Get number of bedrooms
    ${number_of_bedrooms}=                     Get Total Number of Bedrooms
    ${last_index}=                             Evaluate              ${number_of_bedrooms}-1
    ${json_id}=                                Get Json Value        ${bodyRequest}         /${last_index}/id        
    Log to Console                             ${json_id}         
    [Return]                                   ${json_id}
    

 
 
Get Last Created Bedroom        
    ${bedroomId}=                    Get ID Of The Last Bedroom
    ${get_bedroom_endpoint}=         Catenate       SEPARATOR=       ${get_bedroom_endpoint}        ${bedroomId}
    GET                              ${get_bedroom_endpoint}
    ${status_code}=                  Get Response Status
    ${bedroom_body}=                 Get Response Body
    Log to Console                   ${status_code}
    Log to Console                   ${bedroom_body}
    Should contain                   ${status_code}	                      ${status_code_OK} 
    Set Suite Variable               ${bedroom_body_suite}                   ${bedroom_body}
    [Return]                         ${bedroom_body}



Get Total Number of Bedrooms
    Create Http Context                ${http_context}                      ${http_variable}
    GET                                ${get_bedrooms_counter_endpoint}
    ${status_code}=                    Get Response Status
    ${response_body}=                  Get Response Body
    Log to Console                     ${status_code}
    Log to Console                     ${response_body}
    Should contain                     ${status_code}	                      ${status_code_OK} 
    [Return]                           ${response_body}

Get All Bedrooms 
    Create Http Context            ${http_context}       ${http_variable}
    Set Request Header               Content-Type        ${header_content_json}
    Set Request Header               Accept              ${header_accept_all}  
    HttpLibrary.HTTP.GET                                 ${get_all_bedrooms_endpoint}    
    ${status_code}=                Get Response Status
    ${response_body}=              Get Response Body
    Log to Console                 ${status_code}
    Log to Console                 ${response_body}
    Should contain                 ${status_code}	                      ${status_code_OK} 
       

    
Edit Bedroom Data 
    Create A New bedroom 
    ${id_to_delete}=                 Get ID Of The Last Bedroom     
    ${request_body} =               Create Bedroom Data 
    Create Http Context              ${http_context}     ${http_variable}    
    Set Request Header               Content-Type        ${header_content_json}
    Set Request Header               Accept              ${header_accept_all} 
    Set request body                 ${request_body}
        
    Log to console                   ${\n}Editing a bedroom${\n}DATA:${request_body}
    
    HttpLibrary.HTTP.PUT           ${put_edit_bedroom_endpoint}${id_to_delete}
    ${response_status}=              Get response Status   
    log to console                   ${\n}Status code:${response_status}   
    Should contain                   ${response_status}	                      204
    
    
Get The Total Of Bedrooms                       
    Create Http Context              ${http_context}     ${http_variable}     
    Set Request Header               Content-Type        ${header_content_json}
    Set Request Header               Accept              ${header_accept_all}
    HttpLibrary.HTTP.GET             ${get_bedrooms_counter_endpoint}    
    ${response_status}=              Get response Status
    ${total_bedrooms}=                Get response body      
    log to console                   ${\n}Getting the total of bedrooms:${total_bedrooms}
    log to console                   ${\n}Status code:${response_status}   
    Should contain                   ${response_status}	                      200 
    #log to console                   ${total_bedrooms}
    [Return]                         ${total_bedrooms}   
    
    
    
    
           