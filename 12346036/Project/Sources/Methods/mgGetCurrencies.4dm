//%attributes = {}
C_OBJECT:C1216($0)
C_TEXT:C284($mypage)

$mypage:=mgGetDocument("currencies.json")

If ($mypage#"")
	$0:=JSON Parse:C1218($mypage)
End if 


