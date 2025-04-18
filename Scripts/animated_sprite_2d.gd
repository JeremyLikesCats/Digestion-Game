extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().get_node("RichTextLabel").modulate.a = 0
	get_parent().get_node("RichTextLabel").text = "[center]Fun fact: It takes almost 7 seconds for the food to reach from the throat to the stomach![/center]"
	$Sprite2D.modulate.a=1
	play("default")
	for i in range(100):
		$Sprite2D.modulate.a -= 0.01
		await get_tree().create_timer(0.001).timeout
	await get_tree().create_timer(0.9).timeout
	for i in range(100):
		$Sprite2D.modulate.a += 0.01
		await get_tree().create_timer(0.001).timeout
	await get_tree().create_timer(0.9).timeout
	for i in range(100):
		get_parent().get_node("RichTextLabel").modulate.a += 0.01
		await get_tree().create_timer(0.01).timeout
	await get_tree().create_timer(3).timeout
	for i in range(100):
		get_parent().get_node("RichTextLabel").modulate.a -= 0.01
		await get_tree().create_timer(0.01).timeout
	get_tree().change_scene_to_file("res://Scenes/stomach.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
