extends Node

var player_party: Array # of amigo_units
var amigo_unit: Dictionary = {
	"species": "focafoca",
	"default_sprite": "normal",
	"current_sprite": "normal",
	"scale": 0.5,
	"finura": 1,
	"baixura": 1,
	"pressa": 1,
	"walk_animation": "shuffle001",
	"max_eggs": 1,
	"eggs": 1,
	"signo": "nenhum",
	"sabor": "normal"
}
var protagonistico_type: String = "rappi"

onready var amigos: Dictionary = JsonParser.load_data("res://assets/data/amigos.json")
onready var signos: Dictionary = JsonParser.load_data("res://assets/data/signos.json")

func _ready():
	player_party.append(generate_amigo("topeiro"))
	print("Amigo pseudoaleatorio: ", get_random_amigo_id(1))
	print("Amigo pseudoaleatorio: ", get_random_amigo_id(1))
	print("Amigo pseudoaleatorio: ", get_random_amigo_id(1))
	print("Amigo pseudoaleatorio: ", get_random_amigo_id(1))
	print("Amigo pseudoaleatorio: ", get_random_amigo_id(1))
	print("Amigo pseudoaleatorio: ", get_random_amigo_id(1))
	print("Amigo pseudoaleatorio: ", get_random_amigo_id(1))
	#debug_print_party()

func get_random_amigo(rarity: int = 3, force: bool = false, force_id: String = ""):
	return generate_amigo(get_random_amigo_id(rarity, force, force_id))

func get_random_amigo_id(rarity: int = 3, force: bool = false, force_id: String = ""):
	var random_id: String = "erro"
	var valid_amigos: Array = []
	var shit: Dictionary = {}
	var valid_weights: Array = []
	for amigo_key in amigos:
		var amigo = amigos[amigo_key]
		if int(amigo.raridade_nivel) >= rarity:
			valid_amigos.append(String(amigo.id))
			valid_weights.append(int(amigo.raridade_nivel))
	random_id = Random.choose(valid_amigos, valid_weights)
	return random_id

func debug_print_party():
	print(player_party)

func generate_amigo(id) -> Dictionary:
	var new_amigo_data: Dictionary
	var new_amigo: Dictionary
	new_amigo_data = amigos[id]
	new_amigo = amigo_unit
	new_amigo.species = id
	new_amigo.default_sprite = get_random_sprite()
	new_amigo.current_sprite = new_amigo.default_sprite
	new_amigo.scale = get_random_scale()
	new_amigo.finura = get_random_finura()
	new_amigo.baixura = get_random_finura()
	new_amigo.pressa = get_random_pressa()
	new_amigo.signo = get_random_signo()
	new_amigo.sabor = get_random_sabor()
	new_amigo.max_eggs = Random.roll("3d6")
	new_amigo.eggs = new_amigo.max_eggs
	return new_amigo

func get_random_sprite() -> String:
	var sprite_odds = ["normal", "triste", "raiva", "contente"]
	var sprite_weights = [1, 1, 1, 1]
	return Random.choose(sprite_odds, sprite_weights)

func get_random_scale() -> float:
	var scale_odds = [0.3, 0.45, 0.5, 0.55, 0.7, 0.8, 0.9, 1]
	var scale_weights = [1, 50, 100, 10, 3, 2, 1, 1]
	return Random.choose(scale_odds, scale_weights)

func get_random_finura() -> float:
	var finura_odds = [1, 1.5, 2, 3]
	var finura_weights = [94, 3, 2, 1]
	return Random.choose(finura_odds, finura_weights)

func get_random_pressa() -> float:
	return rand_range(0.5, 1.5)

func get_random_signo() -> String:
	var new_kwargs: Array = []
	var new_odds: Array = []
	var result: String = "nenhum"
	for item in signos.normais:
		new_kwargs.append(item[0])
		new_odds.append(item[1])
	result = Random.choose(new_kwargs, new_odds)
	return result

func get_random_sabor() -> String:
	var sabor = "normal"
	var new_sabores = [
		"morango",
		"banana",
		"limão",
		"uva",
		"goiaba",
		"laranja",
		"menta",
		"mistério"
	]
	var new_odds = [10, 10, 10, 10, 10, 10, 10, 1]
	if Random.prob(0.05):
		sabor = Random.choose(new_sabores, new_odds)
	print(sabor)
	return sabor