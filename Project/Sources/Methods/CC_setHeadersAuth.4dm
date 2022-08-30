//%attributes = {}
//**************************************************************
//Method for setting headers (with an auth key) for a HTTP 
//request to the Currency Cloud platform
//
//Required Parameters:
//@HeaderNames (Pointer): Pointer to text array
//@HeaderValues (Pointer): Pointer to a text array
//@body (String): String containing the body of the request
//@authKey (String): Valid authentication key for currency cloud
//
//Output:
//HeaderNames and HeaderValues populated with required fields for
// a HTTP request 
//**************************************************************

C_POINTER:C301($1; $2)
C_TEXT:C284($3; $4; $body; $authKey)
ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)

ASSERT:C1129(Is nil pointer:C315($1)=False:C215)
ASSERT:C1129(Is nil pointer:C315($2)=False:C215)
$body:=$3
$authKey:=$4

APPEND TO ARRAY:C911($headerNames; "Content-Type")
APPEND TO ARRAY:C911($headerValues; "application/x-www-form-urlencoded")
APPEND TO ARRAY:C911($headerNames; "Content-Length")
APPEND TO ARRAY:C911($headerValues; String:C10(Length:C16($body)))
APPEND TO ARRAY:C911($headerNames; "X-Auth-Token")
APPEND TO ARRAY:C911($headerValues; $authKey)

COPY ARRAY:C226($headerNames; $1->)
COPY ARRAY:C226($headerValues; $2->)