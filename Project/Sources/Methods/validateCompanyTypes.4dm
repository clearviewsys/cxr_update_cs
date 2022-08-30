//%attributes = {}

checkIfNullString(->[CompanyTypes:161]Code:1; "Code")
checkIfNullString(->[CompanyTypes:161]Description:3; "Description")

checkUniqueKey(->[CompanyTypes:161]; ->[CompanyTypes:161]Code:1; "Code")