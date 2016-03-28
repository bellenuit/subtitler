#tag ClassProtected Class SonicScenaristExporterBNInherits TitleExporterBN	#tag Event		Function ExportEvent() As string		  dim item,i, sonicheight as integer		  dim lines(-1), textlines(-1), result, inp, outp, tab, fp as string		  dim first as boolean		  dim title as onetitle		  dim tc, offset as timecode		  		  tc = gettimeCode		  offset = getoffset		  tab = chr(9)		  		  call dict.getstring("folderpath",fp)		  		  sonicheight = style.height-1		  if sonicheight = 575 then sonicheight = 574  // ntsc 479, pal  574 who knows why		  		  lines.append "st_format"+tab+" 2"		  lines.append "SubTitle"+tab+"Bellenuit" // + name of folder as it appears in data editor		  lines.append "Display_start"+tab+"non_forced"		  lines.append "Pixel_Area"+tab+"(2 "+str(sonicheight)+")"		  lines.append "Display_Area"+tab+"(0 2 "+str(style.width-1)+" "+str(sonicheight)+")"		  lines.append "Color"+tab+"("+style.dvdinfo("Outline2Color")+" " +style.DVDinfo("Outline1Color")+" " + _		  style.dvdinfo("textColor") + " " + style.dvdinfo("BackgroundColor") + ")"  // changed order 1.7b17		  lines.append "Contrast  ("+style.dvdinfo("Outline2Contrast")+" " +style.DVDinfo("Outline1Contrast")+" " + _		  style.dvdinfo("textContrast") + " " + style.dvdinfo("BackgroundContrast") + ")"  // changed order 1.7b17		  lines.append "BG"+tab+"(255 255 255   = = =)" 		  lines.append "PA"+tab+" (0 0 0   = = =)" 		  lines.append "E1"+tab+" (255 0 0   = = =)" 		  'lines.append "E2"+tab+" 0 0 255   = = =)" 		  lines.append "E2"+tab+" (0 0 255   = = =)" // 1.7.3b1		  lines.append "# Note: " + style.DVDinfo("Comments")		  lines.append "directory"+tab +fp		  lines.append "##"		  lines.append "SP_NUMBER"+tab+"START"+tab+"END"+tab+"FILE_NAME"		  		  		  for each title in titles		    		    if title.getinpoint<>"" and title.getoutpoint<>"" then		      item = item + 1		      inp = title.getinpoint		      outp = title.getoutpoint		      		      tc.settext inp		      tc.plus(offset)		      inp = tc.gettext		      tc.settext outp		      tc.plus(offset)		      outp = tc.gettext		      		      lines.append format(item,"0000")+ tab + inp + tab + outp + tab + title.filenameComplete		    end		  next		  		  result = join(lines,endofLine.windows)		  return result		  		  		End Function	#tag EndEvent	#tag Event		Function GetDefaultDictEvent() As dictionary		  dim d as new dictionary		  d.value("applyoffset") = false		  d.value("applyoffsetvalue") = "00:00:00:00"		  d.value("folderpath") = "C:\"		  return d		End Function	#tag EndEvent	#tag Event		Function GetDefaultNameEvent() As string		  return documentname + ".sst"		End Function	#tag EndEvent	#tag Event		Function GetDefaultPathEvent() As folderitem		  return exportfolder		End Function	#tag EndEvent	#tag Event		Function GetLabelEvent() As string		  return "Sonic Scenarist"		End Function	#tag EndEvent	#tag Note, Name = dump		  dim i,j,cf as integer		  dim onet as onetitle		  dim titles(-1) as string		  dim lines(-1) as string		  dim result as string		  dim title as string		  dim tc as timecode		  dim inp, outp, t as string		  dim tab as string		  dim numb as string		  dim sonicheight as integer		  		  tab = chr(9)		  		  		  		  if graph then		    sonicheight = style.height-1		    if sonicheight = 575 then sonicheight = 574  // ntsc 479, pal  574 who knows why		    		    lines.append "st_format 2"		    lines.append "SubTitle"+tab+"Bellenuit" // + name of folder as it appears in data editor		    lines.append "Display_start"+tab+"non_forced"		    lines.append "Pixel_Area (2 "+str(sonicheight)+")"		    lines.append "Display_Area (0 2 "+str(style.width-1)+" "+str(sonicheight)+")"		    lines.append "Color ("+style.dvdinfo("BackgroundColor")+" " +style.DVDinfo("textColor")+" " + _		         style.dvdinfo("Outline1Color") + " " + style.dvdinfo("Outline2Color") + ")" 		    lines.append "Contrast  ("+style.dvdinfo("BackgroundContrast")+" " +style.DVDinfo("textContrast")+" " + _		        style.dvdinfo("Outline1Contrast") + " " + style.dvdinfo("Outline2Contrast") + ")" 		    lines.append "BG (255 255 255   = = =)" // color here?		    lines.append "PA (0 0 0   = = =)" // color here?		    lines.append "E1 (255 0 0   = = =)" // color here?		    lines.append "E2 (0 0 255   = = =)" // color here?		    lines.append "# Note: " + style.DVDinfo("Comments")		    lines.append "# Note: Add correct absolute path to directory by hand:"		    lines.append "directory " +folderpath		    lines.append "##"		    lines.append "SP_NUMBER"+tab+"START"+tab+"END"+tab+"FILE_NAME"		  end		  		  		  		  onet = new onetitle(style)		  		  cf = titlecount		  		  tc = style.getTimeCode		  		  for i = 1 to cf		    onet = gettitle(i)		    if onet.getinpoint<>"" and onet.getoutpoint<>"" then		      inp = onet.getinpoint		      outp = onet.getoutpoint		      if not tapeoffset then		        tc.settext inp		        tc.minus(offset)		        inp = tc.gettext		        tc.settext outp		        tc.minus(offset)		        outp = tc.gettext		      end		      if graph then		        t = prefix + onet.getfilename + suffix		      else		        t = onet.text		        t = replaceall(t,endofline,endofline + tab + tab + tab)		        if app.parsestyletags then		          t = replaceall(t,"<b>","^b")		          t = replaceall(t,"</b>","^b")		          t = replaceall(t,"<i>","^i")		          t = replaceall(t,"</i>","^i")		          t = replaceall(t,"<u>","^u")		          t = replaceall(t,"</u>","^u")		        end		        if not app.reg.online then		          t = "Offline" + mid(t,8)		        end		      end		      numb = format(i,"0000")		      lines.append numb + tab + inp + tab + outp +  tab + t		    end		  next		  		  result = join(lines,endofline)		  result = result.convertEncoding(encodings.macroman)		  return result		  			#tag EndNote	#tag Note, Name = menuhandler		  dim f as folderItem		  dim t as textoutputStream		  dim i as integer		  dim st as string		  dim s as string		  dim sd as saveasDialog		  dim tc as timecode		  dim fold as folderitem		  dim suffix as string		  		  sd = new saveasDialog		  sd.Filter = "TEXT"		  sd.ActionButtonCaption = "Export SST"		  sd.suggestedFileName = title + ".sst"		  fold = getfolderItem(folderpath)		  if fold = nil then		    if document = nil then		      sd.initialDirectory = documentsFolder		    else		      sd.initialDirectory = document.parent		    end		  else		    sd.initialDirectory = fold		  end		  //f = sd.showmodalwithin(me)		  f = sd.showmodal		  select case left(exportformat,4)		  case "PICT"		    suffix = app.pictextension		  case "TIFF"		    suffix = app.tiffextension		  end		  		  if f<>nil then		    t = f.createtextfile		    if t<>nil then		      'offlineWarning		      app.mouseCursor = system.cursors.wait		      tc = style.gettimeCode		      tc.settext movieoffsetField.text		      t.write titlelist.dumpSonicSST(prefix, suffix, app.stltapeoffset, tc, true, folderpath)		      t.close 		      app.mouseCursor = system.cursors.standardpointer		    else		      msgbox "Error Main:FileExportSonicSSTText: No TextOutPutStream"		    end		    		  end			#tag EndNote	#tag ViewBehavior		#tag ViewProperty			Name="documentname"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="TitleExporterBN"		#tag EndViewProperty		#tag ViewProperty			Name="dumpstring"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="TitleExporterBN"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="moviename"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="TitleExporterBN"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass