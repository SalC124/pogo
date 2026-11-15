extends Control


signal game_start

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MainMenu/PlayButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
