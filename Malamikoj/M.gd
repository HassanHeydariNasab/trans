extends KinematicBody2D

onready var Navo_tempilo = get_node("Navo_tempilo")
onready var Halto_tempilo = get_node("Halto_tempilo")

var K = null

var je_Areo = false
const komenca_vivo = 12.0
var vivo = 12.0

const RAPIDO = 1000
var nav = null
var vojo = []
var celo = Vector2()

func _ready():
	K = get_node("/root/Bazo/K")
	celo = get_node("/root/Bazo/K").get_global_pos()
	nav = get_node("/root/Bazo/Nivelo/Navo")
	set_fixed_process(true)
	Navo_tempilo.start()
	set_process(true)

func rekalkuli_vojon():
	vojo = nav.get_simple_path(get_pos(), celo, false)
	if vojo.size() == 0:
		pass

func _process(delta):
	if vojo.size() > 1:
		var d = get_pos().distance_to(vojo[0])
		if d > 2:
			set_pos(get_pos().linear_interpolate(vojo[0], (RAPIDO * delta)/d))
		else:
			vojo.remove(0)
			look_at(celo)
	else:
		pass

func _on_Navo_tempilo_timeout():
	celo = get_node("/root/Bazo/K").get_global_pos()
	rekalkuli_vojon()

func _fixed_process(delta):
	if je_Areo:
		K.vivo -= 1
		if K.vivo <= 0:
			Tutmonda.malvenkigxi_kialo = "mortigxi"
			get_tree().change_scene("res://Malvenkigxi.tscn")

func _on_Areo_body_enter( korpo ):
	if korpo == K:
		je_Areo = true

func _on_Areo_body_exit( korpo ):
	if korpo == K:
		je_Areo = false

func _on_Halto_tempilo_timeout():
	set_process(true)
