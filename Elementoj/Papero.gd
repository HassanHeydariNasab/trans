extends Node2D

onready var K = get_node("/root/Bazo/K")
onready var Kamero = get_node("/root/Bazo/Kamero")
onready var Areo = get_node("Areo")
onready var Montri = get_node("Montri")

func _ready():
	pass

func _on_Areo_body_enter( korpo ):
	if korpo == K:
		get_node("Sono").play()
		Montri.interpolate_property(self, "transform/scale",
		Vector2(1,1), Vector2(6,6), 0.5, Tween.TRANS_QUAD,
		Tween.EASE_IN
		)
		Montri.interpolate_property(self, "transform/rot",
		get_rot(), 360, 0.5, Tween.TRANS_QUAD,
		Tween.EASE_IN
		)
		Montri.interpolate_property(self, "visibility/opacity",
		1,0,0.4,Tween.TRANS_QUAD,
		Tween.EASE_IN, 1.5
		)
		Areo.clear_shapes()
		set_z(2)
		Montri.start()

func _on_Montri_tween_complete( objekto, klavo ):
	if klavo == "visibility/opacity":
		queue_free()