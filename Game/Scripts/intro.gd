extends Control

# Referencias
@onready var anim_player = $AnimationPlayer
@onready var start_button = $CanvasLayer/Start
@onready var audio_player = $CanvasLayer/IntroMusic
@onready var button_sound = $CanvasLayer/Start/ButtonSound

func _ready() -> void:
	audio_player.play(0.0)
	# Asegura que los nodos estén correctamente referenciados
	if anim_player and start_button:
		start_button.connect("pressed", Callable(self, "_on_start_button_pressed"))
	else:
		push_error("AnimationPlayer o StartButton no encontrados.")

func _on_start_button_pressed() -> void:
	if anim_player:
		anim_player.play("intro_game")
		button_sound.play(0.0)
		anim_player.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "intro_game":
		audio_player.stop()
		queue_free()
