# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.scss, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( vendors/iconfonts/mdi/css/materialdesignicons.min.css )
Rails.application.config.assets.precompile += %w( vendors/css/vendor.bundle.base.css )
Rails.application.config.assets.precompile += %w( vendors/css/vendor.bundle.addons.css )
Rails.application.config.assets.precompile += %w( css/style.css )
Rails.application.config.assets.precompile += %w( vendors/js/vendor.bundle.base.js )
Rails.application.config.assets.precompile += %w( vendors/js/vendor.bundle.addons.js )
Rails.application.config.assets.precompile += %w( js/off-canvas.js )
Rails.application.config.assets.precompile += %w( js/misc.js )
Rails.application.config.assets.precompile += %w( js/dashboard.js )
Rails.application.config.assets.precompile += %w( images/favicon.png )
Rails.application.config.assets.precompile += %w( vendors/iconfonts/mdi/css/materialdesignicons.css )