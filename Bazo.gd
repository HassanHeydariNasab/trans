extends Node2D

onready var Kamero = get_node("Kamero")
onready var K = get_node("K")
onready var Tempo = get_node("Tempo")
onready var Tempilo = get_node("Kanvaso/Tempilo")
var tempo = 0

func _ready():
	tempo = int(Tempo.get_time_left())
	K.set_global_pos(Vector2(450,500))
	K.set_global_rot(deg2rad(90))
	set_process(true)

func _process(delta):
	tempo = int(Tempo.get_time_left())
	var minuto = "%02d" % (tempo/60)
	var sekundo = "%02d" % (tempo%60)
	print(str(minuto))
	Tempilo.set_text(str(minuto)+":"+str(sekundo))
	Kamero.set_offset(K.get_global_pos()+Vector2(0,-100))