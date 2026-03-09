class_name TowerData

enum Type { INVALID, WALL, BULLET, MISSILE, BEAM, PULSE }

var display_name: String = ""
var has_turret: bool = false
var type: Type = Type.INVALID # projectile type
var target_range: int = 0 # projectile range
var rate_of_fire: float = 0.0 # number of times per second to fire
var damage_per_hit: int = 0 # hit points to remove from creep on each hit
var sprite_base_texture: Texture2D # stationary 64x64px tower sprite (bottom of z-order)
var sprite_turret_texture: Texture2D # rotating 64x64px sprite (sit on top of base and faces currently targeted creep)
var thumbnail_texture: Texture2D # thumbnail 64x64px - shown in selection area and cursor
var projectile_sprite_texture: Texture2D # used differently depending on tower type
var projectile_sprite_fps: float = 0.0 # speed of animation of projectile (depending on tower type) 

	
