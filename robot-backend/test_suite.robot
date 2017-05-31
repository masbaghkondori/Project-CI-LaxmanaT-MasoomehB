#https://github.com/bul
kan/robotframework-requests 
#https://github.com/bulkan/robotframework-requests/blob/master/tests/testcase.txt
#http://stackoverflow.com/questions/35262216/json-handling-in-robot
#http://peritus.github.io/robotframework-httplibrary/HttpLibrary.html#POST
#http://peritus.github.io/robotframework-httplibrary/HttpLibrary.html


*** Settings ***
Library                        json
Library                       HttpLibrary.HTTP
Library                       String
Library                       Collections
#Resource                      environment.robot
Resource                      client_operations.robot
Resource                      bedroom_operations.robot
Resource                      reservation_operations.robot
Resource                      user_operations.robot





*** Test cases***
Test1-Create Bedroom  
    Create A New bedroom

Test2-Delete Bedroom
    Delete A Bedroom     

Test3-Get Bedroom
    Get Last Created Bedroom
      
Test4- Get All Bedrooms 
    Get All Bedrooms 
     
    
Test5-Edit Bedroom Data 
    Edit Bedroom Data  
  
Test6- get total of bedrooms
    Get The Total Of Bedrooms 
    
Test7- Create a new User
    Create A New User     


***comment***    


    



    
  
    
    
    
    
       



         

    




       
Test Delete a User
    Delete A user  
         
Test Edit a User 
    Edit a user  

Test View Bills
    Create A New User
       
Test Create a Bill
    Delete A user  
         
Test Delete a Bill 
    Edit a user  
         
Test View A Specific Reservation 
   Get A Specific Reservation  



   