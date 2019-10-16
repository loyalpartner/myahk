;;# -*- mode: ahk-mode; ahk-indentation: 2 -*-
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
    this.heightEx := this.height - h
  }
}



Class Grid{
  __New(row:=2, column:=2){
    this.row := row
    this.column := column

  }

  MoveToMonitorEx(monitor,no,unitx:=1,unity:=1,WinTitle:="A"){
    width := monitor.width/this.row ;cell width
    height:= monitor.heightEx/this.column ;cell height
    row := floor((no-1) / this.row) ; Grid row
    column := mod((no-1), this.column) ; Grid column
    x := column * width + monitor.left+10		;offest x
    y := row * height + monitor.top +10		;offset y
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
