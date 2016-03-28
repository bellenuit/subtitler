#tag WindowBegin Window AvidHelperTool   BackColor       =   16777215   Backdrop        =   0   BalloonHelp     =   ""   CloseButton     =   True   Composite       =   False   Frame           =   7   FullScreen      =   False   HasBackColor    =   False   Height          =   210   ImplicitInstance=   True   LiveResize      =   False   MacProcID       =   0   MaxHeight       =   32000   MaximizeButton  =   False   MaxWidth        =   32000   MenuBar         =   0   MenuBarVisible  =   True   MinHeight       =   64   MinimizeButton  =   True   MinWidth        =   64   Placement       =   0   Resizeable      =   False   Title           =   "Avid Helper"   Visible         =   True   Width           =   374   Begin TextArea EditField1      AcceptTabs      =   False      Alignment       =   0      AutoDeactivate  =   True      BackColor       =   16777215      Bold            =   False      Border          =   True      DataField       =   ""      DataSource      =   ""      Enabled         =   True      Format          =   ""      Height          =   91      HelpTag         =   ""      HideSelection   =   True      Index           =   -2147483648      InitialParent   =   ""      Italic          =   False      Left            =   14      LimitText       =   0      LockBottom      =   False      LockedInPosition=   False      LockLeft        =   False      LockRight       =   False      LockTop         =   False      Mask            =   ""      Multiline       =   True      ReadOnly        =   True      Scope           =   0      ScrollbarHorizontal=   False      ScrollbarVertical=   True      Styled          =   False      TabIndex        =   0      TabPanelIndex   =   0      TabStop         =   True      Text            =   "This tool automates the editing of the subtitles with a keymacro ""S T ESC B S ESC"" repeated for each subtitle\r1. Import the EDL of the subtitles and edit it into track V2 (or higher) of your film.\r2. Import subtitles in a new Bin.\r3. Clear the timeline and create a sequence ""all subtitles"" with all subtitles.\r4. Load the sequence ""all subtitles"" into the source monitor, activate track V1 only and go to the beginning.\r5. Load your film into the record monitor. Connect V1 from source to V2 and activate V2 only.\r6. Place the timeline cursor before the first subtitle and click on the record monitor.\r7. Type the number of subtitles into this window.\r8. Click on the run button of this window.\r9. WINDOWS only: You must now click on the timeline window within 2 seconds before the sequence starts.\rYou may need to adjust the pause between edits if the avid is not responsive enough."      TextColor       =   0      TextFont        =   "SmallSystem"      TextSize        =   0      Top             =   12      Underline       =   False      UseFocusRing    =   True      Visible         =   True      Width           =   338   End   Begin Label NumberOfTitlesLabel      AutoDeactivate  =   True      Bold            =   False      DataField       =   ""      DataSource      =   ""      Enabled         =   True      Height          =   20      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Italic          =   False      Left            =   20      LockBottom      =   False      LockedInPosition=   False      LockLeft        =   False      LockRight       =   False      LockTop         =   False      Multiline       =   False      Scope           =   0      TabIndex        =   1      TabPanelIndex   =   0      TabStop         =   True      Text            =   "Number of titles"      TextAlign       =   2      TextColor       =   0      TextFont        =   "Smallsystem"      TextSize        =   0      Top             =   117      Underline       =   False      Visible         =   True      Width           =   167   End   Begin TextField NumberOfTitlesField      AcceptTabs      =   False      Alignment       =   0      AutoDeactivate  =   True      BackColor       =   16777215      Bold            =   False      Border          =   True      CueText         =   ""      DataField       =   ""      DataSource      =   ""      Enabled         =   True      Format          =   ""      Height          =   20      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Italic          =   False      Left            =   199      LimitText       =   0      LockBottom      =   False      LockedInPosition=   False      LockLeft        =   False      LockRight       =   False      LockTop         =   False      Mask            =   ""      Password        =   False      ReadOnly        =   False      Scope           =   0      TabIndex        =   2      TabPanelIndex   =   0      TabStop         =   True      Text            =   ""      TextColor       =   0      TextFont        =   "Smallsystem"      TextSize        =   0      Top             =   117      Underline       =   False      UseFocusRing    =   True      Visible         =   True      Width           =   153   End   Begin Label PauseLabel      AutoDeactivate  =   True      Bold            =   False      DataField       =   ""      DataSource      =   ""      Enabled         =   True      Height          =   20      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Italic          =   False      Left            =   20      LockBottom      =   False      LockedInPosition=   False      LockLeft        =   False      LockRight       =   False      LockTop         =   False      Multiline       =   False      Scope           =   0      TabIndex        =   3      TabPanelIndex   =   0      TabStop         =   True      Text            =   "Pause in msec"      TextAlign       =   2      TextColor       =   0      TextFont        =   "Smallsystem"      TextSize        =   0      Top             =   149      Underline       =   False      Visible         =   True      Width           =   167   End   Begin TextField PauseField      AcceptTabs      =   False      Alignment       =   0      AutoDeactivate  =   True      BackColor       =   16777215      Bold            =   False      Border          =   True      CueText         =   ""      DataField       =   ""      DataSource      =   ""      Enabled         =   True      Format          =   ""      Height          =   20      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Italic          =   False      Left            =   199      LimitText       =   0      LockBottom      =   False      LockedInPosition=   False      LockLeft        =   False      LockRight       =   False      LockTop         =   False      Mask            =   ""      Password        =   False      ReadOnly        =   False      Scope           =   0      TabIndex        =   4      TabPanelIndex   =   0      TabStop         =   True      Text            =   ""      TextColor       =   0      TextFont        =   "Smallsystem"      TextSize        =   0      Top             =   149      Underline       =   False      UseFocusRing    =   True      Visible         =   True      Width           =   153   End   Begin PushButton RunButton      AutoDeactivate  =   True      Bold            =   False      Cancel          =   False      Caption         =   "Run"      Default         =   True      Enabled         =   True      Height          =   16      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Italic          =   False      Left            =   231      LockBottom      =   False      LockedInPosition=   False      LockLeft        =   False      LockRight       =   False      LockTop         =   False      Scope           =   0      TabIndex        =   5      TabPanelIndex   =   0      TabStop         =   True      TextFont        =   "Smallsystem"      TextSize        =   0      Top             =   179      Underline       =   False      Visible         =   True      Width           =   120   End   Begin Timer Timer1      Height          =   32      Index           =   -2147483648      Left            =   25      LockedInPosition=   False      Mode            =   2      Period          =   1000      Scope           =   0      TabIndex        =   6      TabPanelIndex   =   0      TabStop         =   True      Top             =   205      Width           =   32   End   Begin Label EchoLabel      AutoDeactivate  =   True      Bold            =   False      DataField       =   ""      DataSource      =   ""      Enabled         =   True      Height          =   20      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Italic          =   False      Left            =   14      LockBottom      =   False      LockedInPosition=   False      LockLeft        =   False      LockRight       =   False      LockTop         =   False      Multiline       =   False      Scope           =   0      TabIndex        =   7      TabPanelIndex   =   0      TabStop         =   True      Text            =   ""      TextAlign       =   0      TextColor       =   0      TextFont        =   "SmallSystem"      TextSize        =   0      Top             =   181      Underline       =   False      Visible         =   True      Width           =   205   End   Begin TextField EditField2      AcceptTabs      =   False      Alignment       =   0      AutoDeactivate  =   True      BackColor       =   16777215      Bold            =   False      Border          =   True      CueText         =   ""      DataField       =   ""      DataSource      =   ""      Enabled         =   True      Format          =   ""      Height          =   22      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Italic          =   False      Left            =   107      LimitText       =   0      LockBottom      =   False      LockedInPosition=   False      LockLeft        =   False      LockRight       =   False      LockTop         =   False      Mask            =   ""      Password        =   False      ReadOnly        =   False      Scope           =   0      TabIndex        =   8      TabPanelIndex   =   0      TabStop         =   True      Text            =   ""      TextColor       =   0      TextFont        =   "System"      TextSize        =   0      Top             =   230      Underline       =   False      UseFocusRing    =   True      Visible         =   True      Width           =   80   End   Begin PushButton PushButton1      AutoDeactivate  =   True      Bold            =   False      Cancel          =   False      Caption         =   "Press"      Default         =   False      Enabled         =   True      Height          =   20      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Italic          =   False      Left            =   205      LockBottom      =   False      LockedInPosition=   False      LockLeft        =   False      LockRight       =   False      LockTop         =   False      Scope           =   0      TabIndex        =   9      TabPanelIndex   =   0      TabStop         =   True      TextFont        =   "System"      TextSize        =   0      Top             =   231      Underline       =   False      Visible         =   True      Width           =   69   End   Begin Timer Timer2      Height          =   32      Index           =   -2147483648      Left            =   286      LockedInPosition=   False      Mode            =   0      Period          =   1000      Scope           =   0      TabIndex        =   10      TabPanelIndex   =   0      TabStop         =   True      Top             =   230      Width           =   32   EndEnd#tag EndWindow#tag WindowCode	#tag Event		Sub Close()		  dim dict as new dictionary		  dict.value("top") = top		  dict.value("left") = left		  dict.value("numberoftitles") = numberOfTitlesField.text		  dict.value("pause") = pauseField.text		  app.aviddict = dict		End Sub	#tag EndEvent	#tag Event		Sub Open()		  dim dict as dictionary		  dim s as string		  dim i as integer		  dict = app.aviddict		  		  if dict <>nil then		    if dict.getinteger("top",i) then top = i		    if dict.getinteger("left",i) then left = i		    self.setbounds(left,top,width,height)		    		    if dict.getstring("numberoftitles", s) then numberOfTitlesField.text = s		    		    if not app.reg.online and val(s)>10 then		      numberOfTitlesField.text = "10"		    end		    		    if dict.getstring("pause", s) then pauseField.text = s		  end		  		  setlanguage		End Sub	#tag EndEvent	#tag MenuHandler		Function FileCLose() As Boolean Handles FileCLose.Action			self.close			return true		End Function	#tag EndMenuHandler	#tag Method, Flags = &h21		Private Sub AvidScript()		  dim i as integer		  dim pausestring, periodstring as string		  		  redim printlist(-1)		  		  pausestring = "period " + pauseField.text		  periodstring = "period " + str(val(pausefield.text)/10)		  		  printlist.append periodstring		  		  for i = 1 to val(numberOfTitlesField.text)		    printlist.append "echo "+ format(i,"0") + "/" + format(val(numberOfTitlesField.text),"0") 		    printlist.append "s"		    printlist.append "t"		    printlist.append "b"		    printlist.append pausestring		    printlist.append periodstring		    printlist.append "esc"		    printlist.append "s"		    printlist.append "esc"		  next		  		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub SetLanguage()		  dim value as string		  dim languagedict as dictionary		  languagedict = app.languagedict		  		  if languagedict =nil then return		  		  		  if languagedict.getstring("avidtitle", value) then title = value		  		  if languagedict.getstring("avidhelp", value) then editfield1.text = value		  		  if languagedict.getstring("avidnumberoftitles", value) then numberOfTitleslabel.text = value		  if languagedict.getstring("avidpause", value) then pauseLabel.text = value		  		  if languagedict.getstring("avidrun", value) then prun = value		  if languagedict.getstring("avidstop", value) then pstop = value		  runbutton.caption = prun		  		  		  		  		End Sub	#tag EndMethod	#tag Property, Flags = &h1		Protected askforstop As boolean	#tag EndProperty	#tag Property, Flags = &h21		Private printlist(-1) As string	#tag EndProperty	#tag Property, Flags = &h0		pRun As string	#tag EndProperty	#tag Property, Flags = &h0		pStop As string	#tag EndProperty#tag EndWindowCode#tag Events NumberOfTitlesField	#tag Event		Sub Open()		  me.text = "50"		End Sub	#tag EndEvent#tag EndEvents#tag Events PauseField	#tag Event		Sub Open()		  me.text = "500"		End Sub	#tag EndEvent#tag EndEvents#tag Events RunButton	#tag Event		Sub Action()		  select case me.caption		  case prun		    if not app.reg.online then		      if val(numberOfTitlesField.text )>10 then		        msgbox "Offline license."+endofline+endofline+"You cannot edit more than 10 titles. Click again."		        numberOfTitlesField.text = "10"		        return		      end		    end		    askforstop = false		    me.default = false		    me.caption = pstop		    avidscript		    timer1.period = 2000 // time to click timeline		    echolabel.text = "Click on Timeline now"		    timer1.mode = 2		  case pstop		    me.caption = "..."		    me.default = false		    askforstop = true		  end		End Sub	#tag EndEvent#tag EndEvents#tag Events Timer1	#tag Event		Sub Action()		  		  		  // disabled dependency MBS FEATURE MISSING		  		  		  		  		  dim thekey as string		  dim charcode, keycode as integer		  		  if ubound(printlist)<0 or askforstop then		    me.mode = 0		    runButton.default = true		    runButton.caption = prun		    echolabel.text = ""		  else		    		    thekey = printlist(0)		    printlist.remove 0		    		    if left(thekey,6) = "period" then		      me.period = val(mid(thekey,7))		      return		    end		    		    if left(thekey,4) = "echo" then		      echolabel.text = mid(thekey,6)		      return		    end		    		    		    dim kopt, kcom, kshift, kcontr as boolean		    		    if instr(thekey,"option-") > 0 then		      thekey = replaceall(thekey,"option-","")		      kopt = true		    end		    if instr(thekey,"alt-") > 0 then		      thekey = replaceall(thekey,"alt-","")		      kopt = true		    end		    if instr(thekey,"command-") > 0 then		      thekey = replaceall(thekey,"command-","")		      kcom = true		    end		    if instr(thekey,"shift-") > 0 then		      thekey = replaceall(thekey,"shift-","")		       kshift = true		    end		    if instr(thekey,"control-") > 0 then		      thekey = replaceall(thekey,"control-","")		      kcontr = true		    end 		    		    // testing		    echoLabel.text = thekey		    //		    		    select case thekey		    case "esc"		      charcode = 27		    else		      charcode = asc(thekey)		    end		    		    keycode = keyconverter.nametokey(thekey)  		    		    #if kMBSused		      dim k as presskeyMBS		      k = new presskeyMBS		      k.option = kopt		      k.command = kcom		      k.shift = kshift		      k.control = kcontr		      k.charcode = charcode		      k.keycode = keycode		      k.press		    #endif 		  end		  		End Sub	#tag EndEvent#tag EndEvents#tag Events PushButton1	#tag Event		Sub Action()		  timer2.period = 2000		  timer2.mode = 1		End Sub	#tag EndEvent#tag EndEvents#tag Events Timer2	#tag Event		Sub Action()		  // disabled dependency MBS FEATURE MISSING		  		  #if kMBSused		    		    dim k as presskeyMBS		    		    k = new presskeyMBS		    		    k.charcode = val(editfield2.text)		    		    k.press		    		    		    		  #endif		  		End Sub	#tag EndEvent#tag EndEvents