class_name Warehouse extends StaticBody2D

var stock : Dictionary

# reserve

func getTarget():
	return $Target.get_global_position()

func store(resourceType, amount):
	if stock.has(resourceType):
		stock[resourceType] += amount
	else:
		stock[resourceType] = amount
	
	print("Stock nun mit " + str(amount) + " " + str(resourceType))

func getResource(resourceType, amount):
	pass
