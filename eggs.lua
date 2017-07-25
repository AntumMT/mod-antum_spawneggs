--[[ LICENSE HEADER
  
  MIT License
  
  Copyright © 2017 Jordan Irwin
  
  Permission is hereby granted, free of charge, to any person obtaining a copy of
  this software and associated documentation files (the "Software"), to deal in
  the Software without restriction, including without limitation the rights to
  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
  of the Software, and to permit persons to whom the Software is furnished to do
  so, subject to the following conditions:
  
    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
  
--]]



antum.spawneggs.addEggRecipe = function(name, spawn, ingredients)
	table.insert(ingredients, 1, 'spawneggs:egg')
	core.register_craft({
		output = 'spawneggs:' .. name,
		type = 'shapeless',
		recipe = ingredients,
	})
end

antum.spawneggs.addEgg = function(name, spawn, ingredients)
	core.register_craftitem(':spawneggs:' .. name, {
		description = name:gsub("^%l", string.upper) .. ' Spawn Egg',
		inventory_image = 'spawneggs_' .. name ..'.png',
		
		on_place = function(itemstack, placer, target)
			if target.type == 'node' then
				local pos = target.above
				pos.y = pos.y + 1
				core.add_entity(pos, spawn)
				if not core.settings:get_bool('creative_mode') then
					itemstack:take_item()
				end
				
				return itemstack
			end
		end
	})
	
	antum.spawneggs.addEggRecipe(name, spawn, ingredients)
	
	-- DEBUG
	antum.logAction('Registered spawnegg for ' .. spawn)
end



if core.get_modpath('spawneggs') then
	-- Clear all spawneggs
	local spawneggs_default = {
		'dirt_monster', 'dungeon_master', 'oerkki', 'rat',
		'sand_monster', 'sheep', 'stone_monster', 'tree_monster'
	}
	
	for I in pairs(spawneggs_default) do
		core.clear_craft({
			output = 'spawneggs:' .. spawneggs_default[I],
		})
	end
end


-- Sheep spawnegg
if core.get_modpath('sheep') and core.get_modpath('wool') then
	antum.spawneggs.addEgg('sheep', 'creatures:sheep', {'group:wool'})
end

-- Oerrki spawnegg
if core.get_modpath('oerrki') and core.get_modpath('default') then
	antum.spawneggs.addEgg('oerrki', 'creatures:oerrki', {'default:obsidian'})
end

-- Chicken spawnegg
if core.get_modpath('chicken') then
	antum.spawneggs.addEgg('chicken', 'creatures:chicken', {'creatures:feather'})
end

-- mobs_redo monsters
if core.get_modpath('mobs_monster') and core.get_modpath('default') then
	
	-- Dirt monster
	antum.spawneggs.addEgg('dirt_monster', 'mobs_monster:dirt_monster', {'default:dirt'})
	
	-- Dungeon master
	--addLocalEgg('dungeon_master', 'mobs_monster:dungeon_master', {''}) -- needs ingredient
	
	-- Mese monster
	antum.spawneggs.addEgg('mese_monster', 'mobs_monster:mese_monster', {'default:mese'})
	
	-- Oerkki
	
	-- Sand monster
	antum.spawneggs.addEgg('sand_monster', 'mobs_monster:sand_monster', {'default:sand'})
	antum.spawneggs.addEggRecipe('sand_monster', 'mobs_monster:sand_monster', {'default:desert_sand'})
	
	-- Spider
	--antum.spawneggs.addEgg('spider', 'mobs_monster:spider', {''}) -- need ingredient & egg
	
	-- Stone monster
	--antum.spawneggs.addEgg('stone_monster', 'mobs_monster:stone_monster', {'default:stone'}) -- DISABLED: too graphic
	
	-- Tree monster
	antum.spawneggs.addEgg('tree_monster', 'mobs_monster:tree_monster', {'default:sapling'})
end
