//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 11/04/16, 14:22:10
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: UTIL_getSQLTypeName
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($1; $iType)  //sql type number

C_TEXT:C284($0; $tName)  //sql type name


$iType:=$1


Case of 
	: ($iType=1) | ($iType=Boolean array:K8:21)  //Is Boolean
		$tName:="BOOLEAN"
		
	: ($iType=3) | ($iType=Integer array:K8:18)  //Is integer
		$tName:="INT"
		
	: ($iType=4) | ($iType=LongInt array:K8:19)  //Is longint
		$tName:="INT"
		
	: ($iType=5) | ($iType=LongInt array:K8:19)  //Is integer 64 bits
		$tName:="INT64"
		
	: ($iType=6) | ($iType=Real array:K8:17)  //Is real
		$tName:="REAL"
		
	: ($iType=7) | ($iType=Real array:K8:17)  //Is float
		$tName:="FLOAT"
		
	: ($iType=8) | ($iType=Date array:K8:20)  //Is date
		$tName:="TIMESTAMP"  //date
		
	: ($iType=9) | ($iType=LongInt array:K8:19)  //Is time
		$tName:="DURATION"  //time
		
	: ($iType=10) | ($iType=Text array:K8:16)  //Is alpha field  OR Is text
		$tName:="TEXT"
		
	: ($iType=12) | ($iType=Picture array:K8:22)  //Is picture
		$tName:="PICTURE"
		
		//: ($iType=18) | ($iType=Blob array)  //Is BLOB
		//$tName:="BLOB"
		
	Else 
		$tName:="TEXT"
End case 


//If (False)
//Case of 
//: ($data_type=1)
//$data_type_choice:=" UUID;"  // Alpha
//: ($data_type=2)
//$data_type_choice:=" TEXT;"  // Text
//: ($data_type=3)
//$data_type_choice:=" TIMESTAMP;"  // Date
//: ($data_type=4)
//$data_type_choice:=" DURATION;"  // Time
//: ($data_type=5)
//$data_type_choice:=" BOOLEAN;"  // Boolean
//: ($data_type=6)
//$data_type_choice:=" INT16;"  // Integer 16
//: ($data_type=7)
//$data_type_choice:=" INT;"  // Integer 32
//: ($data_type=8)
//$data_type_choice:=" INT64;"  // Integer 64
//: ($data_type=9)
//$data_type_choice:=" REAL;"  // Real
//: ($data_type=10)
//$data_type_choice:=" FLOAT;"  // Float
//: ($data_type=11)
//$data_type_choice:=" BLOB;"  // Blob
//: ($data_type=12)
//$data_type_choice:=" PICTURE;"  // Picture
//Else 
//$data_type_choice:=" TEXT;"
//End case 

//End if 


$0:=$tName