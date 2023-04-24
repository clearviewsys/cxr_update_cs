//%attributes = {}
C_COLLECTION:C1488($0)
C_TEXT:C284($mypage)

$mypage:=mgGetDocument("world.json")

If ($mypage#"")
	$0:=JSON Parse:C1218($mypage)
End if 

