//Validation here
//checking locked set against Users_lbset
checkInit
READ WRITE:C146([Users:25])
USE SET:C118("$Users_LBSet")
While (Not:C34(End selection:C36([Users:25])))
	checkAddErrorIf(Locked:C147([Users:25]); "User: "+[Users:25]UserName:3+" is locked, please double check it is not being edited on the system")
	NEXT RECORD:C51([Users:25])
End while 
UNLOAD RECORD:C212([Users:25])
READ ONLY:C145([Users:25])

If (isValidationConfirmed)
	
	
	If (Records in set:C195("$Users_LBSet")>0)
		CONFIRM:C162("Are you sure you want to reset the delay for highlighted records?"; "Reset Delay"; "Ignore")
		If (OK=1)
			
			READ WRITE:C146([Users:25])
			USE SET:C118("$Users_LBSet")
			
			APPLY TO SELECTION:C70([Users:25]; [Users:25]nextAttemptTime:34:=Time:C179(0))
			APPLY TO SELECTION:C70([Users:25]; [Users:25]numAttempts:35:=0)
			
			myAlert("Selected Users' login delay has been reset")
			
		Else 
			myAlert("Please highlight some records first")
		End if 
	End if 
End if 

READ ONLY:C145([Users:25])
