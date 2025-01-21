function Get_options()
    return { "start", "stop" }
end

if #arg < 1 then
    local handle = io.popen("screen -ls | grep biptt_db")
    local response = handle:read("*a")
    handle:close()

    if (response and response ~= "") then
        print("Cloudflared is running.")
        print(response)
    else
        print("Cloudflared is not running.")
    end
    os.exit(0)
end

local action = arg[1]

if action == "start" then
    os.execute("screen -d -S biptt_db -m cloudflared access tcp --hostname mongodb.biptt.net --url localhost:27017")
    print("Cloudflared started.")
elseif action == "stop" then
    os.execute("screen -S biptt_db -X quit")
    print("Cloudflared stopped.")
elseif action == "--autocomplete" then
    local options = Get_options()
    for _, option in ipairs(options) do
        print(option)
    end
    os.exit(0)
else
    print("Invalid action. Valid actions: start, stop")
end
