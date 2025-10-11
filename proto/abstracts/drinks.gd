class_name Drinks extends Node
## Abstract class containing common features of all Drinks.
##
## This will eventually have to be called something else. "Drinks" cost "food" to create, and then the "Drinks" are managed.

signal composition_updated

## Name of the drink.
var given_name : String = "unnamed drinks"
## Index of the Drink in data.
var data_index := -1
## Amount of food inside the drink.
var food := 0
## Amount of food consumed per second by the drink every second.
var food_consumed := 0

## Tries to consume food.
func _on_consume_food() -> void:
	var error : Error = HandlerFood.ref.consume_food(food_consumed)
	if error: return
	
	food += food_consumed
	Main.ref.data.drinks[data_index].food = food
	composition_updated.emit()
