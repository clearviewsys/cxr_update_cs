// handleFetchDelayedRatesForSelection

If (Records in set:C195("UserSet")=0)
	ALERT:C41("Please highlight some records first. ")
Else 
	OBJECT SET ENABLED:C1123(Self:C308->; False:C215)
	
	USE SET:C118("UserSet")
	CREATE EMPTY SET:C140([Flags:19]; "$errorSet")
	FIRST RECORD:C50([Flags:19])
	READ WRITE:C146([Flags:19])
	
	C_LONGINT:C283($error; $i)
	For ($i; 1; Records in selection:C76([Flags:19]))
		LOAD RECORD:C52([Flags:19])
		
		$error:=createCurrencyRecord([Flags:19]CurrencyCode:1; <>baseCurrency; [Flags:19]CurrencyName:2; [Flags:19]Country:3; True:C214; False:C215; False:C215; ->[Flags:19]flag:4)
		If ($error>0)
			ADD TO SET:C119([Flags:19]; "$errorSet")
		End if 
		SAVE RECORD:C53([Flags:19])
		NEXT RECORD:C51([Flags:19])
	End for 
	UNLOAD RECORD:C212([Flags:19])
	
	READ ONLY:C145([Flags:19])
	If (Records in set:C195("$errorSet")>0)
		USE SET:C118("$errorSet")
		ALERT:C41(String:C10(Records in set:C195("$errorSet"))+" record(s) was/were not transfered correctly. Perhaps there are dupplicate entrie"+"s in Currency Module.")
		HIGHLIGHT RECORDS:C656([Flags:19]; "$errorSet")
	End if 
	
	CLEAR SET:C117("$errorSet")
	OBJECT SET ENABLED:C1123(Self:C308->; True:C214)
	
End if 