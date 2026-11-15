extends Node2D

const POGOER_SCENE = preload("res://scenes/core/pogoer.tscn")

var game_started: bool = false

var p1: Node2D
var p2: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../../MainMenu/PlayButton".connect("start_button_pressed", on_start_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	pass

func on_start_button_pressed() -> void:
	print("PLEZSE (2)")
	spawn_pogoers()

	game_started = true


func spawn_pogoers() -> void:
	p1 = POGOER_SCENE.instantiate()
	p1.position = Vector2(300,200)
	p1.init(1, false)
	add_child(p1)

	p2 = POGOER_SCENE.instantiate()
	p2.position = Vector2(600, 200)
	p2.init(2, true)
	add_child(p2)
