import { Controller } from "@hotwired/stimulus";
import Pagy from "pagy-module";

class PagyInitializerController extends Controller {
  connect() {
    Pagy.init(this.element);
  }
}

export default PagyInitializerController;
