// handleAutoFillSearch (self; current form table; ->key;->value;->sortKey;->keyArr  `ary;->valueArray; {String:queryCommand})


// Jan 16, 2012 18:00:50 -- I.Barclay Berry -- COMMENTED OUT -- b/c parameters and this form not used

//C_TEXT($search)
//C_TEXT(vRecNum;$8)
//C_POINTER($tablePtr;$self;$tablePtr;$keyPtr;$valuePtr)
//
//
//C_POINTER($1;$2;$3;$4;$5;$6;$7)
//$self:=$1
//$tablePtr:=$2
//$keyPtr:=$3
//$valuePtr:=$4
//$sortKeyPtr:=$5
//$arrKeyPtr:=$6
//$arrValuePtr:=$7
//
//
//If (Form event=On Load)
//  //$self->:=""
//ARRAY TEXT(arrValue;0)
//ARRAY TEXT(arrKey;0)
//End if 
//
//
//If ((Form event=On Getting Focus) | (Form event=On After Keystroke))
//
//If (Form event=On After Keystroke)
//$search:=Get edited text
//Else 
//$search:=$self->
//End if 
//
//
//If (Count parameters=7)
//ALL RECORDS($tablePtr->)
//Else 
//EXECUTE FORMULA($8)
//End if 
//
//QUERY SELECTION($tablePtr->;$valuePtr->="@"+$search+"@";*)
//QUERY SELECTION($tablePtr->; | ;$keyPtr->="@"+$search+"@")
//ARRAY TEXT($arrKeyPtr->;0)
//ARRAY TEXT($arrValuePtr->;0)
//
//REDRAW($arrKeyPtr->)
//REDRAW($arrValuePtr->)
//
//If (Records in selection($tablePtr->)=0)
//BEEP
//Else 
//ORDER BY($tablePtr->;$sortKeyPtr->;>)
//SELECTION TO ARRAY($keyPtr->;$arrKeyPtr->)
//SELECTION TO ARRAY($valuePtr->;$arrValuePtr->)
//GOTO SELECTED RECORD($tablePtr->;arrKey)
//$arrKeyPtr->:=1
//$arrValuePtr->:=1
//
//End if 
//End if 
//  //
//  //If (Form event=On Data Change )
//  //GOTO SELECTED RECORD($tablePtr->;arrKey)
//  //End if 
//
//
//If (Form event=On Losing Focus)
//If (Records in selection($tablePtr->)#0)
//$self->:=$keyPtr->
//Else 
//BEEP
//  //GOTO AREA(Self->)
//End if 
//End if 
//
//vRecNum:=String(Records in selection($tablePtr->))
//
