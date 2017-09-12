extends Control

onready var Niveloj = get_node("Niveloj")
onready var Konservu = get_node("Konservu")
onready var Kasxi = get_node("Konservu/Kasxi")

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()
const lingvoj = ["eo", "en"]

var sumo = 0
const tempoj = [
		[0,0,0,0],
		[0,10,40,80],
		[0,10,40,80],
		[0,10,40,80]
	]

var pakoj = []

func _init():
	var Agordejo = ConfigFile.new()
	Agordejo.load(agordejo)
	var lingvo_indekso = Agordejo.get_value("Lingvo", "lingvo")
	if TranslationServer.get_locale() != lingvoj[lingvo_indekso]:
		TranslationServer.set_locale(lingvoj[lingvo_indekso])

func _ready():
	Agordejo.load(agordejo)
	pakoj = [
			[tr("Enkonduko"), tr("Turneto"), tr("Parko"), tr("Estreto")],
			[],
			[],
			[tr("Longa Koridoro"), tr("Labirinto"), tr("Mallonga Vojo"), tr("Konstruajxo")]
		]
	get_tree().set_auto_accept_quit(true)
	get_node("Pakoj").set_selected(Tutmonda.pako)
	var N = 0
	var Niveloj__ = Niveloj.get_children()
	for Nivelo in Niveloj__:
		N = int(Nivelo.get_name().substr(1,3))
		if Tutmonda.rekordita and N == Tutmonda.nivelo:
			Tutmonda.rekordita = false
			var Novrekordo = get_node("Novrekordo")
			var Novrekordo_Aperi = Novrekordo.get_node("Aperi")
			Novrekordo.set_global_pos(Nivelo.get_global_pos()+Vector2(660,60))
			Novrekordo_Aperi.interpolate_property(Novrekordo, "transform/scale",
			Vector2(5,5), Vector2(0.7,0.7),
			0.75, Tween.TRANS_QUINT, Tween.EASE_IN
			)
			Novrekordo_Aperi.start()
			Novrekordo.show()
			Novrekordo.get_node("Sono").play()
		Nivelo.set_text(pakoj[Tutmonda.pako][N])
		Nivelo.get_node("Tempo").set_text(
			str(Agordejo.get_value("Niveloj", str(N), 0))+"s"
		)
		sumo += Agordejo.get_value("Niveloj",
		 		str(N), 0)
		Nivelo.connect("pressed", self, "_on_Nivelo_pressed", [Nivelo])
	get_node("Sumo").set_text(str(sumo))
	Kasxi.interpolate_property(Konservu, "visibility/opacity", 1,0,
		2, Tween.TRANS_QUINT, Tween.EASE_IN
	)

func _on_Lingvo_pressed():
	get_tree().change_scene("res://Lingvo.tscn")

func _on_Pri_pressed():
	get_tree().change_scene("res://Pri.tscn")

func _on_Nivelo_pressed(Nivelo):
	var N = int(Nivelo.get_name().substr(1,3))
	var bezonita_tempo = tempoj[Tutmonda.pako][N]
	if sumo >= bezonita_tempo:
		Tutmonda.nivelo = N
		Tutmonda.rekordita = false
		get_tree().change_scene("res://Bazo.tscn")
	else:
		Konservu.get_node("Mesagxo").set_text(tr("Pliu vian konservitan tempon al")+" "+str(bezonita_tempo)+"s")
		Kasxi.resume_all()

func _on_Kasxi_tween_complete( object, key ):
	Kasxi.stop_all()

func _on_Pakoj_button_selected( idx ):
	Tutmonda.pako = idx
	get_tree().reload_current_scene()
