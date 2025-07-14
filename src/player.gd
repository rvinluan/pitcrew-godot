extends CharacterBody2D
@export var blueTeam : bool = true;
@export var playerControl : int = 1;

@export var speed = 600

enum STATE {DEFAULT, INGAME}
var currentState = STATE.DEFAULT

signal player_begin_minigame;

func _ready() -> void:
	var spriteString = "res://assets/%s-team-player.png";
	$playerSprite.texture = load(spriteString % ("blue" if blueTeam else "red"));

func get_input():
	var input_direction;
	if (playerControl == 1):
		input_direction = Input.get_vector("left_2", "right_2", "up_2", "down_2")
	else:
		input_direction = Input.get_vector("left_1", "right_1", "up_1", "down_1")
	velocity = input_direction * speed

func _physics_process(delta):
	if(currentState != STATE.INGAME):
		get_input()
		move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.get_parent() is Car):
		if(currentState != STATE.INGAME):
			player_begin_minigame.emit(self)
			currentState = STATE.INGAME
	pass # Replace with function body.
	
func on_minigame_end() -> void:
	currentState = STATE.DEFAULT
	pass
