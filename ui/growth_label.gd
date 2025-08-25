class_name LabelGrowth extends Label
## Displays the amount of growth available.

func _ready() -> void:
	update_label_text()
	HandlerGrowth.ref.growth_created.connect(update_label_text)
	HandlerGrowth.ref.growth_consumed.connect(update_label_text)
	
func update_label_text(_quantity: int = -1) -> void:
	text = "Growth: %s" % HandlerGrowth.ref.growth()
