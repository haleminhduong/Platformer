extends Actor

const SPEED : float = 200.0 * SCALE
const JUMP_VELOCITY : float = -300.0 * SCALE

var double_jump_ready : bool = true

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
    
func _physics_process(delta: float) -> void:
    
    
    var direction : Vector2 = get_direction()
    
    velocity = calculate_movement(direction, velocity)
            
    animated_sprite.flip_h = flip(animated_sprite.flip_h, direction.x)
    move_and_slide()
    #print(direction.x, direction.y)
    
func get_direction() -> Vector2:
    var directionX : int = Input.get_axis("move_left","move_right")
    var directionY : int 
    if Input.is_action_just_pressed("jump"):
        directionY = -1
    elif Input.is_action_just_released("jump"):
        directionY = 1
    else:
        directionY = 0
    return Vector2(directionX, directionY)
    
func calculate_movement(direction : Vector2, velocity : Vector2) -> Vector2:
    if not is_on_floor():
        velocity.y += gravity * get_physics_process_delta_time() 
    else: double_jump_ready = true
    
    if direction.y == -1:
        if is_on_floor():
            velocity.y = JUMP_VELOCITY
        if not is_on_floor() and double_jump_ready:
            velocity.y = JUMP_VELOCITY
            double_jump_ready = false
    
    if direction.y == 1 and velocity.y < 0:
        velocity.y = 0.0
    
    if direction.x == 0:
        velocity.x = move_toward(velocity.x, 0, SPEED)
    else:
        velocity.x = direction.x * SPEED
            
    return velocity
    
func flip(current: bool, directionX : int) -> bool:
    if directionX == 1:
        return false
    elif directionX == -1:
        return true
    else:
        return current
    
#func _physics_process(delta: float) -> void:
#    
#    if Input.is_action_just_pressed("jump") and is_on_floor():
#        velocity.y = JUMP_VELOCITY
#
#    var direction : int = Input.get_axis("move_left", "move_right")
#    
#    if not is_on_floor(): 
#        velocity.y += gravity * delta
#        
#    if direction == 1:
#        animated_sprite.flip_h = false
#        velocity.x = direction * SPEED
#    elif direction == -1:
#        animated_sprite.flip_h = true
#        velocity.x = direction * SPEED
#    else:
#        velocity.x = move_toward(velocity.x, 0, SPEED)
#    
#    move_and_slide()
