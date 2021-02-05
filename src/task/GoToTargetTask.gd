class_name GoToTargetTask extends GoToPointTask

#---------------------------------------------------- Preload
#---------------------------------------------------- Parameters
var target: PhysicsBody2D

#---------------------------------------------------- Initialize
func _init(owner, target: PhysicsBody2D).(owner, target.get_global_position()):
	self.target = target

#---------------------------------------------------- Public Methods
func moveOwner(motion: Vector2):
	var collision : KinematicCollision2D = owner.move_and_collide(motion)
	if collision && collision.collider == target:
		.finish()

#---------------------------------------------------- Abstract Methods
#---------------------------------------------------- Private Methods
#---------------------------------------------------- Inner Classes
#---------------------------------------------------- End
