extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func tween(x=300,y=0) -> void:
	var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS).set_trans(Tween.TRANS_EXPO).set_parallel(false).set_loops(1).tween_property(self, "position", Vector2(position.x+x,position.y+y), 3)
