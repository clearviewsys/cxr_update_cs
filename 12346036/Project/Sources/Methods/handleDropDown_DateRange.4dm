//%attributes = {}
// handlePopupDateRange ( {widgetPtr {;->fromDate {;->toDate}}})
// e.g. handlePopu

READ ONLY:C145([DateRanges:57])
C_POINTER:C301($fromDatePtr; $toDatePtr)
C_POINTER:C301($dateWidgetPtr; $1)

Case of 
	: (Count parameters:C259=0)
		$dateWidgetPtr:=Self:C308
		
	: (Count parameters:C259=1)
		$dateWidgetPtr:=$1
		$fromDatePtr:=->vFromDate
		$toDatePtr:=->vToDate
		
	: (Count parameters:C259=3)
		$dateWidgetPtr:=$1
		$fromDatePtr:=$2
		$toDatePtr:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		ALL RECORDS:C47([DateRanges:57])
		ARRAY TEXT:C222($dateWidgetPtr->; 0)
		ORDER BY:C49([DateRanges:57]; [DateRanges:57]DateRangeID:1)
		SELECTION TO ARRAY:C260([DateRanges:57]DateRangeID:1; $dateWidgetPtr->)
		INSERT IN ARRAY:C227($dateWidgetPtr->; 1; 1)
		$dateWidgetPtr->{0}:="Pick Date Range..."
		$dateWidgetPtr->{1}:="Pick Date Range..."
		
	: (Form event code:C388=On Clicked:K2:4)
		
		
		QUERY:C277([DateRanges:57]; [DateRanges:57]DateRangeID:1=$dateWidgetPtr->{$dateWidgetPtr->})
		If (Records in selection:C76([DateRanges:57])>=1)
			OK:=1
		Else 
			C_TEXT:C284($DateRangeIDPtr)
			pickDateRanges(->$DateRangeIDPtr)
			If (ok=1)
				C_LONGINT:C283($ifound)
				$ifound:=Find in array:C230($dateWidgetPtr->; $DateRangeIDPtr)
				If ($iFound>=1)
					$dateWidgetPtr->:=$ifound
				Else 
					INSERT IN ARRAY:C227($dateWidgetPtr->; 2; 1)
					$dateWidgetPtr->{2}:=$DateRangeIDPtr
					$dateWidgetPtr->:=2
				End if 
				
			End if 
			
			
		End if 
		
		If (OK=1)
			$fromDatePtr->:=[DateRanges:57]fromDate:2
			$toDatePtr->:=[DateRanges:57]toDate:3
		End if 
		
End case 