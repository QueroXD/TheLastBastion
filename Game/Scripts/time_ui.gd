extends Control

# Referencias a los nodos
@onready var date_label = $DateLabel
@onready var next_day_button = $NextDayButton
@onready var popup_instance = preload("res://Game/NotasDiarias.tscn")
@onready var buttonSound = $ButtonSound
@onready var diaNoche = preload("res://Game/ciclo_dia.tscn")

var ciclo_instance: Control

func _ready():
	date_label.text = "01-01-2044"
	next_day_button.pressed.connect(on_button_pressed)

func on_button_pressed():
	buttonSound.play(0.0)

	ciclo_instance = diaNoche.instantiate()
	add_child(ciclo_instance)
	await pausa(4.0)
	ciclo_instance.queue_free()

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
# Función para crear la pausa
func pausa(segundos: float):
	var timer = Timer.new()
	add_child(timer)  # Añadimos el temporizador a la escena
	timer.wait_time = segundos
	timer.one_shot = true
	timer.start()
	await timer.timeout  # Esperamos hasta que el temporizador se acabe
	timer.queue_free()  # Eliminamos el temporizador cuando termine
