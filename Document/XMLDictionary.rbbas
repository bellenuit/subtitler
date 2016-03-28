#tag ModuleProtected Module XMLDictionary	#tag Method, Flags = &h21		Private Sub ClearStorage(storage As Variant)		  Dim i, n As Integer		  		  If storage.Type = 9 Then		    If storage.ObjectValue IsA Dictionary Then		      Dictionary(storage).Clear		    ElseIf storage.ObjectValue IsA Collection Then		      n = Collection(storage.ObjectValue).Count		      For i = n DownTo 1		        Collection(storage.ObjectValue).Remove i		      Next		    End If		  End If		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function ExportXML(Extends xmldict As Dictionary) As XmlDocument		  Dim xdoc As XmlDocument		  Dim root As XmlElement		  		  xdoc = New XmlDocument		  root = XmlElement(xdoc.AppendChild(xdoc.CreateElement("xmldict")))		  'root.SetAttribute("version", CurrentVersion)  // matti		  ParseStorage xmldict, root		  IndentNode root, 0, True		  xdoc.AppendChild(xdoc.CreateTextNode(ChrB(10)))		  		  Return xdoc		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function ExportXMLString(Extends xmldict As Dictionary) As String		  // Since we can't add a DOCTYPE to the XmlDocument,		  // lets hack this output to add it		  		  Dim s As String		  Dim i As Integer		  s = xmldict.ExportXML.ToString		  // Let's add the DTD		  'i = s.InStr("<xmldict")		  's = s.Mid(1, i-1) + XMLDictDTD + Chr(10) + s.Mid(i)  // matti		  Return s		End Function	#tag EndMethod	#tag Method, Flags = &h21		Private Sub IndentNode(node As XmlNode, level As Integer, indentCloseTag As Boolean = False)		  Dim i As Integer		  Dim s As String		  s = Chr(10) // Linefeed		  For i = 1 To level		    s = s + Chr(9) // Tab		  Next		  node.Parent.Insert(node.OwnerDocument.CreateTextNode(s), node)		  If indentCloseTag Then		    node.AppendChild(node.OwnerDocument.CreateTextNode(s))		  End If		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function LoadXML(Extends xmldict As Dictionary, XMLFile As FolderItem) As Boolean		  Dim tos As TextInputStream		  Dim s As String		  		  tos = XMLFile.OpenAsTextFile()		  tos.Encoding = encodings.utf8  // 1.7.6b4 concerning 		  If tos <> nil Then		    s = tos.ReadAll		    tos.Close		    Return xmldict.LoadXML(s)		  Else		    Return False		  End If		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function LoadXML(Extends xmldict As Dictionary, XMLData As String) As Boolean		  Dim xdoc As XmlDocument		  dim v as integer		  dim xmldata2 as string		  dim s, s2 as string		  dim i,line as integer		  		  // matti		  v = instr(xmldata,"<?xml")		  if  v = 0 or v > 80 then return false		  		  xmldata2 = xmlcharacterFilter(xmldata)		  		  xdoc = New XmlDocument(XMLData2)		  Return xmldict.LoadXML(xdoc)		  		Exception err As XmlException		  s2 = replacelineEndings(xmldata2,endofLine)		  line = val(nthField(err.line,":",2))		  s = "Error XMLDictionary.LoadXML XMLException" + endofLine + endofLine		  s = s + err.line+ nthfield(s2,endofLine,line) + endofLine		  s = s + "after " + nthfield(s2,endofLine,line-1)  + endofLine		  s = s + "before " + nthfield(s2,endofLine,line+1)  + endofLine		  s = s + "node " + err.node  + endofline 		  s = s + "token " + err.token + endofline		  s = s + "error " + str(err.errorNumber) + ":" + err.Message + endofline		  s = s + "Please send file to developer (matti@belle-nuit.com)"		  msgBox s		  // Ugh, invalid XML		  Return False		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function LoadXML(Extends xmldict As Dictionary, XMLDoc As XmlDocument) As Boolean		  XMLDoc.PreserveWhitespace = True		  		  // First, make sure the version is at most what we expect		  'If Val(XMLDoc.DocumentElement.GetAttribute("version")) <= Val(CurrentVersion) Then // matti		  ParseXML XMLDoc.DocumentElement, xmldict		  Return True		  'Else		  '// We can't reliably parse a higher version, so lets not parse it at all		  'Return False		  'End If		  		Exception err As XmlException		  // Ugh, invalid XML		  Return False		End Function	#tag EndMethod	#tag Method, Flags = &h21		Private Function NodeContents(parent As XmlNode) As String		  // Concatenates all the node children values and returns the result		  // It's designed for the children to be all text nodes, but for anything		  // else it'll just use .ToString		  		  Dim i, n As Integer		  Dim node As XmlNode		  Dim s As String		  n = parent.ChildCount - 1		  For i = 0 To n		    node = parent.Child(i)		    If node.Type = 3 Then // Text node		      s = s + node.Value		    Else // Other node - shouldn't happen, but we gotta deal with it if it does		      s = s + node.ToString		    End If		  Next		  Return s		End Function	#tag EndMethod	#tag Method, Flags = &h21		Private Sub ParseStorage(storage As Variant, parent As XmlNode)		  Dim v(-1) As Variant		  ParseStorage(storage, parent, v, 1)		End Sub	#tag EndMethod	#tag Method, Flags = &h21		Private Sub ParseStorage(storage As Variant, parent As XmlNode, alreadySeen() As Variant, indentLevel As Integer)		  Dim i, n, x As Integer		  Dim key, value As Variant		  Dim node, tempNode As XmlNode		  Dim xdoc As XmlDocument		  Dim s, data(-1) As String		  Dim multilineTag As Boolean		  Dim mb As MemoryBlock		  		  // First, make sure we haven't already seen this dictionary		  // This protects against circular dictionary references		  n = UBound(alreadySeen)		  For i = 0 To n		    If alreadySeen(i) = storage Then		      // Ack! We've seen this! Bail out		      Return		    End If		  Next		  // Ok, lets add out storage to the list		  alreadySeen.Append storage		  		  xdoc = parent.OwnerDocument		  n = StorageCount(storage) - 1		  For i = 0 To n		    // Key		    key = StorageKey(storage, i)		    If key <> nil Then // It's a keyed storage		      node = parent.AppendChild(xdoc.CreateElement("key"))		      node.AppendChild(xdoc.CreateTextNode(key.StringValue))		      IndentNode node, indentLevel		    End If		    		    // Value		    multilineTag = False		    value = StorageValue(storage, i)		    Select Case value.Type		    Case 0 // Null		      node = parent.AppendChild(xdoc.CreateElement("null"))		    Case 2 // Integer		      node = parent.AppendChild(xdoc.CreateElement("integer"))		      node.AppendChild(xdoc.CreateTextNode(Str(value.IntegerValue)))		    Case 5 // Double/Single		      node = parent.AppendChild(xdoc.CreateElement("real"))		      node.AppendChild(xdoc.CreateTextNode(Str(value.DoubleValue)))		    Case 7 // Date		      node = parent.AppendChild(xdoc.CreateElement("date"))		      node.AppendChild(xdoc.CreateTextNode(value.StringValue))		    Case 8 // String		      node = parent.AppendChild(xdoc.CreateElement("string"))		      s = ConvertEncoding(value.StringValue, Encodings.UTF8) // Convert to UTF8		      If s.Encoding = nil Then s = DefineEncoding(s, Encodings.UTF8) // If encoding was undefined, convert fails. Simply define instead		      node.AppendChild(xdoc.CreateTextNode(s))		    Case 9 // Object		      // Is this a dictionary, memoryblock, collection, or folderitem?		      If value.ObjectValue IsA Dictionary Then		        // We can parse this dictionary		        node = parent.AppendChild(xdoc.CreateElement("dict"))		        ParseStorage Dictionary(value.ObjectValue), node, alreadySeen, indentLevel+1		        multilineTag = True		      ElseIf value.ObjectValue IsA MemoryBlock Then		        // We can parse this memoryblock		        node = parent.AppendChild(xdoc.CreateElement("data"))		        data = Split(EncodeBase64(MemoryBlock(value.ObjectValue), 45), ChrB(13)+ChrB(10)) // 45 is what plists use		        For Each s In data		          tempNode = node.AppendChild(xdoc.CreateTextNode(DefineEncoding(s, Encodings.ASCII)))		          IndentNode tempNode, indentLevel		        Next		        multilineTag = True		      ElseIf value.ObjectValue IsA Collection Then		        // We can parse this collection		        node = parent.AppendChild(xdoc.CreateElement("array"))		        ParseStorage Collection(value.ObjectValue), node, alreadySeen, indentLevel+1		        multilineTag = True		      ElseIf value.ObjectValue IsA FolderItem Then		        // Do the same thing as a memoryblock, but with a different tag		        node = parent.AppendChild(xdoc.CreateElement("file"))		        data = Split(EncodeBase64(FolderItem(value.ObjectValue).GetSaveInfo(Nil), 45), ChrB(13)+ChrB(10))		        For Each s In Data		          tempNode = node.AppendChild(xdoc.CreateTextNode(s))		          IndentNode tempNode, indentLevel		        Next		        multilineTag = True		      Else		        // Arbitrary object? We can't do this. Let's just add a null element		        node = parent.AppendChild(xdoc.CreateElement("null"))		      End If		    Case 11 // Boolean		      If value.BooleanValue = True Then		        node = parent.AppendChild(xdoc.CreateElement("true"))		      Else		        node = parent.AppendChild(xdoc.CreateElement("false"))		      End If		    Case 16 // Color		      node = parent.AppendChild(xdoc.CreateElement("color"))		      node.AppendChild(xdoc.CreateTextNode("#" + Hex(value.IntegerValue)))		    Else		      // Buh? We should never reach this point, but just in case, lets add a null value		      node = parent.AppendChild(xdoc.CreateElement("null"))		    End Select		    IndentNode node, indentLevel, multilineTag		  Next		End Sub	#tag EndMethod	#tag Method, Flags = &h21		Private Sub ParseXML(parent As XmlNode, storage As Variant)		  Dim i, n As Integer		  Dim node, tempNode As XmlNode		  Dim key As Variant		  Dim v As Variant		  Dim d As Dictionary		  Dim col As Collection		  Dim mb As MemoryBlock		  		  ClearStorage storage		  		  n = parent.ChildCount - 1		  For i = 0 To n		    node = parent.Child(i)		    // We only want to deal with element nodes		    // The only other type of node that *should* show up is		    // a text node with only whitespace. However, even if		    // other nodes show up, we should ignore them, since		    // we're not a validator		    If node.Type = 1 Then // Element node		      If key = nil And node.Name = "key" Then		        key = NodeContents(node)		      Else		        Select Case node.Name		        Case "null"		          StoreValue key, nil, storage		        Case "integer"		          StoreValue key, Val(NodeContents(node)) \ 1, storage		        Case "real"		          StoreValue key, Val(NodeContents(node)), storage		        Case "date"		          v = NodeContents(node)		          StoreValue key, v.DateValue, storage		        Case "string"		          StoreValue key, NodeContents(node), storage		        Case "dict"		          d = New Dictionary		          ParseXML node, d		          StoreValue key, d, storage		        Case "array"		          col = New Collection		          ParseXML node, col		          StoreValue key, col, storage		        Case "data"		          // Lets parse our Base64-encoded data		          mb = DecodeBase64(NodeContents(node))		          StoreValue key, mb, storage		        Case "file"		          // Lets parse our Base64-encoded alias data		          StoreValue key, GetFolderItem(DecodeBase64(NodeContents(node))), storage		        Case "true"		          StoreValue key, True, storage		        Case "false"		          StoreValue key, False, storage		        Case "color"		          v = "&h" + NodeContents(node).Mid(1)		          StoreValue key, v.ColorValue, storage		        End Select		        key = nil		      End If		    End If		  Next		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function SaveXML(Extends xmldict As Dictionary, XMLFile As FolderItem) As Boolean		  Dim bs As BinaryStream		  		  bs = XMLFile.CreateBinaryFile("text")		  bs.littleEndian = false		  If bs <> nil Then		    bs.Write xmldict.ExportXMLString		    bs.Close		    Return True		  Else		    Return False		  End If		End Function	#tag EndMethod	#tag Method, Flags = &h21		Private Function StorageCount(storage As Variant) As Integer		  If storage.Type = 9 Then		    If storage.ObjectValue IsA Dictionary Then		      Return Dictionary(storage.ObjectValue).Count		    ElseIf storage.ObjectValue IsA Collection Then		      Return Collection(storage.ObjectValue).Count		    End If		  End If		  Return 0		End Function	#tag EndMethod	#tag Method, Flags = &h21		Private Function StorageKey(storage As Variant, index As Integer) As Variant		  If storage.Type = 9 And storage.ObjectValue IsA Dictionary Then		    Return Dictionary(storage.ObjectValue).Key(index)		  End If		  Return nil		End Function	#tag EndMethod	#tag Method, Flags = &h21		Private Function StorageValue(storage As Variant, index As Integer) As Variant		  If storage.Type = 9 Then		    If storage.ObjectValue IsA Dictionary Then		      Return Dictionary(storage.ObjectValue).Value(Dictionary(storage.ObjectValue).Key(index))		    ElseIf storage.ObjectValue IsA Collection Then		      Return Collection(storage.ObjectValue).Item(index+1)		    End If		  End If		End Function	#tag EndMethod	#tag Method, Flags = &h21		Private Sub StoreValue(key As Variant, value As Variant, storage As Variant)		  If storage.Type = 9 Then		    If storage.ObjectValue IsA Dictionary And key <> nil Then		      Dictionary(storage.ObjectValue).Value(key) = value		    ElseIf storage.ObjectValue IsA Collection Then		      Collection(storage.ObjectValue).Add value		    End If		  End If		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function XMLCharacterFilter(s as string) As string		  dim s2 as string		  dim i as integer		  		  		  // They are valid unicode (and yes, valid UTF8 as a single byte), but not all of them are allowed in an xml document. 		  // The legal characters for xml documents are: #x9 | #xA | #xD | [#x20-#xD7FF] | [#xE000-#xFFFD] | [#x10000-#x10FFFF]		  		  		  //filter out all low characters		  //s2= s.defineEncoding(encodings.asCII)    // this line was introduced in 1.7.5, but creates now problems with files with chinese text		  // so we do not use it		  s2 = s		  		  		  		  for i = 0 to &h1F		    select case i		    case &h9, &hA, &hD		    else		      s2 = replaceall(s2,chr(i),"")		    end		  next		  		  s2 = s2.defineEncoding(encodings.utf8)		  		  return s2		  		  		End Function	#tag EndMethod	#tag Note, Name = changes matti		comment out DTL in exportXML		comment out version attribute in exportxml and version check in loadxml.  // version will prevent older subtitler to read newer files.		check xml file tag in loadxml			#tag EndNote	#tag Note, Name = Version History		Kevin Ballard		kevin@sb.org		http://www.tildesoft.com				v1.1:		- Added support for Collections as a replacement for lack of array support		     Note that keys in Collections are not preserved		- Ugraded version attribute of resulting document to "1.1" - previous versions of XMLDictionary won't read new documents		- When adding a string value to a document, it now converts it to UTF-8. If conversion failed (because no encoding was present originally),		     it simply defines the encoding as UTF-8				v1.0.1:		- Added support for 5.5b6 changes				v1.0:		- Initial release			#tag EndNote	#tag Constant, Name = CurrentVersion, Type = String, Dynamic = False, Default = \"1.1", Scope = Private	#tag EndConstant	#tag Constant, Name = XMLDictDTD, Type = String, Dynamic = False, Default = \"<!DOCTYPE xmldict PUBLIC \"-//Tildesoft//DTD XMLDICT 1.1//EN\" \"http://www.tildesoft.com/DTDs/XMLDictionary-1.1.dtd\">", Scope = Private	#tag EndConstant	#tag ViewBehavior		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Module#tag EndModule