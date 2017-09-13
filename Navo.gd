extends Navigation2D

const RAPIDO = 550.0

onready var M = get_node("M1")
onready var P = get_node("P")
var K = null

var begin = Vector2()
var end = Vector2()
var path = []

var i = 0
var angulo = 0

func _update_path():
	var p = get_simple_path(begin, end, true)
	path = Array(p) # Vector2array too complex to use, convert to regular array
	path.invert()
	set_fixed_process(true)

func _ready():
	K = get_node("/root/Bazo/K")
	set_process(true)
	set_fixed_process(true)

func _fixed_process(delta):
	if K.is_colliding():
		if K.get_collider().get_name() == "M1":
			get_parent().vivo -= 1
	P.set_global_pos(M.get_global_pos())
	if (path.size() > 1):
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