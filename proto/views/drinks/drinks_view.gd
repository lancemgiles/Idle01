class_name ViewDrinks extends View
## View for displaying and managing Drinks.

## Area where Drinks are added.
@export var main_list : VBoxContainer

## Reference to drink component scene.
@export var scene_drink : PackedScene

## Reference to the drink handler.
@onready var handler : HandlerDrinks = HandlerDrinks.ref

func _ready() -> void:
	super()
	_generate_drinks()
	handler.drink_created.connect(_generate_newest_drink)

## Ask the handler to create a new drink
func _on_create_drink_button_pressed() -> void:
	handler.create_drink()
	
## Generate all drinks from the handler.
func _generate_drinks() -> void:
	if handler.drinks.size() == 0: return
	
	for drink : Drinks in handler.drinks:
		var new_node : CompoDrink = scene_drink.instantiate() as CompoDrink
		new_node.drink = drink
		main_list.add_child(new_node)

## Generate the newest node.
func _generate_newest_drink() -> void:
	var table_size : int = handler.drinks.size()
	
	var new_node : CompoDrink = scene_drink.instantiate() as CompoDrink
	new_node.drink = handler.drinks[table_size - 1]
	main_list.add_child(new_node)
