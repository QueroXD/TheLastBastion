extends Camera2D

@export var speed : float = 500  # Velocidad de movimiento de la cámara
@export var zoom_speed : float = 0.1  # Velocidad de zoom
@export var min_zoom : float = 0.5     # Zoom mínimo
@export var max_zoom : float = 2.0     # Zoom máximo

func _process(delta):
	var movement = Vector2.ZERO

	# Movimiento de la cámara con las teclas
	if Input.is_action_pressed("player_right"):
		movement.x += 1
	if Input.is_action_pressed("player_left"):
		movement.x -= 1
	if Input.is_action_pressed("player_up"):
		movement.y -= 1
	if Input.is_action_pressed("player_down"):
		movement.y += 1

	# Aplicar el movimiento a la cámara
	if movement != Vector2.ZERO:
		position += movement.normalized() * speed * delta

# Función que ajusta el scale de la UI para que no se vea afectada
func _adjust_ui_scale():
	for child in get_children():
		if child is Control:
			child.scale = Vector2(1 / zoom.x, 1 / zoom.y)

func _input(event):
	# Detectar el desplazamiento de la rueda del ratón
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			# Hacer zoom con la rueda del ratón hacia arriba
			zoom *= 1 + zoom_speed
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			# Hacer zoom con la rueda del ratón hacia abajo
			zoom *= 1 - zoom_speed

		# Limitar el zoom
		zoom.x = clamp(zoom.x, min_zoom, max_zoom)
		zoom.y = clamp(zoom.y, min_zoom, max_zoom)
	
	# Ajustar la escala de la UI para que no se vea afectada
	_adjust_ui_scale()
