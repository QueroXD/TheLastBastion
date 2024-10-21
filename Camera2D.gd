extends Camera2D

# Velocidades de movimiento del viewport
var speed_normal = 1000  # Velocidad para zoom <= 50% (más alejado)
var speed_zoomed_out = 3000  # Velocidad por defecto para zoom > 50% (más cerca)
var zoom_level = 10.0  # Nivel de zoom inicial

func _ready():
	# Establecer un nivel de zoom inicial
	zoom_level = 10.0  # Cambia este valor para ajustar el zoom inicial
	zoom = Vector2(zoom_level, zoom_level)

func _process(delta):
	# Vector para el movimiento
	var movement = Vector2.ZERO
	
	# Teclas WASD para mover la cámara
	if Input.is_action_pressed("ui_up"):  # W
		movement.y -= 1
	if Input.is_action_pressed("ui_down"):  # S
		movement.y += 1
	if Input.is_action_pressed("ui_left"):  # A
		movement.x -= 1
	if Input.is_action_pressed("ui_right"):  # D
		movement.x += 1

	# Normalizar para evitar movimientos diagonales más rápidos
	movement = movement.normalized()

	# Ajustar la velocidad según el nivel de zoom
	var speed = speed_normal  # Valor por defecto
	if zoom_level > 0.5:  # Zoom mayor al 50%
		speed = speed_zoomed_out

	# Mover la cámara
	position += movement * speed * delta

var zoom_speed = 0.1
var is_fullscreen = false

func _input(event):
	# Zoom In (usando la rueda del ratón hacia arriba)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			zoom_level -= zoom_speed
		elif event.button_index == BUTTON_WHEEL_DOWN:
			zoom_level += zoom_speed
	
	# Limitar el zoom entre un mínimo y un máximo
	zoom_level = clamp(zoom_level, 0.5, 10.0)  # Aumentar el valor máximo a 10.0

	# Aplicar el zoom
	zoom = Vector2(zoom_level, zoom_level)



