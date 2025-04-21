extends AnimatedSprite2D
var simultaneous_scene = preload("res://Scenes/mouth.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1).timeout
	play()
	await get_tree().create_timer(5).timeout
	for i in range(200):
		get_node(".").modulate.a -= 0.005
		await get_tree().create_timer(0.005).timeout
	get_tree().change_scene_to_file("res://Scenes/mouth.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
