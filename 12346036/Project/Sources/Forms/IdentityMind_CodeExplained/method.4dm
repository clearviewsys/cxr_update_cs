Case of 
	: (Form event code:C388=On Load:K2:1)
		
		// === PART 1: Extract data from IdentityMindResponse ===
		
		C_TEXT:C284($data)
		$data:=IdentityMindResponse.rcd
		
		// === PART 2: Split rcd codes into an array ===
		
		C_REAL:C285($start; $end)
		$start:=1
		ARRAY REAL:C219($codes; 0)
		C_BOOLEAN:C305($more)
		$more:=True:C214
		While ($more)
			$end:=Position:C15(","; $data; $start)
			If ($end=0)
				$more:=False:C215
				APPEND TO ARRAY:C911($codes; Num:C11(Substring:C12($data; $start)))
			Else 
				APPEND TO ARRAY:C911($codes; Num:C11(Substring:C12($data; $start; $end-$start)))
			End if 
			$start:=$end+1
		End while 
		
		// === PART 3: Load rcdCodes.txt data ===
		
		C_TEXT:C284($path)
		$path:=Get 4D folder:C485(Current resources folder:K5:16)+"rcdCodes.txt"
		ARRAY REAL:C219($rcdCodes; 0)
		ARRAY TEXT:C222($rcdDescriptions; 0)
		//C_DocRef($refDoc)
		C_TIME:C306($refDoc)
		$refDoc:=Open document:C264($path; "TEXT"; Read mode:K24:5)
		If (OK=1)
			Repeat 
				C_TEXT:C284($rcdCode)
				RECEIVE PACKET:C104($refDoc; $rcdCode; Char:C90(Tab:K15:37))
				APPEND TO ARRAY:C911($rcdCodes; Num:C11($rcdCode))
				
				C_TEXT:C284($rcdDescription)
				RECEIVE PACKET:C104($refDoc; $rcdDescription; Char:C90(Line feed:K15:40))
				APPEND TO ARRAY:C911($rcdDescriptions; $rcdDescription)
			Until (OK=0)
		End if 
		
		CLOSE DOCUMENT:C267($refDoc)
		
		// === PART 4: Display the the codes + descriptions ===
		Form:C1466.data:=New collection:C1472
		If (Size of array:C274($codes)>0)
			C_LONGINT:C283($i)
			For ($i; 1; Size of array:C274($codes))
				C_OBJECT:C1216($display)
				$display:=New object:C1471
				$display.code:=$codes{$i}
				C_LONGINT:C283($index)
				$index:=Find in array:C230($rcdCodes; $codes{$i})
				If ($index#-1)
					$display.description:=$rcdDescriptions{$index}
				End if 
				Form:C1466.data.push($display)
			End for 
		End if 
End case 