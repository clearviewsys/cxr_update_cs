//%attributes = {}
//author: Amir
//13th Oct 2018
//fillArrWithRegisterYearRange(->$array)
//fills $array with years from min to max of [Registers]RegisterDate
C_POINTER:C301($arrPtr; $1)
$arrPtr:=$1
ASSERT:C1129(Type:C295($arrPtr)=Is pointer:K8:14; "Expected pointer to integer array")
ASSERT:C1129(Type:C295($arrPtr->)=Integer array:K8:18; "Expected pointer to integer array")
READ ONLY:C145([Registers:10])
QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2>!00-00-00!)
ORDER BY:C49([Registers:10]; [Registers:10]RegisterDate:2)
C_LONGINT:C283($minYear; $maxYear)
FIRST RECORD:C50([Registers:10])
$minYear:=Year of:C25([Registers:10]RegisterDate:2)
LAST RECORD:C200([Registers:10])
$maxYear:=Year of:C25([Registers:10]RegisterDate:2)
ARRAY INTEGER:C220($arrPtr->; $maxYear-$minYear+1)
C_LONGINT:C283($i)
For ($i; 1; $maxYear-$minYear+1)
	$arrPtr->{$i}:=$maxYear-$i+1  //descending order
End for 

