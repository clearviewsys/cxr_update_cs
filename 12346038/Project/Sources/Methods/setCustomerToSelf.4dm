//%attributes = {}
If ((Records in selection:C76([Registers:10])=0) & (vCustomerID=getWalkInCustomerID))
	setvCustomerID(getSelfCustomerID)
End if 

checkAddWarningOnTrue(vCustomerID#getSelfCustomerID; "Customer ID is not self")
