#tag ClassProtected Class CIPConverterInherits cTitleListConverter	#tag Event		Sub DoConvert(s as string)		  dim s2,lines(-1),line, textlines(-1), textline, titles(-1), title as string		  dim tit as ctitle		  dim start,ende, text, theline as string		  dim t, i,l, pos2 as integer		  		  s2 = replacelineEndings(s,endofLine)		  		  pos2 = 1		  titles =split(s2,endofline+"#")		  for each title in titles		    if title<>"" and left(title,1) = "0" then		      lines = split(title,endofLine)		      if ubound(lines)>=1 then		        start = trim(nthField(lines(0),chr(9),2))		        ende = trim(nthField(lines(0),chr(9),3))		        start = tc.tctotext(tc.texttotc(start)) // clean tc		        ende = tc.tctotext(tc.texttotc(ende))		        i=  val(trim(nthField(lines(0),chr(9),1)))		        tit = new ctitle		        tit.start = start		        tit.ende = ende		        tit.filename = format(i,"0000")		        pos2 = pos2 +  len(lines(0) + EndOfLine)		        for l = 1 to ubound(lines)		          theline = lines(l)		          pos2 =  instr(pos2, s, theline) // not 100% save if duplicate content		          tit.lines.append theline		          if IsItalic(pos2 + len(theline)-2) and IsItalic(pos2+2) and tit.lines(0) <> "/style italic" then		            tit.lines.Insert 0, "/style italic"		          end		        next		        titlelist.titles.append tit		      end		    end		    		  next		  		  createedl uppercase(documentname),0,ubound(titlelist.titles)		  		End Sub	#tag EndEvent	#tag Method, Flags = &h0		Sub Constructor()		  label ="CIP Tempo"		End Sub	#tag EndMethod	#tag ViewBehavior		#tag ViewProperty			Name="binaryfile"			Group="Behavior"			InitialValue="0"			Type="boolean"			InheritedFrom="cTitleListConverter"		#tag EndViewProperty		#tag ViewProperty			Name="charactercount"			Group="Behavior"			InitialValue="0"			Type="integer"			InheritedFrom="cTitleListConverter"		#tag EndViewProperty		#tag ViewProperty			Name="clipnames"			Group="Behavior"			InitialValue="0"			Type="boolean"			InheritedFrom="cTitleListConverter"		#tag EndViewProperty		#tag ViewProperty			Name="documentname"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitleListConverter"		#tag EndViewProperty		#tag ViewProperty			Name="endline"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitleListConverter"		#tag EndViewProperty		#tag ViewProperty			Name="framerate"			Group="Behavior"			InitialValue="0"			Type="double"			InheritedFrom="cTitleListConverter"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="italicstring"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitleListConverter"		#tag EndViewProperty		#tag ViewProperty			Name="label"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitleListConverter"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass