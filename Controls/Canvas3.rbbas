#tag ClassProtected Class Canvas3Inherits Canvas	#tag Event		Sub Paint(g As Graphics)		  g.drawpicture buffer,0,0		End Sub	#tag EndEvent	#tag Method, Flags = &h0		Sub canvas3()		  Constructor		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Constructor()		  buffer = newpicture(width,height,32)		  if buffer<>nil then  // added check 1.5 / 5.5		    graph = buffer.graphics		  end		  settextsize textsizeevent		  textcolor = &cffffff		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function gettextsize() As integer		  return textsize		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub setformat()		  if me.width>1 then		    text alttext		  end		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub settextsize(v as integer)		  'if v<>textsize then		  textsize = v		  height = v * 2 * 1.5		  width = aspectratio * textsize		  if buffer<>nil and buffer.width <> width then		    buffer = newpicture(width,height,32)		    if buffer<>nil then 		      graph = buffer.graphics		    end		  end		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub text(s as string)		  dim s0,s1,s2 as string		  dim l1,l2 as integer		  		  alttext = s		    		  if graph = nil or buffer = nil or  height<>buffer.height then		    canvas3		  end		  		  if width = 0 or height = 0 then return		  		  if graph = nil then		    return		  end		  		  graph.textfont = textfont		  graph.textsize = textsize		  graph.bold = bold		  graph.italic = italic		  graph.underline = underline		  		  graph.forecolor = rgb(0,0,0)		  graph.fillrect 0,0,width,height		  //graph.forecolor = rgb(255,255,255)		  graph.foreColor = textcolor		  		  wrap(s)		  s1 = firstline		  s2 = secondline		  		  select case textalign		  case 0 //left		    l1=0		    l2=0		  case 1 //center		    l1 = (width-graph.stringwidthwithspace(s1,spacing, s1+s2))/2		    l2 = (width-graph.stringwidthwithspace(s2,spacing, s1+s2))/2		  case 2 //right		    l1 = width-graph.stringwidthwithspace(s1,spacing, s1+s2)		    l2 = width-graph.stringwidthwithspace(s2,spacing, s1+s2)		  case 3 // center left		    l1 = (width-max(graph.stringwidthwithspace(s1,spacing, s1+s2), graph.stringwidthwithspace(s2,spacing, s1+s2)))/2		    l2 = l1		  end		  		  graph.drawstringwithspace s1, l1, textsize * 1.2, spacing, s1+s2		  graph.drawstringwithspace s2, l2, textsize * 2.5, spacing, s1+s2		  		  		  		  graphics.drawpicture buffer,0,0		  		  haspainted buffer		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub wrap(s as string)		  dim i,w,w2,altw,altw2 as integer		  dim first, second, altsecond,altfirst, line as string		  		  		  if s = "" then 		    firstline = ""		    secondline = ""		    return		  end		  		  select case wrapmethod		  case 0 'no wrap		    firstline = nthfield(s,endofline,1)		    secondline = nthField(s,endofline,2)		  case 1 'simple wrap		    line = nthField(s,endofline,1)		    if graph.stringwidthwithspace(line,spacing,s) > width then		      first = s		      do		        second = nthfield(first," ",countFields(first," "))+" "+second		        first = left(first,len(s)-len(second))		        w = graph.stringwidth(first) + len(first)*spacing		      loop until w< width 		      second = left(second,len(second)-1)		      firstline = first		      secondline = second		    else		      firstline = nthfield(s,endofline,1)		      secondline = nthField(s,endofline,2)		    end if		  case 2 'smart wrap		    line = nthField(s,endofline,1)		    if graph.stringwidthwithspace(line,spacing,s) > width then		      first = s		      do		        altfirst = first		        altsecond = second		        altw = w		        altw2 = w2		        second = nthfield(first," ",countFields(first," "))+" "+second		        first = left(first,len(s)-len(second))		        w = graph.stringwidthwithspace(first, spacing,s)		        w2 = graph.stringwidthwithspace(second, spacing,s)		      loop until  w<w2 and w< width 		      if max(w,w2) < max (altw,altw2) then		        second = left(second,len(second)-1)		        firstline =first		        secondline = second		      else		        second = left(altsecond,len(altsecond)-1)		        firstline =altfirst		        secondline = second		      end		    else		      firstline = nthfield(s,endofline,1)		      secondline = nthField(s,endofline,2)		    end if		  end		End Sub	#tag EndMethod	#tag Hook, Flags = &h0		Event haspainted(p as picture)	#tag EndHook	#tag Hook, Flags = &h0		Event Textsizeevent() As integer	#tag EndHook	#tag Property, Flags = &h0		alttext As string	#tag EndProperty	#tag Property, Flags = &h0		aspectratio As double	#tag EndProperty	#tag Property, Flags = &h0		bold As boolean	#tag EndProperty	#tag Property, Flags = &h0		buffer As picture	#tag EndProperty	#tag Property, Flags = &h0		firstline As string	#tag EndProperty	#tag Property, Flags = &h0		graph As graphics	#tag EndProperty	#tag Property, Flags = &h0		italic As boolean	#tag EndProperty	#tag Property, Flags = &h0		secondline As string	#tag EndProperty	#tag Property, Flags = &h0		spacing As double	#tag EndProperty	#tag Property, Flags = &h0		textalign As integer	#tag EndProperty	#tag Property, Flags = &h0		textcolor As color	#tag EndProperty	#tag Property, Flags = &h0		textfont As string	#tag EndProperty	#tag Property, Flags = &h21		Private textsize As integer	#tag EndProperty	#tag Property, Flags = &h0		underline As boolean	#tag EndProperty	#tag Property, Flags = &h0		wrapmethod As integer	#tag EndProperty	#tag ViewBehavior		#tag ViewProperty			Name="AcceptFocus"			Visible=true			Group="Behavior"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="AcceptTabs"			Visible=true			Group="Behavior"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="alttext"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"		#tag EndViewProperty		#tag ViewProperty			Name="aspectratio"			Group="Behavior"			InitialValue="0"			Type="double"		#tag EndViewProperty		#tag ViewProperty			Name="AutoDeactivate"			Visible=true			Group="Appearance"			InitialValue="True"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Backdrop"			Visible=true			Group="Appearance"			Type="Picture"			EditorType="Picture"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="bold"			Group="Behavior"			InitialValue="0"			Type="boolean"		#tag EndViewProperty		#tag ViewProperty			Name="buffer"			Group="Behavior"			InitialValue="0"			Type="picture"		#tag EndViewProperty		#tag ViewProperty			Name="DoubleBuffer"			Visible=true			Group="Behavior"			InitialValue="False"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Enabled"			Visible=true			Group="Appearance"			InitialValue="True"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="EraseBackground"			Visible=true			Group="Behavior"			InitialValue="True"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="firstline"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"		#tag EndViewProperty		#tag ViewProperty			Name="Height"			Visible=true			Group="Position"			InitialValue="100"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="HelpTag"			Visible=true			Group="Appearance"			Type="String"			EditorType="MultiLineEditor"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="InitialParent"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="italic"			Group="Behavior"			InitialValue="0"			Type="boolean"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="LockBottom"			Visible=true			Group="Position"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="LockLeft"			Visible=true			Group="Position"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="LockRight"			Visible=true			Group="Position"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="LockTop"			Visible=true			Group="Position"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			Type="String"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="secondline"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"		#tag EndViewProperty		#tag ViewProperty			Name="spacing"			Group="Behavior"			InitialValue="0"			Type="double"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="TabIndex"			Visible=true			Group="Position"			InitialValue="0"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="TabPanelIndex"			Group="Position"			InitialValue="0"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="TabStop"			Visible=true			Group="Position"			InitialValue="True"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="textalign"			Group="Behavior"			InitialValue="0"			Type="integer"		#tag EndViewProperty		#tag ViewProperty			Name="textcolor"			Group="Behavior"			InitialValue="&h000000"			Type="color"		#tag EndViewProperty		#tag ViewProperty			Name="textfont"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="underline"			Group="Behavior"			InitialValue="0"			Type="boolean"		#tag EndViewProperty		#tag ViewProperty			Name="UseFocusRing"			Visible=true			Group="Appearance"			InitialValue="True"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Visible"			Visible=true			Group="Appearance"			InitialValue="True"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Width"			Visible=true			Group="Position"			InitialValue="100"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="wrapmethod"			Group="Behavior"			InitialValue="0"			Type="integer"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass