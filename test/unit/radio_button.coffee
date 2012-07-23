#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'sci-ui'

setAndFlush = (view, key, value) ->
  Ember.run ->
    Ember.set view, key, value

radioButtonView = null
append = -> (Ember.run -> radioButtonView.appendTo('#qunit-fixture'))

#
# This module specifically tests UI Widgets part of the sci-ui library.
#
module "SCi - Basic Widget RadioButton", ->
    @TemplateTests = Ember.Namespace.create()
  , ->
    if radioButtonView
      Ember.run -> radioButtonView.destroy()
      radioButtonView = null
    @TemplateTests = undefined


test "should become disabled if the disabled attribute is true", ->
  radioButtonView = SCi.RadioButton.create({})
  radioButtonView.set "disabled", true
  append()
  ok radioButtonView.$("input").is(":disabled")

test "should become disabled if the disabled attribute is true", ->
  radioButtonView = SCi.RadioButton.create({})
  append()
  ok radioButtonView.$("input").is(":not(:disabled)")
  Ember.run ->
    radioButtonView.set "disabled", true

  ok radioButtonView.$("input").is(":disabled")
  Ember.run ->
    radioButtonView.set "disabled", false

  ok radioButtonView.$("input").is(":not(:disabled)")

test "value property mirrors input value", ->
  radioButtonView = SCi.RadioButton.create(value: "value")
  Ember.run ->
    radioButtonView.append()

  equals get(radioButtonView, "value"), "value", "initially starts with a string value"
  equals !!radioButtonView.$("input").prop("checked"), false, "the initial checked property is false"
  setAndFlush radioButtonView, "checked", true
  equals radioButtonView.$("input").prop("checked"), true, "changing the value property changes the DOM"
  radioButtonView.remove()
  Ember.run ->
    radioButtonView.append()

  equals radioButtonView.$("input").prop("checked"), true, "changing the value property changes the DOM"
  Ember.run ->
    radioButtonView.remove()

  Ember.run ->
    set radioButtonView, "checked", false

  Ember.run ->
    radioButtonView.append()

  equals radioButtonView.$("input").prop("checked"), false, "changing the value property changes the DOM"

test "checking the radiobutton updates the value", ->
  radioButtonView = SCi.RadioButton.create(value: "testing")
  Ember.run ->
    radioButtonView.appendTo "#qunit-fixture"

  equals !!radioButtonView.$("input").attr("checked"), false, "precond - the initial checked property is false"
  unless jQuery.browser.msie
    radioButtonView.$("input")[0].click()
  else
    radioButtonView.$("input").trigger "click"
    radioButtonView.$("input").removeAttr("checked").trigger "change"
  equals radioButtonView.$("input").prop("checked"), true, "after clicking a radiobutton, the checked property changed"