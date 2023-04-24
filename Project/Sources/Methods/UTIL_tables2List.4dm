//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 12/18/13, 21:29:11
// Copyright 2012 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: UTIL_Table2List
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($1; $iList)

$iList:=$1

//maybe dlete items if exist

C_LONGINT:C283($iFileCount; $iCount; $i)
C_BOOLEAN:C305($bInvisible)
$iFileCount:=Get last table number:C254  //Number of files to appear in File array
$iCount:=1

For ($i; 1; $iFileCount)
	
	If (Is table number valid:C999($i))
		GET TABLE PROPERTIES:C687($i; $bInvisible)
		
		If (Not:C34($bInvisible))  //don't show invisible tables
			APPEND TO LIST:C376($iList; Table name:C256($i); $i)
		End if 
	End if 
End for 

SORT LIST:C391($iList)