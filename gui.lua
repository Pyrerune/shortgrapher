require("helper")

graph = function (event)

    local player_global = global.players[event.player_index]
    player_global.gui.visible = player_global.show_graph
    player_global.show_graph = not player_global.show_graph

end

update_gui = function()
    local setting = settings.global["shortgrapher-show-gains"].value
    for player in iter(global.players) do
        
        local flow = player.gui.children[1];
        flow.clear();

        for item in iter(sorted_items) do
            if not setting and item.count < 0 then
                local button = flow.add{type="button", }
                local content = button.add{type="table", column_count=2}
                button.style.width = 230
                button.style.minimal_height = 45
                
                content.add{type="sprite-button", sprite=(item.type.."/"..item.name), tooltip=({item.type.."-name".."."..item.name})}
                content.add{type="label", caption=(item.count.." items")}
            elseif setting then
                local button = flow.add{type="button", }
                local content = button.add{type="table", column_count=2}
                button.style.width = 230
                button.style.minimal_height = 45
                
                content.add{type="sprite-button", sprite=(item.type.."/"..item.name), tooltip=({item.type.."-name".."."..item.name})}
                content.add{type="label", caption=(item.count.." items")}
            end
        end
    end

end

create_gui = function ()
    count_items()
    for player in iter(game.players) do
        local frame = player.gui.screen.add{type="frame", name=("shortgrapher-graph-frame"..player.index), caption={"shortgrapher.graph-title"}, visible=false};
        local flow = frame.add{type="scroll-pane", name="shortgrapher-graph-scroll"}
        
        flow.style.size = {250, 450}
        frame.style.horizontal_align = "center"
        frame.style.vertical_align = "center"
        frame.style.size = {300, 500}
        frame.auto_center = true
        for name,item in pairs(items) do
            if item.count < 0 then
                local button = flow.add{type="button", }
                local content = button.add{type="table", column_count=2}
                button.style.width = 230
                button.style.minimal_height = 45
                content.add{type="sprite-button", sprite=(item.type.."/"..name)}
                content.add{type="label", caption=(item.count.." items")}
            end
        end
        
        global.players[player.index] = {
            show_graph = true,
            gui = frame,
        }

        player.gui.left.add{type="button", name="shortgrapher-graph-toggle", caption={"controls.shortgrapher-graph-toggle-input"}}
        --mod_gui.table(player).add{type="button", name="shortgrapher_graph_toggle", caption={"controls.shortgrapher_graph_toggle_input"}}
    
    end

end
