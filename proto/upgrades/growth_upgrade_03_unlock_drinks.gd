class_name GrowthUpgrade03UnlockDrinks extends Upgrade

var max_level := 1

func _init() -> void:
	level = Main.ref.data.growth_upgrades.u_03_unlock_drinks
	title = "Unlock drinks."
	base_cost = 5
	cost = 5


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
