//%attributes = {}
C_TEXT:C284($1)
C_BOOLEAN:C305($0)
C_LONGINT:C283($p)

ARRAY TEXT:C222($invalidFields; 0)

APPEND TO ARRAY:C911($invalidFields; "parent_timestamp")
APPEND TO ARRAY:C911($invalidFields; "field_timestamp._Sync_Data")
APPEND TO ARRAY:C911($invalidFields; "field_timestamp._sync_id")
APPEND TO ARRAY:C911($invalidFields; "field_timestamp._sync_hash")
APPEND TO ARRAY:C911($invalidFields; "field_timestamp.customerid")
APPEND TO ARRAY:C911($invalidFields; "field_timestamp.uuid")

$p:=Find in array:C230($invalidFields; $1)
$0:=Not:C34(($p>0))

