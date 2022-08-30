//%attributes = {}
C_TEXT:C284($test)
$test:="2346 Main Street"
$test:=IdentityMind_reformatAddress($test)
ASSERT:C1129($test="2346 Main Street")

$test:="123 2nd Ave."
$test:=IdentityMind_reformatAddress($test)
ASSERT:C1129($test="123 2nd Ave.")

$test:="234-123 Joyce Ave."
$test:=IdentityMind_reformatAddress($test)
ASSERT:C1129($test="123 Joyce Ave.")

$test:="236324-123 2nd Ave."
$test:=IdentityMind_reformatAddress($test)
ASSERT:C1129($test="123 2nd Ave.")

ALERT:C41("DONE")