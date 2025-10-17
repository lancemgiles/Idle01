class_name RefinedFoodLabel extends Label
## Displays current amount of food available.

func _ready() -> void:
	update_label_text()
	HandlerRefinedFood.ref.refined_food_created.connect(update_label_text)
	HandlerRefinedFood.ref.refined_food_consumed.connect(update_label_text)
	
func update_label_text(_quantity: int = -1) -> void:
	if HandlerRefinedFood.ref.refined_food():
		text = "Refined: %s" % HandlerRefinedFood.ref.refined_food()
	else:
		text = " "
