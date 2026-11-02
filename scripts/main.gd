extends Node

const LOVERBOI_INIT_POS = Vector2i(150, 485)
const CAM_INIT_POS = Vector2i(576, 324)
var  score : int
var speed : float
const INIT_VELOCITY : float = 5.0
const MAX_VELOCITY : int = 25
var screen_size : Vector2i

var game_running : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size
	new_game()
	
func new_game():
	score = 0
	$LoverBoy.position = LOVERBOI_INIT_POS
	$LoverBoy.velocity = Vector2i(0,0)
	$Camera2D.position = CAM_INIT_POS
	$Ground.position = Vector2i(0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	if game_running:
		speed = INIT_VELOCITY
		
		$LoverBoy.position.x += speed
		$Camera2D.position.x += speed
		
		score += speed
		show_score()
		
		if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.5:
			$Ground.position.x += screen_size.x #Move ground
	else:
		if Input.is_action_pressed("ui_accept"):
			game_running = true
			$CanvasLayer.get_node("Start").hide()
			
func show_score():
	$CanvasLayer
