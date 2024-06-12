extends Actor

const SLIME_SPEED = 100 * SCALE

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right_down: RayCast2D = $RayCastRightDown
@onready var ray_cast_left_down: RayCast2D = $RayCastLeftDown

var direction : Vector2 

func _ready() -> void:
    set_physics_process(true)
    direction = Vector2(-1,0)

func _physics_process(delta: float) -> void:
    
    direction.x = check_for_edge(ray_cast_right, 
                                  ray_cast_left, 
                                  ray_cast_right_down, 
                                  ray_cast_left_down,
                                  direction.x) 
    
    velocity = calculate_movement(direction, velocity)
    
    animated_sprite.flip_h = flip(animated_sprite.flip_h, direction.x)
    print("enabled!")
    move_and_slide()

func calculate_movement(direction : Vector2, velocity : Vector2) -> Vector2:
    if not is_on_floor():
        velocity.y += gravity * get_physics_process_delta_time() 
    
    if direction.x == 0:
        velocity.x = move_toward(velocity.x, 0, SLIME_SPEED)
    else:
        velocity.x = direction.x * SLIME_SPEED 
            
    return velocity

func check_for_edge(ray_right : RayCast2D,
                    ray_left : RayCast2D,
                    ray_right_down : RayCast2D,
                    ray_left_down : RayCast2D,
                    current: int) -> int:
    if ray_cast_right.is_colliding()\
       or not ray_cast_right_down.is_colliding():
        return -1
    elif ray_cast_left.is_colliding()\
       or not ray_cast_left_down.is_colliding():
        return 1
    else: 
        return current


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
    print("exited!")
