#tag ModuleProtected Module KeyConverter	#tag Method, Flags = &h21		Private Sub InitKeys()		  dim s, br as string		  		  		  keydict = new dictionary		  		  keydict.value("esc") = 53		  keydict.value("s") = 1		  keydict.value("t") = 17		  keydict.value("b") = 11		  		  		  		End Sub	#tag EndMethod	#tag Method, Flags = &h21		Private Sub InitKeysWin()		  // using vb table, to be tested		  dim s, br as string		  dim i as integer		  br = endofline.windows		  		  keydict = new dictionary		  		  'keydict.value("esc") = 32    // how do i know that		  keydict.value("esc") = 27    // how do i know that		  keydict.value("s") = asc("s")		  keydict.value("t") = asc("t")		  keydict.value("b") = asc("b")		  		  ''s = s + "leftmouse 1" + br		  ''s = s + "rightmouse 2" + br		  ''s = s + "cancel 3" + br		  ''s = s + "middlemouse 4" + br		  '		  's = s + "backspace 8 8" + br		  's = s + "tab 9 9" + br		  's = s + "clear  12" + br		  's = s + "return 13 13" + br		  '		  ''s = s + "shift  16" + br		  ''s = s + "ctrl  17" + br		  ''s = s + "menu  18" + br		  ''s = s + "pause  19" + br		  ''s = s + "capslock  20" + br		  '		  's = s + "esc 27 27" + br		  's = s + "space 32 32" +br		  's = s + "pageup  33" + br		  's = s + "pagedown  34" + br		  's = s + "end  35" + br		  's = s + "home  36" + br		  's = s + "left 28 37" + br		  's = s + "up 30 38" + br		  's = s + "right 29 39" + br		  's = s + "down 31 40" + br		  '		  ''s = s + "select  41" + br		  ''s = s + "printscreen  42" + br		  ''s = s + "execute  43" + br		  ''s = s + "snapshot  44" + br		  ''s = s + "insert  45" + br		  '		  's = s + "delete  46" + br		  's = s + "help  47" + br		  '		  ''s = s + "numlock  144" + br		  '		  '//letters		  'for i = 65 to 90		  's = s + lowercase(chr(i)) + " " + str(i) + " " + str(i) + br		  'next		  '		  '//numbers		  'for i = 48 to 57		  's = s + chr(i) + " " + str(i) + " " + str(i) + br		  'next		  '		  '//numpad		  'for i = 0 to 9		  's = "num"+ str(i) + " "  +str(i+48) + " " + str(96+i) + br		  'next		  '		  's = s + "nummult  106" + br		  's = s + "numplus  107" + br		  's = s + "enter  108" + br		  's = s + "numminus  109" + br		  's = s + "numperiod  110" + br		  's = s + "numdiv  111" + br		  '		  'for i = 1 to 16		  ' s = s + "f"+ str(i) + "  " + str(i+111) + br		  'next		  '		  'initkeys(s)		  		End Sub	#tag EndMethod	#tag Method, Flags = &h1		Protected Function NameToKey(s as string) As integer		  if keydict = nil then initkeys		  		  if keydict.hasKey(s) then return keydict.value(s)		  		  		  		  'dim i as integer		  'for i=1 to ubound(conv)		  'if nthField(conv(i)," ",1)=name then		  'return val(nthField(conv(i)," ", 3))		  'end if		  'next		End Function	#tag EndMethod	#tag Property, Flags = &h1		Protected keydict As dictionary	#tag EndProperty	#tag ViewBehavior		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Module#tag EndModule