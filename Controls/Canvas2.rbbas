#tag ClassProtected Class Canvas2Inherits Canvas	#tag Event		Function MouseDown(X As Integer, Y As Integer) As Boolean		  if not activating then		    if extbuffer <> nil then		      if keyboard.asyncoptionKey then		        		        if keyboard.asyncshiftKey then		          if dvdbuffer<>nil then		            graphics.drawpicture dvdbuffer,-x*(extbuffer.width/width-1),-y*(extbuffer.height/height-1)		          end		        else		          if extbufferalpha<>nil then		            graphics.drawpicture extbufferalpha,-x*(extbuffer.width/width-1),-y*(extbuffer.height/height-1)		          end		        end		        		      else 		        graphics.forecolor = rgb(0,0,0)		        graphics.fillrect 0,0,width,height		        graphics.drawpicture extbuffer,-x*(extbuffer.width/width-1),-y*(extbuffer.height/height-1)		      end if		    end if		    return true		  end		End Function	#tag EndEvent	#tag Event		Sub MouseUp(X As Integer, Y As Integer)		  drawbuffer		End Sub	#tag EndEvent	#tag Event		Sub Paint(g As Graphics)		  drawbuffer		End Sub	#tag EndEvent	#tag Method, Flags = &h0		Sub Canvas2()		  Constructor		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Canvas2(w as integer, h as integer)		  Constructor(w,h)		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Constructor()		  canvas2(width,height)		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Constructor(w as integer, h as integer)		  		  if w>0 and h>0 then		    width = w		    height = h		  end		  		  if buffer = nil then 		    buffer = newpicture(1920,1080,32)		  end		  		  if buffer <> nil then		    buffer.graphics.forecolor = rgb(0,0,0)		    buffer.graphics.fillrect 0,0,width,height		    drawbuffer		  else		    //error 		  end		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub drawblack()		  graphics.forecolor = rgb(0,0,0)		  graphics.fillrect 0,0,width,height		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub drawbuffer()		  if graphics <> nil then		    if buffer <> nil then		      me.graphics.drawpicture buffer,0,0,width,height,0,0,bufferw,bufferh		    end		    if savetitle then		      graphics.forecolor = rgb(255,255,255)		      graphics.drawrect 0.05*width,0.05*height,0.9*width,0.9*height		      graphics.drawrect 0.1*width,0.1*height,0.8*width,0.8*height		    end		  end		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub drawinto(p as picture, alpha as picture)		  dim bufferg,pmaskg as graphics		  		  if buffer= nil then		    canvas2		  end if		  		  if p = nil or alpha = nil then		    drawbuffer		    return		  end		  		  extbuffer = p		  extbufferalpha = alpha		  		  bufferw = p.width		  bufferh = p.height		  		  bufferg = buffer.graphics		  pmaskg = p.mask.graphics		  		  pmaskg.drawpicture alpha,0,0		  		  if bg<>nil and showbackgroundpicture then		    bufferg.drawpicture bg,0,0,bufferw,bufferh,0,0,bg.width,bg.height		  else		    bufferg.forecolor = rgb(0,0,0)		    bufferg.fillrect 0,0,bufferw,bufferh		  end		  		  bufferg.drawpicture p,0,0,bufferw,bufferh,0,0,p.width,p.height		  		  pmaskg.forecolor = rgb(0,0,0)		  pmaskg.fillrect 0,0,p.width,p.height		  		  drawbuffer		End Sub	#tag EndMethod	#tag Property, Flags = &h0		activating As boolean	#tag EndProperty	#tag Property, Flags = &h0		bg As picture	#tag EndProperty	#tag Property, Flags = &h0		buffer As picture	#tag EndProperty	#tag Property, Flags = &h1		Protected bufferh As integer	#tag EndProperty	#tag Property, Flags = &h1		Protected bufferw As integer	#tag EndProperty	#tag Property, Flags = &h0		dvdbuffer As picture	#tag EndProperty	#tag Property, Flags = &h0		extbuffer As picture	#tag EndProperty	#tag Property, Flags = &h0		extbufferalpha As picture	#tag EndProperty	#tag Property, Flags = &h0		savetitle As boolean	#tag EndProperty	#tag Property, Flags = &h0		showbackgroundpicture As boolean	#tag EndProperty	#tag Property, Flags = &h0		style As subtitle	#tag EndProperty	#tag ViewBehavior		#tag ViewProperty			Name="AcceptFocus"			Visible=true			Group="Behavior"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="AcceptTabs"			Visible=true			Group="Behavior"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="activating"			Group="Behavior"			InitialValue="0"			Type="boolean"		#tag EndViewProperty		#tag ViewProperty			Name="AutoDeactivate"			Visible=true			Group="Appearance"			InitialValue="True"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Backdrop"			Visible=true			Group="Appearance"			Type="Picture"			EditorType="Picture"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="bg"			Group="Behavior"			InitialValue="0"			Type="picture"		#tag EndViewProperty		#tag ViewProperty			Name="buffer"			Group="Behavior"			InitialValue="0"			Type="picture"		#tag EndViewProperty		#tag ViewProperty			Name="DoubleBuffer"			Visible=true			Group="Behavior"			InitialValue="False"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="dvdbuffer"			Group="Behavior"			InitialValue="0"			Type="picture"		#tag EndViewProperty		#tag ViewProperty			Name="Enabled"			Visible=true			Group="Appearance"			InitialValue="True"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="EraseBackground"			Visible=true			Group="Behavior"			InitialValue="True"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="extbuffer"			Group="Behavior"			InitialValue="0"			Type="picture"		#tag EndViewProperty		#tag ViewProperty			Name="extbufferalpha"			Group="Behavior"			InitialValue="0"			Type="picture"		#tag EndViewProperty		#tag ViewProperty			Name="Height"			Visible=true			Group="Position"			InitialValue="100"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="HelpTag"			Visible=true			Group="Appearance"			Type="String"			EditorType="MultiLineEditor"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="InitialParent"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="LockBottom"			Visible=true			Group="Position"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="LockLeft"			Visible=true			Group="Position"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="LockRight"			Visible=true			Group="Position"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="LockTop"			Visible=true			Group="Position"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			Type="String"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="savetitle"			Group="Behavior"			InitialValue="0"			Type="boolean"		#tag EndViewProperty		#tag ViewProperty			Name="showbackgroundpicture"			Group="Behavior"			InitialValue="0"			Type="boolean"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="TabIndex"			Visible=true			Group="Position"			InitialValue="0"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="TabPanelIndex"			Group="Position"			InitialValue="0"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="TabStop"			Visible=true			Group="Position"			InitialValue="True"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="UseFocusRing"			Visible=true			Group="Appearance"			InitialValue="True"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Visible"			Visible=true			Group="Appearance"			InitialValue="True"			Type="Boolean"			InheritedFrom="Canvas"		#tag EndViewProperty		#tag ViewProperty			Name="Width"			Visible=true			Group="Position"			InitialValue="100"			Type="Integer"			InheritedFrom="Canvas"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass