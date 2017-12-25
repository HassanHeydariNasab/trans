extends KinematicBody2D

onready var Fumo = get_node("Fumo")
onready var Fortigxi = get_node("Fortigxi")
onready var Aspekto = get_node("Aspekto")
onready var Tempilo_forto = get_node("Tempilo_forto")
onready var Nitrogensono = get_node("Nitrogensono")
onready var Fortsono = get_node("Fortsono")
onready var Sparko = get_node("/root/Bazo/Sparko")
onready var Sparko_Sono = get_node("/root/Bazo/Sparko/Sono")
onready var Duoblfrapeto = get_node("/root/Bazo/Kanvaso/Kontroliloj/Duoblfrapeto")

var K_shift = Vector2()

const RAPIDO = 8
const RAPIDEGO = 14
var nitrogenoj = 0
var vivo = 200
var bomboj = 0

func _ready():
	Duoblfrapeto.stop()
	if Input.is_action_pressed("rapidi"):
		Input.action_release("rapidi")
	Fortigxi.interpolate_property(Aspekto, "modulate",
	Color("000000"), Color("B71C1C"),
	0.3, Tween.TRANS_QUART, Tween.TRANS_LINEAR
	)
	Fortigxi.interpolate_property(Aspekto, "modulate",
	Color("B71C1C"), Color("000000"),
	0.5, Tween.TRANS_QUART, Tween.TRANS_LINEAR
	)
	set_process(true)
	set_fixed_process(true)
	set_process_input(true)

func bombi():
	bomboj -= 1
	var Bombajxo_ = get_node("/root/Bazo").Bombajxo.instance()
	get_node("/root/Bazo/Bombajxoj").add_child(Bombajxo_)
	Bombajxo_.set_global_pos(get_global_pos())
	Bombajxo_.set_rot(get_rot())

func _input(event):
	if event.is_action_pressed("bombi") and bomboj > 0:
		bombi()
	elif event.type == InputEvent.MOUSE_BUTTON:
		if event.button_index == BUTTON_RIGHT:
			if event.is_pressed() and bomboj > 0:
				bombi()
		elif Duoblfrapeto.get_time_left() > 0 and event.is_pressed() and\
			nitrogenoj > 0:
			Duoblfrapeto.stop()
			Input.action_press("rapidi")
		else:
			Duoblfrapeto.start()
			if Input.is_action_pressed("rapidi"):
				Input.action_release("rapidi")

func angle360(angle):
	if angle > 0:
		return angle
	else:
		return angle +360

func anglediff(angle):
	if abs(angle) < 180:
		return angle
	elif angle < 0:
		return angle + 360
	elif angle > 0:
		return angle - 360

func _fixed_process(delta):
	move(Vector2(RAPIDO*cos(get_rot()), -RAPIDO*sin(get_rot())))
	if Input.is_action_pressed("rapidi") and nitrogenoj > 0:
		nitrogenoj -= 1
		move(Vector2(RAPIDEGO*cos(get_rot()), -RAPIDEGO*sin(get_rot())))
		Fumo.set("color/color","1E88E5EE")
		if not Nitrogensono.is_playing():
			Nitrogensono.set("stream/play", Tutmonda.Agordejo.get_value("Agordoj", "Sonoj", true))
	else:
		Fumo.set("color/color","FFFFFFFF")
		Nitrogensono.stop()
	if Input.is_action_pressed("turni_touch"):
		# get touch event position /mouse position
		var touch_pos = get_viewport().get_mouse_pos()
		# offset of K
#		var K_shift = Vector2(400,600)
		# touch_pos becomes relative coordinate to K
		touch_pos -= K_shift
		#calc angle in degree
		var angle = rad2deg(atan2(touch_pos.y, -touch_pos.x))
		var angle_K = self.get_rotd()
		# shift angle to 0-360 degree
		angle = angle360(angle)
		angle_K = angle360(angle_K)
		
		# get angle difference
		var delta_angle = angle_K - angle
		# to turn in shorter direction
		delta_angle = anglediff(delta_angle)
		var abs_angle = abs(delta_angle)  # to make for small angle the movement smooth
		if abs_angle > 3:
			abs_angle = 3
		if delta_angle > 0: # turn right
			rotate(deg2rad(abs_angle))
		else: # turn left
			rotate(deg2rad(-abs_angle))
	if Input.is_action_pressed("turni_dekstre"):
		rotate(deg2rad(-3))
	elif Input.is_action_pressed("turni_maldekstre"):
		rotate(deg2rad(3))

func _process(delta):
	if is_colliding():
		Sparko.set_global_pos(get_collision_pos())
		Sparko.set_rot(get_rot())
		Sparko.set_emitting(true)
		if not Sparko_Sono.is_playing():
			Sparko_Sono.set("stream/play", Tutmonda.Agordejo.get_value("Agordoj", "Sonoj", true))
	else:
		Sparko.set_emitting(false)
		Sparko_Sono.stop()

func fortigxi():
	set_collision_mask_bit(0,false)
	Fortigxi.resume(Aspekto, "modulate")
	Tempilo_forto.start()
	Fortsono.set("stream/play", Tutmonda.Agordejo.get_value("Agordoj", "Sonoj", true))

func _on_Tempilo_forto_timeout():
	set_collision_mask_bit(0,true)
	Fortigxi.stop(Aspekto, "modulate")
	Aspekto.set("modulate", "000000")
	Fortsono.stop()