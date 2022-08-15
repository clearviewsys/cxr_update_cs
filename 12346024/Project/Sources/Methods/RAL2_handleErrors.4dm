//%attributes = {}
//Method: RAL2_handleErrors
//Purpose: Takes in a response code from the RAL service, and displays 
//an appropriate error message. Returns True for a success, false otherwise

//Parameters
C_TEXT:C284($1; $response)
C_BOOLEAN:C305($0)
//Internal
C_TEXT:C284($message)

Case of 
	: (Count parameters:C259=1)
		$response:=$1
End case 

If ($response="0")
	$0:=True:C214
Else 
	Case of 
		: ($response="1")
			$0:=False:C215
			$message:="Error connecting to the server. Please try again later."
		: ($response="2")
			$0:=False:C215
			$message:="Incomplete or invalid inputs. Please double check any required fields."
		: ($response="3")
			$0:=False:C215
			$message:="Server temporarily unavailable. Please try again in a few minutes."
		: ($response="11")
			$0:=False:C215
			$message:="Registration not confirmed. Please activate your registration before continuing."
		: ($response="12")
			$0:=False:C215
			$message:="Account disabled."
		: ($response="13")
			$0:=False:C215
			$message:="Email is invalid."
		: ($response="14")
			$0:=False:C215
			$message:="Phone number is invalid."
		: ($response="15")
			$0:=False:C215
			$message:="Too many requests from the same location."
		: ($response="17")
			$0:=False:C215
			$message:="An account with that email already exists."
		: ($response="18")
			$0:=False:C215
			$message:="Client not found"
		: ($response="20")
			$0:=True:C214
			$message:="Trial license has been generated."
		: ($response="21")
			$0:=False:C215
			$message:="There is no application in they sytsem with that application ID."
		: ($response="22")
			$0:=False:C215
			$message:="Application license expired."
		: ($response="23")
			$0:=False:C215
			$message:="Monthly system hit limit reached."
		: ($response="24")
			$0:=False:C215
			$message:="Total system hit limit reached."
		: ($response="28")
			$0:=False:C215
			$message:="Client's Master License Record (MLR) not found."
		: ($response="29")
			$0:=False:C215
			$message:="Client's Master License Record (MLR) expired. No access to any application"
		: ($response="911")
			$0:=False:C215
			$message:="Service is not available temporarily due a disaster. Try again later."
	End case 
	myAlert($message)
End if 