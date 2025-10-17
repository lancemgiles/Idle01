class_name HandlerRefinedFood extends Node

## Singelton Reference
static var ref : HandlerRefinedFood

## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
	else: queue_free()
	
signal refined_food_created(quantity : int)
signal refined_food_consumed(quantity : int)

## Returns current amount of food.
func refined_food() -> int:
	return Main.ref.data.refined_food

## Gather an amount of food
func create_refined_food(quantity: int) -> void:
	Main.ref.data.refined_food += quantity
	
	refined_food_created.emit(quantity)

## Use an amount of food.
func consume_refined_food(quantity: int) -> Error:
	if quantity > Main.ref.data.refined_food:
		return Error.FAILED
	else:
		Main.ref.data.refined_food -= quantity
		refined_food_consumed.emit(quantity)
	return Error.OK
