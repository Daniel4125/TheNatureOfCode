extends Node2D

var velocity = Vector2(0,0)
var current = Vector2(0,0)
var target = Vector2(0,0) # target for agent to move towards
var acceleration = Vector2(0,0)
var force = Vector2(0,0)
const maxSpeed = 4
const maxForce = 0.1

func _ready():
	position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
	scale = Vector2(0.3,0.3)
	randomize() # generates a new seed each time, make rand functions actually random
	var xComp = rand_range(1,get_viewport().size.x)
	var yComp = rand_range(1,get_viewport().size.y)
	target = Vector2(xComp, yComp)
	
	#print("target" + str(target))

func _process(delta):
	seek(target)
	#print("velocity" +str(velocity))
	#print("acceleration" + str(acceleration))
	#print("vel length"+str(velocity.length()))
	
	if velocity.length() < maxSpeed:
		velocity += acceleration
	
	position += velocity
	acceleration * 0
	
	print("position"+str(position))

func seek(target):
	var desired = target - position
	desired.normalized()
	desired * maxSpeed
	
	#print("desired"+str(desired))
	
	#var steer = desired - velocity
	var steer = vecSub(desired, velocity)
	#print("streer"+str(steer))
	
	if force.length() < maxForce: 
		applyForce(steer)
	
	#print("force" + str(force))
	#print(position)

func applyForce(force):
	acceleration += force
	#print("acceleration"+str(acceleration))

func vecSub(vec1, vec2):
	var xComp = vec1.x - vec2.x
	var yComp = vec1.y - vec2.y
	var difference = Vector2(xComp, yComp)
	#print(difference)
	return difference
