#tag ClassProtected Class OneTitle	#tag Method, Flags = &h0		Sub AddLine(s as string)		  if source<>"" then source = source + endofLine		  source = source + s		  parse		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Constructor(st as subtitle)		  style = st		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function DurationString() As String		  dim result as string		  dim tc,tc2 as timecode		  if instyle<>nil then  tc = instyle.getTimeCode		  if inpoint<>"" and outpoint<>"" and tc<>nil then		    tc.settext outpoint		    tc2 = tc.clone		    tc2.settext inpoint		    tc.Minus tc2		    result = tc.gettext		    if left(result,6)="00:00:" then		      result = mid(result,7)		    end		    return result		  end		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function FilenameComplete() As string		  return prefix + filename + suffix		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function GetExtraStyle() As string()		  parse		  return extrastyle		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function GetFilename() As string		  return filename		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function GetInPoint() As string		  return inpoint		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function GetOutPoint() As string		  return outpoint		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function GetText() As string		  return text		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function GetTextWithStyle() As string		  dim s as string		  		  s = text		  if me.style<>nil then		    if me.style.italic then		      s = "<i>"+s+"</i>"		    end		  end		  if me.style<>nil then		    if me.style.bold then		      s = "<b>"+s+"</b>"		    end		  end		  if me.style<>nil then		    if me.style.underline then		      s = "<u>"+s+"</u>"		    end		  end		  return s		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function LengthString() As String		  return str(len(textclean))		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub parse()		  dim line, fn as string		  dim textlines(-1), commentlines(-1), lines(-1) as string		  dim words(-1) as string		  dim r,g,b as integer		  dim word, shortword, par as string		  		  redim extrastyle(-1)		  comment = ""		  text= ""		  inpoint = ""		  outpoint = ""		  		  		  outstyle = new subtitle		  outstyle.clone instyle		  		  // support for multiple line comments 1.4 16.24		  lines = split(source,endofline)		  for each line in lines		    if left(line,1) = "/" then		      if left(line,2) = "//" then		        textlines.append mid(line,2)		      else		        commentlines.append line		        words = split(line," ")		        select case words(0)		        case "/file"		          words.remove 0		          fn = join(words," ")		          fn = replaceall(fn,":","-")		          fn = replaceall(fn,"/","-")		          fn = replaceall(fn,"\","-")		          filename = fn.defineEncoding(encodings.utf8)		          filenamedefined = filename		        case "/tc"		          if ubound(words)>=2 then		            inpoint = words(1)		            outpoint = words(2)		          end		        case "/style"		          for each word in words		            shortword = nthfield(word,"(",1)		            select case shortword		            case "italic"		              outstyle.italic = true		              extrastyle.append shortword		            case "bold"		              outstyle.bold = true		              extrastyle.append shortword		            case "underline"		              outstyle.underline = true		              extrastyle.append shortword		            case "plain"		              outstyle.bold = false		              outstyle.italic = false		              outstyle.underline = false		              extrastyle.append shortword		            case "left"		              outstyle.halign = 0		              extrastyle.append shortword		            case "center"		              outstyle.halign = 1		              extrastyle.append shortword		            case "right"		              outstyle.halign = 2 		              extrastyle.append shortword		            case "centerleft"		              outstyle.halign = 3		              extrastyle.append shortword		            case "color"		              par = nthfield(nthField(word,"(",2),")",1)		              r = val(nthfield(par,",",1))		              g = val(nthfield(par,",",2))		              b = val(nthfield(par,",",3))		              outstyle.textc = rgb(r,g,b)		              extrastyle.append word //!!		            case "boxlevel"		              par = nthfield(nthField(word,"(",2),")",1)		              outstyle.rectalpha = val(par)/100.0		            case "vertical"		              par = nthfield(nthField(word,"(",2),")",1)		              outstyle.ver.value = outstyle.ver.value + val(par)		            end		          next		        end		      end		    else		      textlines.append line		    end		  next		  comment = join(commentlines,endofline)		  text = join(textlines,endofline)		  		  // limit text to 256 characters performance very long lines		  text = left(text,256)		  		  		exception err as outofBoundsException		  // ignore		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub parseTimeCode()		  dim cf, i as integer		  dim line, macro, macrobody, fn as string		  dim nonempty as boolean		  		  inpoint = ""		  outpoint = ""		  realstart = 0		  		  cf = countfields (source,endofline)		  for i = 1 to cf		    line = nthField(source,endofline,i)		    		    if left(line,1) = "/" and left(line,2) <> "//" then		      macro = nthfield(line," ",1)		      macrobody = mid(line,len(macro)+2)		      select case macro		      case "/tc"		        inpoint = nthfield(macrobody," ",1)		        outpoint = nthfield(macrobody," ",2)		      case "/file"		        fn = macrobody		        fn = replaceall(fn,":","-")		        fn = replaceall(fn,"/","-")		        fn = replaceall(fn,"\","-")		        filename = fn.defineEncoding(encodings.utf8)		        filenamedefined = filename		      end		    elseif left(line,2)= "//" then		      textstart = instr(source,endofline+line) + 2 // escape //		      exit		    else		      // text starts		      if not nonempty then 		        textstart = instr(source,endofline+line) + 1		      else		        // empty line from  above 		      end		      if line<>"" then 		        nonempty = true 		      else		        if realstart = 0 then realstart = 1 		      end		      'exit  // could be an empty line		    end		  next		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function ReadingSpeedString() As string		  dim tc as timecode		  dim ls,ds as string		  dim d as double		  if instyle<>nil then  tc = instyle.getTimeCode		  ds = durationString		  ls = lengthString		  if ds<>"00:00" then		    tc.settext ds		    d = tc.gettotalSeconds		    if d>0 then		      return format(val(ls)/d, "0.0")		    end		  end		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub SetFilename(s as string)		  dim lines(-1) as string		  dim i,cf as integer		  dim found as boolean		  		  lines = split(source,endofline)		  cf = ubound(lines)		  		  		  		  for i = 0 to cf		    if left(lines(i),5) = "/file" then		      if s<>"" then		        lines(i) = "/file " + s		      else		        lines.remove i		        cf = cf-1		      end		      found = true		    end		  next		  		  if not found and s<>"" then		    lines.insert 0,  "/file " + s		  end		  		  source = join(lines,endofline)		  parse		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub SetInOut(newin as string, newout as string)		  dim s as string		  dim lines(-1) as string		  dim i,cf as integer		  dim found as boolean		  dim sin, sout as string		  		  lines = split(source,endofline)		  cf = ubound(lines)		  		  if newin <> "" then sin = newin else sin = getinpoint		  if newout <> "" then sout = newout else sout = getoutPoint		  		  for i = 0 to cf		    if left(lines(i),3) = "/tc" then		      lines(i) = "/tc " + sin + " " + sout		      found = true		      if lines(i) = "/tc 00:00:00:00 00:00:00:00" or lines(i) = "/tc 00:00:00;00 00:00:00;00" then		        lines.remove i		      end 		      exit		    end		  next		  		  if not found then		    lines.insert 0,  "/tc " + sin + " " + sout		  end		  		  source = join(lines,endofline)		  parse		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub SetItemFilename(v as integer, temp as boolean = false)		  if not temp then		    setfilename format(v,"0000")		  else		    filename = format(v,"0000")		  end		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub SetText(s as string)		  dim lines(-1), newlines(-1) as string		  dim i,cf as integer		  dim found as boolean		  		  lines = split(source,endofline)		  cf = ubound(lines)		  		  for i = 0 to cf		    if left(lines(i),1) = "/" and left(lines(i),2) <> "//" then		      newlines.append lines(i)		    end		  next		  		  newlines.append s		  		  source = join(newlines,endofline)		  parse		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function style() As subtitle		  return outstyle		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub style(assigns st as subtitle)		  instyle = st		  parse		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function TextClean() As string		  dim s as string		  if true then 'app.parsestyletags then //1.7b22		    s = text		    s = replaceall(s,"<b>","")		    s = replaceall(s,"</b>","")		    s = replaceall(s,"<i>","")		    s = replaceall(s,"</i>","")		    s = replaceall(s,"<u>","")		    s = replaceall(s,"</u>","")		    return s		  else		    return text		  end		End Function	#tag EndMethod	#tag Property, Flags = &h0		comment As string	#tag EndProperty	#tag Property, Flags = &h0		exportfolder As folderitem	#tag EndProperty	#tag Property, Flags = &h0		extrastyle(-1) As string	#tag EndProperty	#tag Property, Flags = &h21		Private filename As string	#tag EndProperty	#tag Property, Flags = &h0		filenamedefined As string	#tag EndProperty	#tag Property, Flags = &h21		Private inpoint As string	#tag EndProperty	#tag Property, Flags = &h21		Private instyle As subtitle	#tag EndProperty	#tag Property, Flags = &h21		Private outpoint As string	#tag EndProperty	#tag Property, Flags = &h21		Private outstyle As subtitle	#tag EndProperty	#tag Property, Flags = &h0		prefix As string	#tag EndProperty	#tag Property, Flags = &h0		realstart As integer	#tag EndProperty	#tag Property, Flags = &h0		source As string	#tag EndProperty	#tag Property, Flags = &h0		suffix As string	#tag EndProperty	#tag Property, Flags = &h21		Private text As string	#tag EndProperty	#tag Property, Flags = &h0		textstart As integer	#tag EndProperty	#tag ViewBehavior		#tag ViewProperty			Name="comment"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"		#tag EndViewProperty		#tag ViewProperty			Name="filenamedefined"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="prefix"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"		#tag EndViewProperty		#tag ViewProperty			Name="realstart"			Group="Behavior"			InitialValue="0"			Type="integer"		#tag EndViewProperty		#tag ViewProperty			Name="source"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"		#tag EndViewProperty		#tag ViewProperty			Name="suffix"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="textstart"			Group="Behavior"			InitialValue="0"			Type="integer"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass