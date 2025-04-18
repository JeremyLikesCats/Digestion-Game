extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_parent().get_node("Character").dialogue("[center]This is the duodenum, the beginning of the small intestine. The green-ish yellow substances here are bile, which is produced in the gall bladder.[/center]",get_node("RichTextLabel"),true,0.5,0.5,5)
		await get_tree().create_timer(5).timeout
		
