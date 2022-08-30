C_TEXT:C284(vFeePaidSeparately)
If ([Invoices:5]ThirdPartyisInvolved:22=True:C214)
	Self:C308->:="Fee is paid separately."
Else 
	Self:C308->:="Fee is charged as part of the transaction."
End if 