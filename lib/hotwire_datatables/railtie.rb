module HotwireDatatables
  class Railtie < Rails::Railtie
    initializer "hotwire_datatables.append_view_path" do
      ActionController::Base.append_view_path(HotwireDatatables::PARTIALS_PATH)
    end
  end
end
