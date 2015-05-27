# minirouter
Because sometimes you just want a router.

## Usage:
	Router.defaultLayout = 'mainLayout';
	Router.notFound = 'home';
	Router.routes([
	  {
		template: 'home',
		path: '/home',
		layout: 'homeLayout'
	  },
	  {
		template: 'posts',
		path: '/posts/{id}'
	  }
	]);


