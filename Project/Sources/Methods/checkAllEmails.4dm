//%attributes = {}
//C_POINTER($1; $table)
//C_TEXT($2; $setName; $errorString)
//C_LONGINT($i; $setSize; $errorSize)
//ARRAY BOOLEAN($setArray; 0)
//C_BLOB($setBlob)
//C_LONGINT($process)
//C_OBJECT($criteria)

//Case of 
//: (Count parameters=3)
//$customers:=$1
//$criteria:=$2
//Else 
//assertInvalidNumberOfParams(Current method name; Count parameters)
//End case 

//checkAllEmailsProcess($customers; $criteria)