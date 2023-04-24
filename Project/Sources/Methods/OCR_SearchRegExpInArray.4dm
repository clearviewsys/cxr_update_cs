//%attributes = {}
// OCR_SearchRegExpInArray ( $regExp; ->$arrPtr; $iniPos; $endPos; ->$found; ->$arrOCRPosReal )
// Search for a RegExp pattern between 2 positions of an array.
// Created By CVS Dev. Team, 04/22/2017


C_TEXT:C284($1; $regExp)
C_POINTER:C301($2; $arrPtr; $5; $foundPtr; $6; $arrOCRPosRealPtr)
C_LONGINT:C283($3; $iniPos; $4; $endPos)
C_BOOLEAN:C305($0; $match; $confirmed; $used)

C_LONGINT:C283($i; $j; $found)

ARRAY TEXT:C222($arrFieldObj; 0)
ARRAY TEXT:C222($arrFieldName; 0)
ARRAY TEXT:C222($arrFieldRegExp; 0)

ARRAY LONGINT:C221($arrSeq; 0)
ARRAY LONGINT:C221($arrOCRPos; 0)

Case of 
		
	: (Count parameters:C259=6)
		
		$regExp:=$1
		$arrPtr:=$2
		$iniPos:=$3
		$endPos:=$4
		$foundPtr:=$5
		$arrOCRPosRealPtr:=$6
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$0:=False:C215
$foundPtr->:=-1

For ($i; $iniPos; $endPos)
	If ($i<=Size of array:C274($arrPtr->))
		
		$match:=Match regex:C1019($regExp; $arrPtr->{$i})
		
		If ($match)
			$used:=(Find in array:C230($arrOCRPosRealPtr->; $i)>0)
			If (Not:C34($used))
				$foundPtr->:=$i
				$i:=$endPos+1
			End if 
			
		End if 
	End if 
	
End for 

$0:=($foundPtr->>0)
