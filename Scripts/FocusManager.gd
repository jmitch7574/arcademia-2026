class_name FocusManager
extends Node

enum POSITION{
	BOARD,
	SHOP,
	PERKS
}

## Available Player Options
enum PLAYER{
	ONE,
	TWO,
	PANDORA
}

## The Node 2D this script is managing
@export var mouse_object : Node2D

## Which player this mouse is for
@export var player : PLAYER
var input_prefix : String

## Which area in the game the pointer is currently focused on
var location : POSITION = POSITION.BOARD

## The start position of the mouse (Top Left Corner for now)
static var START_POSITION = Vector2(500, 75)
var grid_position = Vector2(0, 0)

## The first element in the shop, the reroll
@export var shop_elements : Control

## The parent of the perks,  for going to the first child
@export var perks_parent : Control

## If the mouse is in the UI, track its focused control
var focused_control : Control

## Time Between Movement Commands
var movement_cooldown : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_mouse(START_POSITION)
	input_prefix = "p1" if player == PLAYER.ONE else "p2"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed(input_prefix + "_accept") and focused_control is InteractableControl:
		focused_control._on_press()
	
	movement_cooldown -= delta
	var movement : Vector2 = Input.get_vector(input_prefix + "_move_left", 
											  input_prefix + "_move_right", 
											  input_prefix + "_move_up", 
											  input_prefix + "_move_down")
	
	if movement.length() != 0 and movement_cooldown <= 0:
		movement_cooldown = 0.2
		
		if location == POSITION.SHOP:
			if movement.y == -1:
				move_mouse_grid(Vector2(0, 6))
				return
			
			var new_child_index = clamp(focused_control.get_index() + movement.x, 0, focused_control.get_parent().get_child_count() - 1)
			var new_control = focused_control.get_parent().get_child(new_child_index)
			move_mouse_to_control(new_control)
			
		
		if location == POSITION.BOARD:
			if grid_position.y == 6 and movement.y == 1:
				move_to_shop()
				return
			
			if grid_position.x == 0 and movement.x == -1:
				move_to_perks()
				return
			
			grid_position += movement
			grid_position.x = clamp(grid_position.x, 0, 4)
			grid_position.y = clamp(grid_position.y, 0, 6)
			move_mouse_grid(grid_position)

## Move the mouse to the provided position
func move_mouse(newPosition : Vector2):
	mouse_object.position = newPosition
	
## Move the grid to the grid tile
func move_mouse_grid(newPosition : Vector2):
	grid_position = newPosition
	mouse_object.position = START_POSITION + (grid_position * 102)
	location = POSITION.BOARD
	focused_control = null

func move_mouse_to_control(control : Control):
	move_mouse(control.get_global_rect().get_center())
	focused_control = control
	
func move_to_shop():
	location = POSITION.SHOP
	move_mouse_to_control(shop_elements.get_child(0))

func move_to_perks():
	pass
