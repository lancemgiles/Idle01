class_name ProtoGenerator extends Control
## Generator prototype which creates food every few seconds.

var food := 0
@export var label : Label
@export var button : Button
@export var timer : Timer

func _ready() -> void:
	update_label_text()

func gather() -> void:
	food += 1
	update_label_text()
	
func update_label_text() -> void:
	label.text = "food: %s" % food
	
func start_generator() -> void:
	timer.start()
	button.disabled = true

func _on_button_pressed() -> void:
	start_generator()

func _on_timer_timeout() -> void:
	gather()
	#button.disabled = false
