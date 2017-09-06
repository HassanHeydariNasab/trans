extends Node2D

onready var Bazo = get_tree().get_root().get_node("/root/Bazo")
onready var Kasxi = get_node("Kasxi")

func _ready():
	Kasxi.interpolate_property(self, "transform/scale",
	Vector2(1,1), Vector2(2,2),0.2,Tween.TRANS_QUART,
	Tween.EASE_IN_OUT
	)

func _on_Area2D_body_enter( korpo ):
	if korpo.get_name() == "K":
		Kasxi.start()

func _on_Kasxi_tween_complete( object, key ):
	Bazo.K.fortigxi()
	queue_free()