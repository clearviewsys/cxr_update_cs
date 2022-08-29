//%attributes = {}
//queryEntitySelection

C_OBJECT:C1216($entitySelection; $1; $settings; $3; $0)
C_TEXT:C284($queryString; $2)

$entitySelection:=$1
$queryString:=$2
$settings:=$3

$0:=$entitySelection.query($queryString; $settings)
