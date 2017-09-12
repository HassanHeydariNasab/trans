extends KinematicBody2D

onready var Fumo = get_node("Fumo")
onready var Fortigxi = get_node("Fortigxi")
onready var Aspekto = get_node("Aspekto")
onready var Tempilo_forto = get_node("Tempilo_forto")
onready var Nitrogensono = get_node("Nitrogensono")
onready var Fortsono = get_node("Fortsono")
onready var Sparko = get_node("/root/Bazo/Sparko")
onready var Sparko_Sono = get_node("/root/Bazo/Sparko/Sono")

const RAPIDO = 8
const RAPIDEGO = 14
var nitrogenoj = 0

func _ready():
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

func _fixed_process(delta):
	move(Vector2(RAPIDO*cos(get_rot()), -RAPIDO*sin(get_rot())))
	if Input.is_action_pressed("rapidi") and nitrogenoj > 0:
		nitrogenoj -= 1
		move(Vector2(RAPIDEGO*cos(get_rot()), -RAPIDEGO*sin(get_rot())))
		Fumo.set("color/color","1E88E5EE")
		if not Nitrogensono.is_playing():
			Nitrogensono.play()
	else:
		Fumo.set("color/color","FFFFFFFF")
		Nitrogensono.stop()
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
			Sparko_Sono.play()
	else:
		Sparko.set_emitting(false)
		Sparko_Sono.stop()

func fortigxi():
	set_collision_mask_bit(0,false)
	Fortigxi.resume(Aspekto, "modulate")
	Tempilo_forto.start()
	Fortsono.play()

func _on_Tempilo_forto_timeout():
	set_collision_mask_bit(0,true)
	Fortigxi.stop(Aspekto, "modulate")
	Aspekto.set("modulate", "000000")
	Fortsono.stop()