class_name ProtoClicker extends Control
## A clicker prototype for gathering food.

@export var label : Label
var food := 0

func _ready() -> void:
	update_label_text()

func gather() -> void:
	food += 1
	update_label_text()
	
func update_label_text() -> void:
	label.text = "food: %s" % str(food)
	
func _on_button_pressed() -> void:
	gather()
