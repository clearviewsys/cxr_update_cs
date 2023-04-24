//%attributes = {}
//saveRecordOnRemoteServer(->table;id)

C_POINTER:C301($1; $tablePtr)
C_TEXT:C284($2; $recordID)

//For ($i;1;Records in table($tablePtr->))
//
//end for

ws_setKeyValueAsText(<>clientCode; <>clientCode; String:C10(Table:C252($tablePtr); "0#")+"-"+$recordID; "")


