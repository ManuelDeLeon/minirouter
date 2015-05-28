Package.describe({
  name: 'manuel:minirouter',
  summary: "Because sometimes you just want a router.",
  version: "1.0.0",
  git: "https://github.com/ManuelDeLeon/minirouter"
});

Package.onUse(function(api) {
  api.versionsFrom('METEOR@1.0.4');
    api.use('coffeescript');
    api.use('blaze', 'client');
    api.use('templating', 'client');
    api.addFiles('routerHooks.html', 'client');
    api.addFiles('routerHooks.coffee', 'client');
    api.addFiles('router.coffee', 'client');
    api.export('Router', 'client');
});
