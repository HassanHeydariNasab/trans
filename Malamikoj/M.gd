extends KinematicBody2D

var K = null

var je_Areo = false
var vivo = 2

func _ready():
	K = get_node("/root/Bazo/K")
	set_fixed_process(true)

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