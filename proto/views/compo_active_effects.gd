class_name CompoActiveEffects extends VBoxContainer

@export var food_per_second : RichTextLabel

func _ready() -> void:
	connect_signals()
	_update_active_effects()
	
func connect_signals() -> void:
	HandlerFoodGenerator.ref.generator_power_calculated.connect(_on_food_generator_power_calculated)
	HandlerDrinks.ref.effect_food_consumption_updated.connect(_on_effect_drink_food_consumption_updated)
	
func _update_active_effects() -> void:
	var text := "Food per second: %s" % HandlerFoodGenerator.ref.generator_power
	if (HandlerDrinks.ref.effect_food_consumed):
		text += "\nDrinks' food consumption: %s" % HandlerDrinks.ref.effect_food_consumed
	food_per_second.text = text

func _on_food_generator_power_calculated() -> void:
	_update_active_effects()

func _on_effect_drink_food_consumption_updated() -> void:
	_update_active_effects()
