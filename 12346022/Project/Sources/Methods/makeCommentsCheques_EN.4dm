//%attributes = {}
// makeCommentCashTransaction -> text

C_TEXT:C284($comments; $0)

If (<>useSentenceForACG=True:C214)
	
	If ([Cheques:1]isPaid:11)  // payment is paid to customer
		$comments:=$comments+"Cheque issued"
	Else   // payment is received 
		$comments:=$comments+"Cheque received"
	End if 
	$comments:=$comments+" for the amount of "+String:C10([Cheques:1]Amount:8)+" "+[Cheques:1]Currency:9  // Ex: Amount 1000 USD...
	$comments:=$comments+appendStringIfSucceded(" type "; [Cheques:1]chequeType:13)
	$comments:=$comments+appendStringIfSucceded(" no. "; [Cheques:1]ChequeNumber:4)
	$comments:=$comments+appendStringIfSucceded(" to the order of "; [Cheques:1]PayTo:15)
	
	If ([Cheques:1]DueDate:3>[Cheques:1]IssueDate:16)
		$comments:=$comments+appendStringIfSucceded(", postdated for "; String:C10([Cheques:1]DueDate:3))
	End if 
	
	$comments:=$comments+appendStringIfSucceded(" from bank "; [Cheques:1]Bank:12)
	$comments:=$comments+"."
Else 
	
	If ([Cheques:1]isPaid:11)  // payment is paid to customer
		$comments:="Cheque Paid"+CRLF
	Else   // payment is received 
		$comments:="Cheque Received"+CRLF
	End if 
	
	appendLabelString(->$comments; "Amount: "; String:C10([Cheques:1]Amount:8)+" "+[Cheques:1]Currency:9; True:C214)
	appendLabelString(->$comments; "Cheque Type: "; [Cheques:1]chequeType:13; True:C214)
	appendLabelString(->$comments; "Cheque No: "; [Cheques:1]ChequeNumber:4; True:C214)
	appendLabelString(->$comments; "To the order of: "; [Cheques:1]PayTo:15; True:C214)
	appendLabelString(->$comments; "Bank: "; [Cheques:1]Bank:12; True:C214)
	
	If ([Cheques:1]DueDate:3>[Cheques:1]IssueDate:16)
		appendLabelString(->$comments; "Post dated: "; String:C10([Cheques:1]DueDate:3))
	End if 
	
End if 

$0:=$comments
