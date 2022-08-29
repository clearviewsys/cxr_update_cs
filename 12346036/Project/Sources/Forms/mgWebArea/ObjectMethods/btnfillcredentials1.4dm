
waSetSelected(Form:C1466.mywa; "ddlLanguage"; "English")



mgFillCredentials(Form:C1466.credentials)

DELAY PROCESS:C323(Current process:C322; 120)

waClickOnElement(Form:C1466.mywa; "LoginButton")  // submit login form

