//%attributes = {}
//Method for Updating a client wih the RAL webserver
//Parameters (Required): ClientCode (string), ClientKey(string)
//Parameters (Optional): ClientKey(string), FirstName(string), LastName(string), isCompany(string (True or False)),
//            CompanyName(string), phone(string), city(string), province(string),
//            country(string), postalCode(string)
//To update a field towards the back of the parameter list, all the parameters leading up to it must be blank
//Will fill in any unused parameters for the actually REST call to updateClient

//Parameters
C_OBJECT:C1216($0)
C_TEXT:C284($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13)
C_TEXT:C284($clientCode; $clientKey; $newClientKey; $firstName; $isCompany; $lastName; $companyName; $phone; $address; $city; $province; $country; $postalCode)

Case of 
	: (Count parameters:C259=3)
		$0:=RAL2_executeUpdateClient($1; $2; $3; ""; ""; ""; ""; ""; ""; ""; ""; ""; "")
	: (Count parameters:C259=4)
		$0:=RAL2_executeUpdateClient($1; $2; $3; $4; ""; ""; ""; ""; ""; ""; ""; ""; "")
	: (Count parameters:C259=5)
		$0:=RAL2_executeUpdateClient($1; $2; $3; $4; $5; ""; ""; ""; ""; ""; ""; ""; "")
	: (Count parameters:C259=6)
		$0:=RAL2_executeUpdateClient($1; $2; $3; $4; $5; $6; ""; ""; ""; ""; ""; ""; "")
	: (Count parameters:C259=7)
		$0:=RAL2_executeUpdateClient($1; $2; $3; $4; $5; $6; $7; ""; ""; ""; ""; ""; "")
	: (Count parameters:C259=8)
		$0:=RAL2_executeUpdateClient($1; $2; $3; $4; $5; $6; $7; $8; ""; ""; ""; ""; "")
	: (Count parameters:C259=9)
		$0:=RAL2_executeUpdateClient($1; $2; $3; $4; $5; $6; $7; $8; $9; ""; ""; ""; "")
	: (Count parameters:C259=10)
		$0:=RAL2_executeUpdateClient($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; ""; ""; "")
	: (Count parameters:C259=11)
		$0:=RAL2_executeUpdateClient($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $11; ""; "")
	: (Count parameters:C259=12)
		$0:=RAL2_executeUpdateClient($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $12; "")
	: (Count parameters:C259=13)
		$0:=RAL2_executeUpdateClient($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 