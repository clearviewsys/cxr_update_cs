If (Form event code:C388=On Clicked:K2:4)
	If (isCheckBoxSwitchedOn(->[ExceptionsLog:75]isReviewed:10))  // checked
		[ExceptionsLog:75]ReviewerUserID:15:=getApplicationUser
	Else 
		[ExceptionsLog:75]ReviewerUserID:15:=Old:C35([ExceptionsLog:75]ReviewerUserID:15)
	End if 
End if 