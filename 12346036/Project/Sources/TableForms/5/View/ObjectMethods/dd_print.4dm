C_LONGINT:C283($selection; $vlProcessID; $winRef; $starttime; $waittime)
C_TEXT:C284($isDoNotAskAgain)
C_OBJECT:C1216($form; $s_obj)

If (Form event code:C388=On Clicked:K2:4)
	$selection:=Self:C308->
	
	//Prompt User about custom print settings
	If (Shift down:C543)
		$isDoNotAskAgain:="false"
	Else 
		$isDoNotAskAgain:=getKeyValue("print.format.isDoNotAskAgain"; "false")
	End if 
	
	If ($isDoNotAskAgain#"true")
		$s_obj:=New shared object:C1526("isDone"; False:C215)
		$vlProcessID:=New process:C317("openPrintOptionsWindow"; 0; "openPrintOptionsWindow"; $s_obj)
		If ($vlProcessID#0)
			BRING TO FRONT:C326($vlProcessID)
		End if 
		
		Use ($s_obj)
			// loop while "openPrintOptionsWindow" process is running
			$starttime:=Milliseconds:C459
			$waittime:=Milliseconds:C459-$starttime
			While (Not:C34($s_obj.isDone))
				$waittime:=Milliseconds:C459-$starttime
			End while 
		End use 
	End if 
	
	Case of 
		: ($selection=1)  // tabular style
			printInvoiceUsingForm_v17("print_Tabular")
			
		: ($selection=2)  // large
			printInvoiceUsingForm_v17("print_Large")
			
		: ($selection=3)  // medium 
			printInvoiceUsingForm_v17("print_Medium")
			
		: ($selection=4)  // thermal
			printInvoiceUsingForm_v17("print_Thermal")
			
	End case 
	
End if 