// select invoices with large cash
QUERY:C277([Invoices:5]; [Invoices:5]isAMLReportable:46=True:C214; *)
QUERY:C277([Invoices:5];  & ; [Invoices:5]isAMLReported:45=False:C215)

