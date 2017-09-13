extends Node2D

var M = null

func _ready():
	M = get_node("/root/Bazo/Navo/M")

func _on_Areo_body_enter( korpo ):
	if korpo == M:
		M.vivo -= 1
		if M.vivo <= 0:
			get_node("/root/Bazo/Navo").set_process(false)
			get_node("/root/Bazo/Navo").set_fixed_process(false)
			M.queue_free()
		queue_free()
