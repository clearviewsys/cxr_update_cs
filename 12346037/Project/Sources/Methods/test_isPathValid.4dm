//%attributes = {}


ASSERT:C1129(isPathValid("C:\\"; Is a folder:K24:2))  // valid paths to test
ASSERT:C1129(isPathValid("C:\\"; Is a document:K24:1)=False:C215)  // not a document


ASSERT:C1129(isPathValid("C:\\CXR7\\"; Is a folder:K24:2))  // not a document
ASSERT:C1129(isPathValid("C:\\CXR7\\CXR7.4DB"; Is a document:K24:1))  // not a document
