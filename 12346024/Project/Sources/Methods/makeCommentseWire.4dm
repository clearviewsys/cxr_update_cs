//%attributes = {}
// makeCommentseWire

C_TEXT:C284($0; $subject; $value)

RELATE ONE:C42([eWires:13]LinkID:8)

If ([eWires:13]isCancelled:34)
	If ([eWires:13]isPaymentSent:20)  // customer to link
		$subject:=" > THIS EWIRE IS CANCELLED"
	Else   // link to customer
		$subject:="THIS EWIRE IS CANCELLED"
	End if 
Else 
	
	If ([eWires:13]isPaymentSent:20)
		appendLabelString(->$subject; "Send eWire: "; [eWires:13]eWireID:1; True:C214)
		
		//@Zoya - 25 Aug 2021
		$value:=Storage:C1525.keyValues["ewire.tomop.cash"]
		If ([eWires:13]toMOP_Code:114=$value)
			appendLabelString(->$subject; "Security Code: "; [eWires:13]securityChallengeCode:75; True:C214)
		End if 
		
		//appendLabelString (->$subject;"Sender: ";[eWires]SenderName;True)
		appendLabelString(->$subject; "Amount Sent: "; String:C10([eWires:13]ToAmount:14; "|Currency (blank for 0)")+" "+[eWires:13]Currency:12; True:C214)
		
		appendLabelString(->$subject; "From "; [eWires:13]fromCountry:9+" to "+[eWires:13]toCountry:10; True:C214)
		
		appendLabelString(->$subject; "Beneficiary Name: "; [eWires:13]BeneficiaryFullName:5; True:C214)
		appendLabelString(->$subject; "Local Spelling"; [eWires:13]BeneficiaryUNICODEName:62; True:C214)
		appendLabelString(->$subject; "Relationship: "; [eWires:13]BeneficiaryRelationship:64; True:C214)
		
		appendLabelString(->$subject; "Ben. Cell: "; [eWires:13]BeneficiaryCellPhone:61; True:C214)
		appendLabelString(->$subject; "Ben.  Email: "; [eWires:13]BeneficiaryEmail:63; True:C214)
		appendLabelString(->$subject; "Ben.  Address: "; [eWires:13]BeneficiaryAddress:59; True:C214)
		appendLabelString(->$subject; "Ben.  City: "; [eWires:13]BeneficiaryCity:60; True:C214)
		
		If ([eWires:13]doTransferToBank:33)
			appendLabelString(->$subject; "__________________________"; "________"; True:C214)
			
			appendLabelString(->$subject; "Bank Name: "; [eWires:13]BeneficiaryBankName:76; True:C214)
			appendLabelString(->$subject; "Bank Account#: "; [eWires:13]BeneficiaryBankAccountNo:66; True:C214)
			appendLabelString(->$subject; "SWIFT: "; [eWires:13]BeneficiarySWIFT:105; True:C214)
			appendLabelString(->$subject; "Branch Transit/IBAN: "; [eWires:13]BeneficiaryBankTransitCode:77; True:C214)
			appendLabelString(->$subject; "Bank Address: "; [Links:17]BankAddress:30; True:C214)
			appendLabelString(->$subject; "Other Banking Details: "; [eWires:13]BeneficiaryBankDetails:38; True:C214)
			appendLabelString(->$subject; "Special Instructions: "; [eWires:13]comments_Visible:48; True:C214)
			
		End if 
		
	Else 
		appendLabelString(->$subject; "Received eWire: "; [eWires:13]eWireID:1; False:C215)
		appendLabelString(->$subject; " for : "; [eWires:13]SenderName:7+" - "+[eWires:13]CustomerID:15; True:C214)
		appendLabelString(->$subject; "Sender: "; [Links:17]FullName:4+" - "+[eWires:13]LinkID:8+" paid "+String:C10([eWires:13]FromAmount:13; "|Currency (blank for 0)")+" "+[eWires:13]FromCurrency:11; True:C214)
		appendLabelString(->$subject; "From "; [eWires:13]fromCountry:9; True:C214)
		
		//If ([eWires]ToAmount>0)
		//appendLabelString (->$subject;"Received Amount (set at source): ";String([eWires]ToAmount;"|Currency (blank for 0)")+" "+[eWires]Currency;True)
		//
		//End if 
		appendLabelString(->$subject; "Sender Home Phone: "; [Links:17]HomePhone:6; True:C214)
		appendLabelString(->$subject; "Sender Address: "; [Links:17]Address:19; True:C214)
		appendLabelString(->$subject; "   "; [Links:17]City:11+", "+[Links:17]Country:12; True:C214)
		
	End if 
	
	appendLabelString(->$subject; "Deliver to: "; [eWires:13]DeliveryAddress:37; True:C214)
	If ([eWires:13]doTransferToBank:33=False:C215)  // avoid duplicate, bank details already set above
		appendLabelString(->$subject; "Direct deposit into account: "; [eWires:13]BeneficiaryBankDetails:38; True:C214)
	End if 
	appendLabelString(->$subject; "Notify by Phone: "; [eWires:13]phoneNumber:39; True:C214)
	appendLabelString(->$subject; "Message: "; [eWires:13]CustomerMsg:16; True:C214)
End if 

$0:=$subject