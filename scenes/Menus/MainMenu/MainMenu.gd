extends Control

var state = states.idle
enum states {
	idle,
	cargando,
	deserto,
	amigopedia,
	portiolli,
	pachinko
}

var current_menu

const cargando = preload("res://scenes/Menus/Cargando/Cargando.tscn")
const menu_identidade = preload("res://scenes/Menus/DeclareIdentidade/DeclareIdentidade.tscn")
const menu_deserto = preload("res://scenes/Deserto/Deserto.tscn")
const menu_amigopedia = preload("res://scenes/Amigopedia/Amigopedia.tscn")
const menu_portiolli = preload("res://scenes/Menus/CelsoPortiolli/CelsoPortiolli.tscn")
const pachinko = preload("res://scenes/Pachinko/Pachinko.tscn")

func _ready():
	pass

func _process(delta: float) -> void: match state:
	states.idle:
		if Input.is_action_just_pressed("J"):
			SoundManager.play_and_forget("confirm", 0, rand_range(0.8, 1.2))
			yield(cargar(), "completed")
			change_menu(menu_identidade)
			state = states.deserto
		if Input.is_action_just_pressed("Z"):
			SoundManager.play_and_forget("confirm", 0, rand_range(0.8, 1.2))
			yield(cargar(), "completed")
			change_menu(menu_amigopedia)
			state = states.amigopedia
		if Input.is_action_just_pressed("X"):
			SoundManager.play_and_forget("confirm", 0, rand_range(0.8, 1.2))
			yield(cargar(), "completed")
			change_menu(menu_portiolli)
			state = states.portiolli
		if Input.is_action_just_pressed("I"):
			SoundManager.play_and_forget("back", 0, rand_range(0.8, 1.2))
			yield(get_tree().create_timer(0.55), "timeout")
			get_tree().quit()
	states.portiolli:
		if Input.is_action_just_pressed("X"):
			SoundManager.play_and_forget("back", 0, rand_range(0.8, 1.2))
			$MenuStage.remove_child(current_menu)
			current_menu = null
			state = states.idle
	states.pachinko:
		if Input.is_action_just_pressed("X"):
			SoundManager.play_and_forget("back", 0, rand_range(0.8, 1.2))
			$MenuStage.remove_child(current_menu)
			current_menu = null
			state = states.idle
	states.amigopedia:
		if Input.is_action_just_pressed("K"):
			SoundManager.play_and_forget("back", 0, rand_range(0.8, 1.2))
			$MenuStage.remove_child(current_menu)
			current_menu = null
			state = states.idle

func change_menu(menu):
	if current_menu:
		$MenuStage.remove_child(current_menu)
	current_menu = menu.instance()
	$MenuStage.add_child(current_menu)

func cargar(loops = 0):
	var cargando_instance = cargando.instance()
	var cargando_sprite
	state = states.cargando
	$MenuStage.add_child(cargando_instance)
	cargando_sprite = cargando_instance.get_node("AnimatedSprite")
	cargando_sprite.frame = 0
	cargando_sprite.scale.y = 1.25
	cargando_sprite.rotation_degrees = Random.choose([0, 90, 180, 270])# rand_range(0, 360)
	cargando_sprite.play("default")
	yield(get_tree().create_timer(2.25), "timeout")
	$MenuStage.remove_child(cargando_instance)
