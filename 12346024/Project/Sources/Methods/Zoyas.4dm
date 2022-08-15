//%attributes = {}
C_OBJECT:C1216($obj)

ALERT:C41(String:C10(ds:C1482.SanctionLists.all().last().MatchType))
$obj:=ds:C1482.SanctionLists.query("ShortName = :1"; "PEP")
ALERT:C41(String:C10($obj#Null:C1517))
