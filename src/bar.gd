extends Panel
class_name Bar

@export var speedCurve : Curve;
@export var defaultTime : float = 2.5; #s
var fixedSpeed : int = 100; #px/s

signal bar_pressed;
signal bar_completed;

var endpoint : float;
enum STATE { UNSTARTED, INPROGRESS, COMPLETE }
var currentState : STATE = 0;
var pressed : bool = false;
var timeSinceStart : float = 0;

func _ready() -> void:
	endpoint = size.x;

func _process(delta: float) -> void:
	if(currentState == STATE.INPROGRESS):
		timeSinceStart += delta;
		if(!pressed):
			$Line2D.position.x = speedCurve.sample(timeSinceStart/defaultTime) * endpoint;
		else:
			$Line2D.position.x += fixedSpeed * delta;
		var ys = $YellowArea.get_rect().position.x
		var ye = $YellowArea.get_rect().end.x
		var gs = $GreenArea.get_rect().position.x
		var ge = $GreenArea.get_rect().end.x
		var p = $Line2D.position.x;
		if($Line2D.position.x >= endpoint):
			endBar()
		elif(!pressed && Input.is_action_just_pressed("a_2")):
			if(p >= gs && p <= ge):
				print("inside green")
				#end bar immediately
				endBar()
			elif(p >= ys && p <= ye):
				print("inside yellow")
				#speed boost
				fixedSpeed = fixedSpeed * 5
			else:
				#speed penalty
				fixedSpeed = fixedSpeed * 1
				print("failed")
			pressed = true;

func beginBar() -> void:
	timeSinceStart = 0
	pressed = false
	currentState = STATE.INPROGRESS

func endBar() -> void:
	currentState = STATE.COMPLETE
	bar_completed.emit()
	
