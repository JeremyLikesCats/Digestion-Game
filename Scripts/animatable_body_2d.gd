extends AnimatableBody2D
@export var firstpos = Vector2(self.position.x, self.position.y+125)
@export var secondpos = Vector2(self.position.x, self.position.y)
@export var duration = 2


# Called when the node enters the scene tree for the first time.
func _ready():

	if str(get_node("."))[4] == "2":	
		await get_tree().create_timer(0.4).timeout
	start_tween()
	
	while true:
		
		if get_parent().get_node("Character").doshakebilly == true:
			get_parent().get_node("Character/Camera").apply_shake(30)
		else:
			get_parent().get_node("Doshake").doshake == false
		await get_tree().create_timer(4).timeout
		
	
		
		
	

func start_tween():
	await get_tree().create_timer(0.5).timeout
	var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS).set_trans(Tween.TRANS_EXPO)
	tween.set_loops().set_parallel(false)
	tween.tween_property(self, "position", secondpos, duration / 2)
	tween.tween_property(self, "position", self.position, duration / 2)
	tween.tween_property(self, "position", firstpos, duration / 2)
	tween.tween_property(self, "position", self.position, duration / 2)
