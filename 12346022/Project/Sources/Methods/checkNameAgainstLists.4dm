//%attributes = {}
// checkNameAgainstLists(name: text; nameType: int ; {isManual: bool; ->fieldPtr: Pointer;sanctionList: string; ->indicator: picture ptr; option: obj})
// The starting point for sanction list check.
//
// Paramters:
// $name         (C_TEXT)    the customer full name or the company name
// $nameType     (C_INTEGER) 1 = Full Name, 2 = Company Name, (future: 3 = product name, etc.)
// $isManual     (C_BOOLEAN) false = skipping [SancationList]isManual = true
// $logIdPtr     (C_POINTER) field pointer to log
// $sanctionList (C_TEXT)    the sanction list to test, query as shortName = $sanctionList, defualt ignores PEP
// $indicatorPtr (C_POINTER) picture pointer to display status
// $options      (C_OBJECT)  other options
//
// Return:
// (C_INTERGER) 0 = no match, 1 = match found, 2 = hold customer
//
// Author: Wai-Kin Chau

//ds.SanctionCheckLog.query("InternalRecordID = ':1'";$logIdPtr->)


C_TEXT:C284($1; $name)
C_LONGINT:C283($2; $nameType)
C_BOOLEAN:C305($3; $isManual)
C_POINTER:C301($4; $logIdPtr)
C_TEXT:C284($5; $sanctionList)
C_POINTER:C301($6; $indicatorPtr)
C_OBJECT:C1216($7; $options)

$isManual:=True:C214
$logIdPtr:=Null:C1517
$sanctionList:=""
$indicatorPtr:=Null:C1517
$options:=New object:C1471("setHold"; New object:C1471(\
"onHoldField"; ""; \
"messageField"; ""\
); "listbox"; False:C215\
)

Case of 
	: (Count parameters:C259=2)
		$name:=$1
		$nameType:=$2
	: (Count parameters:C259=3)
		$name:=$1
		$nameType:=$2
		$isManual:=$3
	: (Count parameters:C259=4)
		$name:=$1
		$nameType:=$2
		$isManual:=$3
		$logIdPtr:=$4
	: (Count parameters:C259=5)
		$name:=$1
		$nameType:=$2
		$isManual:=$3
		$logIdPtr:=$4
		$sanctionList:=$5
	: (Count parameters:C259=6)
		$name:=$1
		$nameType:=$2
		$isManual:=$3
		$logIdPtr:=$4
		$sanctionList:=$5
		$indicatorPtr:=$6
	: (Count parameters:C259=7)
		$name:=$1
		$nameType:=$2
		$isManual:=$3
		$logIdPtr:=$4
		$sanctionList:=$5
		$indicatorPtr:=$6
		$options:=utils_setupObjectProperties($options; $7)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
// #ORDA
// Build list
C_OBJECT:C1216($entity)
C_OBJECT:C1216($listSel; $entity)
If ($sanctionList#"")
	$listSel:=ds:C1482.SanctionLists.query("ShortName = :1 and IsEnabled = true"; $sanctionList)
Else 
	$listSel:=ds:C1482.SanctionLists.query("ShortName # PEP and IsEnabled = true")
End if 


C_LONGINT:C283($return)
$return:=0

// Check if check allowed
C_BOOLEAN:C305($isReady)
$isReady:=Length:C16($name)>3

If (Not:C34($isManual))
	// is automatic; therefore skip list that are set to isManual
	$listSel:=$listSel.query("isManual = false")
	
	If (Not:C34(<>doCheckSanctionLists))
		$isReady:=False:C215
	End if 
End if 

If ($listSel.length=0)
	$isReady:=False:C215
End if 
If ($isReady)
	
	C_TEXT:C284($_0; $_1)
	$_0:="runAndViewSanctionChecks"
	$_1:=$name
	C_LONGINT:C283($_2)
	$_2:=$nameType
	C_COLLECTION:C1488($_3)
	$_3:=$listSel.ShortName
	C_LONGINT:C283($_4)
	C_TEXT:C284($_5)
	If ($logIdPtr=Null:C1517)
		$_4:=0
		$_5:=""
	Else 
		$_4:=Table:C252($logIdPtr)
		$_5:=$logIdPtr->
	End if 
	C_POINTER:C301($_6; $_7; $_8)
	$_6:=$indicatorPtr
	
	If (($options.setHold.messageField#"") & ($options.setHold.onHoldField#""))
		$_7:=OBJECT Get pointer:C1124(Object named:K67:5; $options.setHold.onHoldField)
		$_8:=OBJECT Get pointer:C1124(Object named:K67:5; $options.setHold.messageField)
		
	End if 
	//runAndViewSanctionChecks ($_1;$_2;$_3;$_4;$_5;$_6;$_7;$_8)
	CALL WORKER:C1389("RunSanctionChecks"; $_0; $_1; $_2; $_3; $_4; $_5; $_6; $_7; $_8)
End if 