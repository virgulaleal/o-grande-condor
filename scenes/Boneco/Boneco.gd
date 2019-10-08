extends Node2D

export(bool) var is_protagonistico = false
export(bool) var force_type = false
export(String, "rappi", "raissa") var protagonistico_type = "rappi"
export(String) var friend_id = ""

var default_unit: Dictionary = {
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
	"signo": "nenhum"
}

# onready var amigos = JsonParser.load_data("res://assets/data/amigos.json")

func _ready():
	if is_protagonistico:
		initialize_protagonistico()
	$Corpo/AnimationPlayer.play("shuffle001")
	pass
	#initialize(Random.choose(["topeiro", "desempreguitos", "focafoca", "amiga", "crash", "sharkboy"]))
	#yield(get_tree().create_timer(rand_range(0, 1.1)), "timeout")
	#$Corpo/AnimationPlayer.play("shuffle001")

func initialize(species_data: Dictionary, unit_data: Dictionary = default_unit):
	var new_sprite: Texture
	var sprite_variance = Random.choose(species_data.sprites[unit_data.current_sprite])
	new_sprite = load(sprite_variance)
	$Corpo.texture = new_sprite
	$Corpo.offset.y = -$Corpo.texture.get_height() / 2
	$Corpo.scale = Vector2(unit_data.scale / unit_data.finura, unit_data.scale / unit_data.baixura)
	$Corpo/AnimationPlayer.playback_speed = unit_data.pressa

func initialize_protagonistico():
	var new_sprite: Texture
	var protagonistico_sprites: Dictionary = {
		"rappi": "res://assets/bonecos/protagonistico/ifood1.png",
		"raissa": "res://assets/bonecos/protagonistico/raissa3.png"
	}
	if force_type:
		new_sprite = load(protagonistico_sprites[protagonistico_type])
	else:
		new_sprite = load(protagonistico_sprites[AmigoManager.protagonistico_type])
	$Corpo.texture = new_sprite
	$Corpo.offset.y = -$Corpo.texture.get_height() / 2
	$Corpo.scale = Vector2(0.5,0.5)