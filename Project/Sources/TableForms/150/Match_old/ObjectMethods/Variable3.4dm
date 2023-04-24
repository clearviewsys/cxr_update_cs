C_TEXT:C284($customerID)
$customerID:=Form:C1466.Rule.ifCustomerID  // default value
Form:C1466.Rule.ifCustomerID:=pickCustomer(->$customerID)
