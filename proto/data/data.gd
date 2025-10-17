class_name Data extends Resource
## Contains data to save and load.

@export var food := 0

@export var refined_food := 0

@export var growth := 1

@export var growth_upgrades : DataGrowthUpgrades = DataGrowthUpgrades.new()

@export var universe : DataUniverse = DataUniverse.new()

@export var drinks : Array[DataDrink] = []
