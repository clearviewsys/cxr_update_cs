//%attributes = {}
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
C_TEXT:C284(vCustomerID; veWireID; vSecurityCode)


If ((vCustomerID#"") & (vEwireID#"") & (vSecurityCode#""))
	OBJECT SET VISIBLE:C603(*; "FetcheWire"; True:C214)
Else 
	OBJECT SET VISIBLE:C603(*; "FetcheWire"; False:C215)
End if 

If (vEwireID#"")  // & (vSecurityCode#"")) 6/27/21 allow fetch for bank without code
	OBJECT SET VISIBLE:C603(*; "geteWireStatus"; True:C214)
Else 
	OBJECT SET VISIBLE:C603(*; "geteWireStatus"; False:C215)
End if 

setVisibleIff(((vCustomerID#"") & (vBeneficiaryName#[Customers:3]FullName:40)); "missmatch")
