extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	play()
	await get_tree().create_timer(7).timeout
	while modulate.a > 0:
		modulate.a -= 0.005
		await get_tree().create_timer(get_process_delta_time()).timeout
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
