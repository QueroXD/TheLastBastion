extends Camera2D

# Velocidad del movimiento del viewport
var speed = 200

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

	# Mover la cámara
	position += movement * speed * delta
var zoom_level = 1.0
var zoom_speed = 0.1

func _input(event):
	# Zoom In (usando la rueda del ratón hacia arriba)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			zoom_level -= zoom_speed
		elif event.button_index == BUTTON_WHEEL_DOWN:
			zoom_level += zoom_speed
	
	# Limitar el zoom entre un mínimo y un máximo
	zoom_level = clamp(zoom_level, 0.5, 2.0)

	# Aplicar el zoom
	zoom = Vector2(zoom_level, zoom_level)
