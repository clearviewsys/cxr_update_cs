//%attributes = {}
// checks for existance of 4D Info component and launches reporting based on key values

C_LONGINT:C283($NP; $minutes)
C_TEXT:C284($interval)

If (Application type:C494=4D Server:K5:6)
	
	
	ARRAY TEXT:C222($at_Components; 0)
	
	COMPONENT LIST:C1001($at_Components)
	
	If (Find in array:C230($at_Components; "4D_Info_Report@")>0)
		
		If (getKeyValue("4d.info.launch")="true")
			
			$minutes:=30  // default to 30 minutes if key value not present
			
			$interval:=getKeyValue("4d.info.minutes")
			
			If ($interval#"")
				$minutes:=Num:C11($interval)
				If ($minutes=0)
					$minutes:=30
				End if 
			End if 
			
			$NP:=New process:C317("aa4D_NP_Schedule_Reports_Server"; 0; "$4DIR_NP"; $minutes; 0)
			
		End if 
		
	End if 
	
End if 
