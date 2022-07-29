iter = function (a) 
    local i = 0
    return function() 
        i = i + 1; 
        return a[i] 
    end
end

count_items = function ()

    items = {}
    sorted_items = {}
    local entities = game.surfaces["nauvis"].find_entities_filtered{type = SUPPORTED_TYPES}
    
    for entity in iter(entities) do
        if entity.type == "furnace" and entity.status == defines.entity_status.working then
            local inventory = entity.get_output_inventory()
            local dict = inventory.get_contents()
            for k, v in pairs(dict) do
                if items[k] ~= nil then
                    items[k].count = items[k].count + v
                else
                    items[k] = {
                        name = k,
                        count = v,
                        type = "item",
                    }
                end
            end
        elseif entity.type == "mining-drill" and entity.status == defines.entity_status.working then
            local speed = entity.prototype.mining_speed
            local target = entity.mining_target
            local name = target.name
            local category = target.prototype.resource_category
            local type = (category == "basic-solid" and "item" or "fluid")
            local time = target.prototype.mineable_properties.mining_time
            local items_tick = speed / (time / 60) --should be items per game tick (resources / time (in seconds) / ticks per second)
            if items[name] == nil then
                items[name] = {
                    name = name,
                    type = type,
                    count = items_tick
                }
            else
                items[name].count = items[name].count + items_tick

            end
        elseif entity.status == defines.entity_status.working then
            
            local recipe = entity.get_recipe()
            local ingredients = recipe.ingredients
            local products = recipe.products
            
            for item in iter(ingredients) do
                if item.type == "item" then
                    
                    local name = item.name
                    local count = item.amount
                    if items[name] ~= nil then
                        items[name].count = items[name].count - count
                    else
                        items[name] = {
                            name = name,
                            count = -count,
                            type = item.type
                        }
                    end
                end
            end

            for item in iter(products) do
                if item.type == "item" then
                    local name = item.name
                    local count = item.amount
                    if items[name] ~= nil then
                        items[name].count = count + items[name].count
                    else
                        items[name] = {
                            name = name,
                            count = count,
                            type = item.type
                        }
                    end
                end
                
            end

        end
    end

    for k,v in pairs(items) do
        table.insert(sorted_items, v);
    end
    table.sort(sorted_items, comp)
    
end

comp = function(a, b)
    return a.count < b.count
end