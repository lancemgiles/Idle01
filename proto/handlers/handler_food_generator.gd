class_name HandlerFoodGenerator extends Node
## Passively generates food.

## Singelton Reference
static var ref : HandlerFoodGenerator

var generator_power := 1
signal generator_power_calculated

## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
	else: queue_free()

@export var timer : Timer

func _ready() -> void:
	calculate_generator_power()
	HandlerGrowthUpgrades.ref.upgrade_leveled_up.connect(watch_for_upgrades_level_up)
	HandlerDrinks.ref.drink_effect_updated.connect(_on_drink_effect_updated)
	
	if Main.ref.data.growth_upgrades.u_01_food_generator_level:
		timer.start()
		return
	else:
		HandlerGrowthUpgrades.ref.u_01_food_generation.leveled_up.connect(watch_for_growth01_level_up)
	

func watch_for_upgrades_level_up(upgrade: Upgrade) -> void:
	calculate_generator_power()

func watch_for_growth01_level_up() -> void:
	timer.start()
	HandlerGrowthUpgrades.ref.u_01_food_generation.leveled_up.disconnect(watch_for_growth01_level_up)
	

func _on_drink_effect_updated() -> void:
	calculate_generator_power()

func calculate_generator_power() -> void:
	var new_power := 1
	new_power += Main.ref.data.growth_upgrades.u_02_food_boost_level
	new_power += HandlerDrinks.ref.effect_food_generation
	
	generator_power = new_power
	generator_power_calculated.emit()


func _on_timer_timeout() -> void:
	HandlerFood.ref.gather_food(generator_power)
	
	
