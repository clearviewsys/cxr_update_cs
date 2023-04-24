//%attributes = {}

// ----------------------------------------------------
// User name (OS): Milan Adamov
// Date and time: 06.04.23, 21:46:51
// ----------------------------------------------------
// Method: changeAdminPassword
// Description
// 
//
// Parameters
// ----------------------------------------------------


#DECLARE($userID : Integer; $password : Text)->$newUserID : Integer

var $lastLogin : Date
var $name; $startup; $oldPassword : Text
var $nbLogin; $groupOwner : Integer


GET USER PROPERTIES:C611($userID; $name; $startup; $oldPassword; $nbLogin; $lastLogin; $memberships; $groupOwner)

$newUserID:=Set user properties:C612($userID; $name; $startup; $password; $nbLogin; $lastLogin; $memberships; $groupOwner)
