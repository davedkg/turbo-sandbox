import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["address", "zipCode", "country", "submitButton"]

  connect() {
    if (typeof (google) !== "undefined") {
      this.initAddressAutocomplete()
    }
  }

  initAddressAutocomplete() {
    this.autocomplete = new google.maps.places.Autocomplete(this.addressTarget)
    this.autocomplete.setFields(['address_components'])
    this.autocomplete.addListener("place_changed", this.addressChanged.bind(this))
  }

  addressChanged() {
    const place = this.autocomplete.getPlace()

    const zipCode = place?.address_components.find((addressComponent) =>
      addressComponent.types.includes('postal_code'),
    )

    if (zipCode) {
      this.zipCodeTarget.value = zipCode.short_name
    } else {
      this.zipCodeTarget.value = ""
    }

    const country = place?.address_components.find((addressComponent) =>
      addressComponent.types.includes('country'),
    )

    if (country) {
      this.countryTarget.value = country.short_name
    } else {
      this.countryTarget.value = ""
    }

    if (zipCode && country) {
      this.submitButtonTarget.disabled = false
    }
  }
}
