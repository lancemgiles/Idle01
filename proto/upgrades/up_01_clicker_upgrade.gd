class_name Up01ClickerUpgrade extends Upgrade
## Upgrade 001 - increases food created by clicker.

func _init() -> void:
	level = Main.ref.data.up_01_level
	title = "Clicker Upgrade"
	base_cost = 5
	calculate_cost()

func description() -> String:
	var _description = "Increases the amount of food created by the clicker."
	_description += "\nEffects: +1 Food per level."
	_description += "\nCost: %s" % cost
	return _description

func calculate_cost() -> void:
	cost = int(base_cost * pow(1.5, level))
	
func can_afford() -> bool:
	if HandlerFood.ref.food() >= cost:
		return true
	else:
		return false

func level_up() -> void:
	var error : Error = HandlerFood.ref.consume_food(cost)
	if not error:
		level +=1
		Main.ref.data.up_01_level = level
		calculate_cost()
		leveled_up.emit()
