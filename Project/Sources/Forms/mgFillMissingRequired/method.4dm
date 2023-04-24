Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		If (Form:C1466.missing#Null:C1517)
			
			C_OBJECT:C1216($oneField; $default)
			
			Form:C1466.enums:=0
			Form:C1466.flds:=0
			Form:C1466.numOfObjects:=10  // we have this many rows for data on form
			
			//If (Form.stateRequired)
			//If (Form.states#Null)
			
			//OBJECT SET VISIBLE(*;"enum"+String(Form.enums);True)
			//OBJECT SET VISIBLE(*;"enumlbl"+String(Form.enums);True)
			//OBJECT SET TITLE(*;"enumlbl"+String(Form.enums);"Sender state")
			
			//Form["SenderState"]:=Form.customer.Province
			
			//popupsInit ("popups";"enum"+String(Form.enums);form.states;\
				New collection(New object("propertyName";"StateOfCountryName";"separator";""));\
				New object("type";"index";"value";0);"mgFillMissing_OM")
			
			//Form.enums:=Form.enums+1
			
			//end if
			//End if 
			
			For each ($oneField; Form:C1466.missing)
				
				Form:C1466[$oneField.Name]:=""
				
				If ($oneField.Enumerated="true")
					
					OBJECT SET VISIBLE:C603(*; "enum"+String:C10(Form:C1466.enums); True:C214)
					OBJECT SET VISIBLE:C603(*; "enumlbl"+String:C10(Form:C1466.enums); True:C214)
					OBJECT SET TITLE:C194(*; "enumlbl"+String:C10(Form:C1466.enums); $oneField.Caption)
					
					If ($oneField.defaultValue#Null:C1517)
						$default:=New object:C1471("type"; "custom"; "property"; "EnumeratedValue"; "value"; $oneField.defaultValue)
					Else 
						$default:=New object:C1471("type"; "index"; "value"; 0)
					End if 
					
					popupsInit("popups"; "enum"+String:C10(Form:C1466.enums); $oneField.EnumeratedValues.EnumeratedValuesInfo; \
						New collection:C1472(New object:C1471("propertyName"; "EnumeratedLabel"; "separator"; "")); \
						$default; "mgFillMissing_OM")
					
					$oneField.formObjName:="enum"+String:C10(Form:C1466.enums)
					
					Form:C1466.enums:=Form:C1466.enums+1
					
				Else 
					
					OBJECT SET VISIBLE:C603(*; "fld"+String:C10(Form:C1466.flds); True:C214)
					OBJECT SET VISIBLE:C603(*; "fldlbl"+String:C10(Form:C1466.flds); True:C214)
					OBJECT SET TITLE:C194(*; "fldlbl"+String:C10(Form:C1466.flds); $oneField.Caption)
					
					$oneField.formObjName:="fld"+String:C10(Form:C1466.flds)
					
					Form:C1466.flds:=Form:C1466.flds+1
					
				End if 
				
			End for each 
			
			
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		
		
		C_OBJECT:C1216($selected)
		
		$selected:=popupsOnDataChangev17("popups")
		
End case 
