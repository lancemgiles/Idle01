class_name ViewUniverse extends View

@export var intro_text : Label

@export var main_content : MarginContainer


func _ready() -> void:
	super()
	_initialize_view()
	
func _initialize_view() -> void:
	if not Main.ref.data.growth_upgrades.u_01_food_generator_level:
		intro_text.visible = true
		main_content.visible = false
		HandlerGrowthUpgrades.ref.u_01_food_generation.leveled_up.connect(_on_growth_u01_level_up)
	else:
		intro_text.visible = false
		main_content.visible = true
		
func _on_growth_u01_level_up() -> void:
	intro_text.visible = false
	main_content.visible = true
	
	HandlerGrowthUpgrades.ref.u_01_food_generation.leveled_up.disconnect(_on_growth_u01_level_up)
