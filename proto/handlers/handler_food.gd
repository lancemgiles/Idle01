class_name HandlerFood extends Node
## Manages food and related signals

## Singelton Reference
static var ref : HandlerFood

## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
	else: queue_free()

signal food_gathered(quantity: int)
signal food_consumed(quantity: int)

## Returns current amount of food.
func food() -> int:
	return Main.ref.data.food

## Gather an amount of food
func gather_food(quantity: int) -> void:
	Main.ref.data.food += quantity
	Main.ref.data.universe.food += quantity
	food_gathered.emit(quantity)

## Use an amount of food.
func consume_food(quantity: int) -> Error:
	if quantity > Main.ref.data.food:
		return Error.FAILED
	else:
		Main.ref.data.food -= quantity
		food_consumed.emit(quantity)
	return Error.OK

func trigger_clicker() -> void:
	var quantity := 1
	quantity += Main.ref.data.up_01_level
	gather_food(quantity)
