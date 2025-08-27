class_name ViewGrow extends View
## View for displaying colony growth.

@export var growth_up_area : Control 

@export var compo_upgrade_scene : PackedScene 

func _ready() -> void:
	super()
	visible = false
	initialize_upgrades()
	HandlerGrowthUpgrades.ref.upgrade_unlocked.connect(_on_upgrade_unlocked)

func initialize_upgrades() -> void:
	var upgrades : Array[Upgrade] = HandlerGrowthUpgrades.ref.get_all_unlocked_upgrades()
	
	if upgrades.size() == 0:
		return
	
	for upgrade : Upgrade in upgrades:
		var upgrade_node : CompoUpgrade = compo_upgrade_scene.instantiate() as CompoUpgrade
		upgrade_node.upgrade = upgrade
		
		growth_up_area.add_child(upgrade_node)
		
func _on_upgrade_unlocked(_upgrade : Upgrade) -> void:
	for child : Node in growth_up_area.get_children():
		child.queue_free()
		
	initialize_upgrades()
