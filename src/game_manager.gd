extends Node

var canvas : Control
var tireMinigameInstance = preload("res://src/minigame-tires.tscn")

func _ready() -> void:
	canvas = $"../Control"
	var allPlayers = get_tree().get_nodes_in_group("player")
	for p in allPlayers:
		p.player_begin_minigame.connect(beginMinigame)

func beginMinigame(player) -> void:
	var newMinigame = tireMinigameInstance.instantiate()
	var playerXinCanvas = canvas.size.x / 2 + player.position.x
	var playerYinCanvas = canvas.size.y / 2 + player.position.y
	newMinigame.position = Vector2(playerXinCanvas, playerYinCanvas)
	newMinigame.minigame_done.connect(player.on_minigame_end)
	canvas.add_child(newMinigame)
	
func on_minigame_end() -> void:
	pass
