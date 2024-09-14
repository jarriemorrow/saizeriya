// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import MenuSelectorController from "./menu_selector_controller"
application.register("menu-selector", MenuSelectorController)

import TabsController from "./tabs_controller"
application.register("tabs", TabsController)
