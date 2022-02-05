#!/usr/bin/env -S godot -s
extends SceneTree

func _init():
	var args = OS.get_cmdline_args()
	
	if args.size() <= 2:
		print("args error")
		print(args)
		quit()
		return
	
	var merged_name = args[2]
	
	print("Merge TileSets Start.")
	
	var merged_tileset:TileSet = TileSet.new()
	var new_tile_id:int = 0
	
	var dir = Directory.new()
	
	for i in range(1,100):
		var org_tileset_path = merged_name + '_' + String(i) + '.tres'
		
		if !dir.file_exists(org_tileset_path) and new_tile_id == 0:
			printerr('not exists:' + org_tileset_path)
			break
		print(org_tileset_path)
		
		var org_tileset:TileSet = load(org_tileset_path)
		
		for org_tile_id in org_tileset.get_tiles_ids():
			print(org_tile_id)
			merged_tileset.create_tile(new_tile_id)
			
			merged_tileset.tile_set_name(new_tile_id,org_tileset.tile_get_name(org_tile_id))
			merged_tileset.tile_set_texture(new_tile_id,org_tileset.tile_get_texture(org_tile_id))
			merged_tileset.tile_set_texture_offset(new_tile_id,org_tileset.tile_get_texture_offset(org_tile_id))
			merged_tileset.tile_set_modulate(new_tile_id,org_tileset.tile_get_modulate(org_tile_id))
			merged_tileset.tile_set_region(new_tile_id,org_tileset.tile_get_region(org_tile_id))
			merged_tileset.tile_set_tile_mode(new_tile_id,org_tileset.tile_get_tile_mode(org_tile_id))
			merged_tileset.autotile_set_bitmask_mode(new_tile_id,org_tileset.autotile_get_bitmask_mode(org_tile_id))
			merged_tileset.autotile_set_icon_coordinate(new_tile_id,org_tileset.autotile_get_icon_coordinate(org_tile_id))
			merged_tileset.autotile_set_size(new_tile_id,org_tileset.autotile_get_size(org_tile_id))
			merged_tileset.autotile_set_spacing(new_tile_id,org_tileset.autotile_get_spacing(org_tile_id))
			var coord = _get_subtile_coord(org_tileset,org_tile_id)
			for x in range(0,coord.x) :
				for y in range(0,coord.y) :
					var bitmask := org_tileset.autotile_get_bitmask(org_tile_id,Vector2(x,y))
					merged_tileset.autotile_set_bitmask(new_tile_id,Vector2(x,y),bitmask)
					
					var light_occluder := org_tileset.autotile_get_light_occluder(org_tile_id,Vector2(x,y))
					merged_tileset.autotile_set_light_occluder(new_tile_id,light_occluder,Vector2(x,y))
					
					var subtile_priority := org_tileset.autotile_get_subtile_priority(org_tile_id,Vector2(x,y))
					merged_tileset.autotile_set_subtile_priority(new_tile_id,Vector2(x,y),subtile_priority)
					print(Vector2(x,y))
					pass
				pass

			merged_tileset.tile_set_occluder_offset(new_tile_id,org_tileset.tile_get_occluder_offset(org_tile_id))
			merged_tileset.tile_set_shapes(new_tile_id,org_tileset.tile_get_shapes(org_tile_id))
			
			merged_tileset.tile_set_z_index(new_tile_id,org_tileset.tile_get_z_index(org_tile_id))
			merged_tileset.tile_set_light_occluder(new_tile_id,org_tileset.tile_get_light_occluder(org_tile_id))
			merged_tileset.tile_set_material(new_tile_id,org_tileset.tile_get_material(org_tile_id))
			merged_tileset.tile_set_normal_map(new_tile_id,org_tileset.tile_get_normal_map(org_tile_id))
			merged_tileset.tile_set_navigation_polygon(new_tile_id,org_tileset.tile_get_navigation_polygon(org_tile_id))
			merged_tileset.tile_set_navigation_polygon_offset(new_tile_id,org_tileset.tile_get_navigation_polygon_offset(org_tile_id))
			pass
			new_tile_id = new_tile_id + 1
		pass
		
	ResourceSaver.save(merged_name + '.tres',merged_tileset,ResourceSaver.FLAG_CHANGE_PATH)
	
	print("Merge TileSets End.")
	quit()

func _get_subtile_coord(tileset:TileSet,id:int):
	var rect = tileset.tile_get_region(id)
	var x = int(rect.size.x / tileset.autotile_get_size(id).x)
	var y = int(rect.size.y / tileset.autotile_get_size(id).y)
	return Vector2(x, y)
