#tag ClassProtected Class cBabelFishConverterInherits cTitlelistConverter	#tag Event		Sub DoConvert(s as string)		  dim i,j,countlines,item as integer		  dim start, ende, tctext as string		  dim tit as ctitle		  dim separator as string		  dim titles(-1), title,fn as string		  dim  s2 , durationtext , starttext as string		  dim startfeet, startframes, durationfeet, durationframes as integer		  dim namedict as dictionary		  dim sourcelines(-1),sourceline as string		  dim state as string		  		  namedict = new dictionary		  		  tc.gauge 35		  		  //patch for new titra rts files		  s2 = replaceallb(s, chrb(&he2)+chrb(&h80)+chrb(&ha8),endofLine)		  s2 = s2.defineEncoding(encodings.uTF8)		  		  s2 = replacelineEndings(s2,endofLine)		  titles = split(s2,endofline + endofline + endofline)		  countlines = ubound(titles)		  		  sourcelines = split(s2,endofLine)		  		  state = "waitspace"		  		  for each sourceline in sourcelines		    select case state		    case "waitspace"		      if trim(sourceline) = "" then		        state = "waitheader"		      end		    case "waitheader"		      if left(sourceline,1) = "0" then		        tit = new ctitle		        startfeet = val(nthfield(sourceline," ",2))		        startframes =  val(nthfield(sourceline," ",3))		        starttext = format(startfeet,"0") +"."+format(startframes,"00")		        durationtext = nthfield(sourceline," ",1)		        durationfeet = val(nthField(durationtext,".",1))		        durationframes = val(nthField(durationtext,".",2))		        start = tc.tctotext(tc.feettotc(val(starttext)))		        ende = tc.tctotext(tc.tcplus(tc.texttoTC(start),tc.feetTotC(val(durationtext))))		        fn = nthfield(sourceline," ",2)		        if namedict.hasKey(fn) then		          fn = fn +"_"+nthfield(sourceline," ",3)		        end		        while namedict.hasKey(fn)		          fn = fn + "a"		        wend		        tit.filename = fn		        namedict.value(fn) = 1		        item = item + 1		        tit.eventnr = item		        titlelist.titles.append tit		        state = "waitline"		      end		    case "waitline"		      if tit<>nil and trim(sourceline) <>"" then		        if left(sourceline,2) = "**" then		          tit.lines.append "/ " + sourceline		        elseif sourceline<>"" then		          tit.lines.append sourceline		        end		      else		        state = "waitheader"		      end		    end		    		    if i mod 10 = 0 then		      progress 33+66*i/countlines		    end		    if userCancelled then		      exit		    end		  next		  		  createedl uppercase(documentname),0,ubound(titlelist.titles) 		  		End Sub	#tag EndEvent	#tag Method, Flags = &h0		Sub Constructor()		  label = "Titra 3"		End Sub	#tag EndMethod	#tag ViewBehavior		#tag ViewProperty			Name="binaryfile"			Group="Behavior"			InitialValue="0"			Type="boolean"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="charactercount"			Group="Behavior"			InitialValue="0"			Type="integer"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="clipnames"			Group="Behavior"			InitialValue="0"			Type="boolean"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="documentname"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="endline"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="framerate"			Group="Behavior"			InitialValue="0"			Type="double"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="italicstring"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="label"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"			InheritedFrom="cTitlelistConverter"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass