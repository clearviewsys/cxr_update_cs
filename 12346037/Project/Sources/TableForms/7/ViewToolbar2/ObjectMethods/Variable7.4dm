UNLOAD RECORD:C212(Current form table:C627->)
executeMethodName("search"+Table name:C256(Current form table:C627))



//C_STRING(9;vQSearch)
//C_INTEGER(vPrimaryKeyIndex)
//If (vPrimaryKeyIndex=0)
//vPrimaryKeyIndex:=1
//End if 
//
//QUERY(Current form table->;Field(Table(Current form table);vPrimaryKeyIndex)->=(vQSearch+"@"))
//  `vQSearch:=""
//popSearch:=1
POST OUTSIDE CALL:C329(Current process:C322)
//InvestFirmNavigateButtons
FIRST RECORD:C50(Current form table:C627->)
handleVRecNum