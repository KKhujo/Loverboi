extends CharacterBody2D

const SPEED = 300.0
const GRAVITY = 4200
const JUMP_VELOCITY = -1400

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		if not get_parent().game_running:
			$AnimatedSprite2D.play("idle")
		else:
			
			$RunCollision.disabled = false
			if Input.is_action_just_pressed ("ui_accept"):
				velocity.y = JUMP_VELOCITY
			else:
				$AnimatedSprite2D.play("run")
	else:
			$AnimatedSprite2D.play("jump")
			$RunCollision.disabled = true

	move_and_slide()
