//%attributes = {}
//IM_preformTransferRelatedTasks($option)
// Form Events : OnLoad, OnOutsideCall
// #ORDA - only for $registers in send option
// $options = one of of "send", "detailing", "initalize"
// Author: Wai-Kin

C_TEXT:C284($1; $option)

Case of 
	: (Count parameters:C259=1)
		$option:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_LONGINT:C283($i)

If (getKeyValue("identityMind.activated")="true")
	
	C_BOOLEAN:C305($updateResults)
	$updateResults:=False:C215
	
	Case of 
		: ($option="send")
			C_OBJECT:C1216($registers)
			$registers:=Create entity selection:C1512([Registers:10])
			C_OBJECT:C1216($logs)
			// The following syntax error will be fix with newer IdentityMind component
			$logs:=IM_evaluateMoneyTransfers($registers; <>baseCurrency)
			USE ENTITY SELECTION:C1513($logs)
			$updateResults:=True:C214
			
		: ($option="detailing")
			C_REAL:C285($row; $column)
			LISTBOX GET CELL POSITION:C971(*; "IMListBox"; $column; $row)
			$logs:=Create entity selection:C1512([IM_TransferLog:133])
			IM_showDetailTransferReport($logs[$row-1])
			
		: ($option="initalize")
			If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
				$updateResults:=True:C214
			End if 
	End case 
	
	If ($updateResults)
		QUERY:C277([IM_TransferLog:133]; [IM_TransferLog:133]InvoiceID:13; =; [Invoices:5]InvoiceID:1; *)
		QUERY:C277([IM_TransferLog:133]; [IM_TransferLog:133]Environment:10; =; IM_getEnviornment)
		If (Records in selection:C76([IM_TransferLog:133])=0)
			IM_transfer_result:=""
			OBJECT SET ENABLED:C1123(*; "b_sendToIM"; True:C214)
			OBJECT SET RGB COLORS:C628(*; "IM_result"; Foreground color:K23:1; Background color:K23:2)
			OBJECT SET RGB COLORS:C628(*; "b_identityMind"; Foreground color:K23:1; Background color:K23:2)
		Else 
			IM_transfer_result:="ACCEPT"
			OBJECT SET ENABLED:C1123(*; "b_sendToIM"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "IM_result"; 0x004CBB17; Background color:K23:2)
			OBJECT SET RGB COLORS:C628(*; "b_identityMind"; 0x004CBB17; Background color:K23:2)  // Green = Pass
			
			For ($i; 1; Records in selection:C76([IM_TransferLog:133]))
				GOTO SELECTED RECORD:C245([IM_TransferLog:133]; $i)
				Case of 
					: ([IM_TransferLog:133]Result:6="DENY")
						IM_transfer_result:="DENY"
						OBJECT SET RGB COLORS:C628(*; "IM_result"; 0x00FF0000; Background color:K23:2)
						OBJECT SET RGB COLORS:C628(*; "b_identityMind"; 0x00FF0000; Background color:K23:2)  // Red = Failed
						$i:=Records in selection:C76([IM_TransferLog:133])
					: ([IM_TransferLog:133]Result:6="MANUAL_REVIEW")
						IM_transfer_result:="MANUAL_REVIEW"
						OBJECT SET RGB COLORS:C628(*; "IM_result"; 0xA9A9A900; Background color:K23:2)
						OBJECT SET RGB COLORS:C628(*; "b_identityMind"; 0xA9A9A900; Background color:K23:2)  // Yellow = Review
				End case 
			End for 
		End if 
	End if 
End if 