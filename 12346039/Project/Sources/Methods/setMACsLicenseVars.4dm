//%attributes = {}
// setMACsLicenseVars( settingName;expiryDate; expiryCount; ...)

// 0 : no view

// -1 : unlimited

// n : number of max records allowed


C_TEXT:C284($1)
C_DATE:C307($2)
C_LONGINT:C283($3; $4)


[MACs:18]SettingName:17:=$1
[MACs:18]ExpirationDate:2:=$2
[MACs:18]LaunchLimit:3:=$3
[MACs:18]OtherModulesLimit:16:=$4