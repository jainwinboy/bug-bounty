name = "subfinder"
type = "ext"

function vertical(ctx, domain)
    print("in subfinder")
    local cmd = output_dir(ctx) .. "/bin/subfinder -d " .. domain

    local data = assert(io.popen(cmd))
    for line in data:lines() do
        new_name(ctx, line)
    end
    data:close()
end