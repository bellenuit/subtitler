#tag ClassProtected Class RenderThreadInherits Thread	#tag Event		Sub Run()		  if style <> nil then		    style.render text, frame, alpha, nil		  end		End Sub	#tag EndEvent	#tag Property, Flags = &h0		alpha As picture	#tag EndProperty	#tag Property, Flags = &h0		frame As picture	#tag EndProperty	#tag Property, Flags = &h0		mytimer As timer	#tag EndProperty	#tag Property, Flags = &h0		style As subtitle	#tag EndProperty	#tag Property, Flags = &h0		text As string	#tag EndProperty	#tag ViewBehavior		#tag ViewProperty			Name="alpha"			Group="Behavior"			InitialValue="0"			Type="picture"		#tag EndViewProperty		#tag ViewProperty			Name="frame"			Group="Behavior"			InitialValue="0"			Type="picture"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InheritedFrom="Thread"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InheritedFrom="Thread"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Thread"		#tag EndViewProperty		#tag ViewProperty			Name="Priority"			Visible=true			Group="Behavior"			InitialValue="5"			Type="Integer"			InheritedFrom="Thread"		#tag EndViewProperty		#tag ViewProperty			Name="StackSize"			Visible=true			Group="Behavior"			InitialValue="0"			Type="Integer"			InheritedFrom="Thread"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Thread"		#tag EndViewProperty		#tag ViewProperty			Name="text"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InheritedFrom="Thread"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass