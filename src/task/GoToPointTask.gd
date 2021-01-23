class_name GoToPointTask extends Task

const MAX_SPEED : float = 90.0

var displayTask : bool = true
var startLocation  : Vector2
var targetLocation : Vector2
var path 		   : PoolVector2Array = PoolVector2Array()
var equipment

func get_class(): return "GoToPointTask/" + str(get_instance_id())

func _init(owner: Dwarf, targetLoc: Vector2, equipment = "").(owner):
	self.targetLocation = targetLoc
	self.equipment = equipment

func start():
	self.startLocation = owner.get_global_position()
	var navigation = owner.get_node("../..")
	path = navigation.get_simple_path(owner.get_global_position(), targetLocation, true)
	print("path: " + str(path.size()))

func process(delta):
	pass

func physicsProcess(delta):
	if path.empty():
		finish()
		print("GoTo finished")
	else:
		var moveDistance = MAX_SPEED * delta
		var targetPosition = determineTargetPosition(moveDistance)
		var motion = targetPosition - owner.position
		var animation = getAnimationDirection(motion)
		
		owner.updateAnimation(animation)
		moveOwner(motion)

func getAnimationDirection(motion: Vector2) -> String:
	var animationDirection
	
	var norm_direction = motion.normalized()
	if norm_direction.y >= 0.707:
		animationDirection = "down" 
	elif norm_direction.y <= -0.707:
		animationDirection = "up"
	elif norm_direction.x <= -0.707:
		animationDirection = "left"
	elif norm_direction.x >= 0.707:
		animationDirection = "right"
	else:
		 animationDirection = ""
		
	if equipment:
		animationDirection = animationDirection + "_" + equipment
	return animationDirection 

func moveOwner(motion: Vector2):	# TODO: has to be done in _physics_process
	owner.move_and_collide(motion)

func determineTargetPosition(distance: float) -> float : 
	var currentPoint = owner.position
	while path.size():
		var distanceToNext = currentPoint.distance_to(path[0])
		if distance <= distanceToNext:
			currentPoint = currentPoint.linear_interpolate(path[0], distance / distanceToNext)
			break
		distance -= distanceToNext
		currentPoint = path[0]
		path.remove(0)
	return currentPoint

func display():
	if displayTask:
		var position = owner.position
		var ownerSize = owner.get_node("Collision").position;
		
		var last = owner.get_global_position()
		var index = 0;
		for i in path:
			var from = last - position
			var to = i - position
			
			owner.draw_line(from, to, Color.blue.darkened(1.0 * index/path.size()), 1)
			last = i
			index += 1
