extends Control
# Node references
@onready var date_label = $DateLabel
@onready var next_day_button = $NextDayButton
func _ready():
	date_label.text = "01-01-2024"
	next_day_button.pressed.connect(on_button_pressed)

func on_button_pressed():
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
	
	date_label.text = str(day).pad_zeros(2) + "-" + str(month).pad_zeros(2) + "-" + str(year)
