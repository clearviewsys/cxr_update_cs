//%attributes = {}
// getModuleFieldPtr (->table)->fieldPtr (field pointer of the module in MACs table)

C_POINTER:C301($1; $0; $fieldPtr)

$fieldPtr:=->[MACs:18]OtherModulesLimit:16


$0:=$fieldPtr