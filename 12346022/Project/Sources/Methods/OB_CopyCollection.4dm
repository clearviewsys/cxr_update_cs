//%attributes = {}
// Method: OB_CopyCollection
// $1: Collection to copy from
// $2: Shared Collection to copy to

C_COLLECTION:C1488($1; $from; $2; $to)
C_LONGINT:C283($nSize; $nCount; $nElement; $nType)

$nSize:=$1.length
$from:=$1
$to:=$2

For ($nCount; 1; $nSize)
	$nElement:=$nCount-1
	$nType:=Value type:C1509($from[$nElement])
	Case of 
		: ($nType=Is object:K8:27)
			$to[$nElement]:=New shared object:C1526
			Use ($to[$nElement])
				
				OB_CopyToSharedObject($from[$nElement]; $to[$nElement])
				
			End use 
		: ($nType=Is collection:K8:32)
			$to[$nElement]:=New shared collection:C1527
			Use ($to[$nElement])
				OB_CopyCollection($from[$nElement]; $to[$nElement])
			End use 
		Else 
			$to[$nElement]:=$from[$nElement]
	End case 
End for 
