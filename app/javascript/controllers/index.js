// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import AutocompleteController from "./autocomplete_controller"
application.register("autocomplete", AutocompleteController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import SearchController from "./search_controller"
application.register("search", SearchController) 

import TabsController from "./tabs_controller"
application.register("tabs", TabsController)
