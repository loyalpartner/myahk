;;# -*- mode: ahk; ahk-indentation: 2 -*-
CreateGUI() {

        global
    Gui, +AlwaysOnTop -Caption +Owner +LastFound +E0x20
    Gui, Margin, 0, 0
    Gui, Color, Black
    Gui, Font, cWhite s50 bold, Arial
    Gui, Add, Text, vHotkeyText Center y20

    WinSet, Transparent, 200
}

ShowIndicator(text:="^") {
    WinGetPos, x, y, width, height, A
    if !x
	throw

    text_w := (ActWin_W > A_ScreenWidth) ? A_ScreenWidth : ActWin_W
    GuiControl,     , HotkeyText, % text
    GuiControl, Move, HotkeyText, w100 Center


    gui_x := x + width/2 - 100
    gui_y := y + height/2 - 150
    Gui, Show, NoActivate x%gui_x% y%gui_y% h100 w100

    SetTimer HideGui, 500
}

CreateGUI()
HideGUI() {
    Gui, Hide
}



Class MonitorDetect{

  Current[]{
    get  {
      SysGet, numberOfMonitors, MonitorCount
      WinGetPos, x, y, width, hegiht, A
      winMidX := x + width / 2
      winMidY := y + hegiht / 2
      Loop %numberOfMonitors%
      {
	SysGet, monArea, Monitor, %A_Index%
	if (winMidX > monAreaLeft && winMidX < monAreaRight && winMidY < monAreaBottom && winMidY > monAreaTop)
	  return New Monitor(A_Index)
      }
    }
  }

  Next{
    get{
      SysGet, count, MonitorCount
      currentNo := this.Current.no
      return New Monitor(currentNo == count ? 1 : currentNo + 1)
    }
  }

  Prev{
    get{
      SysGet, count, MonitorCount
      currentNo := this.Current.no
      return New Monitor(currentNo == 1 ? count : currentNo -1)
    }
  }
}

Class Monitor{
  __New(no:=1){
    SysGet, monArea, Monitor, %no%
    this.No := no
    this.left := monAreaLeft
    this.top := monAreaTop
    this.width := monAreaRight - monAreaLeft
    this.height := monAreaBottom - monAreaTop
    WinGetPos,,,,h, ahk_class Shell_TrayWnd
    this.taskbarHeight := h
    this.heightEx := this.height - h
  }
}

Class Grid{

  __New(row:=2, column:=2){
    this.row := row
    this.column := column
    this.marginTop := 110 	;顶部预留一排图标
  }

  gridCount
  {
    get {
      return this.row * this.column
    }
  }

  GetWindowNo(){
    WinGetPos,X,Y, , ,A
    currentMonitor := MonitorDetect.Current
    width := currentMonitor.width/this.column			   ;cell width
    height:= (currentMonitor.heightEx-this.marginTop)/this.row ;cell height

    a := Ceil((X-currentMonitor.left)/width)
    b := Floor((Y-currentMonitor.top-currentMonitor.taskbarHeight)/height)
    return b * this.column + a
  }

  Right(){
    no := this.GetWindowNo()
    ; no := no > this.gridCount ? 1 : no
    no := mod(no, this.gridCount) + 1
    this.MoveTo(no)
  }

  ;; autohotkey 负数取模和预期不一致
  ;; 使用 ?: 替换
  Left(){
    no := this.GetWindowNo() - 1
    no := no<1 ? this.gridCount : no
    ;no := Mod(no, this.gridCount)
    this.MoveTo(no)
  }

  Up(){
    no := this.GetWindowNo() - this.column
    no := Max(no, 1)
    this.MoveTo(no)
    ShowIndicator(this.GetWindowNo())
  }

  Down(){
    no := this.GetWindowNo() + this.column
    no := Min(no, this.gridCount)
    this.MoveTo(no)
  }

  MoveToMonitorEx(monitor,no,unitx:=1,unity:=1,WinTitle:="A"){
    width := monitor.width/this.column			   ;cell width
    height:= (monitor.heightEx-this.marginTop)/this.row ;cell height
    row := floor((no-1) / this.column)			   ; Grid row
    column := mod((no-1), this.column)	    ; Grid column
    x := column * width + monitor.left + 10		   ;offest x
    y := row * height + monitor.top  + 10 + this.marginTop		;offset y
    WinMove,% WinTitle,,x,y,unitx*width-20, unity*height-20
    ShowIndicator(this.GetWindowNo())
  }

  MoveToMonitor(monitor,no)  {
    if (no > 0 && no <= this.row * this.column)
    {
      this.MoveToMonitorEx(monitor,no,1,1)
    }
  }

  NextMonitor(){
    this.MoveToMonitor(MonitorDetect.Next, this.GetWindowNo())
  }

  PrevMonitor(){
    this.MoveToMonitor(MonitorDetect.Prev, this.GetWindowNo())
  }

  MoveTo(no){
    if (no > 0 && no <= this.row * this.column)
    {
      this.MoveToMonitor(MonitorDetect.Current,no)
    }
  }

  MoveAppTo(no,winTitle){
    if (no > 0 && no <= this.row * this.column){
      this.MoveToMonitorEx( MonitorDetect.Current,no,1,1,winTitle)
    }
  }

  Middle(){
    (New Grid(8,8)).MoveToMonitorEx(MonitorDetect.Current,10,6,6)
  }

  FullScreen(){
    (New Grid(1,1)).MoveTo(1)
  }
}
