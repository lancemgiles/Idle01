class_name HandlerGrowthUpgrades extends Node
## Handles growth upgrades and related signals.

## Singelton Reference
static var ref : HandlerGrowthUpgrades

## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
	else: queue_free()

signal upgrade_leveled_up(upgrade: Upgrade)
signal upgrade_unlocked(upgrade: Upgrade)


@onready var u_01_food_generation :  GrowthUpgrade01FoodGenerator = GrowthUpgrade01FoodGenerator.new()

@onready var u_02_food_boost : GrowthUpgrade02FoodBoost = GrowthUpgrade02FoodBoost.new()

@onready var u_03_unlock_drinks : GrowthUpgrade03UnlockDrinks = GrowthUpgrade03UnlockDrinks.new()

func get_all_upgrades() -> Array[Upgrade]:
	return [
		u_01_food_generation,
		u_02_food_boost,
		u_03_unlock_drinks,
	]

func get_all_unlocked_upgrades() -> Array[Upgrade]:
	var list : Array[Upgrade] = []
	for upgrade : Upgrade in get_all_upgrades():
		if upgrade.is_unlocked():
			list.append(upgrade)
	return list
