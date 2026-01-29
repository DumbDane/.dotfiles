return {
    cmd = { "docker-compose-langserver", "--stdio" },
    filetypes = { "yaml.docker-compose" },
    settings = {
        yaml = {
            schemas = {
                ["http://json.schemastore.org/docker-compose"] = {
                    "/docker-compose.yml",
                    "/docker-compose.yaml",
                    "/compose.yml",
                    "/compose.yaml",
                },
            },
        },
        dockerCompose = {
            validation = true,
            linting = true,
        },
    },
}
