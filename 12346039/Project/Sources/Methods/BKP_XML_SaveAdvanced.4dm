//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jonathan Le
// Date and time: 04/02/04, 09:26:54
// ----------------------------------------------------
// Method: BKP_XML_SaveAdvanced
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TIME:C306($1; $0; $tiDocRef)
C_LONGINT:C283($i; $k)
C_TEXT:C284($tTimeoutVal)

$tiDocRef:=$1

// initialize variables
If (TimeoutVal<10)
	$tTimeoutVal:="0"+String:C10(TimeoutVal)
Else 
	$tTimeoutVal:=String:C10(TimeoutVal)
End if 

Timeout:="00:"+$tTimeoutVal+":00-"+<>TimeOffset
TryToBackupAfter:=TryToBackupChoice{TryToBackupChoice}
TryBackupAtTheNextScheduledDate:=TryBackupOnDate
CompressionRate:=CompressionChoice{CompressionChoice}
Interlacing:=InterlacingChoice{InterlacingChoice}
Redondancy:=RedundancyChoice{RedundancyChoice}

// set the segmentation size based on the selection in the list
If (SegmentChoice{SegmentChoice}#"None")
	FileSegmentation_DefaultSize:=Num:C11(SegmentChoice{SegmentChoice})
Else 
	FileSegmentation_DefaultSize:=0
End if 

// set the before or after backup option
If (EraseOldChoice{EraseOldChoice}="before")
	EraseOldBackupBefore:=1
Else 
	EraseOldBackupBefore:=0
End if 

// handle Transaction
ARRAY TEXT:C222($aTransaction; 0)
ARRAY TEXT:C222($aTransactionVals; 0)
ARRAY TEXT:C222($aWorkNames; 0)

COPY ARRAY:C226(aAdvancedNames; $aWorkNames)

For ($i; 1; Size of array:C274($aWorkNames))
	
	If ($i<=Size of array:C274($aWorkNames))
		If (($aWorkNames{$i}="Timeout")) | (($aWorkNames{$i}="WaitForEndOfTransaction"))
			
			APPEND TO ARRAY:C911($aTransaction; $aWorkNames{$i})
			APPEND TO ARRAY:C911($aTransactionVals; BKP_GetTextVal($aWorkNames{$i}))
			
			DELETE FROM ARRAY:C228($aWorkNames; $i)
			$i:=$i-1
			
		End if 
	End if 
	
End for 

// top element
SAX OPEN XML ELEMENT:C853($tiDocRef; "Advanced")

// we have special cases to handle so do them first
SAX OPEN XML ELEMENT:C853($tiDocRef; "Transaction")

For ($i; 1; Size of array:C274($aTransaction))
	SAX OPEN XML ELEMENT:C853($tiDocRef; $aTransaction{$i})
	SAX ADD XML ELEMENT VALUE:C855($tiDocRef; $aTransactionVals{$i})
	SAX CLOSE XML ELEMENT:C854($tiDocRef)
End for 

SAX CLOSE XML ELEMENT:C854($tiDocRef)

// handle BackupFail
ARRAY TEXT:C222($aBackupFail; 0)
ARRAY TEXT:C222($aBackupFailVals; 0)

For ($i; 1; Size of array:C274($aWorkNames))
	
	If ($i<=Size of array:C274($aWorkNames))
		Case of 
			: (($aWorkNames{$i}="TryBackupAtTheNextScheduledDate") | ($aWorkNames{$i}="TryToBackupAfter"))
				
				APPEND TO ARRAY:C911($aBackupFail; $aWorkNames{$i})
				APPEND TO ARRAY:C911($aBackupFailVals; BKP_GetTextVal($aWorkNames{$i}))
				
				DELETE FROM ARRAY:C228($aWorkNames; $i)
				$i:=$i-1
		End case 
		
	End if 
	
End for 

// we have special cases to handle so do them first
SAX OPEN XML ELEMENT:C853($tiDocRef; "BackupFailure")

For ($i; 1; Size of array:C274($aBackupFail))
	SAX OPEN XML ELEMENT:C853($tiDocRef; $aBackupFail{$i})
	SAX ADD XML ELEMENT VALUE:C855($tiDocRef; $aBackupFailVals{$i})
	SAX CLOSE XML ELEMENT:C854($tiDocRef)
End for 

SAX CLOSE XML ELEMENT:C854($tiDocRef)

C_BOOLEAN:C305($isOpen)
C_TEXT:C284($tNextOpen; $tOpen)

// handle the rest
For ($i; 1; Size of array:C274($aWorkNames))
	
	// check if these tags had more depth
	$tNextOpen:=$aWorkNames{$i}
	
	If (Position:C15("_"; $tNextOpen)#0)
		
		$tOpen:=Substring:C12($aWorkNames{$i}; 0; Position:C15("_"; $aWorkNames{$i})-1)
		
		If (Not:C34($isOpen))
			SAX OPEN XML ELEMENT:C853($tiDocRef; $tOpen)
			$isOpen:=True:C214
		End if 
		
		$tNextOpen:=Substring:C12($aWorkNames{$i}; Position:C15("_"; $aWorkNames{$i})+1)
		If (Position:C15("_"; $tNextOpen)=0)
			
			// no more depths, write the data
			SAX OPEN XML ELEMENT:C853($tiDocRef; $tNextOpen)
			SAX ADD XML ELEMENT VALUE:C855($tiDocRef; BKP_GetTextVal($aWorkNames{$i}))
			SAX CLOSE XML ELEMENT:C854($tiDocRef)
			
		End if 
		
	Else 
		
		If ($isOpen)
			$isOpen:=False:C215
			SAX CLOSE XML ELEMENT:C854($tiDocRef)
		End if 
		
		// open, add value, close
		SAX OPEN XML ELEMENT:C853($tiDocRef; $tNextOpen)
		SAX ADD XML ELEMENT VALUE:C855($tiDocRef; BKP_GetTextVal($aWorkNames{$i}))
		SAX CLOSE XML ELEMENT:C854($tiDocRef)
		
	End if 
	
End for 

// top element
SAX CLOSE XML ELEMENT:C854($tiDocRef)

$0:=$tiDocRef

