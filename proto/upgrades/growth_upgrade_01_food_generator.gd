class_name GrowthUpgrade01FoodGenerator extends Upgrade
## Unlocks the passive food generator.

var max_level := 1

func _init() -> void:
	level = Main.ref.data.growth_upgrades.u_01_food_generator_level
	title = "Graze"
	base_cost = 1
	calculate_cost()

func description() -> String:
	var text := "Eat continuously."
	text += "\n[b]Effect: [/b] passive food gathering"
	if level < max_level:
		text += "\n[b]Cost: [b] %s Growth" % cost
	return text

func calculate_cost() -> void:
	cost = base_cost

func can_afford() -> bool:
	if level >= max_level: return false
	if Main.ref.data.growth >= cost:
		return true
	else: return false

func level_up() -> void:
	if level >= max_level:
		return
	else:
		var error : Error = HandlerGrowth.ref.consume_growth(cost)
		if error:
			return
		else:
			level += 1
			Main.ref.data.growth_upgrades.u_01_food_generator_level = true
			leveled_up.emit()
			HandlerGrowthUpgrades.ref.upgrade_leveled_up.emit(self)
			
## Virtual class, returns whether or not upgrade has been unlocked.
func is_unlocked() -> bool:
	return true
