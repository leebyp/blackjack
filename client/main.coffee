# instantiates the whole app and appends the app view to the body

new AppView(model: new App()).$el.appendTo 'body'