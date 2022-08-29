If (Form event code:C388=On Mouse Enter:K2:33)
	Form:C1466.statusDetails:="These are emails that we determined to be valid and safe to email to, they will have a very low bounce rate of under 2%. If you receive bounces it can be because your IP might be blacklisted where our IP was not. Sometimes the email accounts exist, bu"+"t they are only accepting mail from people in their contact lists. Sometimes you will get throttle on number of emails you can send to a specific domain per hour. It's important to look at the SMTP Bounce codes to determine why."
End if 

If (Form event code:C388=On Clicked:K2:4)
	Form:C1466.valid:=True:C214
End if 