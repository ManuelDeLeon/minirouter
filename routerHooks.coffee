Template.router.onCreated ->
  Router.initialize()

Template.router.helpers
  templateName: -> Router.template()
  templateData: -> Router.data()
  layoutName: -> Router.layout()

Template.yield.helpers
  templateName: -> Router.template()
  templateData: -> Router.data()