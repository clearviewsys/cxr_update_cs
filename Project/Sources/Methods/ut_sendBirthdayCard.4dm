//%attributes = {"shared":true}
// __UNIT_TEST
// written by @viktor
// Jan 2021

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("sendBirthdayCard"; Current method name:C684; "Notifications.Email")
//sendBirthdayCard

START TRANSACTION:C239
// START TRANSCATION TO MANIPULATE DATABASE

// Change this keyValue to not enable the sending of emails from VM2 
setKeyValue("email.greetings.birthday.production.mode"; "true")

// Delete All Customer Records That Have BDAY Today
getCustomersWithUpcomingBday(1)
DELETE SELECTION:C66([Customers:3])

// Delete All Notification Records be able to send and to test if sent
ALL RECORDS:C47([Notifications:158])
DELETE SELECTION:C66([Notifications:158])

C_OBJECT:C1216($customers; $notifications)
C_LONGINT:C283($numCustomers; $numNotifications; $expectedNum; $baselineCustomers)
C_TEXT:C284($email; $expectedEmail; $given; $should)

// TEST INITIAL - WHEN NO RECORDS EXIST
$baselineCustomers:=ds:C1482.Customers.all().length
$numNotifications:=ds:C1482.Notifications.all().length
sendBirthdayCard
AJ_assert($test; $numNotifications; 0; "Calling the method with no notification records in the database"; "the method should not crash")
//---------------------------------------------------------------

// RUN METHOD WHEN THERE ARE NO BDAYS, BUT CUSTOMER OPTED-IN FOR EMAIL MARKETING
CREATE RECORD:C68([Customers:3])  // create Customer record
[Customers:3]Email:17:="noreply-notBday@clearviewsys.com"
[Customers:3]FirstName:3:="testName"
[Customers:3]DOB:5:=Add to date:C393(Current date:C33(*); -20; 2; 2)  // Random date in the past with different month and day from current date. 
[Customers:3]optInEmail:149:=1  // Wants to recieve emails
SAVE RECORD:C53([Customers:3])

sendBirthdayCard

$numCustomers:=ds:C1482.Customers.all().length  // update count
$expectedNum:=$baselineCustomers+1  // 1 customer record created
$given:="Calling the method with no bdays today"
$should:="show that one record exists"
AJ_assert($test; $numCustomers; $expectedNum; $given; $should)

$numNotifications:=ds:C1482.Notifications.all().length  // update count
$expectedNum:=0  // 0 Emails should have been sent
$given:="Calling the method with no bdays today"
$should:="show no records in the notification table"
AJ_assert($test; $numNotifications; $expectedNum; $given; $should)
//---------------------------------------------------------------

// CREATE CUSTOMER WITH BDAY TODAY BUT OPTED-OUT OF EMAIL MAKETING
CREATE RECORD:C68([Customers:3])  // create Customer record
[Customers:3]Email:17:="noreply-noEmail@clearviewsys.com"
[Customers:3]FirstName:3:="testName2"
[Customers:3]DOB:5:=Add to date:C393(Current date:C33(*); -20; 0; 0)  // currnet date minus 20 years 
[Customers:3]optInEmail:149:=2  // Does NOT want to recieve emails
SAVE RECORD:C53([Customers:3])

sendBirthdayCard

$numCustomers:=ds:C1482.Customers.all().length  // update count
$expectedNum:=$baselineCustomers+2  // 2 customer records created
$given:="Calling the method with 1 bdays today, but opted-out of email marketing"
$should:="show that two records exists"
AJ_assert($test; $numCustomers; $expectedNum; $given; $should)

$numNotifications:=ds:C1482.Notifications.all().length  // update count
$expectedNum:=0  // 0 Emails should have been sent
$given:="Calling the method with 1 bdays today, but opted-out of email marketing"
$should:="show no records in the notification table"
AJ_assert($test; $numNotifications; $expectedNum; $given; $should)
//---------------------------------------------------------------

// CREATE CUSTOMER WITH BDAY TODAY AND OPTED-IN FOR EMAIL MAKETING
CREATE RECORD:C68([Customers:3])  // create Customer record
[Customers:3]Email:17:="noreply@clearviewsys.com"
[Customers:3]FirstName:3:="testName3"
[Customers:3]DOB:5:=Add to date:C393(Current date:C33(*); -30; 0; 0)  // currnet date minus 30 years 
[Customers:3]optInEmail:149:=1  // Wants Email Marketing
SAVE RECORD:C53([Customers:3])

sendBirthdayCard

$numCustomers:=ds:C1482.Customers.all().length  // update count
$expectedNum:=$baselineCustomers+3  // 3 customer records created
$given:="Calling the method with 1 bdays today and opted-in to receive email marketing"
$should:="show that three records exists"
AJ_assert($test; $numCustomers; $expectedNum; $given; $should)

$numNotifications:=ds:C1482.Notifications.all().length  // update count
$expectedNum:=1  // 1 Email should have been sent
$given:="Calling the method with 1 bdays today and opted-in to receive email marketing"
$should:="Show one record with one email sent"
AJ_assert($test; $numNotifications; $expectedNum; $given; $should)
//---------------------------------------------------------------

// CREATE CUSTOMER WITH BDAY TODAY AND OPT-IN NOT SPECIFIED
CREATE RECORD:C68([Customers:3])  // create Customer record
[Customers:3]Email:17:="noreply2@clearviewsys.com"
[Customers:3]FirstName:3:="testName4"
[Customers:3]DOB:5:=Add to date:C393(Current date:C33(*); -40; 0; 0)  // currnet date minus 40 years 
[Customers:3]optInEmail:149:=0  // Wants Email Marketing
SAVE RECORD:C53([Customers:3])

sendBirthdayCard

$numCustomers:=ds:C1482.Customers.all().length  // update count
$expectedNum:=$baselineCustomers+4  // 4 customer records created
$given:="Calling the method with 1 bdays today and opt-in to email marketing not specified"
$should:="show that four records exists"
AJ_assert($test; $numCustomers; $expectedNum; $given; $should)

$numNotifications:=ds:C1482.Notifications.all().length  // update count
$expectedNum:=2  // 2 Email should have been sent - 1 Now, and 1 from before
$given:="Calling the method with 1 bdays today and opt-in to email marketing not specified"
$should:="Show two records, with one email sent now and one from previous test"
AJ_assert($test; $numNotifications; $expectedNum; $given; $should)
//---------------------------------------------------------------

// TEST THAT THE MESSAGES WERE SENT TO THE RIGHT EMAILS
$notifications:=ds:C1482.Notifications.all().orderBy("ID desc")

$email:=$notifications.first().message.to
$expectedEmail:="noreply2@clearviewsys.com"
$given:="Checking which email address the second message was sent to"
$should:="return 'noreply2@clearviewsys.com'"
AJ_assert($test; $email; $expectedEmail; $given; $should)

$email:=$notifications.first().next().message.to
$expectedEmail:="noreply@clearviewsys.com"
$given:="Checking which email address the first message was sent to"
$should:="return 'noreply@clearviewsys.com'"
AJ_assert($test; $email; $expectedEmail; $given; $should)
//---------------------------------------------------------------


// PUT KEYVALUE BACK JUST IN CASE _ CANCEL TRANSACTION WILL TAKE CARE OF IT
setKeyValue("email.greetings.birthday.production.mode"; "false")


// CANCEL TRANSCATION TO ELIMINATE ANY CHANGES
CANCEL TRANSACTION:C241