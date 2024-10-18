extends Area2D
export var speed = 200 # Velocidad del NPC.
var screen_size # Tamaño de la ventana del juego.

var waypoints = [Vector2(150, 150), Vector2(300, 300)] # Puntos de ruta predefinidos.
var current_waypoint = 0

func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite.play() # El NPC estará en constante movimiento.

func _process(delta):
	# Obtener la posición actual del NPC y la posición del siguiente waypoint.
	var target = waypoints[current_waypoint]
	var direction = (target - position).normalized()
	
	# Moverse hacia el waypoint actual.
	position += direction * speed * delta
	
	# Cambiar la animación según la dirección del movimiento.
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			$AnimatedSprite.animation = "ne"
		else:
			$AnimatedSprite.animation = "nw"
	else:
		if direction.y > 0:
			$AnimatedSprite.animation = "se"
		else:
			$AnimatedSprite.animation = "sw"
	
	# Si está lo suficientemente cerca del waypoint, cambiar al siguiente.
	if position.distance_to(target) < 10:
		current_waypoint += 1
		if current_waypoint >= waypoints.size():
			current_waypoint = 0  # Reiniciar el recorrido de los waypoints.
