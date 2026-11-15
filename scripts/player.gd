extends Node2D

@export var player_id: int = 1
@export var facing_left: bool = true

@export var health: int = 100 # 0 to 100

const SCALE = 1.5

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
		scale = Vector2(-SCALE, SCALE)
	else:
		scale = Vector2(SCALE, SCALE)
