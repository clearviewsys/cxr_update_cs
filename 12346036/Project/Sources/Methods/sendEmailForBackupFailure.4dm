//%attributes = {}


//C_TEXT($email;$subject;$message;<>companyName;<>timeZone;<>companyTel1)

//$email:="tiran@clearviewsys.com"
//$subject:="CXR backup failed:"+<>companyName
//$message:="CXR "+getCurrentVersion +" backup Failed for "+<>companyName+" on "+String(Current date)+" at "+String(Current time)+" "+<>timeZone+CRLF 
//$message:=$message+Current machine+": "+Current system user+CRLF 
//$message:=$message+"Tel: "+<>companyTel1+" "+<>companycity+" "+<>companyCountry

//  //sendQuickEmailUsingJavaMailer($email;$subject;$message)
//If (<>administratorEmail#"")
//sendEmail (<>administratorEmail;$subject;$message)
//Else 
//  //sendEmail ("tiran@clearviewsys.com";$subject;$message)
//End if 

//If (<>administratorCellNo#"")  // send an sms for the administrator about backup failure
//SMS_sendQuickMessageFromTiran (<>administratorCellNo;$message)
//End if 