class_name GoToTargetTask extends GoToPointTask

var target: PhysicsBody2D

func get_class(): return "GoToTargetTask/" + str(get_instance_id())

func _init(owner, target: PhysicsBody2D).(owner, target.get_global_position()):
	self.target = target

func moveOwner(motion: Vector2):
	var collision : KinematicCollision2D = owner.move_and_collide(motion)
	if collision && collision.collider == target:
		.finish()
