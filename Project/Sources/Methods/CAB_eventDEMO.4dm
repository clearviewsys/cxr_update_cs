//%attributes = {}

C_TIME:C306($start; $end)

$start:=Current time:C178

If (getKeyValue("CAB.testMode"; "false")="true")
	iH_Notify("Importing csv"; String:C10(Current time:C178)+" data importing")
End if 

CAB_log("Purging old data:"; String:C10(Current time:C178))

disableTriggers


If (getKeyValue("CAB.testMode"; "false")="true")
	TRUNCATE TABLE:C1051([Registers:10])
	TRUNCATE TABLE:C1051([Invoices:5])
	TRUNCATE TABLE:C1051([AML_Alerts:137])
End if 

CAB_log("Importing csv"; String:C10(Current time:C178)+" data importing")

CAB_eventImportCsv

enableTriggers

If (getKeyValue("CAB.useVpn"; "true")="true")
	If (getKeyValue("CAB.testMode"; "false")="true")
		iH_Notify("Running Rules"; String:C10(Current time:C178)+" updating customers")
	End if 
	CAB_log("Updating customers. "+String:C10(Current time:C178))
	CAB_eventUpdateCustomers
End if 

If (getKeyValue("CAB.testMode"; "false")="true")
	iH_Notify("Running Rules"; String:C10(Current time:C178))
End if 
CAB_log("Running rules. "+String:C10(Current time:C178))
CAB_eventRunRules

$end:=Current time:C178
CAB_log("Process completed in: "+String:C10($end-$start)+" seconds.")


If (getKeyValue("CAB.testMode"; "false")="true")
	iH_Notify("Process Time"; "This took: "+String:C10($end-$start)+" seconds.")
	displayLboxAML_Alerts
End if 



