//%attributes = {}

//Author @Zoya
//June 2021

ARRAY TEXT:C222($at_file; 0)
C_TEXT:C284($final; $reportText; $file; $text; $line)
C_LONGINT:C283($resultPtr)
C_POINTER:C301($logID)

$file:=Select document:C905(""; "*.*"; "Select a file ..."; 0; $at_file)
If (ok=1)
	//C_OBJECT($matchMethod)
	//$matchMethod:=New object
	$text:=Document to text:C1236($at_file{1})
	ARRAY TEXT:C222($arr_names; 38)
	C_LONGINT:C283($i)
	
	//While ($i<Size of array($arr_names))
	For each ($line; Split string:C1554($text; "\r"))
		If ($i<Size of array:C274($arr_names))
			$arr_names{$i}:=$line
			//$matchMethod.MatchType:="QUICK"
			
			//[SanctionLists]MatchType:="FULL-TEXT"
			$resultPtr:=slold_screenPerson(True:C214; $arr_names{$i}; $logID; New object:C1471("options"; New object:C1471(\
				"list"; "pep"; "matchType"; "EXACT")))
			
			//ALERT(String($resultPtr))
			//$myresult:=checkNameAgainstList($arr_names{$i}; ->$num; False; "PEP"; True)
			
			//$needPosition:=Position("Birth Date"; $myresult)
			//$final:=Substring($myresult; $needPosition)
			//ALERT($myresult)
			//$i:=$i+1
			//$reportText:=$reportText+String($i)+$line+"    "+$final
		End if 
	End for each 
	//End while
End if 
//ALERT($reportText)
//SET TEXT TO PASTEBOARD($reportText)

