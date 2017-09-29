extends Node2D

onready var Kamero = get_node("Kamero")
onready var K = get_node("K")
onready var Tempilo = get_node("Tempilo")
onready var Tempo = get_node("Kanvaso/Tempo")
onready var Nitrogenoj = get_node("Kanvaso/Nitrogenoj")
onready var Montrilo = get_node("Kanvaso/Montrilo/Montrilo")
onready var FPS = get_node("Kanvaso/FPS")
onready var Rekordo = get_node("Kanvaso/Rekordo")
onready var Nivelo = null
onready var Finejo1 = null
onready var Finejo2 = null
onready var Tempo_sono = get_node("Tempo_sono")
onready var Nitrogeno_sono = get_node("Nitrogeno_sono")
onready var Tempilo_Sono = get_node("Tempilo/Sono")
onready var Bomboj = get_node("Kanvaso/Kontroliloj/Bombi/Bomboj")
onready var Bombo_sono = get_node("Bombo_sono")
onready var Bombajxo = preload("res://Elementoj/Bombajxo.tscn")
onready var Vivo = get_node("Kanvaso/Vivo")

var tempo = 0
var minuto = 0
var sekundo = 0
var L = Vector2()
var L1 = Vector2()
var L2 = Vector2()

func _ready():
	get_tree().set_auto_accept_quit(false)
	K.set_global_pos(Vector2(400,500))
	K.set_global_rot(deg2rad(90))
	K.nitrogenoj += Tutmonda.nitrogenoj*60
	if K.nitrogenoj > 200:
		K.nitrogenoj = 200
	K.bomboj += Tutmonda.bomboj
	if K.bomboj > 10:
		K.bomboj = 10
	add_child(load("res://Niveloj/P%dN%d.tscn" % [Tutmonda.pako, Tutmonda.nivelo]).instance())
	Nivelo = get_node("Nivelo")
	Tempilo.set_wait_time(Nivelo.tempo)
	Tempilo.start()
	if Tutmonda.nivelo == 3:
		Tempo.hide()
	Nivelo.get_node("Fonmuziko").set("stream/play", Tutmonda.Agordejo.get_value("Agordoj", "Muzikoj", true))
	move_child(Nivelo,0)
	Finejo1 = Nivelo.get_node("Finejo1")
	if Nivelo.has_node("Finejo2"):
		Finejo2 = Nivelo.get_node("Finejo2")
	var rekordo = Tutmonda.Agordejo.get_value("Niveloj", "P"+str(Tutmonda.pako)+"N"+str(Tutmonda.nivelo), null)
	if rekordo != null and Tutmonda.nivelo != 3:
		minuto = "%02d" % (rekordo/60)
		sekundo = "%02d" % (rekordo%60)
		Rekordo.set_text(str(minuto)+":"+str(sekundo))
		Rekordo.show()
	set_process(true)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().change_scene("res://Niveloj.tscn")

func _process(delta):
	FPS.set_text(str(int(1.0/delta)))
	tempo = int(Tempilo.get_time_left())
	if tempo < 10:
		if not Tempilo_Sono.is_playing():
			Tempilo_Sono.set("stream/play", Tutmonda.Agordejo.get_value("Agordoj", "Sonoj", true))
	else:
		Tempilo_Sono.stop()
	minuto = "%02d" % (tempo/60)
	sekundo = "%02d" % (tempo%60)
	Tempo.set_text(str(minuto)+":"+str(sekundo))
	Kamero.set_offset(K.get_global_pos()+Vector2(0,-100))
	Nitrogenoj.set_value(K.nitrogenoj)
	Bomboj.set_text(str(K.bomboj))
	Vivo.set_value(K.vivo)
	L1 = Finejo1.get_global_pos() - K.get_global_pos()
	if Finejo2 != null:
		L2 = Finejo2.get_global_pos() - K.get_global_pos()
		if L1.length() < L2.length():
			Montrilo.set_rot(atan2(L1.x,L1.y))
		else:
			Montrilo.set_rot(atan2(L2.x,L2.y))
	else:
		Montrilo.set_rot(atan2(L1.x,L1.y))

func _on_Tempo_timeout():
	Tutmonda.malvenkigxi_kialo = "fintempo"
	get_tree().change_scene("res://Malvenkigxi.tscn")

func _on_Rekomencu_pressed():
	get_tree().reload_current_scene()