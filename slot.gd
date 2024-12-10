extends Button

@export var item_name: String

var texture_inside: Sprite2D

func _ready():
	var sprite = Sprite2D.new()
	sprite.texture = load("res://Buildings/LightHouse.png")
	texture_inside = sprite

func _on_button_down() -> void:
	GameManager.item_select(texture_inside)
