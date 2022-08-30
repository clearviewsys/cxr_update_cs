//%attributes = {}
// Checks if reference number exists using MoneyGram SOAP API

//C_TEXT($1;$refNumber)
//C_OBJECT($2;$mgCredentials;$soapAPI_result)
//C_OBJECT($0;$parameters)

//$0:=New object
//$0.success:=False

//Case of 

//: (Count parameters=0)

//$0.erorr:="No refNumber to check"


//: (Count parameters=1)

//$0.erorr:="No credentials"

//Else 

//$refNumber:=$1
//$mgCredentials:=$2

//End case 

//If ($0.error=Null)

//$parameters:=New object("TransferNumber";$refNumber;"TransferSearchMode";0)

//$soapAPI_result:=mgSOAP_RunMethod ($mgCredentials;"GetTransfer";$parameters)

//If ($soapAPI_result.success)

//$0.success:=True
//$0.result:=$soapAPI_result.result

//Else 

//$0.error:="No results returned"
//$0.mgerror:=$soapAPI_result.mgerrormsg

//End if 

//End if 
