class_name CompoActiveEffects extends VBoxContainer

@export var food_per_second : RichTextLabel

func _ready() -> void:
	connect_signals()
	_update_food_per_second()
	
func connect_signals() -> void:
	HandlerFoodGenerator.ref.generator_power_calculated.connect(_on_food_generator_power_calculated)
	
func _update_food_per_second() -> void:
	var text := "[b]Food per second [/b] %s " % HandlerFoodGenerator.ref.generator_power
	food_per_second.text = text

func _on_food_generator_power_calculated() -> void:
	_update_food_per_second()
