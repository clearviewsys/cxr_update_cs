//%attributes = {}
// handleCBfeeStructure (->foreignFee; ->percentFee; ->serviceFee)

C_TEXT:C284($feeStructureID)
C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8; $9)

If (Form event code:C388=On Load:K2:1)
	
	ARRAY TEXT:C222(cbFeeStructure; 0)
	READ ONLY:C145([FeeStructures:38])
	ALL RECORDS:C47([FeeStructures:38])
	SELECTION TO ARRAY:C260([FeeStructures:38]FeeStructureID:1; cbFeeStructure)
	If (Size of array:C274(cbFeeStructure)>0)  // if at least one selection exist in the combo box
		cbFeeStructure:=0
		$feeStructureID:=cbFeeStructure{1}  // the first item in the list
		cbFeeStructure{0}:=[Invoices:5]feeStructureID:32  // set the default valude
	End if 
	//getFeeStructure ($feeStructureID;$1;$2;$3;$4;$5;$6;$7;$8;$9)
	
	// once the form is loaded, assign the default value of the box to the field
	
Else 
	If (Size of array:C274(cbFeeStructure)>0)  // if at least one selection exist in the combo box
		$feeStructureID:=cbFeeStructure{0}
	End if 
	
	Case of 
		: (Count parameters:C259>=9)
			getFeeStructure($feeStructureID; $1; $2; $3; $4; $5; $6; $7; $8; $9)
		Else 
			getFeeStructure($feeStructureID; $1; $2; $3; $4; $5; $6; $7; $8)
	End case 
	
	[Invoices:5]feeStructureID:32:=$feeStructureID
End if 