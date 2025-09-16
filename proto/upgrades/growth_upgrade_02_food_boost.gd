class_name GrowthUpgrade02FoodBoost extends Upgrade
## Increases the amount of food generated per second.

var max_level := 5

func _init() -> void:
	level = Main.ref.data.growth_upgrades.u_02_food_boost_level
	base_cost = 1
	cost = 1
	
	if is_unlocked() == false:
		HandlerGrowthUpgrades.ref.u_01_food_generation.leveled_up.connect(_on_growth_upgrade_01_level_up)
	
func title() -> String:
	var text := "Food Generator Efficiency"
	
	match level:
		0:
			text += " "
		1:
			text += " I"
		2:
			text += " II"
		3:
			text += " III"
		4:
			text += " IV"
		5:
			text += " V"
		
	return text

func description() -> String:
	var text := "Gather more food."
	text += "\nEffects: +1 food/second"
	
	if level < max_level:
		text += "\nCost: %s Growth" % cost
	return text

## Virtual class, must be overwritten.
func can_afford() -> bool:
	if level >= max_level:
		return false
	if Main.ref.data.growth >= cost:
		return true
	return false

## Virtual class, must be overwritten.
func level_up() -> void:
	if level >= max_level:
		return
	
	var error : Error = HandlerGrowth.ref.consume_growth(cost)
	
	if error:
		return
	else:
		level += 1
		Main.ref.data.growth_upgrades.u_02_food_boost_level = level
		leveled_up.emit()
		HandlerGrowthUpgrades.ref.upgrade_leveled_up.emit(self)

## Virtual class, returns whether or not upgrade has been unlocked.
func is_unlocked() -> bool:
	if Main.ref.data.growth_upgrades.u_01_food_generator_level:
		return true
	return false

## Triggered when growth upgrade 01 is purchased, unlocking upgrade 02.
func _on_growth_upgrade_01_level_up() -> void:
	HandlerGrowthUpgrades.ref.u_01_food_generation.leveled_up.disconnect(_on_growth_upgrade_01_level_up)
	HandlerGrowthUpgrades.ref.upgrade_unlocked.emit(self)
	
## Returns if the upgrade has been disabled.
func disabled() -> bool:
	if level >= max_level:
		return true
	else:
		return false
