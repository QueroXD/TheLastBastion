extends Area2D

# Variables de movimiento
var grid_size = Vector2(64, 32) # Ajusta esto según el tamaño de tu cuadrícula
var speed = 100  # Velocidad de movimiento
var path = []    # Aquí se almacenará el camino a seguir
var current_tile_index = 0  # Índice del tile actual
var target_position: Vector2
var moving = false

# Referencia al AnimatedSprite
onready var animated_sprite = $AnimatedSprite

func _ready():
	# Define el camino como una lista de posiciones de los tiles (x, y) en coordenadas del TileMap
	path = [
		Vector2(1, 0),  # Primer tile (1, 0)
		Vector2(1, 1),  # Segundo tile (1, 1)
		Vector2(2, 1),  # Tercer tile (2, 1)
		Vector2(2, 0)   # Cuarto tile (2, 0)
		# Agrega más tiles según el camino deseado
	]
	target_position = (path[current_tile_index] * grid_size)  # Establece la primera posición objetivo
	start_moving()  # Comienza el movimiento al inicio

func _process(delta):
	if moving:
		# Mueve el NPC hacia la posición objetivo
		var direction = (target_position - position).normalized()
		position += direction * speed * delta  # Ajusta la velocidad

		# Verifica si el NPC ha llegado a la posición objetivo
		if position.distance_to(target_position) < 1:
			position = target_position
			moving = false
			current_tile_index += 1  # Avanza al siguiente tile
			if current_tile_index < path.size():
				target_position = path[current_tile_index] * grid_size  # Actualiza la nueva posición objetivo
				start_moving()  # Comienza a moverse hacia el nuevo objetivo
			else:
				queue_free()  # Elimina el NPC si ha llegado al final del camino

# Función para iniciar el movimiento
func start_moving():
	moving = true
	update_animation()  # Actualiza la animación al empezar a moverse

# Función para actualizar la animación según la dirección
func update_animation():
	if moving:
		animated_sprite.play("move")  # Cambia "move" al nombre de la animación de movimiento
	else:
		animated_sprite.play("idle")  # Cambia "idle" al nombre de la animación de inactividad
