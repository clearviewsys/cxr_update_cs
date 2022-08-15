//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/12/18, 22:29:19
// ----------------------------------------------------
// Method: WAPI_getJavascript
// Description
// 
//    HOOK METHOD
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $tForm)
C_TEXT:C284($2; $tEvent)
C_TEXT:C284($3; $tSource)
C_TEXT:C284($4; $tSourceType)
C_POINTER:C301($5; $ptrNameArray)
C_POINTER:C301($6; $ptrValueArray)

C_TEXT:C284($0; $tResult)

C_TEXT:C284($tValue)
C_LONGINT:C283($recNum)


$tForm:=$1
$tEvent:=$2
$tSource:=$3
$tSourceType:=$4
$ptrNameArray:=$5
$ptrValueArray:=$6

$tResult:=""
//TRACE

C_TEXT:C284($tTable)
C_TEXT:C284($tMethod; $tMessage; $message)

Case of 
	: ($tForm="login-register-@")
		$tMethod:="webOnChange_Register"
		
	: ($tForm="profile-@")
		$tForm:="profile"
		$tMethod:="webOnChange_"+$tForm
		
	: ($tForm="dashboard@")
		$tForm:="dashboard"
		$tMethod:="webOnChange_"+$tForm
		
	Else 
		// -- FORM NAMES = TABLE-FORMTYPE-FORM IE. LINKS-CREATE-FORM
		$tTable:=WAPI_getParameter("table")
		
		If ($tTable="")
			C_LONGINT:C283($iPos)
			$iPos:=Position:C15("-"; $tForm)
			If ($iPos>0)
				$tTable:=Substring:C12($tForm; 1; $iPos-1)  //get the table name
			End if 
		End if 
		
		$tMethod:="webOnChange_"+$tTable
		
End case 

//TRACE


If (UTIL_isMethodExists($tMethod))
	EXECUTE METHOD:C1007($tMethod; $tResult; $tForm; $tEvent; $tSource; $tSourceType; $ptrNameArray; $ptrValueArray)
End if 


$0:=$tResult