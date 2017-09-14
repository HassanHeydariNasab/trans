extends Node2D

onready var Kamero = get_node("Kamero")
onready var K = get_node("K")
onready var Nitrogenoj = get_node("Kanvaso/Nitrogenoj")
onready var Vivo = get_node("Kanvaso/Vivo")
onready var Bomboj = get_node("Kanvaso/Bomboj")
onready var Montrilo = get_node("Kanvaso/Montrilo/Montrilo")
onready var FPS = get_node("Kanvaso/FPS")
onready var Finejo = get_node("Finejo")
onready var Nitrogeno_sono = get_node("Nitrogeno_sono")
onready var Bombo_sono = get_node("Bombo_sono")
onready var Bombajxo = preload("res://Elementoj/Bombajxo.tscn")


var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()

var tempo = 0
var minuto = 0
var sekundo = 0
var L = Vector2()

func _ready():
	get_tree().set_auto_accept_quit(false)
	Agordejo.load(agordejo)
	K.set_global_pos(Vector2(400,500))
	K.set_global_rot(deg2rad(90))
	K.nitrogenoj += Tutmonda.nitrogenoj*60
	if K.nitrogenoj > 200:
		K.nitrogenoj = 200
	K.bomboj += Tutmonda.bomboj
	if K.bomboj > 10:
		K.bomboj = 10
	set_process(true)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().change_scene("res://Niveloj.tscn")

func _process(delta):
	FPS.set_text(str(int(1.0/delta)))
	Kamero.set_offset(K.get_global_pos()+Vector2(0,-100))
	Nitrogenoj.set_value(K.nitrogenoj)
	Vivo.set_value(K.vivo)
	Bomboj.set_text(str(K.bomboj))
	L = Finejo.get_global_pos() - K.get_global_pos()
	Montrilo.set_rot(atan2(L.x,L.y))

func _on_Rekomencu_pressed():
	get_tree().reload_current_scene()