import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "styles/application.scss"
import "bootstrap/dist/js/bootstrap"
import "air-datepicker/dist/js/datepicker.min"
import "../scripts/custom_datepicker"
import "ekko-lightbox"
import "../scripts/lightbox"
import "../scripts/map"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

const images = require.context('../images', true)
