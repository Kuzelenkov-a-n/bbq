import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "../styles/application"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// const images = require.context('../images', true)