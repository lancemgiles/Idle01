class_name HandlerDrinks extends Node
## Manages drinks.

## Singelton Reference
static var ref : HandlerDrinks

## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
	else: queue_free()

signal drink_created

@export var timer : Timer

var drinks : Array[Drinks] = []

func _ready() -> void:
	load_drinks()

func load_drinks() -> void:
	if Main.ref.data.drinks.size() == 0:
		return
		
	drinks = []
	var index := 0
	for _drink : DataDrink in Main.ref.data.drinks:
		var new_drink : Drinks = Drinks.new()
		new_drink.name = _drink.name
		new_drink.food = _drink.food
		new_drink.food_consumed = _drink.food_consumed
		new_drink.data = index
		
		timer.timeout.connect(new_drink._on_consume_food)
		
		drinks.append(new_drink)

func get_all_drinks() -> Array[Drinks]:
	return drinks


func create_drink() -> void:
	var new_drink : Drinks = Drinks.new()
	new_drink.data_index = drinks.size()
	timer.timeout.connect(new_drink._on_consume_food)
	drinks.append(new_drink)
	
	var data_drink : DataDrink = DataDrink.new()
	data_drink.name = new_drink.given_name
	data_drink.food = new_drink.food
	data_drink.food_consumed = new_drink.food_consumed
	Main.ref.data.drinks.append(data_drink)
	
	drink_created.emit()

## Change food consumption value for a single drink.
func update_drink_consumption_value(index : int, value : int) -> void:
	drinks[index].food_consumed = value
	Main.ref.data.drinks[index].food_consumed = value
