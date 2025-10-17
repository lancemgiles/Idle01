class_name CompoDrink extends VBoxContainer
## Displays Drink information.

## Reference to the Drink's Name Label
@export var label_name : Label
## Reference to label displaying the composition of the drink.
@export var label_composition : Label
## Reference to the slider to controls how much food is consumed per second.
@export var attraction_slider : HSlider
## Reference to the silder that controls how much refined food is released.
@export var release_slider : HSlider

## Reference to the Drink to display.
var drink : Drinks

func _ready() -> void:
	update_component()
	drink.composition_updated.connect(update_label_composition)

func update_component() -> void:
	update_label_name()
	update_label_composition()
	update_attraction_slider()

func update_label_name() -> void:
	label_name.text = drink.given_name
	
func update_label_composition() -> void:
	var text = "Food: %s" % drink.food
	text += "\nRefined food: %s" % drink.refined_food
	label_composition.text = text
	
func update_attraction_slider() -> void:
	attraction_slider.min_value = HandlerDrinks.ref.min_attraction_value
	attraction_slider.max_value = HandlerDrinks.ref.max_attraction_value
	attraction_slider.value = drink.attraction_value

func update_release_slider() -> void:
	release_slider.min_value = HandlerDrinks.ref.min_release_value
	release_slider.max_value = HandlerDrinks.ref.max_release_value
	release_slider.value = drink.release_value
	

func _on_attraction_slider_value_changed(value: float) -> void:
	HandlerDrinks.ref.update_drink_attraction_value(drink.data_index, int(value))


func _on_release_slider_value_changed(value: float) -> void:
	HandlerDrinks.ref.update_drink_release_value(drink.data_index, int(value))
