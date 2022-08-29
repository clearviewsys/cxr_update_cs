//%attributes = {}
// exportToTextFile (->listbox;path)
// WARNING: all numeric columns should have an object name with the prefix num_

C_POINTER:C301($1)
C_TEXT:C284($2)

listbox_exportWithDelimiters($1; $2; Char:C90(Tab:K15:37); Char:C90(LF ASCII code:K15:11))