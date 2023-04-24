//%attributes = {}
// STEP BY STEP

// STEP 1:
// 1: create a method with a name starting with IC_ 
// if integrity checking is on a selection of the records perform the query first and pass FALSE as last parameter : for example

// QUERY([Registers];[Registers]externalReference=Table(->[eWires]))
// integrityCheck (->[Registers];Current method name;"";False)
// else
// integrityCheck (->[Registers];Current method name;"")

// STEP 2:
// modify the method 'integrityCheckRow' and add an extra 'case'
//  


// STEP 3: 
// modify the method:
//fillIntegrityCheckArrays