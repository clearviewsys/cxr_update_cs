//%attributes = {}
// concatenateBLOBs (->blob1; ->blob2) 
// appends blob2 to tail of blob1 and therefore blob 1 gets longer

C_POINTER:C301($1; $2; $blob1Ptr; $blob2Ptr)

$blob1Ptr:=$1
$blob2Ptr:=$2

COPY BLOB:C558($blob2Ptr->; $blob1Ptr->; 0; BLOB size:C605($blob1Ptr->); BLOB size:C605($blob2Ptr->))  // append $blob2 to end of $blob1