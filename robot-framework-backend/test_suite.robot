*** Settings ***
Resource                 ./operations/client_operations.robot
Resource                 ./operations/user_operations.robot

*** Test case ***

Test Case 1 :  Get All Clients
		Get  all clients 
    
Test case 2 :Get Specific Client
    Get Specific Clients
  
    
Test case 3: Delete Last Client
    Delete last Client
    
Test case 4: Modify Last Client
    Modify Last Client
    
Test case 5: Get All Users
    Get All Users
    
Test case 6 :Create New User
    Create New User
    
Test case 7:Get Total Of Users
    Get Total Of Users
    
Test case 8:Get The ID of The Last User
    Get The ID of The Last User
    
Test case 9 : Get User By ID 
    Get User By ID 

Test case 10: Delete User By ID
    Delete User By ID
    
    
    
