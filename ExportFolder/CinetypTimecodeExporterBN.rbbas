#tag ClassProtected Class CinetypTimecodeExporterBNInherits TitleExporterBN	#tag Event		Function ExportEvent() As string		  dim item as integer		  dim lines(-1), inp, outp, textlines, result as string		  dim title as oneTitle		  		  		  		  item = 0		  for each title in titles		    if title.getinpoint<>"" and title.getoutpoint<>"" then		      item = item + 1		      		      inp = converttcexport(title.getinpoint)		      outp = converttcexport(title.getoutpoint)		      		      textlines = title.textclean		      textlines = replaceall(textlines,endofLine,getlineending)		      		      lines.append inp + " - " + outp		      lines.append str(item) + " " +textlines		      		      lines.append ""		    end		  next		  		  result = join(lines,getlineending)		  result = converttext(result)		  return result		End Function	#tag EndEvent	#tag Event		Function GetDefaultDictEvent() As dictionary		  dim d as new dictionary		  d.value("lineending") = "Windows"		  d.value("textencoding") = "Windows Latin1"		  return d		End Function	#tag EndEvent	#tag Event		Function GetDefaultNameEvent() As string		  return documentname + ".txt"		End Function	#tag EndEvent	#tag Event		Function GetLabelEvent() As string		  return "Cinetyp Timecode"		End Function	#tag EndEvent	#tag Method, Flags = &h0		Function convertTC(s as string) As string		  dim result as string		  dim tc as timecode		  tc = gettimeCode		  		  result = trim(s)		  result = replaceall(result,".","")		  if tc <> nil then		    tc.setTC val(result)		    result = tc.gettext		  end		  return result		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function convertTCexport(s as string) As string		  dim result as string		  		  result = trim(s)		  result = replaceall(result,":",".")		  result = result		  return result		End Function	#tag EndMethod	#tag Note, Name = changes		1.7.8b5 removed period after title number after discussion with bloesch and cinetyp			#tag EndNote	#tag Note, Name = Export		  dim i,j,cf as integer		  dim onet as onetitle		  dim titles(-1), textlines as string		  dim lines(-1) as string		  dim result as string		  dim title as string		  dim tc as timecode		  dim inp, outp, t as string		  dim stylestr as string		  dim d as date		  		  onet = new onetitle(style)		  		  cf = ed.titlecount		  		  tc = ed.style.getTimeCode		  		  for i = 1 to cf		    onet = ed.gettitle(i)		    if onet.getinpoint<>"" and onet.getoutpoint<>"" then		      inp = converttcexport(onet.getinpoint)		      outp = converttcexport(onet.getoutpoint)		      lines.append inp + " - " + outp		      textlines = onet.text		      textlines = replaceall(textlines,endofLine,endofline.windows)		      textlines = replaceall(textlines,"<b>","")		      textlines = replaceall(textlines,"</b>","")		      textlines = replaceall(textlines,"<i>","")		      textlines = replaceall(textlines,"</i>","")		      textlines = replaceall(textlines,"<u>","")		      textlines = replaceall(textlines,"</u>","")		      if not app.reg.online then		        textlines = "Offline" + mid(textlines,8)		      end		      lines.append str(i)+ " " +textlines		      lines.append ""		    end		  next		  		  result = join(lines,endofline.windows)		  result = result.convertEncoding(encodings.windowsaNSI)		  return result		  			#tag EndNote	#tag Note, Name = MenuHandler		  dim f as folderItem		  dim t as textoutputStream		  dim i as integer		  dim st as string		  dim s as string		  dim sd as saveasDialog		  dim tc as timecode		  dim ct as cinetyptCConverter		  		  ct = new cinetyptcConverter		  		  sd = new saveasDialog		  sd.Filter = "TEXT"		  sd.ActionButtonCaption = "Export"		  sd.suggestedFileName = title + ".txt"		  if document = nil then		    sd.initialDirectory = documentsFolder		  else		    sd.initialDirectory = document.parent		  end		  //f = sd.showmodalwithin(me)		  f = sd.showmodal		  if f<>nil then		    t = f.createtextfile		    if t<>nil then		      offlineWarning		      app.mouseCursor = system.cursors.wait		      tc = style.gettimeCode		      tc.settext movieoffsetField.text		      t.write ct.Export(titlelist)		      t.close 		      app.mouseCursor = system.cursors.standardpointer		    else		      msgbox "Error Main:ExportOtherCinetypTimeCode: No TextOutPutStream"		    end		    		  end			#tag EndNote	#tag ViewBehavior		#tag ViewProperty			Name="documentname"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="TitleExporterBN"		#tag EndViewProperty		#tag ViewProperty			Name="dumpstring"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="TitleExporterBN"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="moviename"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="TitleExporterBN"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass