#tag ClassProtected Class EBUConverterTeletextInherits EBUConverter	#tag Event		Function DetectComments(s as string) As string		  if instrb(s,chrb(&h01))>0 then return " color(255,0,0)"		  if instrb(s,chrb(&h02))>0 then return " color(0,255,0)"		  if instrb(s,chrb(&h03))>0 then return " color(255,255,0)"		  if instrb(s,chrb(&h04))>0 then return " color(0,0,255)"		  if instrb(s,chrb(&h05))>0 then return " color(255,0,255)"		  if instrb(s,chrb(&h06))>0 then return " color(0,255,255)"		  if instrb(s,chrb(&h07))>0 then return " color(255,255,255)"		  if instrb(s,chrb(&h00))>0 then return " color(0,0,0)"		End Function	#tag EndEvent	#tag Event		Function ShowVertical() As boolean		  return true		End Function	#tag EndEvent	#tag Method, Flags = &h0		Sub Constructor()		  label = "EBU (STL Binary) Teletext"		  binaryfile = true		End Sub	#tag EndMethod	#tag ViewBehavior		#tag ViewProperty			Name="binaryfile"			Group="Behavior"			InitialValue="0"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="charactercount"			Group="Behavior"			InitialValue="0"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="clipnames"			Group="Behavior"			InitialValue="0"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="documentname"			Group="Behavior"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="endline"			Group="Behavior"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="framerate"			Group="Behavior"			InitialValue="0"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="italicstring"			Group="Behavior"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="label"			Group="Behavior"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass