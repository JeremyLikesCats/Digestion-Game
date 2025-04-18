extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		await get_tree().create_timer(0.5).timeout
		for i in range(100):
			modulate.a += 0.01
			await get_tree().create_timer(0.01).timeout
		get_parent().get_node("Character").end()
