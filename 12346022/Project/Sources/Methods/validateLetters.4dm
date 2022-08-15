//%attributes = {}

checkUniqueKey(->[Letters:52]; ->[Letters:52]LetterID:1; "LetterID")

checkIfNullString(->[Letters:52]Subject:3; "Subject")
checkIfNullString(->[Letters:52]Body:4; "Body of letter"; "warn")
