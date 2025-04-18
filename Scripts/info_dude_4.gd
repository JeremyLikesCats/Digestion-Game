extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_parent().get_node("Character").dialogue("[center]You may be wondering, if there is a small intestine, there must be a large intestine, right? Yeah, there is, and it is mainly for absorbing water, vitamins and propelling feces. Get ready to exit![/center]",get_node("RichTextLabel"),true,0.5,0.5,5)
		await get_tree().create_timer(5).timeout
