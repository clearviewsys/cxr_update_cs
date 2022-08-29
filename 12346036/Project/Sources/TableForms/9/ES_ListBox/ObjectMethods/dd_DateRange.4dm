
handleDropDown_DateRange(Self:C308)

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	Form:C1466.applyDates:=1
	SET TIMER:C645(5)
End if 