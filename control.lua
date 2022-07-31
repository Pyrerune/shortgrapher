items = {}
sorted_items = {}



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