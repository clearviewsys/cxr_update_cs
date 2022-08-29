//%attributes = {}
// Get the path to the folder holding endpoints, currency codes and country code JSON files

C_TEXT:C284($0)

$0:=Get 4D folder:C485(Current resources folder:K5:16)+"MG"+Folder separator:K24:12
