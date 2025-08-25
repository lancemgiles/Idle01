class_name FoodLabel extends Label
## Displays current amount of food available.

func _ready() -> void:
	update_label_text()
	HandlerFood.ref.food_gathered.connect(update_label_text)
	HandlerFood.ref.food_consumed.connect(update_label_text)
	
func update_label_text(_quantity: int = -1) -> void:
	text = "Food: %s" % HandlerFood.ref.food()
