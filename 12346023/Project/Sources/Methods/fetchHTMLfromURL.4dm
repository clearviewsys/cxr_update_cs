//%attributes = {}
// fetchHTMLfromURL( domainName; subURL)->HTML
// ex: fetchHTMLfromURL ("apple.com";"store")

C_TEXT:C284($0; $1; $2)
C_BLOB:C604($blob)

$blob:=fetchBLOBfromURL($1; $2)
$0:=BLOB to text:C555($blob; Mac Pascal string:K22:8)