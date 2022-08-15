//%attributes = {}
// handleFetchDelayedRatesForSelection ({Set})
C_TEXT:C284($setName)


If (isUserAllowedToUpdateRates)
	
	C_TEXT:C284($userSet; $1)
	Case of 
		: (Count parameters:C259=1)
			$userSet:=$1
		Else 
			$userSet:="UserSet"
	End case 
	$setName:=makeSetNameForTable(->[Currencies:6])
	COPY NAMED SELECTION:C331([Currencies:6]; $setName)
	If (Records in set:C195($userSet)=0)
		//ALL RECORDS([Currencies])
		QUERY:C277([Currencies:6]; [Currencies:6]AutoUpdateOurRates:21=True:C214)
	Else 
		USE SET:C118($userSet)
	End if 
	
	CREATE EMPTY SET:C140([Currencies:6]; "$errorSet")
	
	
	C_REAL:C285($spotRateLocal)
	
	FIRST RECORD:C50([Currencies:6])
	READ WRITE:C146([Currencies:6])
	
	C_LONGINT:C283($progress)
	C_LONGINT:C283($i; $n; $error)
	
	$progress:=launchProgressBar("Updating Rates...")
	$n:=Records in selection:C76([Currencies:6])
	$i:=1
	
	FIRST RECORD:C50([Currencies:6])
	Repeat 
		LOAD RECORD:C52([Currencies:6])
		
		If ([Currencies:6]AutoUpdateOurRates:21)
			$error:=ws_getCurrencyRate([Currencies:6]ISO4217:31; [Currencies:6]toISO4217:32; ->$spotRateLocal)
		Else 
			$error:=0
		End if 
		
		If ($error>0)
			ADD TO SET:C119([Currencies:6]; "$errorSet")
			[Currencies:6]hasFailedUpdate:37:=True:C214
			setProgressBarTitle($progress; "Failed to fetch rate for "+[Currencies:6]ISO4217:31)
			
		Else 
			setCurrencySpotRate($spotRateLocal; "Clear View KYC")
			setProgressBarTitle($progress; "Downloading rate for "+[Currencies:6]ISO4217:31+" @ "+String:C10([Currencies:6]SpotRateLocal:17)+" ("+String:C10([Currencies:6]spotRateInverse:41)+")")
			
		End if 
		
		SAVE RECORD:C53([Currencies:6])
		NEXT RECORD:C51([Currencies:6])
		refreshProgressBar($progress; $i; $n)
		
		$i:=$i+1
	Until (($i>$n) | (isProgressBarStopped($progress)))
	HIDE PROCESS:C324($progress)
	
	UNLOAD RECORD:C212([Currencies:6])
	READ ONLY:C145([Currencies:6])
	
	If (Records in set:C195("$errorSet")>0)
		USE SET:C118("$errorSet")
		notifyAlert("Update Rate Error"; String:C10(Records in set:C195("$errorSet"))+" record(s) was/were not updated correctly."; 5)
		HIGHLIGHT RECORDS:C656([Currencies:6]; "$errorSet")
	End if 
	
	CLEAR SET:C117("$errorSet")
	
	writeCurrencyRatesAsXML
	USE NAMED SELECTION:C332($setName)
	HIGHLIGHT RECORDS:C656([Currencies:6]; $userSet)
	
	
Else 
	If (Not:C34(isScreenLocked))
		notifyAlert("Access Denied"; "Sorry! You are not authorized to update the currency rates!"; 5)
	End if 
End if 
