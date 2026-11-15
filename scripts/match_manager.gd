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
	if (game_started):
		var p1_dir: int = 0
		var p2_dir: int = 0

		if (event.is_action_pressed("p1_left")):
			p1_dir -= 1
		if (event.is_action_pressed("p1_right")):
			p1_dir += 1

		if (event.is_action_pressed("p2_left")):
			p2_dir += 1
		if (event.is_action_pressed("p2_right")):
			p2_dir -= 1


		p1.get_child(0).tilt = p1_dir
		p2.get_child(0).tilt = p2_dir

		p1.get_child(0).charge = event.is_action_pressed("p1_charge")
		p2.get_child(0).charge = event.is_action_pressed("p2_charge")

func on_start_button_pressed() -> void:
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
