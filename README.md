# minirouter
Because sometimes you just want a router.

## Usage:
	Router.defaultLayout = 'mainLayout';
	Router.notFound = '4oh4';
	Router.routes([
	  {
		template: 'home',
		path: '/home',
		layout: 'homeLayout'
	  },
	  {
		template: 'posts',
		path: '/posts/:id'
	  }
	]);


