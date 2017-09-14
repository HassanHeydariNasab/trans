extends Navigation2D

const RAPIDO = 1000.0

onready var M = get_node("M")
onready var P = get_node("P")
onready var Halti = get_node("Halti")
var K = null

var begin = Vector2()
var end = Vector2()
var path = []

var i = 0
var angulo = 0

var haltita = false

func _update_path():
	var p = get_simple_path(begin, end, true)
	path = Array(p) # Vector2array too complex to use, convert to regular array
	path.invert()
	set_fixed_process(true)

func haltigi():
	haltita = true
	Halti.start()

func _ready():
	K = get_node("/root/Bazo/K")
	set_process(true)
	set_fixed_process(true)

func _fixed_process(delta):
	P.set_global_pos(M.get_global_pos())
	if (path.size() > 1 and not haltita):
		M.set_rot(P.get_angle_to(K.get_global_pos())+deg2rad(180))
		var to_walk = delta*RAPIDO
		while(to_walk > 0 and path.size() >= 2):
			var pfrom = path[path.size() - 1]
			var pto = path[path.size() - 2]
			var d = pfrom.distance_to(pto)
			if (d <= to_walk):
				path.remove(path.size() - 1)
				to_walk -= d
			else:
				path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
				to_walk = 0

		var atpos = path[path.size() - 1]
		M.set_global_pos(atpos)
#		M.move_to(atpos)

		if (path.size() < 2):
			path = []
			set_fixed_process(false)
	else:
		set_fixed_process(false)

func _process(delta):
	i += 1
	if i % 20 == 0:
		begin = M.get_global_pos()
		end = K.get_global_pos()
		_update_path()

func _on_Halti_timeout():
	haltita = false
