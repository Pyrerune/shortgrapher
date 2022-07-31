--formatter.lua
--a tool I wrote for debugging purposes
local Formatter = {
    init = false,
    tag = nil,
    fn_write = nil
}

function Formatter.new(tag, fn)
    Formatter.tag = tag
    Formatter.fn_write = fn
    return Formatter
end

function Formatter.write(content)
    local string = "["..(Formatter.tag or "").."]: "..content
    Formatter.fn_write(string)
end

return Formatter
