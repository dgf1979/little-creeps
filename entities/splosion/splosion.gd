class_name Splosion
extends Node2D

@export var splosion_texture: Texture2D
@export var animation_speed: float
@export var blast_radius: int = 99
@export var damage: int = 99

const SPLODE = "splode"

func _ready() -> void:
	assert(splosion_texture, "splosion_texture required")
	assert(animation_speed, "animation_speed required")
	assert(blast_radius, "blast_radius required")
	assert(damage, "damage required")
	
	($BlastArea/BlastRadius.shape as CircleShape2D).radius = blast_radius
	
	var sprite_frames = SpriteFrames.new()
	sprite_frames.add_animation(SPLODE)
	sprite_frames.set_animation_speed(SPLODE, animation_speed)
	sprite_frames.set_animation_loop(SPLODE, false)
	
	var atlas_textures: Array[Texture2D] = Utils.unpack_sprite_sheet(splosion_texture)

	#remaining frames are the animation that gets played when missle is in flight
	for atlas_texture in atlas_textures:
		sprite_frames.add_frame(SPLODE, atlas_texture)

	$SplosionAnimation.sprite_frames = sprite_frames	
	$SplosionAnimation.play(SPLODE)
	
	await get_tree().physics_frame # have to wait for physics to process (needed 2 frames, apparently)
	await get_tree().physics_frame
	var targets: Array[Area2D] = $BlastArea.get_overlapping_areas()
	Event.splode.emit(targets, damage)
	
func _on_splosion_animation_animation_finished() -> void:
	queue_free()
