#tag ClassProtected Class RTFtextImplements RtfTarget	#tag Method, Flags = &h0		Sub Export(target as RtfTarget)		  dim st as RtfState		  		  if not target.preprocess then		    return		  end		  		  target.setstate new rtfstate		  		  target.write text		  		  		  if not target.postprocess then		    return		  end		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function Postprocess() As Boolean		  dim pos as integer		  		  pos = stream.position		  stream.position(0)		  text = stream.read(pos)		  text = text.defineEncoding(currentstate.encoding)		  		  pos = italicstream.position		  italicstream.position(0)		  italictext  = italicstream.read(pos)		  italictext = italictext.defineEncoding(encodings.ascii)		  		  return true		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Preprocess() As Boolean		  text = ""		  redim textlines(-1)		  currentstate = new rtfstate		  stream = new ramstream(32000)		  italicstream = new ramstream(32000)		  return true		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub SetState(st as RtfState)		  // catch for italic		  		  isitalic = st.italic		  		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Write(t as string)		  dim i,c as integer		  dim pos as integer		  		  		  		  stream.write t		  		  		  pos = stream.position		  stream.position(0)		  text = stream.read(pos)		  stream.position(pos)		  		  		  		  		  c = len(t)		  if isitalic then		    for i = 1 to c 		      italicstream.write "I"		    next		  else		    for i = 1 to c 		      italicstream.write "P"		    next		  end		  		End Sub	#tag EndMethod	#tag Note, Name = Version		1.0 16.10.5			#tag EndNote	#tag Property, Flags = &h0		currentstate As RtfState	#tag EndProperty	#tag Property, Flags = &h21		Private isitalic As boolean	#tag EndProperty	#tag Property, Flags = &h21		Private italicstream As ramStream	#tag EndProperty	#tag Property, Flags = &h0		italictext As string	#tag EndProperty	#tag Property, Flags = &h21		Private stream As ramstream	#tag EndProperty	#tag Property, Flags = &h0		text As string	#tag EndProperty	#tag Property, Flags = &h21		Private textlines(-1) As string	#tag EndProperty	#tag ViewBehavior		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="italictext"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="text"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass