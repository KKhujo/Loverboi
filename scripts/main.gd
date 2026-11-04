extends Node

var  boulder = preload("res://scenes/boulder.tscn")
var cow = preload("res://scenes/cow.tscn")
var monds = preload("res://scenes/monds.tscn")

var obstacles_types := [boulder, cow]
var obstacles : Array
var monds_height := [200,-13]
const LOVERBOI_INIT_POS = Vector2i(150, 485)
const CAM_INIT_POS = Vector2i(576, 324)
var speed : float
const INIT_VELOCITY : float = 5.0
const MAX_VELOCITY : int = 25
var screen_size : Vector2i
var ground_height : int
var last_obs 
var game_running : bool

var score := 0
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	new_game()
	
func new_game():
	$LoverBoy.position = LOVERBOI_INIT_POS
	$LoverBoy.velocity = Vector2i(0,0)
	$Camera2D.position = CAM_INIT_POS
	$Ground.position = Vector2i(0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	if game_running:
		speed = INIT_VELOCITY
		
		generate_obs()
		
		$LoverBoy.position.x += speed
		$Camera2D.position.x += speed
		
		show_score()
		
		if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.5:
			$Ground.position.x += screen_size.x #Move ground
	else:
		if Input.is_action_pressed("ui_accept"):
			game_running = true
			$CanvasLayer.get_node("Start").hide()
			
func generate_obs():
	if obstacles.is_empty() or last_obs.position.x < $Camera2D.position.x + randi_range(300, 500):
		var obs_type = obstacles_types[randi() % obstacles_types.size()]
		var obs = obs_type.instantiate()
		var obs_height = obs.get_node("Sprite2D").texture.get_height()
		var obs_scale = obs.get_node("Sprite2D").scale
		var obs_x: int = $Camera2D.position.x + screen_size.x
		var obs_y :int = screen_size.y - ground_height -(obs_height * obs_scale.y / 2) + 5
		last_obs = obs
		
		add_obs(obs, obs_x, obs_y)
		
		if (randf() < 0.8):
			obs = monds.instantiate()
			obs_x = $Camera2D.position.x + screen_size.x
			obs_y = monds_height.pick_random()
			add_obs(obs, obs_x, obs_y)
		

func add_obs(obs, x, y):
	obs.position = Vector2i(x, y)
	add_child(obs)
	obstacles.append(obs)
			
func show_score():
	$CanvasLayer
	
