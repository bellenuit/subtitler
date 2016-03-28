#tag ClassProtected Class EBUExporterBNInherits TitleExporterBN	#tag Event		Function ExportEvent() As string		  dim item,  pos as integer		  dim title as onetitle		  dim s,inp,outp, titletext as string		  dim d as date		  dim first as boolean		  dim tc as timecode		  dim b as ramStream		  dim st as subtitle		  		  exporteventprepareevent		  		  b = new ramstream(ubound(titles)*500 + 1024)		  b.littleEndian(true)		  		  // write header		  		  '0..2 3 Code Page Number CPN		  // 437 USA		  // 850 multilingual		  		  b.write "850"		  		  '3..10 8 Disk Format Code DFC		  select case style.framerate		  case "24"		    b.write "STL24.01"		  case "25"		    b.write "STL25.01"		  case "29.97 DF", "29.97 NDF", "30"		    b.write "STL30.01"		  else		    msgBox "EditTitle:dumpEBUfile unsupported framerate " + style.framerate		    return ""		  end		  		  '11 1 Display Standard Code DSC		  b.write DisplayStandardCode		  		  '12..13 2 Character Code Table number CCT		  		  b.write GetEBUCharacterCode		  '14..15 2 Language Code LC		  b.write "00" // unknown		  		  '16..47 32 Original Programme Title OPT		  s = documentname.convertEncoding(encodings.ASCII)		  s = left(s,32)		  b.write s		  while b.position < 48		    b.write " "		  wend		  '48..79 32 Original Episode Title OET		  while b.position < 80		    b.write " "		  wend		  '80..111 32 Translated Programme Title TPT		  s = documentname.convertEncoding(encodings.asCII)		  s = left(s,32)		  b.write s		  while b.position < 112		    b.write " "		  wend		  '112..143 32 Translated Episode Title TET		  while b.position < 144		    b.write " "		  wend		  '144..175 32 Translator's Name TN		  s = app.reg.user.convertEncoding(encodings.asCII)		  s = left(s,32)		  b.write s		  while b.position < 176		    b.write " "		  wend		  '176..207 32 Translator's Contact Details TCD		  s = "Belle Nuit Subtitler " + app.shortversion		  s = left(s,32)		  b.write s		  while b.position < 208		    b.write " "		  wend		  '208..223 16 Subtitle List Reference Code SLR		  while b.position < 224		    b.write " "		  wend		  '224..229 6 Creation Date CD		  d = new date		  s = right(format(d.year,"00"),2)		  s = s + right(format(d.month,"00"),2)		  s = s + right(format(d.day,"00"),2)		  b.write s		  '230..235 6 Revision Date RD		  b.write s		  '236..237 2 Revision number RN		  b.write "00"		  '238..242 5 Total Number of text and Timing Information (TTI) blocks TNB		  s = right(format(ubound(titles),"00000"),5)  // we will write that a second time later		  b.write s		  '243..247 5 Total Number of Subtitles TNS		  b.write s		  '248..250 3 Total Number of Subtitle Groups TNG		  b.write "001"		  '251..252 2 Maximum Number of Displayable Characters in any text row MNC		  b.write "99"		  '253..254 2 Maximum Number of Displayable Rows MNR		  b.write MaximumNumberOfDisplayableRows		  '255 1 Time Code: Status TCS		  b.write "1"		  '256..263 8 Time Code: Start-of-Programme TCP		  // guess: use the first title		  b.write "00000000" // we will come back		  '264..271 8 Time Code: First In-Cue TCF		  // use first title		  b.write "00000000" // we will come back		  '272 1 Total Number of Disks TND		  b.write "1"		  '273 1 Disk Sequence Number DSN		  '274..276 3 Country of Origin CO		  b.write "SUI"		  '277..308 32 Publisher PUB		  '309..340 32 Editor's Name EN		  '341..372 32 Editor's Contact Details ECD		  '373..447 75 Spare Bytes		  '448..1023 576 User-Defined Area UDA		  		  // pad 1024 with space		  while b.position < 1024		    b.write " "		  wend		  		  first = true		  		  tc = style.getTimeCode		  		  for each title in titles		    if title.getinpoint<>"" and title.getoutpoint<>"" then		      st = title.style		      select case st.halign		      case st.kHalignleft		        justificationCode = kJustificationLeft		      case st.kHaligncenter		        justificationCode = kJustificationCenter		      case st.khalignright		        justificationCode = kJustificationRight		      case st.KHalignCenterLeft		        justificationCode = kJustificationCenter		      else		        justificationCode = kJustificationCenter		      end		      		      inp = title.getinpoint		      outp = title.getoutpoint		      tc.settext inp		      inp = tc2ebu(tc)		      tc.settext outp		      outp = tc2ebu(tc)		      if first then		        pos = b.position		        // write into header		        b.position(256)		        b.write inp		        b.position(264)		        b.write outp		        first = false		        b.position(pos)		      end		      if title.gettext <> "" then		        titletext = title.gettext		        titletext = simplifyText(titletext)		        		        select case getEBUCharacterCode		        case "00"		          titletext = utf82latinEBU(titletext)		        case "01"		          titletext = utf82LatinCyrillicEBU(titletext)		        case "02"		          titletext = utf82latinarabicEBU(titletext)		        case "03"		          titletext = utf82latingreekEBU(titletext)		        case "04"		          titletext = utf82LatinHebrewEBU(titletext)		          		        else		          titletext = utf82latinEBU(titletext)		        end		        		        titletext = replacelineEndings(titletext,chr(13)) //1.7.6b3		        titletext = replaceallb(titletext,chr(13),chr(&h8a))  // 1.7.6b2  //b3 replaceallb		        		        // support for italics //EBU italic		        if st.italic then		          titletext  = chr(&h80) + titletext + chr(&h81)		        end		        titletext = replaceallb(titletext,"<i>",chr(&h80))		        titletext = replaceallb(titletext,"</i>",chr(&h81))		        		        		        'titletext = latinEBU2UTF8(titletext) // test unity		        if titletext<>"" then		          item = item + 1		          		          '0 1 Subtitle Group Number SGN		          		          b.writebyte SubtitleGroupNumber		          		          '1..2 2 Subtitle Number SN		          b.writeshort item		          		          '3 1 Extension Block Number EBN		          b.writebyte 255 //&hff // last		          		          '4 1 Cumulative Status CS		          b.writebyte 0		          		          '5..8 4 Time Code In TCI		          b.write inp		          		          '9..12 4 Time Code Out TCO		          b.write outp		          		          '13 1 Vertical Position VP		          b.writebyte VerticalPosition		          '14 1 Justification Code JC		          b.writebyte JustificationCode		          '15 1 Comment Flag CF		          b.writebyte 0		          '16..127 112 text Field TF		          b.write leftb(titletext,127-16)		        end		      end		    end		    		    		    while b.position < 1024 + 128 *item		      b.writebyte &h8f		    wend		    		    if item mod 10 = 0 then		      progress 10 + item/ubound(titles)*40		    end		    		  next		  		  pos = b.position		  		  //write summary		  '238..242 5 Total Number of text and Timing Information (TTI) blocks TNB		  b.position(238)		  s = right(format(item,"00000"),5)		  b.write s		  '243..247 5 Total Number of Subtitles TNS		  b.position(243)		  b.write s		  		  		  b.position(0)		  s = b.read(pos)		  return s		  		  		  		  		  		End Function	#tag EndEvent	#tag Event		Function GetCreatorEvent() As string		  return "EBUS"		End Function	#tag EndEvent	#tag Event		Function GetDefaultDictEvent() As dictionary		  dim d as new dictionary		  d.value("textencoding") = "Latin"		  return d		End Function	#tag EndEvent	#tag Event		Function GetDefaultNameEvent() As string		  return documentname + ".stl"		End Function	#tag EndEvent	#tag Event		Function GetLabelEvent() As string		  return mylabel		End Function	#tag EndEvent	#tag Event		Function GetTextEncodingListEvent() As string		  return "Latin;LatinCyrillic;LatinArabic;LatinGreek;LatinHebrew"		End Function	#tag EndEvent	#tag Event		Function GetTypeEvent() As string		  return "EBUS"		End Function	#tag EndEvent	#tag Event		Function IsBinaryEvent() As boolean		  return true		End Function	#tag EndEvent	#tag Method, Flags = &h1		Protected Sub AddStrings(utfstring as string, ebustart as integer)		  dim i,le as integer		  le = len(utfstring)		  if le<>16 then		    msgBox "EBUExporterBN AddString length not 16 " + utfstring		  end		  for i = 1 to le		    utf8table.append mid(utfstring,i,1)		    ebutable.append ebustart + i-1		    ebuprefixtable.append 0		  next		  		End Sub	#tag EndMethod	#tag Method, Flags = &h1		Protected Sub AddStrings(utfstring as string, ebustring as string, ebuextension as integer)		  dim le1, le2, i as integer		  		  le1 = len(utfstring)		  le2 = len(ebustring)		  if le1<>le2 then		    msgBox "EBUExporterBN AddString length not equal " + utfstring		  end		  		  for i = 1 to le1		    utf8table.append mid(utfstring,i,1)		    ebutable.append asc(mid(ebustring,i,1))		    ebuprefixtable.append ebuextension		  next		  		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Constructor()		  mylabel = "EBU (stl binary)"		  displayStandardCode = "0"		  maximumNumberOfDisplayableRows = "99"		  VerticalPosition = 02		  JustificationCode = kJustificationCenter		End Sub	#tag EndMethod	#tag Method, Flags = &h1		Protected Function GetEBUCharacterCode() As string		  dim s, result as string		  if dict.getstring("textencoding",s) then		    select case s		    case "Latin"		      return "00"		    case "LatinCyrilic"		      return "01"		    case "LatinArabic"		      return "02"		    case "LatinGreek"		      return "03"		    case "LatinHebrew"		      return "04"		    else		      return "00"		    end		  else		    return "00"		  end		End Function	#tag EndMethod	#tag Method, Flags = &h1		Protected Sub Init()		  dim i as integer		  		  redim ebutable(-1)		  redim utf8table(-1)		  redim ebuprefixtable(-1)		  		  		  // return		  utf8table.append chr(13)		  ebutable.append &h8a		  ebuprefixtable.append 0		  		  for i = 32 to 127		    utf8table.append chr(i)		    ebutable.append i		    ebuprefixtable.append 0		  next		  		  addstrings("_¡¢£$¥_§_‵‶«←↑→↓",&hA0)		  addstrings("°±²³×µ¶·÷′″»¼½¾¿", &hB0)		  		  addstrings("ÀàÈèÌìÒòÙù","AaEeIiOoUu",&hC1) // grave		  addstrings("ÁáĆćÉéÍíĹĺŃńÓóŚśÚúÝýŹź","AaCcEeIiLlNnOoSsUuYyZz",&hC2) // acute		  AddStrings("í",chr(245),&hC2) // special case islandic		  addstrings("ÂâĈĉÊêĜĝĤĥÎîĴĵÔôŔŕŜŝÛûŴŵŶŷ","AaCcEeGgHhIiJjOoRrSsUuWwYy",&hC3)  //circ		  addstrings("ÃãĨĩÑñÕõŨũ","AaIiNnOoUu",&hC4) // tilde		  addstrings("ÄäËëÏïÖöÜüŸÿ","AaEeIiOoUuYy",&hC8) // umlaut		  addstrings("ÅåŮů","AaUu",&hCA) // ring		  addstrings("ĀāĒēĪīŌōŪū","AaEeIiOoUu",&hC5)  // macron		  addstrings("ĄąĘęĮįŲų","AaEeIiUu",&hCE) // ogonek		  addstrings("ĂăĔĕĞğĬĭŎŏŬŭŽž","AaEeGgIiOoUuZz",&hC6) // breve		  addstrings("ȦȧĊċĖėĠġİıŻż","AaCcEeGgIiZz",&hC7) // dot		  // &hC9 not defined		  addstrings("ÇçĢģĻļŅņŖŗŞşŢţ","CcGgLlNnRrSsTt",&hCB)  // cedilla		  addstrings("Ṯṯ","Tt",&hCC)  // underline		  addstrings("ŐőŰű","OoUu",&hCD)  // double aacute		  addstrings("ČčĎďĚěĽľŇňŘřŠšŤťŽž","CcDdEeLlNnRrTtSsZZ",&hCF) // caron		  		  addstrings("-¹®©™♪¬╎____⅛⅜⅝⅞", &hD0)		  addstrings("ΩÆĐạĦ_ĲĿŁØŒọÞŦŊŉ", &hE0)		  addstrings("κæđðħ_ĳŀłøœßþŧŋ_", &hF0)		  		  if ubound(utf8table) <> ubound(ebutable) or ubound(utf8table) <> ubound(ebuprefixtable) then		    msgBox "EBUExporterBN Init Tables not same length"		  end		  		  		  		End Sub	#tag EndMethod	#tag Method, Flags = &h1		Protected Function Instr2(source as string, find as string) As integer		  dim i,le,lef as integer		  dim test as string		  		  // instr normal geht nicht, case-insensitive		  // instrb geht nicht, wir wollen position in utf8		  		  le = len(source)		  lef = len(find)		  for i = 1 to le		    test = mid(source,i,lef)		    if strcomp(test,find,0) = 0 then		      return i		    end		  next		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function LatinEBU2UTF8(s as string) As string		  dim j,ub,le, pos, test, test2 as integer		  dim result as string		  dim b as ramstream		  dim found as boolean		  		  if ubound(ebuprefixtable) = -1 then init		  		  le = len(s)		  b = new ramstream(le)		  b.write s		  b.position(0)		  		  ub = ubound(utf8table)		  		  while not b.eof		    test = b.readbyte		    if test>= &hC0 and test <= &hCF then		      if not b.eof then		        test2 = b.readbyte		        for j = 0 to ub		          if test = ebuprefixtable(j) and test2 = ebutable(j) then		            result = result +utf8table(j)		            exit		          end		        next		      end		    else		      found = false		      select case test		      case &h00,&h01,&h02, &h03, &h04,&h05, &h06, &h0A, &h0B, &h0C,&h0D, &h0E, &h0F,  _		        &h10,&h11,&h12, &h13, &h14,&h15, &h16, &h1A, &h1B, &h1C,&h1D, &h1E, &h1F, &h84, &h85 // ignore teletext		        found = true		      case &h80   //EBU italic		        result = result + "<i>"		        		      case &h81  //EBU italic		        result = result + "</i>"		      case &h8f		        // end		        result = result.defineEncoding(encodings.utf8)		        return result		      else		        for j = 0 to ub		          if test = ebutable(j) then		            result = result + utf8table(j)		            found = true		            exit		          end		        next		      end		      if not found then  result = result + "<" + hexformat(test,2) + ">"		    end		  wend		  		  result = result.defineEncoding(encodings.utf8)		  return result		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function tc2ebu(tc as timecode) As string		  dim m as memoryBlock		  dim s as string		  m = newmemoryBlock(4)		  m.littleEndian = false		  s = tc.gettext		  m.byte(0) = val(mid(s,1,2))		  m.byte(1) = val(mid(s,4,2))		  m.byte(2) = val(mid(s,7,2))		  m.byte(3) = val(mid(s,10,2))		  return m.stringValue(0,4)		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub UnityTest()		  dim rs , es, rs2 as string		  dim i,ub as integer		  		  ub = ubound(utf8table)		  for i = 0 to 48		    rs = rs + utf8table(rnd*ub)		  next		  es = utf82latinEBU(rs)		  rs2 = latinEBU2UTF8(es)		  		  if strComp(rs,rs2,0) <> 0 then		    msgBox "string not identical " +endofLine + endofLine + rs +rs2		  end		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function UTF82LatinArabicEBU(s as string) As string		  dim result as string		  		  result = s.convertEncoding(encodings.isolatinArabic)		  return result		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function UTF82latincyrillicEBU(s as string) As string		  dim result as string		  		  result = s.convertEncoding(encodings.isolatinCyrillic)		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function UTF82LatinEBU(s as string) As string		  dim i,j,ub,le, pos as integer		  dim letter as string		  dim b as ramstream		  		  if ubound(ebuprefixtable) = -1 then init		  		  le = len(s)		  b = new ramstream(2*le)		  		  le = len(s)		  ub = ubound(utf8table)		  		  addformatEvent b		  		  for i = 1 to le		    letter = mid(s,i,1)		    for j = 0 to ub		      if strcomp(letter,utf8table(j),0) = 0 then		        if ebuprefixtable(j) <> 0 then b.writebyte ebuprefixtable(j) 		        b.writebyte ebutable(j)		        exit		      end		    next		    if letter = endofLine then		      addformatEvent b		    end		  next		  		  pos = b.position		  b.position(0)		  		  return b.read(pos)		  		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function UTF82LatinGreekEBU(s as string) As string		  dim result as string		  		  result = s.convertEncoding(encodings.isolatinGreek)		  		  		  		  '0xB4 0x0384 # GREEK TONOS		  '0xB5 0x0385 # GREEK DIALYTIKA TONOS		  '		  '		  return result		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function UTF82LatinHebrewEBU(s as string) As string		  dim result as string		  		  result = s.convertEncoding(encodings.isolatinHebrew)		  return result		End Function	#tag EndMethod	#tag Hook, Flags = &h0		Event AddFormatEvent(b as ramstream)	#tag EndHook	#tag Hook, Flags = &h0		Event ExportEventPrepareEvent()	#tag EndHook	#tag Note, Name = dump		  dim b as binaryStream		  dim cf, i, item,  pos as integer		  dim onet as onetitle		  dim s,inp,outp, titletext as string		  dim d as date		  dim first as boolean		  dim tc as timecode		  dim enc as string		  		  cf = titlecount		  		  b = f.createBinaryFile("EBU")		  b.littleEndian = false		  if b= nil then		    msgBox "EditTitle:dumpEBUfile no binarystream"		    return		  end		  b.littleEndian = true		  		  // write header		  		  '0..2 3 Code Page Number CPN		  // 437 USA		  // 850 multilingual		  		  select case getfontTextEncoding(textfont).internetName		  case "MACINTOSH"		    enc = "850"		  case "X-MAC-CE"		    enc = "852"		  else		    enc = "850"		  end		  		  b.write enc		  		  '3..10 8 Disk Format Code DFC		  select case style.framerate		  case "25"		    b.write "STL25.01"		  case "29.97 DF", "29.97 NDF", "30"		    b.write "STL30.01"		  else		    msgBox "EditTitle:dumpEBUfile unsupported framerate " + style.framerate		    b.close		    return		  end		  		  '11 1 Display Standard Code DSC		  b.write "0" // open captioning		  		  '12..13 2 Character Code Table number CCT		  b.write "00" // Latin		  '14..15 2 Language Code LC		  b.write "00" // unknown		  		  '16..47 32 Original Programme Title OPT		  s = edltitle.convertEncoding(encodings.asCII)		  s = left(s,32)		  b.write s		  while b.position < 48		    b.write " "		  wend		  '48..79 32 Original Episode Title OET		  while b.position < 80		    b.write " "		  wend		  '80..111 32 Translated Programme Title TPT		  s = edltitle.convertEncoding(encodings.asCII)		  s = left(s,32)		  b.write s		  while b.position < 112		    b.write " "		  wend		  '112..143 32 Translated Episode Title TET		  while b.position < 144		    b.write " "		  wend		  '144..175 32 Translator's Name TN		  s = app.reg.user.convertEncoding(encodings.asCII)		  s = left(s,32)		  b.write s		  while b.position < 176		    b.write " "		  wend		  '176..207 32 Translator's Contact Details TCD		  s = "Belle Nuit Subtitler " + app.shortversion		  s = left(s,32)		  b.write s		  while b.position < 208		    b.write " "		  wend		  '208..223 16 Subtitle List Reference Code SLR		  while b.position < 224		    b.write " "		  wend		  '224..229 6 Creation Date CD		  d = new date		  s = right(format(d.year,"00"),2)		  s = s + right(format(d.month,"00"),2)		  s = s + right(format(d.day,"00"),2)		  b.write s		  '230..235 6 Revision Date RD		  b.write s		  '236..237 2 Revision number RN		  b.write "00"		  '238..242 5 Total Number of text and Timing Information (TTI) blocks TNB		  s = right(format(cf,"00000"),5)		  b.write s		  '243..247 5 Total Number of Subtitles TNS		  b.write s		  '248..250 3 Total Number of Subtitle Groups TNG		  b.write "001"		  '251..252 2 Maximum Number of Displayable Characters in any text row MNC		  b.write "99"		  '253..254 2 Maximum Number of Displayable Rows MNR		  b.write "99"		  '255 1 Time Code: Status TCS		  b.write "1"		  '256..263 8 Time Code: Start-of-Programme TCP		  // guess: use the first title		  b.write "00000000" // we will come back		  '264..271 8 Time Code: First In-Cue TCF		  // use first title		  b.write "00000000" // we will come back		  '272 1 Total Number of Disks TND		  b.write "1"		  '273 1 Disk Sequence Number DSN		  '274..276 3 Country of Origin CO		  b.write "SUI"		  '277..308 32 Publisher PUB		  '309..340 32 Editor's Name EN		  '341..372 32 Editor's Contact Details ECD		  '373..447 75 Spare Bytes		  '448..1023 576 User-Defined Area UDA		  		  // pad 1024 with space		  while b.position < 1024		    b.write " "		  wend		  		  first = true		  		  tc = style.getTimeCode		  		  for i = 1 to cf		    onet = gettitle(i)		    if onet.getinpoint<>"" and onet.getoutpoint<>"" then		      inp = onet.getinpoint		      outp = onet.getoutpoint		      tc.settext inp		      inp = tc2ebu(tc)		      tc.settext outp		      outp = tc2ebu(tc)		      if first then		        pos = b.position		        // write into header		        b.position = 256		        b.write inp		        b.position = 264		        b.write outp		        first = false		        b.position = pos		      end		      if onet.text <> "" then		        titletext = onet.text		        if not app.reg.online then		          titletext = "Offline" + mid(titletext,8)		        end		        titletext = utf82latin(titletext,enc)		        if titletext<>"" then		          item = item + 1		          		          '0 1 Subtitle Group Number SGN		          		          b.writebyte 0		          		          '1..2 2 Subtitle Number SN		          b.writeshort item		          		          '3 1 Extension Block Number EBN		          b.writebyte &hff // last		          		          '4 1 Cumulative Status CS		          b.writebyte 0		          		          '5..8 4 Time Code In TCI		          b.write inp		          		          '9..12 4 Time Code Out TCO		          b.write outp		          		          '13 1 Vertical Position VP		          b.writebyte 02		          '14 1 Justification Code JC		          b.writebyte 02 // centered		          '15 1 Comment Flag CF		          b.writebyte 0		          '16..127 112 text Field TF		          b.write leftb(titletext,127-16)		        end		      end		    end		    		    		    while b.position < 1024 + 128 *item		      b.writebyte &h8f		    wend		  next		  		  //write summary		  '238..242 5 Total Number of text and Timing Information (TTI) blocks TNB		  b.position = 238		  s = right(format(item,"00000"),5)		  b.write s		  '243..247 5 Total Number of Subtitles TNS		  b.position = 243		  b.write s		  		  //write titlecount		  		  		  		  		  b.close		  		  			#tag EndNote	#tag Note, Name = menuhandler		  dim f as folderItem		  dim t as textoutputStream		  dim i as integer		  dim st as string		  dim s as string		  dim sd as saveasDialog		  dim tc as timecode		  		  sd = new saveasDialog		  sd.Filter = "EBU"		  sd.ActionButtonCaption = "Export EBU"		  sd.suggestedFileName = title + ".stl"		  if document = nil then		    sd.initialDirectory = documentsFolder		  else		    sd.initialDirectory = document.parent		  end		  //f = sd.showmodalwithin(me)		  f = sd.showmodal		  		  if f<>nil then		    offlineWarning		    app.mouseCursor = system.cursors.wait		    titlelist.dumpEBUfile(f,title)		    app.mouseCursor = system.cursors.standardpointer		  end			#tag EndNote	#tag Note, Name = versions				2.0.0b1 islandic character iacute	#tag EndNote	#tag Property, Flags = &h0		DisplayStandardCode As string	#tag EndProperty	#tag Property, Flags = &h1		Protected ebuprefixtable(-1) As integer	#tag EndProperty	#tag Property, Flags = &h1		Protected ebutable(-1) As integer	#tag EndProperty	#tag Property, Flags = &h0		greekdict As dictionary	#tag EndProperty	#tag Property, Flags = &h0		inversegreekdict As dictionary	#tag EndProperty	#tag Property, Flags = &h0		JustificationCode As integer	#tag EndProperty	#tag Property, Flags = &h0		MaximumNumberOfDisplayableRows As string	#tag EndProperty	#tag Property, Flags = &h0		mylabel As string	#tag EndProperty	#tag Property, Flags = &h1		Protected SubtitleGroupNumber As integer	#tag EndProperty	#tag Property, Flags = &h1		Protected utf8table(-1) As string	#tag EndProperty	#tag Property, Flags = &h0		VerticalPosition As integer	#tag EndProperty	#tag Constant, Name = kJustificationCenter, Type = Integer, Dynamic = False, Default = \"2", Scope = Public	#tag EndConstant	#tag Constant, Name = kJustificationLeft, Type = Integer, Dynamic = False, Default = \"1", Scope = Public	#tag EndConstant	#tag Constant, Name = kJustificationOrigin, Type = Integer, Dynamic = False, Default = \"0", Scope = Public	#tag EndConstant	#tag Constant, Name = kJustificationRight, Type = Double, Dynamic = False, Default = \"3", Scope = Public	#tag EndConstant	#tag ViewBehavior		#tag ViewProperty			Name="DisplayStandardCode"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"		#tag EndViewProperty		#tag ViewProperty			Name="documentname"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="TitleExporterBN"		#tag EndViewProperty		#tag ViewProperty			Name="dumpstring"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="TitleExporterBN"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="JustificationCode"			Group="Behavior"			InitialValue="0"			Type="integer"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="MaximumNumberOfDisplayableRows"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"		#tag EndViewProperty		#tag ViewProperty			Name="moviename"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="TitleExporterBN"		#tag EndViewProperty		#tag ViewProperty			Name="mylabel"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="VerticalPosition"			Group="Behavior"			InitialValue="0"			Type="integer"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass