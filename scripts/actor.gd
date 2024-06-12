extends CharacterBody2D
class_name Actor

const SCALE = 3
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * SCALE

func flip(current: bool, directionX : int) -> bool:
    if directionX == 1:
        return false
    elif directionX == -1:
        return true
    else:
        return current
