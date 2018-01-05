Rails.application.config.assets.version = "1.2"

Rails.application.config.assets.paths << Rails.root.join("node_modules")
Rails.application.config.assets.paths << Rails.root.join("public", "assets")

Rails.application.config.assets.precompile += %w( app.css app.js )
