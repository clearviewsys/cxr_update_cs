//%attributes = {}
// getObjectProperties(objectName)
C_TEXT:C284($1; $objectName; $machineName)
$objectName:=$1
$machineName:=getCurrentMachineName
C_POINTER:C301($2; $isVisiblePtr; $3; $isEnterablePtr)
$isVisiblePtr:=$2
$isEnterablePtr:=$3
C_LONGINT:C283($i)

READ ONLY:C145([ObjectProperties:44])
QUERY:C277([ObjectProperties:44]; [ObjectProperties:44]machineName:1=$machineName; *)
QUERY:C277([ObjectProperties:44];  | ; [ObjectProperties:44]machineName:1="")

QUERY SELECTION:C341([ObjectProperties:44]; [ObjectProperties:44]machineName:1=$machineName; *)
QUERY SELECTION:C341([ObjectProperties:44];  | ; [ObjectProperties:44]machineName:1="")

QUERY SELECTION:C341([ObjectProperties:44]; [ObjectProperties:44]tableName:2=Table:C252(Current form table:C627); *)
QUERY SELECTION:C341([ObjectProperties:44];  | ; [ObjectProperties:44]tableName:2="")

//QUERY SELECTION([ObjectProperties];[ObjectProperties]objectName=$objectName;*)
//QUERY SELECTION([ObjectProperties]; | ;[ObjectProperties]objectName=$objectName+"@")
FIRST RECORD:C50([ObjectProperties:44])
For ($i; 1; Records in selection:C76([ObjectProperties:44]))
	OBJECT SET VISIBLE:C603(*; [ObjectProperties:44]objectName:4; [ObjectProperties:44]isVisible:5)
	OBJECT SET ENTERABLE:C238(*; [ObjectProperties:44]objectName:4; [ObjectProperties:44]isEnterable:6)
	NEXT RECORD:C51([ObjectProperties:44])
End for 
