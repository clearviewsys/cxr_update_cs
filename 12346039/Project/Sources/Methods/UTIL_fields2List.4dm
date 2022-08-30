//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 12/18/13, 21:50:43
// Copyright 2012 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: UTIL_Fields2List
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $iList)
C_LONGINT:C283($2; $iTable)

C_LONGINT:C283($i; $iCount; $iList; $iLength; $iTable; $iType)
C_BOOLEAN:C305($bIndex; $bInvisible; $bUnique)

$iList:=$1
$iTable:=$2



$iCount:=Get last field number:C255($iTable)


For ($i; 1; $iCount)
	
	If (Is field number valid:C1000($iTable; $i))
		GET FIELD PROPERTIES:C258($iTable; $i; $iType; $iLength; $bIndex; $bUnique; $bInvisible)
		
		If (Not:C34($bInvisible))
			APPEND TO LIST:C376($iList; Field name:C257($iTable; $i); $i)
		End if 
	End if 
	
End for 