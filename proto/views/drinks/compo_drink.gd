class_name CompoDrink extends VBoxContainer
## Displays Drink information.

## Reference to the Drink's Name Label
@export var label_name : Label
## Reference to label displaying the composition of the drink.
@export var label_composition : Label
## Reference to the slider
@export var consumption_slider : HSlider

## Reference to the Drink to display.
var drink : Drinks

func _ready() -> void:
	update_component()
	drink.composition_updated.connect(update_label_composition)

func update_component() -> void:
	update_label_name()
	update_label_composition()
	update_slider()

func update_label_name() -> void:
	label_name.text = drink.given_name
	
func update_label_composition() -> void:
	label_composition.text = "Food: %s" % drink.food
	
func update_slider() -> void:
	consumption_slider.max_value = 5
	consumption_slider.value = drink.food_consumed


func _on_h_slider_value_changed(value: float) -> void:
	HandlerDrinks.ref.update_drink_consumption_value(drink.data_index, int(value))
