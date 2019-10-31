;;# -*- mode: ahk; ahk-indentation: 2 -*-
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

  GetWindowNo(){
    WinGetPos,X,Y, , ,A
    currentMonitor := MonitorDetect.Current
    width := currentMonitor.width/this.column			   ;cell width
    height:= (currentMonitor.heightEx-this.marginTop)/this.row ;cell height


    a := Ceil(X/width)
    b := Floor((Y-currentMonitor.taskbarHeight)/height)
    return b * this.column + a
  }

  Next(){
    no := this.GetWindowNo()
    gridCount := this.column * this.row
    if(no >= gridCount)
      no := 0
    no := no + 1
    this.MoveTo(no)
  }

  Prev(){
    no := this.GetWindowNo()
    gridCount := this.column * this.row
    if(no <= 1)
      no := gridCount + 1
    no := no - 1
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
  }

  MoveToMonitor(monitor,no){
    this.MoveToMonitorEx(monitor,no,1,1)
  }

  MoveTo(no){
    this.MoveToMonitor(MonitorDetect.Current,no)
  }

  MoveAppTo(no,winTitle){
    this.MoveToMonitorEx( MonitorDetect.Current,no,1,1,winTitle)
  }


  Middle(){
    (New Grid(8,8)).MoveToMonitorEx(MonitorDetect.Current,10,6,6)
  }

  FullScreen(){
    (New Grid(1,1)).MoveTo(1)
  }
}
