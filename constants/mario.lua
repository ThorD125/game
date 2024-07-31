window_width = 1280
window_height = 720
virtual_window_width = 256
virtual_window_height = 144


camera_speed = 100
background_scroll_speed = 10

tile_size = 16

tile_screen_width = virtual_window_width / tile_size
tile_screen_height = virtual_window_height / tile_size

tile_set_width = 5
tile_set_height = 4

topper_sets_wide = 6
topper_sets_tall = 18

topper_sets = topper_sets_wide * topper_sets_tall
tile_sets = tile_set_width * tile_set_height


-- player jumping velocity
jump_boost = -150

-- snail movement speed
move_speed = 60
neak_speed = 10

--
-- tile IDs
--
id_tile_empty = 5
id_tile_ground = 3

-- table of tiles that should trigger a collision
tile_collisions = {
    id_tile_ground
}

--
-- game object IDs
--
id_tile_bushes = {
    1, 2, 5, 6, 7
}

id_coin = {
    1, 2, 3
}

crates = {
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
}

gems = {
    1, 2, 3, 4, 5, 6, 7, 8
}

tile_jumps = {}

for i = 1, 30 do
    table.insert(tile_jumps, i)
end