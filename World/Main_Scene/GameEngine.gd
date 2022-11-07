extends Node2D

enum State {STATE_PLAYER1_TURN, STATE_PLAYER2_TURN, STATE_PLAYER1_FINISHED, STATE_PLAYER2_FINISHED}

# current game status
var game_status = State.STATE_PLAYER1_TURN
# how long the key to change the game status beeing pressed
var hold_to_change_status = 0.0
# prevent the player from switching status two times in a row
var has_key_been_released = true

onready var Player1 = get_node("../Player1/CanvasLayer")
onready var Player2 = get_node("../Player2/CanvasLayer")
onready var PlayerSwitch = get_node("../PlayerSwitch/CanvasLayer")
onready var Load_Circle = get_node("../Load_Canvas/load_circle")
onready var Load_Circle_Canva = get_node("../Load_Canvas")


func circle_set_middle():
	Load_Circle_Canva.set_offset(Vector2(640,650))
	Load_Circle_Canva.set_scale(Vector2(.15,.15))
	
func circle_set_left():
	Load_Circle_Canva.set_offset(Vector2(20,660))
	Load_Circle_Canva.set_scale(Vector2(.1,.1))


func change_game_status():
	print("Game status changed")
	Load_Circle.value = 0
	#match = switch case, _ = default
	match game_status:
		State.STATE_PLAYER1_TURN:
			Player1.visible = false
			Player2.visible = false
			PlayerSwitch.get_node("resume_text").clear()
			PlayerSwitch.get_node("resume_text").add_text("Hold DOWN to resume game for player 2.")
			PlayerSwitch.visible = true
			game_status = State.STATE_PLAYER1_FINISHED
			circle_set_middle()
		State.STATE_PLAYER2_TURN:
			Player1.visible = false
			Player2.visible = false
			PlayerSwitch.get_node("resume_text").clear()
			PlayerSwitch.get_node("resume_text").add_text("Hold DOWN to resume game for player 1.")
			PlayerSwitch.visible = true
			game_status = State.STATE_PLAYER2_FINISHED
			circle_set_middle()
		State.STATE_PLAYER1_FINISHED:
			Player1.visible = false
			Player2.visible = true
			PlayerSwitch.visible = false
			game_status = State.STATE_PLAYER2_TURN
			circle_set_left()
		State.STATE_PLAYER2_FINISHED:
			Player1.visible = true
			Player2.visible = false
			PlayerSwitch.visible = false
			game_status = State.STATE_PLAYER1_TURN
			circle_set_left()
		_ :
			pass

func _ready():
	pass

func _process(var delta):
	# Part to change who's turn it is
	# We look for how long the key was pressed and
	# change the game status according to that
	if Input.is_action_pressed("ui_down"):
		if(has_key_been_released == true):
			hold_to_change_status += delta
			Load_Circle.value = hold_to_change_status * 100
			if (hold_to_change_status > 1.0):
				hold_to_change_status = 0
				change_game_status()
				has_key_been_released = false
	else:
		has_key_been_released = true
		hold_to_change_status = 0
		Load_Circle.value = 0
	#

func _input(event):
	pass
		
