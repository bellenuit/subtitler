#tag ClassProtected Class CinetypTCConverterInherits cTitlelistConverter	#tag Event		Sub DoConvert(s as string)		  dim i,j,countlines,item as integer		  dim start, ende, tctext as string		  dim tit as ctitle		  dim separator as string		  dim word, words(-1), lines(-1), line, titles(-1), title, substring as string		  dim state as string		  dim tab as string		  dim d as dictionary		  		  separator = guessseparator(s)		  tab = chr(9)		  		  titles = split(s,separator+separator)		  countlines = ubound(titles)		  		  for i = 0 to ubound(titles) 		    lines = split(titles(i),separator)		    		    if ubound(lines) >= 1 then		      		      line =  lines(0)		      tit = new ctitle		      		      words = split(line,"-")		      if ubound(words) > 0 then		        tit.start = converttc(words(0))		        tit.ende = converttc(words(1))		      end		      		      word = nthfield(lines(1)," ",1)		      tit.eventnr = val(word)		      tit.lines.append mid(lines(1),len(word)+2)		      		      for j = 2 to ubound(lines)		        tit.lines.append lines(j)		      next		      		      titlelist.titles.append tit		    end		    		    if i mod 10 = 0 then		      progress 33+66*i/countlines		    end		    if userCancelled then		      exit		    end		    		  next		  		  createedl uppercase(documentname),0,ubound(titlelist.titles) 		  		End Sub	#tag EndEvent	#tag Event		Function DoExport(ed as edittitle) As string		  dim i,j,cf as integer		  dim onet as onetitle		  dim titles(-1), textlines as string		  dim lines(-1) as string		  dim result as string		  dim title as string		  dim tc as timecode		  dim inp, outp, t as string		  dim stylestr as string		  dim d as date		  		  onet = new onetitle(style)		  		  cf = ed.titlecount		  		  tc = ed.style.getTimeCode		  		  for i = 1 to cf		    onet = ed.gettitle(i)		    if onet.getinpoint<>"" and onet.getoutpoint<>"" then		      inp = converttcexport(onet.getinpoint)		      outp = converttcexport(onet.getoutpoint)		      lines.append inp + " - " + outp		      textlines = onet.gettext		      textlines = replaceall(textlines,endofLine,endofline.windows)		      textlines = replaceall(textlines,"<b>","")		      textlines = replaceall(textlines,"</b>","")		      textlines = replaceall(textlines,"<i>","")		      textlines = replaceall(textlines,"</i>","")		      textlines = replaceall(textlines,"<u>","")		      textlines = replaceall(textlines,"</u>","")		      if not app.reg.online then		        textlines = "Offline" + mid(textlines,8)		      end		      lines.append str(i)+ " " +textlines		      lines.append ""		    end		  next		  		  result = join(lines,endofline.windows)		  result = result.convertEncoding(encodings.windowsaNSI)		  return result		  		End Function	#tag EndEvent	#tag Method, Flags = &h0		Sub Constructor()		  label = "Cinetyp TimeCode"		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function convertTC(s as string) As string		  dim result as string		  		  result = trim(s)		  result = replaceall(result,".","")		  if tc <> nil then		    result = tc.TCtoText(val(result))		  end		  return result		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function convertTCexport(s as string) As string		  dim result as string		  		  result = trim(s)		  result = replaceall(result,":",".")		  result = result + "."		  return result		End Function	#tag EndMethod	#tag ViewBehavior		#tag ViewProperty			Name="binaryfile"			Group="Behavior"			InitialValue="0"			Type="boolean"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="charactercount"			Group="Behavior"			InitialValue="0"			Type="integer"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="clipnames"			Group="Behavior"			InitialValue="0"			Type="boolean"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="documentname"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="endline"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="framerate"			Group="Behavior"			InitialValue="0"			Type="double"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="italicstring"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="label"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass