extends Control

signal countdown_over

export var seconds = 0
export var minutes = 0
var desc = 0

func _physics_process(delta):
	if seconds > 0 and desc <= 0:
		seconds -= 1
		desc = 10
	if minutes > 0 and seconds <= 0:
		minutes -= 1
		seconds = 60
	
	if seconds >= 10:
		$Sec.set_text(str(seconds))
	else:
		$Sec.set_text("0" + str(seconds))
		
	if minutes >= 10:
		$Min.set_text(str(minutes))
	else:
		$Min.set_text("0" + str(minutes))


func _on_Timer_timeout():
	desc -= 1
	if seconds == 0 and minutes == 0:
		emit_signal("countdown_over")
		$Timer.stop()
	if desc == 0:
		$Clock_Tick.play()
