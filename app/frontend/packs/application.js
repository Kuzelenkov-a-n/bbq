import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "styles/application.scss"
import "bootstrap/dist/js/bootstrap"
import "air-datepicker/dist/js/datepicker.min"
import "../scripts/min_date"

Rails.start()
ActiveStorage.start()

const images = require.context('../images', true)