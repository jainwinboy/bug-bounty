name = "assetfinder"
type = "ext"

function vertical(ctx, domain)
    print("in assetfinder")
    local cmd = output_dir(ctx) .. "/assetfinder --subs-only " .. domain

    local data = assert(io.popen(cmd))
    for line in data:lines() do
        new_name(ctx, line)
    end
    data:close()
end