C_LONGINT:C283($selected)
C_OBJECT:C1216($selection; $entity)
$selected:=Selected record number:C246([IM_KYCLog:144])
$selection:=Create entity selection:C1512([IM_KYCLog:144])
$entity:=$selection[$selected-1]
IM_showDetailKYCReport($entity)
