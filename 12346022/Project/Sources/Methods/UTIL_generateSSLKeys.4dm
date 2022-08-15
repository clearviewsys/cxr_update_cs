//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 10/05/17, 14:54:19
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: WEB_Generate_SSL_Keys
// Description
// 
//     http://kb.4d.com/assetid=75985
//
//   https://gethttpsforfree.com/  <--- use let's encrypt to get cert
//  -- end result is cert.pem from let's encrypt


//other cert auths
// openssl x509 -req -days 365 -in csr.txt -signkey key.pem -out cert.pem
//convert .crt to .pem from cert authority
//openssl x509 -in mycert.crt -out mycert.pem -outform PEM

// key.pem comes from 4D when you creaete the csr

// Parameters
// ----------------------------------------------------


C_TEXT:C284($tPath)

$tPath:=Get 4D folder:C485(Database folder:K5:14)

If (Test path name:C476($tPath+"key.pem")=Is a document:K24:1)  //already created so ignore
Else 
	// generate new Key Pair
	C_BLOB:C604($privKey; $pubKey)
	GENERATE ENCRYPTION KEYPAIR:C688($privKey; $pubKey; 2048)
	
	
	// Setup Certificate Signing Request information
	
	ARRAY LONGINT:C221($aiCodes; 6)
	ARRAY TEXT:C222($asInfos; 6)
	
	
	$aiCodes{1}:=13  // Common Name
	$aiCodes{2}:=14  // Country Name (2 Letters)
	$aiCodes{3}:=15  // Locality Name
	$aiCodes{4}:=16  // State or Province Name
	$aiCodes{5}:=17  // Organization Name
	$aiCodes{6}:=18  // Organization Unit
	
	$asInfos{1}:="dev.clearviewsys.com"  //UUrgGetParameter_Set("WebServer";"SSL_CommonName";"www.icomponline.com")
	$asInfos{2}:="CA"  //UUrgGetParameter_Set("WebServer";"SSL_Country";"US")
	$asInfos{3}:="Vancouver"  //UUrgGetParameter_Set("WebServer";"SSL_City";UUrgGetParameter("CompanyInfo";"City"))
	$asInfos{4}:="BC"  //UUrgGetParameter_Set("WebServer";"SSL_State";"Washington")
	$asInfos{5}:="Clearview Systems"  //UUrgGetParameter_Set("WebServer";"SSL_Company";UUrgGetParameter("CompanyInfo";"CompanyName"))
	$asInfos{6}:="Currency Exchange"  //UUrgGetParameter_Set("WebServer";"SSL_Unit";"Workers Comp")
	
	
	// generate CSR
	C_BLOB:C604($CSR)
	GENERATE CERTIFICATE REQUEST:C691($privKey; $CSR; $aiCodes; $asInfos)
	
	// save CSR to file
	BLOB TO DOCUMENT:C526($tPath+"csr.txt"; $CSR)
	
	// save private key to file
	BLOB TO DOCUMENT:C526($tPath+"key.pem"; $privKey)
	
	// save public key to file
	BLOB TO DOCUMENT:C526($tPath+"publickey.pem"; $pubKey)
	
	//now take these files and get signed by cert authority or use openssl to self sign and get a cert.pem
End if 

If (Application type:C494=4D Server:K5:6)
Else 
	//SHOW ON DISK($tPath)
End if 