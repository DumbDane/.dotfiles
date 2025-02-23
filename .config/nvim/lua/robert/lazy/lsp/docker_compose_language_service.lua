return {
    settings = {
        yaml = { schemas = { ["http://json.schemastore.org/docker-compose"] = "/docker-compose.yml" } },
        dockerCompose = {
            validation = true,
            linting = true,
        },
    }
}
