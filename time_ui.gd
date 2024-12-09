extends Control

# Referencias a los nodos
@onready var date_label = $DateLabel
@onready var next_day_button = $NextDayButton
@onready var popup_instance = preload("res://NotasDiarias.tscn")

func _ready():
	date_label.text = "01-01-2044"
	next_day_button.pressed.connect(on_button_pressed)

func on_button_pressed():
	# Incrementar la fecha
	var current_date = date_label.text
	var date_parts = current_date.split("-")
	var day = int(date_parts[0])
	var month = int(date_parts[1])
	var year = int(date_parts[2])
	
	day += 1
	if day > 31:
		day = 1
		month += 1
		if month > 12:
			month = 1
			year += 1
	
	# Actualizar la fecha en la etiqueta
	date_label.text = str(day).pad_zeros(2) + "-" + str(month).pad_zeros(2) + "-" + str(year)

	# Actualizar la variable global con la nueva fecha
	Global.mi_variable = date_label.text

	# Mostrar el pop-up
	show_popup_with_message("Día actualizado a " + date_label.text)

func show_popup_with_message(message: String):
	# Instanciar la escena del pop-up
	var popup_scene = popup_instance.instantiate()
	add_child(popup_scene)

	# Configurar el mensaje en el TextureRect o su hijo
	var texture_rect = popup_scene.get_node("TextureRect")
	if texture_rect:
		# Suponiendo que el TextureRect tiene un hijo RichTextLabel para mostrar el mensaje
		var label = texture_rect.get_node("RichTextLabel")
		if label:
			label.text = message

		# Mostrar el TextureRect (hacerlo visible)
		texture_rect.visible = true
	#else:
		#print_error("El nodo 'TextureRect' no se encuentra en la escena de pop-up")
