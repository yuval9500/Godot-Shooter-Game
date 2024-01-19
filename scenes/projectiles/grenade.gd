extends RigidBody2D

@export var speed = 750

func explode():
	linear_velocity = Vector2.ZERO
	rotation = 0
	set_deferred('lock_rotation', true)
	$AnimationPlayer.play("Explosion")

func hit():
	explode()
