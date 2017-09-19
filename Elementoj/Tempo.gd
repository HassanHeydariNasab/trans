extends Node2D

onready var Bazo = get_tree().get_root().get_node("/root/Bazo")
onready var Kasxi = get_node("Kasxi")
onready var Aspekto = get_node("Aspekto")
onready var Areo = get_node("Areo")
onready var tempo1 = preload("res://Elementoj/tempo1.png")
onready var tempo2 = preload("res://Elementoj/tempo2.png")
onready var tempo3 = preload("res://Elementoj/tempo3.png")

var TIPO = 0

func _ready():
	var aspekto = [tempo1,tempo2,tempo3]
	randomize()
	TIPO = randi()%3+1
	Aspekto.set_texture(aspekto[TIPO-1])
	Kasxi.interpolate_property(self, "transform/scale",
	Vector2(1,1), Vector2(2,2),0.2,Tween.TRANS_QUART,
	Tween.EASE_IN_OUT
	)

func _on_Areo_body_enter( korpo ):
	if korpo.get_name() == "K":
		Areo.clear_shapes()
		if not Bazo.Tempilo_Sono.is_playing():
			Bazo.Tempo_sono.set("stream/play", Tutmonda.Agordejo.get_value("Agordoj", "Sonoj", true))
		Bazo.Tempilo.set_wait_time(Bazo.Tempilo.get_time_left()+TIPO*5)
		Bazo.Tempilo.start()
		if Bazo.Tempilo.get_time_left() < 10:
			Bazo.Tempilo_Sono.seek_pos(10.0-Bazo.Tempilo.get_time_left())
			Bazo.Tempilo_Sono.set("stream/play", Tutmonda.Agordejo.get_value("Agordoj", "Sonoj", true))
		Kasxi.start()

func _on_Kasxi_tween_complete( object, key ):
	queue_free()