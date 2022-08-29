C_TEXT:C284(veWireID; vSecurityCode)
C_DATE:C307(vDate)
C_TEXT:C284(vSenderName)
C_TEXT:C284(vBeneficiaryName)
C_REAL:C285(vFromAmount)
C_REAL:C285(vToAmount)
C_TEXT:C284(vFromCountry)
C_TEXT:C284(vToCountry)

C_TEXT:C284(vCurrency)
C_BOOLEAN:C305(vIsSettled)
C_TEXT:C284(vComments)
C_BOOLEAN:C305(vIsFetched)
C_DATE:C307(vFetchDate)
C_TEXT:C284(vFetchLocation)

C_LONGINT:C283($i)
$i:=listbox_getSelectedRowNumber(->lb_eWire)

If ($i>0)
	//handleGeteWireStatusButton 
	vEwireID:=arrEwireID{$i}
	vSecurityCode:=arrSecurityCode{$i}
	
	geteWireStatusRemotely(veWireID; vSecurityCode; ->vDate; ->vSenderName; ->vBeneficiaryName; ->vFromAmount; ->vToAmount; ->vCurrency; ->vFromCountry; ->vToCountry; ->vIsSettled; ->vComments; ->vIsFetched; ->vFetchDate; ->vFetchLocation)
	
	CONFIRM:C162("Are you sure you want to fetch eWire "+arrEwireID{$i}+"-"+arrSecurityCode{$i})
	If (OK=1)
		handleFetcheWireFromAgentModule
	End if 
Else 
	myAlert("You need to select a row first")
End if 