#tag ClassProtected Class CinetypEliteConverterInherits cTitlelistConverter	#tag Event		Sub DoConvert(s as string)		  dim i,j,countlines,item as integer		  dim start, ende, tctext as string		  dim tit as ctitle		  dim separator as string		  dim word, words(-1), lines(-1), line, titles(-1), title, substring as string		  dim state as string		  dim tab as string		  dim d as dictionary		  dim pos,pos2 as integer		  dim bi as boolean		  dim titleitalic as boolean		  dim eventnrfield as string		  dim titletext as string		  		  separator = guessseparator(s)		  tab = chr(9)		  		  titles = split(s,separator+separator)		  countlines = ubound(titles)		  		  pos = 1		  for i = 0 to ubound(titles) 		    		    pos2=pos		    lines = split(titles(i),separator)		    while ubound(lines)>0 and trim(lines(0)) = ""		      lines.remove 0		    wend		    // test for header		    if ubound(lines)>0 and instr("0123456789",left(trim(lines(0)),1))>0 then		      		      if ubound(lines) >= 1 then		        		        line =  lines(0)		        tit = new ctitle		        		        words = split(line," ")		        // remove empty elements		        for j = ubound(words) downto 0		          if words(j)="" then words.remove j		        next		        		        if ubound(words) > 1 then		          eventnrfield = words(0)		          eventnrfield = replace(eventnrfield,")","")		          eventnrfield = replace(eventnrfield,":","")		          eventnrfield = replace(eventnrfield,".","")		          tit.eventnr = val(eventnrfield)		          tit.start = words(1)		          tit.ende = words(2)		        end		        		        titleitalic = false		        		        for j = 1 to ubound(lines)		          		          pos2 = instr(pos2,s,lines(j)) 		          titletext = replace(trim(makeitalic(lines(j),pos2)),"_","-")		          if left(titletext,1) = "#" then		            titletext = mid(titletext,2)		            titleitalic = true		          end		          if titleitalic then		            titletext = "<i>"+titletext+"</i>"		          end		          tit.lines.append titletext		          		          pos2 = pos2 +1  // avoid repetition		          		        next		        		        titlelist.titles.append tit		      end		      		      if i mod 10 = 0 then		        progress 33+66*i/countlines		      end		      if userCancelled then		        exit		      end		      		    end		    		    		    pos = pos + len(titles(i))+len(separator+separator)		    		  next		  		  createedl uppercase(documentname),0,ubound(titlelist.titles) 		  		End Sub	#tag EndEvent	#tag Method, Flags = &h0		Sub Constructor()		  label = "Cinetyp TimeCode 2"		End Sub	#tag EndMethod	#tag ViewBehavior		#tag ViewProperty			Name="binaryfile"			Group="Behavior"			InitialValue="0"			Type="boolean"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="charactercount"			Group="Behavior"			InitialValue="0"			Type="integer"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="clipnames"			Group="Behavior"			InitialValue="0"			Type="boolean"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="documentname"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="endline"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="framerate"			Group="Behavior"			InitialValue="0"			Type="double"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="italicstring"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="label"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass