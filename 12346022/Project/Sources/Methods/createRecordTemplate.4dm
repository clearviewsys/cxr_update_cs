//%attributes = {}


//C_TEXT($subject;$description;$recordID;$1;$2;$4)
//c_pointer($tablePtr;$3)

//Case of 
//:(Count parameters=4)
//$subject:=$1
//$description:=$2
//$tablePtr:=$3
//$recordID:=$4
//Else 
//assertInvalidNumberOfParams(Current method name;Count parameters)
//end case

//C_POINTER($tablePtr)
//$tablePtr:=->[ExceptionsLog]

//READ WRITE($tablePtr->)
//CREATE RECORD($tablePtr->)

//[AML_Alerts]UUID:=Generate UUID
//[AML_Alerts]alertID:=makeAML_AlertID 
//[AML_Alerts]subject:=$subject
//[AML_Alerts]description:=$description
//[AML_Alerts]tableNo:=Table($tablePtr)
//[AML_Alerts]recordID:=$recordID

//[AML_Alerts]date:=Current date
//[AML_Alerts]branchID:=getBranchID 

//SAVE RECORD($tablePtr->)
//UNLOAD RECORD($tablePtr->)
//READ ONLY($tablePtr->)
