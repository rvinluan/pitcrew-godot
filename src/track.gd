extends Line2D
class_name Track

@export var curve: Curve2D

func _ready() -> void:
	print(curve)
	points = curve.get_baked_points()

func _process(delta) -> void:
	$Path2D/PathFollow2D.progress_ratio += (0.2 * delta)
