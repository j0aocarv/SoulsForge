extends Control

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		$AnimationPlayer.play("fade_out")
	elif anim_name == "fade_out":
		get_tree().change_scene_to_file("res://title_screen.tscn")
