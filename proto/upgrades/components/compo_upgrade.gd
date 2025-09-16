class_name CompoUpgrade extends Control
## Component that displays an upgrade.

@export var label_title : Label
@export var label_description : RichTextLabel
@export var button : Button

@export var veil : ColorRect

## Upgrade to display.
var upgrade : Upgrade


func _ready() -> void:
	if not upgrade:
		upgrade = Up01ClickerUpgrade.new()
	
	update_component()
	
	if not upgrade.disabled():
		HandlerFood.ref.food_gathered.connect(update_button)
		HandlerFood.ref.food_consumed.connect(update_button)
		upgrade.leveled_up.connect(update_component)
	

func update_component() -> void:
	update_button()
	update_label_title()
	update_label_description()
	update_veil()


func update_label_title() -> void:
	label_title.text = upgrade.title()

func update_label_description() -> void:
	label_description.text = upgrade.description()
	
func update_button(_quantity : int = -1) -> void:
	if upgrade.can_afford():
		button.disabled = false
	else:
		button.disabled = true

func update_veil() -> void:
	if upgrade.disabled():
		veil.visible = true
	else:
		veil.visible = false


func _on_purchase_button_pressed() -> void:
	upgrade.level_up()

## Upgrade compoent and check if the signals still need to be connected.
func _on_upgrade_level_up() -> void:
	update_component()
	
	if upgrade.disabled():
		HandlerFood.ref.food_gathered.disconnect(update_button)
		HandlerFood.ref.food_consumed.disconnect(update_button)
		upgrade.leveled_up.disconnect(update_component)
	
