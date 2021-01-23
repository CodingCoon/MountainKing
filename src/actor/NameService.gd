class_name NameService extends Node

var femaleFirstNames = [
	"Balyndis", "Bilba", "Bylanta",
	"Fyrna",
	"Goda",
	"Myrmianda",
	"Sanda", "Saphira",
	"Xamtys"
	]

var maleFirstNames = [
	"Bandaàl", "Balyndar", "Barskalin", "Balendilin", "Baigar", "Bavragor", "Balodil", "Bandilor",
		"Bulingar", "Beldobin", "Bramdal",   
		"Bislipur", "Bilandal", "Bendelbar",
		"Boindil", "Boendal", "Boendalin",
	"Diemo",
	"Frandibar", "Fidelgar", "Feldolin", 
	"Gandogar", "Giselbart", "Ginsgar", "Glaimbli",
		"Gemmil", "Gufgar", "Glaimbar", "Gremdulin", "Gundrabur", "Glandallin", 
		"Goimslin", "Gordislan", "Goimgar", "Gondagar",
	"Hargorin",
	"Ingbar",
	"Jarkalin",
	"Lorimbas",
	"Manon", "Malbalor",
	"Romo", "Rognor",
	"Salfalur", "Sigdal",
	"Tungdil", "Theogil", "Tandibur",
	"Veltage",
	"Xamtor"
	]

var lastNames = [
	"Ambosskraft", "Alabasterhaut",
	"Bitterfaust",
	"Eisenfinger", "Edelhaupt", "Einarm", "Eisenauge", "Eisenbeiß",
	"Feuermut",
	"Goldhand", "Glüheisen",
	"Harthand", "Hammerfaust", "Hammerschlag",
	"Juwelengreif",
	"Karfunkelaug",
	"Lichthammer",
	"Machtschlag", "Meisterklinge", "Metzhammer",
	"Onyxauge",
	"Pinnhand",
	"Rubinrot",
	"Scharfklinge", "Schachtstolz", "Schimmerbart", "Schildbrech", "Schwielenfaust", 
			"Schlagkraft", "Schleifenstein", "Schmalfinger", "Schnellhand",
			"Schwarzfaust", "Schwertritt", 
		"Sicherschlag", "Silberbart", "Sterbenshieb", "Sternenfaust", "Stahlherz", 
	"Trotzstirn", "Todbringer", "Todkling",
	"Ungewalt",
	"Vierhand",
	"Weißhaupt", "Weißauge",
	"Zweiklinge"
	]

func getName(male = true) -> String:
	var generator = RandomNumberGenerator.new()
	generator.randomize()
	
	var firstName
	if male: 
		firstName = maleFirstNames[generator.randi_range(0, maleFirstNames.size() -1)]
	else:
		firstName = femaleFirstNames[generator.randi_range(0, femaleFirstNames.size() -1)]
	
	var lastName = lastNames[generator.randi_range(0, lastNames.size() -1)]
	return firstName + " " + lastName
