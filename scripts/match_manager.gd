extends Node2D

const POGOER_SCENE = preload("res://scenes/core/player.tscn")

var game_started: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _unhandled_input(event: InputEvent) -> void:
	if not game_started and event.is_action_pressed("ui_accept"):
		spawn_pogoers()
		game_started = true

func spawn_pogoers() -> void:
	var p1 = POGOER_SCENE.instantiate()
	
