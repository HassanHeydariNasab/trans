extends KinematicBody2D

const RAPIDO = 5
const RAPIDEGO = 4
var nitrogenoj = 0

func _ready():
	Tutmonda.K = get_tree().get_root().get_node("/root/Bazo/K")
	Tutmonda.Tempilo = get_tree().get_root().get_node("/root/Bazo/Tempilo")
	set_process(true)

func _process(delta):
	move(Vector2(RAPIDO*cos(get_rot()), -RAPIDO*sin(get_rot())))
	if Input.is_action_pressed("rapidi") and nitrogenoj > 0:
		nitrogenoj -= 1
		move(Vector2(RAPIDEGO*cos(get_rot()), -RAPIDEGO*sin(get_rot())))
	if Input.is_action_pressed("turni_dekstre"):
		rotate(deg2rad(-4))
	elif Input.is_action_pressed("turni_maldekstre"):
		rotate(deg2rad(4))