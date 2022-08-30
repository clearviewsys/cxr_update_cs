//%attributes = {}
checkAddErrorIf(([AML_Alerts:137]status:8=1) & ([AML_Alerts:137]resolutionNotes:14=""); "Resolution Notes Cannot be left blank!")
checkAddErrorIf(([AML_Alerts:137]status:8=1) & ([AML_Alerts:137]resolutionDate:11=!00-00-00!); "Resolution Date Cannot be left blank!")

