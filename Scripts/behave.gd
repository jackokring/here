extends Node
# behaviour basis for rigid body AI ... in progress

# verbs
enum {
	# target select from list friends and foes %time
	# move toward target position can call often
	# user to follow player input
	# evade target position maybe reasons
	# protect
}

class Gene:
	var verb: int
	var object: RigidBody2D
