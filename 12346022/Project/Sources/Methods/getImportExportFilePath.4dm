//%attributes = {}
// getimportTemplateName(->table)-> Path

C_POINTER:C301($1)
C_TEXT:C284($tableName)
C_TEXT:C284($importFileName; $importDirectory)


$tableName:=Table name:C256($1)
$importDirectory:=getImportExportFolderPath

$importFileName:=$importDirectory+$tableName+".4si"

$0:=$importFileName
