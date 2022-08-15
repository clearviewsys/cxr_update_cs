//%attributes = {}
// IdentityMind_update($json)
// Updates IdentityMind_EvaluationReport form
//
// Parameter
// $json = Text -> the json to update with

// === PART 1: Setup ===


C_OBJECT:C1216($1; $json)  // (optional) 
Case of 
	: (Count parameters:C259=1)
		$json:=$1
End case 

// === PART 2: Save the JSON data (For debugging) ===

//$tmpFile:=Create document("";".json")
//If (OK=1)
//SEND PACKET($tmpFile;$json)
//CLOSE DOCUMENT($tmpFile)
//End if 

// === PART 3: Load the data ===
Case of 
	: (Not:C34(OB Is defined:C1231(Form:C1466; "state")))
		Form:C1466.state:="n/a"
	: (Form:C1466.state="A")
		Form:C1466.state:="Accepted"
	: (Form:C1466.state="R")
		Form:C1466.state:="Under Review"
	Else 
		Form:C1466.state:="Rejected"
End case 
IdentityMind_colorState("var_state"; Form:C1466.state)

If (Not:C34(OB Is defined:C1231(Form:C1466; "res")))
	Form:C1466.res:="n/a"
End if 
IdentityMind_colorState("var_res"; Form:C1466.res)

// Overview Page - Fraud Rule

If (Not:C34(OB Is defined:C1231(Form:C1466; "frp")))
	Form:C1466.frp:="n/a"
End if 
IdentityMind_colorState("var_frp"; Form:C1466.frp)

// Overview Page - Fraud Rule

If (Not:C34(OB Is defined:C1231(Form:C1466; "arpr")))
	Form:C1466.arpr:="n/a"
End if 
IdentityMind_colorState("var_arpr"; Form:C1466.arpr)

If (OB Is defined:C1231(Form:C1466.ednaScoreCard; "sc"))
	C_OBJECT:C1216($child)
	For each ($child; Form:C1466.ednaScoreCard.sc)
		$child.TestName:=IdentityMind_mapTestName($child.test)
	End for each 
End if 


C_TEXT:C284($ar_result)
$ar_result:=Form:C1466.ednaScoreCard.ar.results
IdentityMind_colorState("var_ar_result"; $ar_result)
If ($ar_result="")
	$ar_result:="n/a"
End if 
IdentityMind_colorState("v_er_resultCode"; Form:C1466.ednaScoreCard.er.reportedRule.resultCode)

C_REAL:C285($i)

If (OB Is defined:C1231(Form:C1466.ednaScoreCard.er.reportedRule; "testResults"))
	For each ($child; Form:C1466.ednaScoreCard.er.reportedRule.testResults)
		$child.TestName:=IdentityMind_mapTestName($child.test)
	End for each 
End if 

If (OB Is defined:C1231(Form:C1466.ednaScoreCard; "etr"))
	For each ($child; Form:C1466.ednaScoreCard.etr)
		$child.TestName:=IdentityMind_mapTestName($child.test)
	End for each 
End if 
