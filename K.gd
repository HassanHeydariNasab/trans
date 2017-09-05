extends KinematicBody2D

onready var Fumo = get_node("Fumo")
onready var Fortigxi = get_node("Fortigxi")
onready var Aspekto = get_node("Aspekto")
onready var Tempilo_forto = get_node("Tempilo_forto")

const RAPIDO = 4
const RAPIDEGO = 5
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

func _process(delta):
	move(Vector2(RAPIDO*cos(get_rot()), -RAPIDO*sin(get_rot())))
	if Input.is_action_pressed("rapidi") and nitrogenoj > 0:
		nitrogenoj -= 1
		move(Vector2(RAPIDEGO*cos(get_rot()), -RAPIDEGO*sin(get_rot())))
		Fumo.set("color/color","1E88E5EE")
	else:
		Fumo.set("color/color","FFFFFFFF")
	if Input.is_action_pressed("turni_dekstre"):
		rotate(deg2rad(-4))
	elif Input.is_action_pressed("turni_maldekstre"):
		rotate(deg2rad(4))

func fortigxi():
	set_collision_mask_bit(0,false)
	Fortigxi.resume(Aspekto, "modulate")
	Tempilo_forto.start()

func _on_Tempilo_forto_timeout():
	set_collision_mask_bit(0,true)
	Fortigxi.stop(Aspekto, "modulate")
	Aspekto.set("modulate", "000000")