//%attributes = {}
// ------------------------------------------------------------------------------
//
// Funcion: FT_NextSequence ($seqName) -> Next Sequence
// Returns next sequence for an ID
// Get a new sequence
//
// Parameters:
//     $1: Sequence Id (input-String)
//     $2: initial Sequence (input-Longint)
//     $0: Next Sequence (Output - Longint)
// ------------------------------------------------------------------------------

C_TEXT:C284($1; $seqName)
C_LONGINT:C283($2; $nextSequence)
C_BOOLEAN:C305($3; $delete)

C_LONGINT:C283($nextSequence; $ticks; $0)
$delete:=False:C215

Case of 
		
	: (Count parameters:C259=1)
		$seqName:=$1
		$nextSequence:=1
		
	: (Count parameters:C259=2)
		$seqName:=$1
		$nextSequence:=$2
		
	: (Count parameters:C259=3)
		$seqName:=$1
		$nextSequence:=$2
		$delete:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


READ WRITE:C146([Sequence_Config:81])

QUERY:C277([Sequence_Config:81]; [Sequence_Config:81]Name:1=$seqName)

If ($delete)
	DELETE SELECTION:C66([Sequence_Config:81])
End if 

If (Records in selection:C76([Sequence_Config:81])=0)
	
	CREATE RECORD:C68([Sequence_Config:81])
	[Sequence_Config:81]Name:1:=$seqName
	[Sequence_Config:81]Next_Value:2:=$nextSequence
	SAVE RECORD:C53([Sequence_Config:81])
	
Else 
	
	Repeat   // Loop until the record is unlocked
		$ticks:=(Random:C100%(3))+1
		DELAY PROCESS:C323(Current process:C322; $ticks)
		LOAD RECORD:C52([Sequence_Config:81])  // Load record and set it to locked
	Until (Not:C34(Locked:C147([Sequence_Config:81])))
	
	$nextSequence:=[Sequence_Config:81]Next_Value:2
	[Sequence_Config:81]Next_Value:2:=[Sequence_Config:81]Next_Value:2+1
	SAVE RECORD:C53([Sequence_Config:81])  // Save the record
End if 

UNLOAD RECORD:C212([Sequence_Config:81])  // Let other users modify it
REDUCE SELECTION:C351([Sequence_Config:81]; 0)

$0:=$nextSequence