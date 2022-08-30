//%attributes = {"publishedWeb":true}

C_TEXT:C284($1)
C_TEXT:C284($0)

C_TEXT:C284(captchaHtmlCode)
C_TEXT:C284($captchaKey)



$captchaKey:="6Lfs5UMUAAAAAJTz_rw7B7YRPip90d0akXSj7NtA"

captchaHtmlCode:=""

If (WAPI_isCaptchaOn)
	
	captchaHtmlCode:=captchaHtmlCode+"<div id='recaptcha-validation' class='g-recaptcha' "+CRLF
	captchaHtmlCode:=captchaHtmlCode+"data-sitekey='"+$captchaKey+"'"+CRLF
	captchaHtmlCode:=captchaHtmlCode+"data-callback='onCaptchaSuccess' "+CRLF
	captchaHtmlCode:=captchaHtmlCode+"data-bind='"+Substring:C12($1; 2)+"'> "+CRLF
	captchaHtmlCode:=captchaHtmlCode+"</div>"+CRLF
	
	captchaHtmlCode:=captchaHtmlCode+CRLF
	
	
	captchaHtmlCode:=captchaHtmlCode+"<script type='text/javascript'>"+CRLF
	captchaHtmlCode:=captchaHtmlCode+"var onCaptchaSuccess=function(response){"+CRLF
	captchaHtmlCode:=captchaHtmlCode+"console.log('Captcha Validation passed')"+CRLF
	
	//captchaHtmlCode:=captchaHtmlCode+"alert('Captcha Validation passed')"+CRLF 
	
	captchaHtmlCode:=captchaHtmlCode+"$('#recaptcha-validation').closest('form').submit();"+CRLF
	captchaHtmlCode:=captchaHtmlCode+"};"+CRLF
	captchaHtmlCode:=captchaHtmlCode+"</script>"+CRLF
End if 


$0:=Char:C90(1)+captchaHtmlCode
