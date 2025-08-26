class_name GrowthUpgrade03UnlockDrinks extends Upgrade

var max_level := 1

func _init() -> void:
	level = Main.ref.data.growth_upgrades.u_03_unlock_drinks
	title = "Unlock drinks."
	base_cost = 2
	cost = 2
	
	if is_unlocked() == false:
		HandlerGrowthUpgrades.ref.u_01_food_generation.leveled_up.connect(_on_growth_upgrade_01_level_up)


func description() -> String:
	var text = "[b]Effects: [/b] unlocks the ability to have drinks."
	if level < max_level:
		text += "\n[b]Cost: [/b] %s Growth" % cost
	return text


func can_afford() -> bool:
	if level >= max_level:
		return false
	
	if Main.ref.data.growth >= cost:
		return true

	return false

func level_up() -> void:
	if level >= max_level:
		return
	
	var error : Error = HandlerGrowth.ref.consume_growth(cost)
	if error:
		return
	level += 1
	Main.ref.data.growth_upgrades.u_03_unlock_drinks = true
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
