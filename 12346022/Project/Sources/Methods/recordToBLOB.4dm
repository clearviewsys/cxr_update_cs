//%attributes = {}
// recordtoBLOB (->Table) => BLOB
// PRE: a record should be selected
// BLOB STRUCTURE
// _____________________
// 4 BYTE: SIZE OF ARRAY (bytes: 0 to 3)
// X BYTES: ARRAY OF size of serialized fields to BLOBS (bytes: 4 to x+4)
// Y Bytes: 

C_POINTER:C301($tablePtr; $1; $fieldPtr)
$tablePtr:=$1


C_BLOB:C604($blob1; $blob_ArrSizes; $0)
C_LONGINT:C283($i; $n; $fieldType; $fieldLength; $m1; $m2)
C_LONGINT:C283($SizeOfBLOB)

$n:=Get last field number:C255($tablePtr)
ARRAY LONGINT:C221($arrSizes; $n)

If ($n>0)
	For ($i; 1; $n)
		If (Is field number valid:C1000($tablePtr; $i))  // Jan 16, 2012 18:30:18 -- I.Barclay Berry 
			$fieldPtr:=Field:C253(Table:C252($tablePtr); $i)
			$m1:=BLOB size:C605($blob1)
			fieldToBLOB($fieldPtr; ->$blob1)
			$m2:=BLOB size:C605($blob1)
			$arrSizes{$i}:=$m2-$m1
		End if 
	End for 
	
	VARIABLE TO BLOB:C532($arrSizes; $blob_ArrSizes)  // serializes the array into a blob
	$SizeOfBLOB:=BLOB size:C605($blob_ArrSizes)  // keep the size of the blob of array
	
	concatenateBLOBs(->$blob_ArrSizes; ->$blob1)  // attach the record blob to the end of the array blob
	
	
	VARIABLE TO BLOB:C532($SizeOfBLOB; $bigBLOB)  // after this command $bigBLOB should be 4 bytes
	concatenateBLOBs(->$bigBLOB; ->$blob_ArrSizes)
	//saveBLOBtoFile($bigBLOB;"")
	BASE64 ENCODE:C895($bigBLOB)
	$0:=$bigBLOB
End if 

