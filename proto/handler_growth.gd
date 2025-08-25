class_name HandlerGrowth extends Node
## Handles growth and related signals.

## Singelton Reference
static var ref : HandlerGrowth

## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
	else: queue_free()

signal growth_created(quantity: int)

signal growth_consumed(quantity: int)

func growth() -> int:
	return Main.ref.data.growth
	
func create_growth(quantity: int) -> void:
	Main.ref.data.grwoth += quantity
	growth_created.emit(quantity)
	
func consume_growth(quantity: int) -> Error:
	if quantity > Main.ref.data.growth:
		return Error.FAILED
	else:
		Main.ref.data.growth -= quantity
		growth_consumed.emit(quantity)
		return Error.OK
