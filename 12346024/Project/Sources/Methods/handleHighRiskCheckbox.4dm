//%attributes = {}
// handleHighRiskCheckBox (self)
C_POINTER:C301($Self; $1)
$Self:=$1
handleTristateCheckBox($Self; ->[Customers:3]AML_HighRisk:24; "High Risk? "; "Customer is High Risk!"; "Customer is NOT High Risk!"; Black:K11:16; Red:K11:4; Blue:K11:7)
