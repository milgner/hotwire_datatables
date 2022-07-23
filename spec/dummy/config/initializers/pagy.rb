Rails.application.config.assets.paths << Pagy.root.join('javascripts')
Rails.application.config.assets.paths << HotwireDatatables::JAVASCRIPT_PATH
Pagy::DEFAULT[:items] = 10
