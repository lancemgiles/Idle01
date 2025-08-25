class_name CompoUpgrade extends Control
## Component that displays an upgrade.

@export var label_title : Label
@export var label_description : RichTextLabel
@export var button : Button


## Upgrade to display.
var upgrade : Upgrade


func _ready() -> void:
	if not upgrade:
		upgrade = Up01ClickerUpgrade.new()
	
	update_label_title()
	update_label_description()
	update_button()
	HandlerFood.ref.food_gathered.connect(update_button)
	HandlerFood.ref.food_consumed.connect(update_button)
	upgrade.leveled_up.connect(update_label_title)
	upgrade.leveled_up.connect(update_label_description)
	upgrade.leveled_up.connect(update_button)
	

func update_label_title() -> void:
	var text : String = upgrade.title + " (%s)" % upgrade.level
	label_title.text = text

func update_label_description() -> void:
	label_description.text = upgrade.description()
	
func update_button(_quantity : int = -1) -> void:
	if upgrade.can_afford():
		button.disabled = false
	else:
		button.disabled = true


func _on_purchase_button_pressed() -> void:
	upgrade.level_up()
