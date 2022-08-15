//%attributes = {}
// JAM_CreateDetailLines ($fileName)
// Create the Report Detail Line
// Author: JA


C_TEXT:C284($1; $fileName)
C_OBJECT:C1216($2; $register)
C_LONGINT:C283($3; $i)


C_TEXT:C284($reportType)

Case of 
		
	: (Count parameters:C259=3)
		$fileName:=$1
		$register:=$2
		$i:=$3
		$sep:=""
		
	: (Count parameters:C259=4)
		$fileName:=$1
		$register:=$2
		$i:=$3
		$sep:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_TEXT:C284($content; $sep)
C_BLOB:C604($blob)
C_REAL:C285($credit; $debit)


If ($register.RegisterType="Sell")
	CreateDetailsForSelling($register; $i; $fileName; $sep)
Else 
	CreateDetailsForBuying($register; $i; $fileName; $sep)
End if 
//APPEND TO ARRAY(arrRegID;$register.RegisterID)





