extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	for i in range(100):
		modulate.a += 0.01
		await get_tree().create_timer(1/100).timeout


func _on_area_2d_body_exited(body: Node2D) -> void:
	for i in range(100):
		modulate.a -= 0.01
		await get_tree().create_timer(1/100).timeout
