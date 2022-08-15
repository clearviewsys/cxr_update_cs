C_TEXT:C284(vCustomerID; $textBlock; $body)
vCustomerID:=""
pickCustomer(->vCustomerID)

appendToString(->$textBlock; CRLF)
appendToString(->$textBlock; [Customers:3]Salutation:2+" "+[Customers:3]FullName:40)
appendToString(->$textBlock; [Customers:3]Address:7)
appendToString(->$textBlock; [Customers:3]City:8+", "+[Customers:3]Province:9+", "+[Customers:3]PostalCode:10; True:C214)
appendToString(->$textBlock; [Customers:3]Country_obs:11)
appendToString(->$textBlock; "Work Phone: "+[Customers:3]WorkTel:12)
appendToString(->$textBlock; "Fax: "+[Customers:3]WorkFax:46+CRLF)

insertTextAtInsertionPointer(->[Letters:52]Body:4; $textBlock)


