extends CharacterBody2D


@export var friction = 600
@export var SPEED = 100.0
const KNOCKBACK = 200.0
const JUMP_VELOCITY = -215.0
var candie = true
var bounce = false
var health = 1
var cankill = true
var canmove = true
var ismoving = false
var canjump = true
var doshakebilly = false
@onready var camera = get_node("Camera")
@onready var cs = get_parent().get_node("chickenstrip")
func dialogue(text: String, target: Node, center=true,length1=1.0,length2=length1,time=2.0,showforever = false):
	if center == true:
		text = "[center]" + text + "[/center]"
	target.text = text
	for i in range(100):
		target.modulate.a += 0.01
		await get_tree().create_timer(length1/100).timeout
	if showforever == false:
		await get_tree().create_timer(time).timeout
		for i in range(100):
			target.modulate.a -= 0.01
			await get_tree().create_timer(length2/100).timeout
	return true

# Gravity for jumping
var gravity = 600
func grav(delta):
	if not is_on_floor() and bounce == false:
		velocity.y += gravity * delta
func jump(delta):
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	

func movement(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if is_on_floor():
		if direction and canmove==true:
			velocity.x = direction * SPEED
			ismoving = true
			if direction < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
		else:
			velocity.x = move_toward(velocity.x, 0, friction*delta)
			ismoving = false
			
	else:
		
		if direction and canmove==true:
			velocity.x = direction * SPEED*0.9
			ismoving = true
			if direction < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
		else:
			velocity.x = move_toward(velocity.x, 0,friction*delta)
			ismoving = false

func _physics_process(delta):
	if canjump == true:
		jump(delta)
	if canmove == true:
		
		movement(delta)
		
		if ismoving:
			get_node("AnimatedSprite2D").play("Run")
		else:
			get_node("AnimatedSprite2D").play("idle")
			camera.position = camera.position.round()
	grav(delta)
	move_and_slide()
func _ready() -> void:
	#Opening scene
	if get_tree().get_current_scene().get_name() == "Mouth":
		var textbox = get_node("dialogue")
		var tut = get_parent().get_node("tut/RichTextLabel")
		textbox.modulate.a = 0
		tut.modulate.a = 0
		get_parent().get_node("chickenstrip").get_node("dialogue").modulate.a = 0
		get_parent().get_node("chickenstrip").visible = false
		velocity.x = 0
		velocity.y = 0
		canmove = false
		canjump = false
		while not is_on_floor():
			velocity.y += gravity * get_process_delta_time()
			await get_tree().create_timer(get_process_delta_time()).timeout
		camera.apply_shake(30)
		await get_tree().create_timer(1.5).timeout
		await dialogue("That was close!",textbox,true)
		await dialogue("I'm so glad I wasn't mechanically digested by the teeth!",textbox,true)
		
		#tutorial
		canmove = true
		await get_tree().create_timer(0.5).timeout
		for i in range(100):
			tut.modulate.a += 0.01
			await get_tree().create_timer(0.01).timeout
	elif get_tree().get_current_scene().get_name() == "stomach":
		var textbox = get_parent().get_node("CanvasLayer2/RichTextLabel")
		var textbox2 = get_parent().get_node("CanvasLayer2/RichTextLabel2")
		cs.queue_free()
		while not is_on_floor():
			canmove = false
			canjump = false
			velocity.y += gravity * get_process_delta_time()
			await get_tree().create_timer(get_process_delta_time()).timeout
		camera.apply_shake(30)
		canmove = true
		canjump = true
		dialogue("Stomach",textbox,true,0.5,0.5,3)
		await dialogue("The green acid is stomach acid, used to break down food. Don't fall in!",textbox2,true,0.5,0.5,3)
 
	

func spikedmg(pos):
	self.position = get_parent().get_node("Dangers").get_node(str(pos)).position


func _on_dontshake_body_entered(body: Node2D) -> void:
	pass # Replace with function body.



func _on_jumptut_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var tut = get_parent().get_node("tut/RichTextLabel")
		canmove = false
		
		velocity.x  = 0
		velocity.y = 0
		cs.tween()
		cs.visible = true
		for i in range(100):
			tut.modulate.a -= 0.01
			await get_tree().create_timer(0.01).timeout
		await dialogue("DON'T MOVE! THAT'S SALIVA!",cs.get_node("dialogue"),true,0.5,0.5,1.5)
		$AnimatedSprite2D.flip_h = true
		await dialogue("huh?",get_node("dialogue"),true,0.2,0.2,1.0)
		await dialogue("YOU'LL GET DIGESTED BY THE AMYLASE ENZYMES!",cs.get_node("dialogue"),true,0.5,0.5,1.5)
		await dialogue("who are you? and where am i?",get_node("dialogue"),true,0.5,0.5,1.5)
		await dialogue("I AM A STRIP OF CHICKEN! AND THIS IS THE MOUTH!",cs.get_node("dialogue"),true,0.5,0.5,1.5)
		await dialogue("I'VE BEEN STUCK HERE 8 YEARS!",cs.get_node("dialogue"),true,0.5,0.5,1.5)
		await dialogue("SO LISTEN TO ME YOUNGUN!",cs.get_node("dialogue"),true,0.5,0.5,1.5)
		await dialogue("USE SPACEBAR TO JUMP! AND BE CAREFUL!!",cs.get_node("dialogue"),true,0.5,0.5,1.5)
		dialogue("BYE BYE! YOU CAN MOVE NOW BY THE WAY!",cs.get_node("dialogue"),true,0.2,0.2,2)
		cs.get_node("Sprite2D").flip_h = true
		cs.tween(-300,0)
		canmove = true
		canjump = true
		get_parent().get_node("jumptut").queue_free()

		



func _on_salivary_gland_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		canmove = false
		canjump = false
		velocity.x  = 0
		velocity.y = 0
		cs.get_node("Sprite2D").flip_h = true
		cs.position = Vector2(1608,-12)
		get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS).set_trans(Tween.TRANS_ELASTIC).set_loops(1).set_parallel(false).tween_property(camera,"position",Vector2(camera.position.x,camera.position.y-100),2)
		get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS).set_trans(Tween.TRANS_ELASTIC).set_loops(1).set_parallel(false).tween_property(camera,"position",Vector2(camera.position.x+50,camera.position.y),2)

		await cs.tween(0,500)
		await get_tree().create_timer(2).timeout
		cs.get_node("Sprite2D").flip_h = false
		await get_tree().create_timer(1).timeout
		await dialogue("THIS IS A SALIVARY GLAND! CAREFUL, SALIVA IS PRODUCED HERE!",cs.get_node("dialogue"),true,0.5,0.5,1.5)
		get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS).set_trans(Tween.TRANS_ELASTIC).set_loops(1).set_parallel(false).tween_property(camera,"position",Vector2(camera.position.x+150,camera.position.y),2)
		await get_tree().create_timer(4).timeout
		get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS).set_trans(Tween.TRANS_ELASTIC).set_loops(1).set_parallel(false).tween_property(camera,"position",Vector2(camera.position.x-150,camera.position.y),2)
		await get_tree().create_timer(2).timeout
		get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS).set_trans(Tween.TRANS_EXPO).set_loops(1).set_parallel(false).tween_property(camera,"position",Vector2(camera.position.x-50,camera.position.y),2)
		dialogue("YOU CAN MOVE NOW!",cs.get_node("dialogue"),true,0.2,0.2,2)
		cs.get_node("Sprite2D").flip_h = true
		cs.tween(0,-500)
		canmove = true
		canjump = true
		get_parent().get_node("facts/salivary gland").queue_free()
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		await get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS).set_trans(Tween.TRANS_EXPO).set_loops(1).set_parallel(false).tween_property(camera,"position",Vector2(camera.position.x,-21.71),1.4)


func _on_startperilstalsis_body_entered(body: Node2D) -> void:
	for i in range(100):
		get_parent().modulate.a -= 0.01
		await get_tree().create_timer(0.005).timeout
	get_tree().change_scene_to_file("res://Scenes/mouth.tscn")


func _on_zoom_camera_out_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS).set_trans(Tween.TRANS_EXPO).set_loops(1).set_parallel(false).tween_property(camera,"zoom",Vector2(5.5,5.5),1)


func _on_zoom_camera_out_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS).set_trans(Tween.TRANS_EXPO).set_loops(1).set_parallel(false).tween_property(camera,"zoom",Vector2(7.8,7.8),1)




func _on_small_intestine_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_parent().get_node("small intestine").queue_free()
		var tween = get_tree().create_tween()
		tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS).set_trans(Tween.TRANS_EXPO).set_loops(1).set_parallel(false).tween_property($Camera, "limit_top", 1450, 0.5)
		var textbox = get_parent().get_node("CanvasLayer2/RichTextLabel")
		var textbox2 = get_parent().get_node("CanvasLayer2/RichTextLabel2")
		camera.apply_shake(30)
		get_parent().get_node("CanvasLayer/Sprite2D").texture = load("res://Sprites/bg.png")
		dialogue("Small intestine",textbox,true,0.5,0.5,3)
		await dialogue("Dangers such as villi and bile reside here.",textbox2,true,0.5,0.5,3)
		
		

func _on_bile_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		self.position = get_parent().get_node("Dangers/5").position


func _on_small_intestine_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_parent().get_node("small intestine2").queue_free()
		var tween = get_tree().create_tween()
		tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS).set_trans(Tween.TRANS_EXPO).set_loops(1).set_parallel(false).tween_property($Camera, "limit_top", 1840, 0.5)
		camera.apply_shake(30)
		


func end() -> void:
	var textbox = get_parent().get_node("CanvasLayer2/RichTextLabel")
	var textbox2 = get_parent().get_node("CanvasLayer2/RichTextLabel2")
	dialogue("Large Intestine",textbox,true,0.5,0.5,3)
	await dialogue("Propels feces to the rectum, then to the anus, and egests it out of the body.",textbox2,true,0.5,0.5,3)
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scenes/end.tscn")
	
