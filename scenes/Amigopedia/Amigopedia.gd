extends Control

var state = states.idle
enum states {
	idle,
	ficha
}

onready var amigos: Dictionary = JsonParser.load_data("res://assets/data/amigos.json")

func _ready():
	var randomigo = Random.choose([
		"topeiro",
		"desempreguitos",
		"focafoca",
		"amiga",
		"crash",
		"sharkboy"
	])
	show_sheet(randomigo)

func _process(delta: float) -> void: match state:
	states.idle:
		pass
	states.ficha:
		if Input.is_action_just_pressed("H"):
			SoundManager.play_and_forget("back", 0, rand_range(0.8, 1.2))

func show_sheet(id):
	state = states.ficha
	$Content/FichadeAmigo.visible = true
	$Content/FichadeAmigo/NameLabel.text = amigos[id].nome
	$Content/FichadeAmigo/SpeciesLabel.text = amigos[id].especie
	$Content/FichadeAmigo/RarityLabel.text = amigos[id].raridade
	$Content/FichadeAmigo/BioLabel.text = amigos[id].bio
	$Content/FichadeAmigo/Boneco.initialize(amigos[id])
	$Content/FichadeAmigo/Boneco/Corpo/AnimationPlayer.play("shuffle001")