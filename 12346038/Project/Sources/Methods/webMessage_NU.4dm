//%attributes = {"publishedWeb":true}

// webMessage ($message;$type): 
// Prepare the HTML Message to send to the web page

C_TEXT:C284($1; $message; $shortMsg; $html; $template; webErrorMessage)
C_LONGINT:C283($2; $type)

// Types:1: Ok Message, 2: Info Msg, 3: Warning, 4: Error


$template:=""
$template:=$template+" <div class='error-message'>"
$template:=$template+"     <div class='row'>"
$template:=$template+"         <div class='col-sm-12 col-md-12'>"

$template:=$template+"             <div class='alert alert-_CLASS_' data-auto-dismiss='7000'>"
$template:=$template+"                  <button type='button' class='close' data-dismiss='alert' aria-hidden='true'>x</button>"
$template:=$template+"                      <span class='glyphicon glyphicon-_ICON_'></span>&nbsp;<strong>_SHORT_MESSAGE_</strong>"
$template:=$template+"                  <hr class='message-inner-separator'>"
$template:=$template+"                  <p>_LONG_MESSAGE_.</p>"
$template:=$template+"             </div>"

$template:=$template+"         </div>"
$template:=$template+"     </div>"
$template:=$template+" </div>"

Case of 
		
	: (Count parameters:C259=1)
		
		$message:=$1
		$type:=3  // Warning
		
	: (Count parameters:C259=2)
		
		$message:=$1
		$type:=$2
		
End case 

Case of 
		
	: ($type=1)
		
		$html:=Replace string:C233($template; "_CLASS_"; "success")
		$html:=Replace string:C233($html; "_ICON_"; "ok")
		$html:=Replace string:C233($html; "_SHORT_MESSAGE_"; "Success Message")
		$html:=Replace string:C233($html; "_LONG_MESSAGE_"; $message)
		
	: ($type=2)
		
		$html:=Replace string:C233($template; "_CLASS_"; "info")
		$html:=Replace string:C233($html; "_ICON_"; "info-sign")
		$html:=Replace string:C233($html; "_SHORT_MESSAGE_"; "Info Message")
		$html:=Replace string:C233($html; "_LONG_MESSAGE_"; $message)
		
	: ($type=3)
		
		$html:=Replace string:C233($template; "_CLASS_"; "warning")
		$html:=Replace string:C233($html; "_ICON_"; "record")
		$html:=Replace string:C233($html; "_SHORT_MESSAGE_"; "Warning Message")
		$html:=Replace string:C233($html; "_LONG_MESSAGE_"; $message)
		
	: ($type=4)
		
		$html:=Replace string:C233($template; "_CLASS_"; "danger")
		$html:=Replace string:C233($html; "_ICON_"; "hand-right")
		$html:=Replace string:C233($html; "_SHORT_MESSAGE_"; "Error Message")
		$html:=Replace string:C233($html; "_LONG_MESSAGE_"; $message)
End case 

webErrorMessage:=$html

