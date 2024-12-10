extends Button

@export var item_name: String

var texture_inside: Texture = null

func _ready():
	texture_inside = load("res://Buildings/LightHouse.png")
	$SlotRect.texture = texture_inside

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		GameManager.emit_signal("item_selected", texture_inside)
