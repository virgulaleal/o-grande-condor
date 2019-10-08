extends Control

signal game_over

var state = states.idle

enum states {
	wait,
	idle,
	friend_encounter,
	special_encounter,
	encounter_choices,
	pachinko,
	drunk_approach,
	pong,
	final_choices,
	game_over
}

const encounter_types: Array = [
	"friend","friend","friend",
	"friend","friend","friend",
	"friend","friend","friend",
	"treasure","treasure",
	"treasure","treasure",
	"cutscene","cutscene"
]

func _ready():
	yield(get_tree().create_timer(1), "timeout")
	# display_encounter_choices()
	determine_route(12)
	friend_encounter()
	for unit in $Trupe.get_children(): if !unit.is_protagonistico:
		var new_friend = AmigoManager.get_random_amigo(1)
		unit.initialize(AmigoManager.amigos[new_friend.species], new_friend)

func _process(delta: float) -> void: match state:
	states.idle:
		pass
	states.encounter_choices:
		if Input.is_action_just_pressed("H"): # chegar bêbado
			pass
		if Input.is_action_just_pressed("J"): # perguntar direções
			state = states.pachinko
		if Input.is_action_just_pressed("K"): # agredir
			state = states.pong

func display_encounter_choices():
	state = states.wait
	SoundManager.play_and_forget("doodaadee")
	$Choices.visible = true
	yield(get_tree().create_timer(0.1), "timeout")
	$Choices/ChegarBebado.visible = true
	yield(get_tree().create_timer(0.4), "timeout")
	$Choices/PerguntarDireccoes.visible = true
	yield(get_tree().create_timer(0.4), "timeout")
	$Choices/Agredir.visible = true
	state = states.encounter_choices

func start_pachinko():
	pass

func start_pong():
	pass

func determine_route(length: int):
	var encounters: Array = []
	var encounter_stack: Array = encounter_types
	for index in length:
		if encounter_stack.size() == 0:
			encounter_stack = encounter_types
			length += 1
		var new_encounter = Random.choose(encounter_stack)
		encounters.append(new_encounter)
		encounter_stack.remove(encounter_stack.find(new_encounter))
	print("Rota de encontros gerada:", encounters)

func friend_encounter():
	var friend_boneco = $EncounterStage/Boneco
	var friend_sprite = $EncounterStage/Boneco/Corpo
	var new_friend = AmigoManager.get_random_amigo(1)
	friend_boneco.visible = false
	friend_boneco.initialize(AmigoManager.amigos[new_friend.species], new_friend)
	friend_sprite.flip_h = true
	$EncounterStage/AnimationPlayer.play("enter_stage_right")
	yield(get_tree().create_timer(0.001), "timeout")
	friend_boneco.visible = true
	

#func change_state(new_state): match state:
#	states.idle:
#		if new_state == 
	