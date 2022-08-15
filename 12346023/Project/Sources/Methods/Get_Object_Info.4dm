//%attributes = {}
//Get_Object_Info (->Object Field)

C_POINTER:C301($pObjectField)
C_LONGINT:C283($iCounter)
C_OBJECT:C1216($o)

$pObjectField:=$1

OB GET PROPERTY NAMES:C1232($pObjectField->; $aName; $arTypes)
C_TEXT:C284(tObjectInfo)
tObjectInfo:=""
For ($iCounter; 1; Size of array:C274($aName))
	C_TEXT:C284($tLabel; $tInfo)
	C_LONGINT:C283($iType)
	
	Case of 
		: ($pObjectField->[$aName{$iCounter}]=Null:C1517)
			
		: (Value type:C1509($pObjectField->[$aName{$iCounter}])=Is picture:K8:10)
			$tInfo:="<Picture>"
			tObjectInfo:=tObjectInfo+$aName{$iCounter}+": "+$tInfo+Char:C90(13)
			
		: (Value type:C1509($pObjectField->[$aName{$iCounter}])=Is object:K8:27)
			$o:=New object:C1471
			$o:=$pObjectField->[$aName{$iCounter}]
			tObjectInfo:=tObjectInfo+$aName{$iCounter}+" Object:"+Char:C90(13)+"  "+\
				Replace string:C233(Get_Object_Info(->$o); Char:C90(Carriage return:K15:38); Char:C90(Carriage return:K15:38)+"  ")
		Else 
			$tInfo:=OB Get:C1224($pObjectField->; $aName{$iCounter}; Is text:K8:3)
			tObjectInfo:=tObjectInfo+$aName{$iCounter}+": "+$tInfo+Char:C90(13)
	End case 
End for 

$0:=tObjectInfo