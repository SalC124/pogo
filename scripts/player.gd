extends Node2D

@export var player_id: int = 1
@export var facing_left: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func init(id: int, left: bool) -> void:
	player_id = id
	facing_left = left
	flip_direction()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func flip_direction() -> void:
	if facing_left:
		scale.x = -1
	else:
		scale.x = 1
