//%attributes = {}
// makeCommentCashTransaction -> text

C_TEXT:C284($comments; $0)
$comments:="Montant de "+String:C10([Cheques:1]Amount:8)+" "+[Cheques:1]Currency:9  // Ex: Amount 1000 USD...


If ([Cheques:1]isPaid:11)  // payment is paid to customer
	$comments:=$comments+" payé par chèque"
Else   // payment is received 
	$comments:=$comments+" reçu par chèque"
End if 

$comments:=$comments+appendStringIfSucceded(" type "; [Cheques:1]chequeType:13)
$comments:=$comments+appendStringIfSucceded(" no. "; [Cheques:1]ChequeNumber:4)
$comments:=$comments+appendStringIfSucceded(" à l’ordre de "; [Cheques:1]PayTo:15)

If ([Cheques:1]DueDate:3>[Cheques:1]IssueDate:16)
	$comments:=$comments+appendStringIfSucceded(" daté pour le "; String:C10([Cheques:1]DueDate:3))
End if 

$comments:=$comments+appendStringIfSucceded(" de la banque "; [Cheques:1]Bank:12)

$0:=$comments+"."

