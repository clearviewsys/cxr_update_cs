//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jonathan Le
// Date and time: 04/02/04, 09:26:10
// ----------------------------------------------------
// Method: BKP_XML_GetDatabaseInfo
// Description
// 
//
// Parameters
// $1 -a reference to the parent element in the DOM
// ----------------------------------------------------
C_TEXT:C284($1)

$0:=BKP_XML_GetSettings($1; "/Backup/DataBase")