If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Bound Variable Change:K2:52))
	If (Current user:C182="Designer")
		OBJECT SET VISIBLE:C603(*; "b_trace"; True:C214)
	End if 
	Form:C1466.tabs:=New object:C1471("values"; \
		New collection:C1472("Decision IQ"; "Smart Scan"; "Adverse Media Statistics"); \
		"index"; 0)
	
	var $property : Object
	var $display : Collection
	$property:=OB Get:C1224(Form:C1466.response; "summary"; Is object:K8:27)
	If ($property=Null:C1517)
		return 
	End if 
	$property:=OB Get:C1224($property; "diq_summary"; Is object:K8:27)
	If ($property=Null:C1517)
		return 
	End if 
	$property:=OB Get:C1224($property; "adverse_media_statistics"; Is object:K8:27)
	If ($property=Null:C1517)
		return 
	End if 
	
	$display:=OB Get:C1224($property; "positions_held"; Is collection:K8:32)
	If ($display#Null:C1517)
		utils_handleFormInArrListBox($display; "col_positions")
	End if 
	
	$display:=OB Get:C1224($property; "designated_offences_categories"; Is collection:K8:32)
	If ($display#Null:C1517)
		utils_handleFormInArrListBox($display; "col_offences")
	End if 
	
	
	$display:=OB Get:C1224($property; "rca_of_pep"; Is collection:K8:32)
	If ($display#Null:C1517)
		utils_handleFormInArrListBox($display; "col_pep")
	End if 
	
	$display:=OB Get:C1224($property; "keywords"; Is collection:K8:32)
	If ($display#Null:C1517)
		utils_handleFormInArrListBox($display; "col_keywords")
	End if 
End if 
OBJECT SET ENABLED:C1123(*; "b_url"; Form:C1466.selectedList#Null:C1517)