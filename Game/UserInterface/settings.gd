extends Control

@onready var master_slider = $CanvasLayer/MarginContainer/VBoxContainer/Audio
@onready var musica_slider = $CanvasLayer/MarginContainer/VBoxContainer/Musica
@onready var efectos_slider = $CanvasLayer/MarginContainer/VBoxContainer/Efectos

# Cargar referencias de los buses
var master_bus := AudioServer.get_bus_index("Master")
var musica_bus := AudioServer.get_bus_index("Musica")
var efectos_bus := AudioServer.get_bus_index("Efectos")

func _ready() -> void:
	# Conectar el botón de cerrar
	$CanvasLayer/Cerrar.connect("pressed", Callable(self, "_on_ButtonCerrar_pressed"))
	
	# Inicializar valores de los sliders
	master_slider.value = AudioServer.get_bus_volume_db(master_bus)
	musica_slider.value = AudioServer.get_bus_volume_db(musica_bus)
	efectos_slider.value = AudioServer.get_bus_volume_db(efectos_bus)

# Cerrar la ventana
func _on_ButtonCerrar_pressed() -> void:
	queue_free()

# Cambia el volumen del Master
func _on_audio_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, value)

# Cambia el volumen de la música
func _on_musica_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(musica_bus, value)

# Cambia el volumen de los efectos de sonido
func _on_efectos_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(efectos_bus, value)
