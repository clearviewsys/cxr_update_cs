//%attributes = {}
// returns collection of cookies from the arrays received after call to HTTP Request command
// if $3 is passed only cookies defined in that collection are returned

C_COLLECTION:C1488($0; $found)
C_POINTER:C301($1; $headerNames_ptr)
C_POINTER:C301($2; $headerValues_ptr)
C_COLLECTION:C1488($3; $filter)  // names of the cookies to get, ignore others
C_OBJECT:C1216($cookie)
C_LONGINT:C283($i; $idx)

$headerNames_ptr:=$1  // pointer to array returned by HTTP Request command
$headerValues_ptr:=$2  // pointer to array returned by HTTP Request command
$0:=New collection:C1472

If (Count parameters:C259>2)
	$filter:=$3
End if 

For ($i; 1; Size of array:C274($headerNames_ptr->))
	
	If ($headerNames_ptr->{$i}="Set-Cookie")
		
		$cookie:=getCookie($headerValues_ptr->{$i})
		
		If ($cookie#Null:C1517)
			
			If ($filter#Null:C1517)
				
				$idx:=$filter.indexOf($cookie.cookie)
				
				If ($idx#-1)
					$0.push($cookie)
				End if 
				
			Else 
				
				$0.push($cookie)
				
			End if 
			
		End if 
		
	End if 
	
End for 

