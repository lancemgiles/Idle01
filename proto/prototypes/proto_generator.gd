class_name ProtoGenerator extends View
## Generator prototype which creates food every few seconds.

@export var button : Button
@export var timer : Timer

func _ready() -> void:
	super()
	visible = true

func start_generator() -> void:
	timer.start()
	button.disabled = true

func _on_button_pressed() -> void:
	start_generator()

func _on_timer_timeout() -> void:
	HandlerFood.ref.gather_food(1)
	#button.disabled = false
