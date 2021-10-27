name = "github-subdomains"
type = "ext"

function vertical(ctx, domain)
    print("in github-subdomains")
    local cmd = output_dir(ctx) .. "/bin/github-subdomains -raw -d " .. domain

    local data = assert(io.popen(cmd))
    for line in data:lines() do
        new_name(ctx, line)
    end
    data:close()
end