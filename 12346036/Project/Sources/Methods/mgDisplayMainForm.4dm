//%attributes = {}
//// not used, it loads dynamic form definition to display MoneyGram send dialog

//C_OBJECT($1; $data)  // data.send is send data, data.receive is receive data from 4D database
//C_OBJECT($formDefinition; $sendFormPage; $receiveFormPage; $send; $receive)
//C_TEXT($formJSON; $currlabel; $currentry)
//C_LONGINT($i; $winref)

//$data:=$1
////$data:=New object
////$data.send:=sendMoneyViaMG 
////$data.receive:=receiveMoneyViaMG 

//$formJSON:=mgGetDocument("mainformtemplate.json")
//$formDefinition:=JSON Parse($formJSON)

//$sendFormPage:=$formDefinition.pages[1].objects
//$receiveFormPage:=$formDefinition.pages[2].objects

//If (True)  // send part

//ARRAY TEXT($properties; 0)
//OB GET PROPERTY NAMES($data.send.object; $properties)

//For ($i; 1; Size of array($properties))

//$currlabel:="sendlabel"+String($i; "00")
//If ($sendFormPage[$currlabel]=Null)
//$sendFormPage[$currlabel]:=New object
//End if 
//$sendFormPage[$currlabel].type:="text"
//$sendFormPage[$currlabel].text:=$properties{$i}
//$sendFormPage[$currlabel].top:=50+(($i-1)*25)
//$sendFormPage[$currlabel].left:=10
//$sendFormPage[$currlabel].width:=200
//$sendFormPage[$currlabel].height:=17

//$currentry:="sendentry"+String($i; "00")
//If ($sendFormPage[$currentry]=Null)
//$sendFormPage[$currentry]:=New object
//End if 
//$sendFormPage[$currentry].type:="input"
//$sendFormPage[$currentry].dataSource:="Form:C1466.send.object."+$properties{$i}
//$sendFormPage[$currentry].top:=50+(($i-1)*25)
//$sendFormPage[$currentry].left:=230
//$sendFormPage[$currentry].width:=350
//$sendFormPage[$currentry].height:=17

//End for 

//End if 

//If (True)  // receive part

//ARRAY TEXT($properties; 0)
//OB GET PROPERTY NAMES($data.receive.object; $properties)

//For ($i; 1; Size of array($properties))

//$currlabel:="receivelabel"+String($i; "00")
//If ($receiveFormPage[$currlabel]=Null)
//$receiveFormPage[$currlabel]:=New object
//End if 
//$receiveFormPage[$currlabel].type:="text"
//$receiveFormPage[$currlabel].text:=$properties{$i}
//$receiveFormPage[$currlabel].top:=50+(($i-1)*25)
//$receiveFormPage[$currlabel].left:=10
//$receiveFormPage[$currlabel].width:=200
//$receiveFormPage[$currlabel].height:=17

//$currentry:="receiveentry"+String($i; "00")
//If ($receiveFormPage[$currentry]=Null)
//$receiveFormPage[$currentry]:=New object
//End if 
//$receiveFormPage[$currentry].type:="input"
//$receiveFormPage[$currentry].dataSource:="Form:C1466.receive.object."+$properties{$i}
//$receiveFormPage[$currentry].top:=50+(($i-1)*25)
//$receiveFormPage[$currentry].left:=230
//$receiveFormPage[$currentry].width:=350
//$receiveFormPage[$currentry].height:=17

//End for 

//End if 

//$winref:=Open form window($formDefinition)
//DIALOG($formDefinition; $data)

//CLOSE WINDOW
