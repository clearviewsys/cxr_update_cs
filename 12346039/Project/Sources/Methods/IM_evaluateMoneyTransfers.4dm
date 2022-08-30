//%attributes = {}
// IM_evaluateMoneyTransfer($registerSelections;{$runEnviornment})
// Evaluate transfers using the current selection
//
// Parameters: 
// $registerSelections (C_Object to [Registers])
//     where to extract registerData
// $runEnviornment (C_Real)
//     IdentityMind environment to use:
//      - -1 = system pick
//      -  0 = sandbox mode
//      -  1 = production mode
//      -  2 = staging mode
//
// Return: (NONE)

// Note to IdentityMind Component Programmer:
// Most command starts with "IM_" (shared component methods) must to require run:
// - IdentityMind_init which declare all IdentityMind prefixed variables

// === PART 1: Setup ===

C_OBJECT:C1216($resultLogs)
$resultLogs:=ds:C1482.IM_TransferLog.newSelection()
C_OBJECT:C1216($registerSelections; $1)
C_TEXT:C284($baseCurrency; $2)
C_REAL:C285($stage; $3)  // -1 = system pick; 0 = sandbox; 1 = production; 2 = staging
Case of 
	: (Count parameters:C259=1)
		$registerSelections:=$1
		$baseCurrency:="CAD"
		$stage:=-1
	: (Count parameters:C259=2)
		$registerSelections:=$1
		$baseCurrency:=$2
		$stage:=-1
	: (Count parameters:C259=3)
		$registerSelections:=$1
		$baseCurrency:=$2
		$stage:=$3
		ASSERT:C1129(($stage>=-1) & ($stage<3); "Unknown stage number: "+String:C10($stage))
	Else 
		EXECUTE METHOD:C1007("assertInvalidNumberOfParams"; *; Current method name:C684; Count parameters:C259)
End case 

If (IdentityMind_init)
	
	// === PART 4: Sending each record ==
	
	C_LONGINT:C283($sendingProgressID)
	$sendingProgressID:=Progress New
	Progress SET TITLE($sendingProgressID; "Sending transaction data to IdentityMind.")
	Progress SET BUTTON ENABLED($sendingProgressID; True:C214)
	Progress SET WINDOW VISIBLE(True:C214)
	
	C_BOOLEAN:C305($continue)
	$continue:=True:C214
	C_LONGINT:C283($registerCount)
	$registerCount:=$registerSelections.length
	C_OBJECT:C1216($register)
	For each ($register; $registerSelections) While ($continue)
		C_LONGINT:C283($registerIndex)
		$registerIndex:=$register.indexOf()
		C_TEXT:C284($message)
		$message:="Sending "+String:C10($registerIndex)+" of "+String:C10($registerCount)
		Progress SET MESSAGE($sendingProgressID; $message)
		Progress SET PROGRESS($sendingProgressID; $registerIndex/$registerCount)
		
		C_TEXT:C284($logEndpoint)
		
		// Perpare endpoint
		C_BOOLEAN:C305($isTransferIn)
		$isTransferIn:=$register.Credit>0
		
		If ($isTransferIn)
			IdentityMindEndpoint:="transferout"
		Else 
			IdentityMindEndpoint:="transferin"
		End if 
		$logEndpoint:=IdentityMindEndpoint
		
		// Send data
		IdentityMind_loadTransferData($register; $isTransferIn; $baseCurrency)
		
		If (IdentityMindInput#Null:C1517)
			If (IdentityMind_sendData(IdentityMindInput))
				
				// === PART 5: extract data from response + saving the data
				
				// Create and save a record
				C_OBJECT:C1216($resultLog)
				$resultLog:=ds:C1482.IM_TransferLog.new()
				
				$resultLog.RegisterID:=$register.RegisterID
				$resultLog.CustomerID:=$register.CustomerID
				$resultLog.InvoiceID:=$register.InvoiceNumber
				$resultLog.AccountID:=$register.AccountId
				
				$resultLog.Endpoint:=IdentityMindEndpoint
				$resultLog.Environment:=IdentityMindStage
				
				$resultLog.ResponseDate:=Current date:C33(*)
				$resultLog.ResponseTime:=Current time:C178(*)
				
				$resultLog.Report:=JSON Stringify:C1217(IdentityMindResponse)
				$resultLog.Result:=IdentityMindResponse.res
				$resultLog.FraudRuleFired:=IdentityMindResponse.frd
				
				$resultLog.save()
				$resultLogs.add($resultLog)
			End if 
		End if 
		If (Progress Stopped($sendingProgressID))
			$continue:=False:C215
		End if 
	End for each 
	Progress QUIT($sendingProgressID)
	Progress SET WINDOW VISIBLE(False:C215)
End if 
$0:=$resultLogs