items = {}
sorted_items = {}

SHOW_POSITIVES = settings.global["shortgrapher-show-gains"]

require("mod-gui")
require("gui")
--TODO not adding items correctly
SUPPORTED_TYPES = {
    "assembling-machine",
    "furnace",
    "mining-drill"
}

script.on_event("shortgrapher-graph-toggle-input", graph)

script.on_init(function ()

    global.players = {}
    create_gui()

end)

script.on_nth_tick(settings.global["shortgrapher-update-tick"].value, function ()
    count_items()
    update_gui()
    
end);
script.on_event(defines.events.on_player_created, function (event)

    local player = game.get_player(event.player_index)
    create_gui()

end)

script.on_event(defines.events.on_gui_click, function (event)

    if event.element.name == "shortgrapher-graph-toggle" then

        graph(event)

    end

end)

script.on_event(defines.events.on_runtime_mod_setting_changed, function ()
    game.reload_mods()
end)