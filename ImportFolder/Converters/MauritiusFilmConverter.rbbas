#tag ClassProtected Class MauritiusFilmConverterInherits cTitlelistConverter	#tag Event		Sub DoConvert(s as string)		  dim s2,lines(-1),line, textlines(-1), textline, titles(-1), title as string		  dim tit as ctitle		  dim start,ende, text as string		  dim t, i,l as integer		  		  s2 = replacelineEndings(s,endofLine)		  		  		  titles =split(s2,endofline+endofline)		  for each title in titles		    if title<>"" then		      lines = split(title,endofLine)		      if ubound(lines)>=2 then		        start = trim(nthField(lines(1),"/",1))		        ende = trim(nthField(lines(1),"/",2))		        text = nthField(line,"}",countfields(line,"}"))		        start = tc.tctotext(tc.feettotc(val(start)))		        ende = tc.tctotext(tc.feettotc(val(ende)))		        i=val(lines(0))		        tit = new ctitle		        tit.start = start		        tit.ende = ende		        tit.filename = format(i,"0000")		        for l = 2 to ubound(lines)		          tit.lines.append lines(l)		        next		        titlelist.titles.append tit		      end		    end		  next		  		  createedl uppercase(documentname),0,ubound(titlelist.titles) 		  		End Sub	#tag EndEvent	#tag Method, Flags = &h0		Sub Constructor()		  label ="Mauritius Film"		End Sub	#tag EndMethod	#tag ViewBehavior		#tag ViewProperty			Name="binaryfile"			Group="Behavior"			InitialValue="0"			Type="boolean"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="charactercount"			Group="Behavior"			InitialValue="0"			Type="integer"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="clipnames"			Group="Behavior"			InitialValue="0"			Type="boolean"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="documentname"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="endline"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="framerate"			Group="Behavior"			InitialValue="0"			Type="double"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="italicstring"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="label"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass