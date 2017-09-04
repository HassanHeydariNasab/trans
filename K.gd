extends KinematicBody2D

const RAPIDO = 5

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_pressed("iri"):
		move(Vector2(RAPIDO*cos(get_rot()), -RAPIDO*sin(get_rot())))
	if Input.is_action_pressed("turni_dekstre"):
		rotate(deg2rad(-4))
	elif Input.is_action_pressed("turni_maldekstre"):
		rotate(deg2rad(4))