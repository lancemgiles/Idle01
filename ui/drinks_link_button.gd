extends LinkButton

func _ready() -> void:
	if Main.ref.data.growth_upgrades.u_03_unlock_drinks:
		visible = true
	else:
		visible = false
		HandlerGrowthUpgrades.ref.u_03_unlock_drinks.leveled_up.connect(_on_growth03_level_up)
	
	
func _on_growth03_level_up() -> void:
	visible = true
	HandlerGrowthUpgrades.ref.u_03_unlock_drinks.leveled_up.disconnect(_on_growth03_level_up)
