//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 06/05/19, 13:46:11
// ----------------------------------------------------
// Method: webGetSanctionListEmoji
// Description
// 
// 
//   returns the "class" name specified in cxr.css
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $tableNumber)
C_TEXT:C284($2; $internalRecordId)
C_TEXT:C284($3; $name)

C_TEXT:C284($0; $tEmojiClass)


Case of 
		
	: (Count parameters:C259=3)
		$tableNumber:=$1
		$internalRecordId:=$2
		$name:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_LONGINT:C283($iStatus)
$iStatus:=getLatestCheckLogStatus($tableNumber; $internalRecordId; $name)

Case of 
		//https://unicode.org/emoji/charts/full-emoji-list.html
	: ($iStatus=0)  //OK pass
		$tEmojiClass:="sanction-ok"  //"&#2705;"  //check mark button
	: ($iStatus=1)  //no exact match-caution
		$tEmojiClass:="sanction-caution"  //"&#26A0;"  //warning
	: ($iStatus=2)  //exact match - alert
		$tEmojiClass:="sanction-warning"  //"&#1F6AB;"  //prohibited
	Else   //not checked -9999 or -1
		//$tEmoji:=Char(0x0001F600)  //"&#2753;"  //question mark
		$tEmojiClass:="sanction-unknown"  //"&#x129458"
End case 

$0:=$tEmojiClass