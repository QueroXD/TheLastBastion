extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var blink_speed = 1.0  # velocidad del parpadeo
var visible_state = true

func _process(_delta: float):
	modulate.a = abs(sin(OS.get_ticks_msec() / 1000.0 * blink_speed))
