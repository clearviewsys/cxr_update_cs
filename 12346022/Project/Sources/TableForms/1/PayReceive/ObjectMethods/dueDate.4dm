handleDateWidget(Self:C308)
//If (Form event=On Data Change )
//If ([Cheques]DueDate>Current date)  ` it's a post dated cheque
//[Cheques]chequeStatus:=0  ` not deposited yet
//[Cheques]DepositDate:=!00/00/00!
//[Cheques]AccountID:=makeChequeAccountID ([Cheques]Currency;[Cheques]isPaid)
//End if 
//End if 
