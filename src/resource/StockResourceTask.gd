class_name StockResourceTask extends Task

var warehouse
var progress = 0

func _init(owner: Dwarf, warehouse).(owner, "StockResourceTask"):
	self.warehouse = warehouse

func process(delta):
	#todo Anweisungen einbauen, alles stocken, nur 1, nur Ware X, etc.
#	todo dauert, bei mehr resourcen länger?
	progress += delta
	if progress > 1:
		owner.stockInto(warehouse)
		finish()

