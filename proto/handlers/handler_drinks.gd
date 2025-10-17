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

var max_drinks_count := 1

var min_attraction_value := 1
var max_attraction_value := 5
var min_release_value := 1
var max_release_value := 5

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
		new_drink.refined_food = _drink.refined_food
		new_drink.attraction_value = _drink.attraction_value
		new_drink.release_value = _drink.release_value
		new_drink.data = index
		
		timer.timeout.connect(new_drink._on_drink_timer_timeout)
		
		drinks.append(new_drink)

func get_all_drinks() -> Array[Drinks]:
	return drinks


func create_drink() -> Error:
	if drinks.size() >= max_drinks_count:
		return Error.FAILED
	var new_drink : Drinks = Drinks.new()
	new_drink.data_index = drinks.size()
	
	timer.timeout.connect(new_drink._on_drink_timer_timeout)
	drinks.append(new_drink)
	
	var data_drink : DataDrink = DataDrink.new()
	data_drink.name = new_drink.given_name
	data_drink.food = new_drink.food
	data_drink.refined_food = new_drink.refined_food
	data_drink.attraction_value = new_drink.attraction_value
	data_drink.release_value = new_drink.release_value
	Main.ref.data.drinks.append(data_drink)
	
	drink_created.emit()
	return Error.OK

## Change food consumption value for a single drink.
func update_drink_attraction_value(index : int, value : int) -> void:
	drinks[index].attraction_value = value
	Main.ref.data.drinks[index].attraction_value = value

func update_drink_release_value(index : int, value : int) -> void:
	drinks[index].release_value = value
	Main.ref.data.drinks[index].release_value = value
