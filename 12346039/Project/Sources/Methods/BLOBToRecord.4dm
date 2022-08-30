//%attributes = {}
// BLOBtoRecord (->Table;->encodedBLOB)
// PRE: a record should be loaded or created
// POST: the record fields will get populated with the blob 
// see also: RecordToBLOB

// this method only loads the fields with the respective blob
// caller is in charge of loading, modifying or creating a new record
//

C_POINTER:C301($tablePtr; $1; $fieldPtr; $blobPtr)

$tablePtr:=$1
$blobPtr:=$2

C_BLOB:C604($blobArray; $blobRecord; $blobSizeofArray)
C_LONGINT:C283($i; $n; $offset; $length; $blobArrayLength)

$n:=Get last field number:C255($tablePtr)
ARRAY LONGINT:C221($arrSizes; $n)
BASE64 DECODE:C896($blobPtr->)  // before anything the blob has to be decoded

// first get the the first four bytes of the blob
COPY BLOB:C558($blobPtr->; $blobSizeOfArray; 0; 0; 9)  // fist four bytes keeps the size of the blob that holds the blobsize array
BLOB TO VARIABLE:C533($blobSizeOfArray; $blobArrayLength)

COPY BLOB:C558($blobPtr->; $blobArray; 9; 0; $blobArrayLength)  // copy the array part of the blob into the $blobArray
BLOB TO VARIABLE:C533($blobArray; $arrSizes)

$offset:=$blobArrayLength+9
//saveBLOBtoFile ($blobArray;"")

If ($n>0)
	For ($i; 1; $n)
		If (Is field number valid:C1000($tablePtr; $i))  // Jan 16, 2012 18:23:48 -- I.Barclay Berry 
			$fieldPtr:=Field:C253(Table:C252($tablePtr); $i)
			$length:=$arrSizes{$i}
			
			BLOBtofield($fieldPtr; $blobPtr; $offset; $length)
			$offset:=$offset+$length
		End if 
	End for 
End if 

