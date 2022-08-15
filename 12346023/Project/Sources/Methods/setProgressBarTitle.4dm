//%attributes = {}
// setProgressParams (progressID; title)

C_LONGINT:C283($progressID; $1)
C_TEXT:C284($title; $2)

$progressID:=$1
$title:=$2

SET PROCESS VARIABLE:C370($progressID; vProgressTitle; $title)