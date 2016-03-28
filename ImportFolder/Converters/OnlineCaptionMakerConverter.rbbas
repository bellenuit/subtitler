#tag ClassProtected Class OnlineCaptionMakerConverterInherits cTitlelistConverter	#tag Event		Sub DoConvert(s as string)		  dim m,mtext as memoryBlock		  dim item as integer		  dim tit, oldtitle as ctitle		  dim i,j,offset as integer		  dim start,ende,text as string		  dim minutes,frames, textlen as integer		  dim lines(-1), line as string		  dim format1, format2, format3 as integer		  dim inline as boolean		  dim mytc as new timecode		  		  		  if  instr(s,"Online CaptionMaker") = 0 then		    msgBox "Online CaptionMaker Import" + endofLine + endofLine+ "Wrong file format (magic)"		    return		  end		  		  m = newmemoryBlock(lenb(s))		  m.stringValue(0,lenb(s)) = s		  'm.littleEndian = true		  		  offset = &h36		  while offset < m.size		    if m.size > offset + 11 then		      start = m.stringValue(offset,11)		      offset = offset + 11		      		      text = m.cstring(offset)		      offset = offset + lenb(text)+1		      		      if lenb(text)<>0 then		        mtext = newmemoryBlock(lenb(text))		        mtext.stringValue(0,mtext.size)= text		        inline =false		        // ignore shorts starting with &h14 and &h17		        for j = 0 to mtext.size-1		          select case mtext.byte(j)		          case &h14, &h17		            if inline then		              mtext.byte(j) = 13		              inline = false		            else		              mtext.byte(j) = 0		            end		            if j+1<mtext.size then 		              mtext.byte(j+1) = 0		              j = j + 1		            end		          else		            inline = true		          end		        next		        text = mtext.stringValue(0,mtext.size-1)		        text = replaceall(text,chr(0),"")		        text = replaceall(text,chr(&hb3),"")		        text =defineEncoding(text,userencoding)		        text = replacelineEndings(text,endofLine)		        		      end		      		      lines = split(text,endofLine)		      for j= ubound(lines) downto 0		        if lines(j)="" then lines.remove j		      next		      text = join(lines,endofLine)		      lines = split(text,endofLine)		      		      if oldtitle<>nil then		        mytc.setfps tc.fps		        mytc.settext start		        mytc.setframes mytc.getframes-app.splitdistance		        oldtitle.ende = mytc.gettext		      else		        ende = start		      end		      tit = new ctitle		      if text<>"" then		        titlelist.titles.append tit		        i = i + 1		        tit.eventnr = i		      end		      if start<>"" then		        tit.start = start		        tit.ende = ende		      end		      for each line in lines		        tit.lines.append line		      next		      oldtitle = tit		    end		    if offset>0 and offset mod 10 = 0 then		      progress 33+66*offset/m.size		    end		    if userCancelled then		      exit		    end		  wend		  		  createedl documentname,0,ubound(titlelist.titles)		  		End Sub	#tag EndEvent	#tag Method, Flags = &h0		Sub Constructor()		  label = "Online CaptionMaker (.onl)"		  binaryfile = true		End Sub	#tag EndMethod	#tag ViewBehavior		#tag ViewProperty			Name="binaryfile"			Group="Behavior"			InitialValue="0"			Type="boolean"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="charactercount"			Group="Behavior"			InitialValue="0"			Type="integer"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="clipnames"			Group="Behavior"			InitialValue="0"			Type="boolean"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="documentname"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="endline"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="framerate"			Group="Behavior"			InitialValue="0"			Type="double"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="italicstring"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="label"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass