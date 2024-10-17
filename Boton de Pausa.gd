extends TextureButton

onready var popup = $PopupDialog

# Este método se llama cuando el nodo se instancia en la escena
func _ready():
	var panel_style = StyleBoxFlat.new()
	panel_style.set_bg_color(Color(0, 0, 0, 0))  # Color transparente
	
	var theme = Theme.new()
	theme.set_stylebox("panel", "PopupDialog", panel_style)
	
	self.theme = theme
	# Conectar la señal 'pressed' a la función que maneja la pausa
	connect("pressed", self, "_on_Boton_de_Pausa_pressed")

	# Asegurarte que el botón funcione cuando el juego esté en pausa
	pause_mode = Node.PAUSE_MODE_PROCESS

	# Fijar el botón en la esquina superior izquierda (esto parece que se usa para otra cosa)
	rect_position = Vector2(10, 10)  # Ajusta las coordenadas si es necesario

# Función que maneja la pausa del juego
func _on_Boton_de_Pausa_pressed():
	# Alternar el estado de pausa
	get_tree().paused = not get_tree().paused
		
	# Crear y añadir un botón para cerrar solo cuando se muestre el PopupDialog
	var boton_cerrar = Button.new()
	var background_texture = preload("res://img/Iron_button.png")

	# Crear un nuevo StyleBoxTexture para el estado "normal"
	var style_box_texture = StyleBoxTexture.new()
	style_box_texture.texture = background_texture

	# Definir los márgenes del StyleBoxTexture
	style_box_texture.margin_top = 100
	style_box_texture.margin_bottom = 100
	style_box_texture.margin_left = 100
	style_box_texture.margin_right = 100

	# Asignar el StyleBoxTexture al estado "normal"
	boton_cerrar.add_stylebox_override("normal", style_box_texture)
	
	boton_cerrar.add_color_override("font_color", Color(0, 0, 0))  # Color normal (negro)


	# Crear un nuevo StyleBoxTexture para el estado "pressed"
	var pressed_style = StyleBoxTexture.new()
	pressed_style.texture = background_texture

	# Crear un nuevo StyleBoxTexture para el estado "hover"
	var hover_style = StyleBoxTexture.new()
	hover_style.texture = background_texture

	# Asignar los StyleBoxTexture a los estados "pressed" y "hover"
	boton_cerrar.add_stylebox_override("pressed", pressed_style)
	boton_cerrar.add_stylebox_override("hover", hover_style)

	# Asignar el texto del botón
	boton_cerrar.text = "Volver"

	# Centrar el texto horizontalmente
	boton_cerrar.align = Button.ALIGN_CENTER  # Centrar horizontalmente

	# Añadir el botón al PopupDialog
	popup.add_child(boton_cerrar)

	# Calcular la posición para el PopupDialog
	var popup_size = popup.rect_size  # Tamaño del PopupDialog
	var button_size = boton_cerrar.rect_size  # Tamaño del botón

	# Posicionar el botón al 75% de la altura del PopupDialog
	var y_position = (popup_size.y * 0.70) - (button_size.y / 2)  # Centrar verticalmente en 75%

	# Ajustar la posición horizontal para mover el botón más a la izquierda
	var x_offset = 150  # Aumentar el desplazamiento a 150 píxeles
	boton_cerrar.rect_position = Vector2(popup_size.x - button_size.x - 10 - x_offset,  # Margen desde el borde derecho
											  y_position)  # Posición al 75% de la altura

	# Conectar la señal del botón para cerrar el popup y pausar el juego
	boton_cerrar.connect("pressed", self, "_on_BotonCerrar_pressed")

	# Deslizar el PopupDialog desde arriba
	slide_in_popup()

# Función para deslizar el PopupDialog hacia el centro
func slide_in_popup():
	# Inicializa la posición del popup fuera de la pantalla, centrado horizontalmente
	popup.rect_position = Vector2((get_viewport().size.x - popup.rect_size.x) / 2, -popup.rect_size.y)

	# Asegúrate de que el PopupDialog esté visible
	popup.show()

	# Crea un Tween para animar el PopupDialog
	var tween = Tween.new()
	add_child(tween)

	# Anima el deslizamiento hacia el centro de la pantalla con un ajuste a la derecha
	var offset_x = 60  # Aumenta el ajuste para moverlo más a la derecha

	tween.interpolate_property(
		popup,
		"rect_position",
		Vector2((get_viewport().size.x - popup.rect_size.x) / 2, -popup.rect_size.y),  # Posición inicial (fuera de la pantalla)
		Vector2((get_viewport().size.x - popup.rect_size.x) / 2 + offset_x, (get_viewport().size.y - popup.rect_size.y) / 2),  # Centro de la pantalla ajustado
		0.5,  # Duración de la animación en segundos
		Tween.TRANS_QUINT,  # Tipo de interpolación
		Tween.EASE_IN_OUT  # Easing
	)

	tween.start()

# Nueva función para deslizar el PopupDialog hacia arriba al cerrar
func slide_out_popup():
	# Crea un Tween para animar el PopupDialog
	var tween = Tween.new()
	add_child(tween)

	# Anima el deslizamiento hacia arriba fuera de la pantalla
	tween.interpolate_property(
		popup,
		"rect_position",
		Vector2((get_viewport().size.x - popup.rect_size.x) / 2 + 60, (get_viewport().size.y - popup.rect_size.y) / 2),  # Posición inicial (en el centro)
		Vector2((get_viewport().size.x - popup.rect_size.x) / 2 + 60, -popup.rect_size.y),  # Posición final (fuera de la pantalla)
		0.5,  # Duración de la animación en segundos
		Tween.TRANS_QUINT,  # Tipo de interpolación
		Tween.EASE_IN_OUT  # Easing
	)

	tween.start()

	# Conectar la señal "tween_completed" para ocultar el PopupDialog después de la animación
	tween.connect("tween_completed", self, "_on_TweenCompleted")

# Función que maneja el cierre del PopupDialog y pausa/despausa el juego
func _on_BotonCerrar_pressed():
	# Despausar el juego al cerrar el popup, solo si estaba pausado
	if get_tree().paused:
		get_tree().paused = false  # Despausar el juego

	# Llamar a la función para deslizar el PopupDialog hacia arriba
	slide_out_popup()

# Función que oculta el PopupDialog una vez que ha terminado la animación
func _on_TweenCompleted(tween_name: String, node: Node):
	# Asegúrate de que el PopupDialog esté oculto
	popup.hide()
