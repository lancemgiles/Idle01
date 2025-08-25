class_name ProtoClicker extends View
## A clicker prototype for gathering food.

func _ready() -> void:
	super()
	visible = false

func _on_button_pressed() -> void:
	HandlerFood.ref.trigger_clicker()
