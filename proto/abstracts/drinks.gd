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
## Amount of food attracted to the drink per second.
var attraction_value := 1
## Amount of refined food inside the drink.
var refined_food := 0
## Amount of refined food being released.
var release_value := 1
## Modifier applied to food generation/gathering
var effect_food_generation := 0

## Tries to consume food.
func attract_food() -> void:
	var error : Error = HandlerFood.ref.consume_food(attraction_value)
	if error: return
	
	food += attraction_value
	Main.ref.data.drinks[data_index].food = food
	composition_updated.emit()


func refine_food() -> void:
	var refined_food_to_create := -1
	if food >= 100:
		var error : Error = consume_food(9)
		if error: return
		
		refined_food_to_create = 5
	
	elif food >= 25:
		var error : Error = consume_food(3)
		if error: return
		
		refined_food_to_create = 2
		
	if refined_food_to_create != -1:
		refined_food += refined_food_to_create
		Main.ref.data.universe.refined_food += refined_food_to_create
		Main.ref.data.drinks[data_index].refined_food = refined_food
		calculate_effect_food_generation()
		composition_updated.emit()
		
		
func consume_food(quantity : int) -> Error:
	if food >= quantity:
		food -= quantity
		Main.ref.data.drinks[data_index].food = food
		return Error.OK
	return Error.FAILED
	
func consume_refined_food(quantity : int) -> Error:
	if refined_food >= quantity:
		refined_food -= quantity
		Main.ref.data.drinks[data_index].refined_food = refined_food
		calculate_effect_food_generation()
		return Error.OK
		
	return Error.FAILED

func release_refined_food() -> void:
	var quantity := -1
	if release_value > refined_food:
		quantity = refined_food
	else:
		quantity = release_value
	var error : Error = consume_refined_food(quantity)
	if error:
		return
	HandlerRefinedFood.ref.create_refined_food(quantity)

func calculate_effect_food_generation() -> void:
	var old_effect : int = effect_food_generation
	if refined_food >= 25:
		effect_food_generation = 1
	if refined_food >= 100:
		effect_food_generation = 2
	if effect_food_generation != old_effect:
		HandlerDrinks.ref.calculate_drink_effect_food_generation()

func _on_drink_timer_timeout() -> void:
	attract_food()
	refine_food()
	release_refined_food()
