//%attributes = {}
// not used

//C_OBJECT($1; $formObj)
//C_OBJECT($session; $formData)
//C_LONGINT($procID; $winref)

//If (Count parameters>0)

//$formObj:=$1

//$session:=mgNewSession($formObj.credentials; True)  // debug

//If ($session.httpCode=200)

//If ($session.debug)
//$formObj.object.isDebug:="true"
//End if 

//$formData:=New object

//$formData.transaction:=$formObj.object
//$formData.session:=$session
//// $formData.winref:=$formObj.winref // we need this in order to get result from Profix
//$formData.winref:=Frontmost window  // we need this in order to get result from Profix by using CALL FORM

//$winref:=Open form window("mgWebArea")

//DIALOG("mgWebArea"; $formData)

//CLOSE WINDOW

//Else 

//myAlert("Couldn't start MoneyGram session!")

//End if 

//Else 

//$formObj:=Form
//$procID:=New process(Current method name; 0; "MG_"+Generate UUID; $formObj)

//End if 
