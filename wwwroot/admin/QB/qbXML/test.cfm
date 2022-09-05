Dim MyQbXMLRP2 As QBXMLRP2Lib.RequestProcessor2
Set MyQbXMLRP2 = New QBXMLRP2Lib.RequestProcessor2

MyQbXMLRP2.OpenConnection2 "", "My Sample App", localQBD
Dim ticket As String
ticket = MyQbXMLRP2.BeginSession("", QBXMLRP2Lib.qbFileOpenDoNotCare)

‘ The variable “xml” here is a fully formed message request set:
‘ we left out that part to keep this as simple as possible
Dim sendXMLtoQB As String
sendXMLtoQB = MyQbXMLRP2.ProcessRequest(ticket, xml)
MyQbXMLRP2.EndSession ticket
MyQbXMLRP2.CloseConnection


<cfscript>
	MyQbXMLRP2 = QBXMLRP2Lib.RequestProcessor2 ;
	
</cfscript>