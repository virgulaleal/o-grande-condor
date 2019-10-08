extends Node

onready var json_parser = JsonParser

onready var falas: Dictionary = json_parser.load_data("res://assets/data/falas.json")
onready var notifications: Dictionary = json_parser.load_data("res://assets/data/notifications.json")
onready var intros: Dictionary = json_parser.load_data("res://assets/data/intros.json")

func _ready():
	pass#print(emotion_alignment_banter(AmigoManager.player_party[0]))

func get_random_notification() -> String:
	return Random.choose(notifications.notifications)

func emotion_alignment_banter(amigo_unit: Dictionary) -> String:
	var target_species: Dictionary = AmigoManager.amigos[amigo_unit.species]
	var random_alignment: String = Random.choose(target_species.alinhamentos)
	var amigo_emotion: String = amigo_unit.current_sprite
	var possible_falas: Array = falas[amigo_emotion][random_alignment]
	var new_fala = Random.choose(possible_falas)
	return new_fala