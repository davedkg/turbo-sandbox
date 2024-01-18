// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./controllers"

window.initGoogleMaps = function (...args) {
  const event = new Event("google-maps-initialized", { "bubbles": true, "cancelable": true });
  event.args = args;
  document.dispatchEvent(event);
}
