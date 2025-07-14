extends Control

signal minigame_done

@export var allBars : Array[Panel]

#enum STATE {UNSTARTED, INPROGRESS, COMPLETE}
#var currentState = STATE.UNSTARTED
var currentBar = 0

func _ready() -> void:
	for b in allBars:
		var bar : Bar = b as Bar
		bar.bar_completed.connect(barIsComplete, 1)
	allBars[0].beginBar()
	
func barIsComplete() -> void:
	currentBar += 1
	if(currentBar < allBars.size()):
		allBars[currentBar].beginBar()
	else:
		minigame_done.emit()
		queue_free()
		print("all bars done")
