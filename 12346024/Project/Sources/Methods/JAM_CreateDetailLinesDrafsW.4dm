//%attributes = {}
// JAM_CreateDetailLinesDrafsW ($fileName; $invoice; $i; $sequence; $separator )
// Create the Report Detail Line
// Author: JA


C_TEXT:C284($1; $fileName)
C_OBJECT:C1216($2; $invoice)
C_LONGINT:C283($3; $i)
C_POINTER:C301($4; $seqPtr)

C_TEXT:C284($5; $reportType; $separator)

Case of 
		
	: (Count parameters:C259=4)
		$fileName:=$1
		$invoice:=$2
		$i:=$3
		$seqPtr:=$4
		$separator:=""
		
	: (Count parameters:C259=5)
		$fileName:=$1
		$invoice:=$2
		$i:=$3
		$seqPtr:=$4
		$separator:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_TEXT:C284($content)
C_BLOB:C604($blob)
C_REAL:C285($credit; $debit)
C_LONGINT:C283($sequence)
C_OBJECT:C1216($registers; $register)


// "om_registers" is the name of the relationship
$registers:=$invoice.om_registers.orderBy("RegisterType desc")
//$registers:=$registers.orderBy("RegisterType desc")
$sequence:=1

For each ($register; $registers)  // Each Invoice mush have entries in Registers Table
	
	
	If ($register.RegisterType="Sell")
		CreateDetailsForSellingDraftsW($register; $i; $fileName; ->$sequence; $separator)
	Else 
		CreateDetailsForBuyingDraftsW($register; $i; $fileName; ->$sequence; $separator)
	End if 
	
	APPEND TO ARRAY:C911(arrRegID; $register.RegisterID)
End for each 

JAM_totalDebitsAmnt:=JAM_totalDebitsAmnt-$registers.sum("UnrealizedGain")






