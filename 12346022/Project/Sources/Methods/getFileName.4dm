//%attributes = {}
// getFileName ( $filePath )
// Returns the base name of the given path.
// i.e.: if path is "C:\Users\admin\Desktop\DB\ClearViewSystems.4DB" wil return "ClearViewSystems.4DB"

C_TEXT:C284($1; $0; $filePath)
C_LONGINT:C283($lf; $p; $start)

$filePath:=$1

$start:=1
Repeat 
	$p:=Position:C15(Folder separator:K24:12; $filePath; $start; $lf)
	$start:=$start+1
Until ($p=0)

$0:=Substring:C12($filePath; $start-1)
