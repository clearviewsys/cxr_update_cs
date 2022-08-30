//%attributes = {}

// FT_UpdateWireTemplates


C_LONGINT:C283($i)
ARRAY TEXT:C222($arrTmp; 0)
C_TEXT:C284($firstName; $lastName; $name)

READ WRITE:C146([WireTemplates:42])
ALL RECORDS:C47([WireTemplates:42])

FIRST RECORD:C50([WireTemplates:42])

While (Not:C34(End selection:C36([WireTemplates:42])))
	
	$name:=""  // ***$name IS USED HERE BUT $firstName is USED EVERYWHERE ELSE*** 
	$lastName:=""
	CLEAR VARIABLE:C89($arrTmp)
	
	tokenizePhraseIntoWords(FT_Clean(FJ_Trim([WireTemplates:42]BeneficiaryFullName:9)); ->$arrTmp; " ")
	
	
	If ([WireTemplates:42]BeneficiaryFullName:9#"")
		
		For ($i; 1; Size of array:C274($arrTmp))
			
			If ($i=1)
				$firstName:=FJ_Trim($arrTmp{$i})
			Else 
				$lastName:=$lastName+" "+FJ_Trim($arrTmp{$i})
			End if 
			
		End for 
		
		[WireTemplates:42]BeneficiaryFirstName:40:=FJ_Trim($firstName)
		[WireTemplates:42]BeneficiaryLastName:41:=FJ_Trim($lastName)
		
		SAVE RECORD:C53([WireTemplates:42])
		
	End if 
	
	NEXT RECORD:C51([WireTemplates:42])
	
End while 



