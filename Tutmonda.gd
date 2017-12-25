extends Node

var pako = 0
var nivelo = 0
var rekordita = false
var malvenkigxi_kialo = ""
var lingvo_elektita = null
var bomboj = 0
var nitrogenoj = 0
var jxus_pasita = false
var vidareo = null

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()

func _ready():
	Agordejo.load(agordejo)