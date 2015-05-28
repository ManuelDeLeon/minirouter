class Router
  @parseUri = (str) ->
    o = Router.parseUri.options
    m = o.parser[(if o.strictMode then "strict" else "loose")].exec(str)
    uri = {}
    i = 14
    uri[o.key[i]] = m[i] or ""  while i--
    uri[o.q.name] = {}
    uri[o.key[12]].replace o.q.parser, ($0, $1, $2) ->
      uri[o.q.name][$1] = $2  if $1
      return

    uri
  @parseUri.options =
    strictMode: false
    key: [
      "source"
      "protocol"
      "authority"
      "userInfo"
      "user"
      "password"
      "host"
      "port"
      "relative"
      "path"
      "directory"
      "file"
      "query"
      "anchor"
    ]
    q:
      name: "queryKey"
      parser: /(?:^|&)([^&=]*)=?([^&]*)/g

    parser:
      strict: /^(?:([^:\/?#]+):)?(?:\/\/((?:(([^:@]*)(?::([^:@]*))?)?@)?([^:\/?#]*)(?::(\d*))?))?((((?:[^?#\/]*\/)*)([^?#]*))(?:\?([^#]*))?(?:#(.*))?)/
      loose: /^(?:(?![^:@]+:[^:@\/]*@)([^:\/?#.]+):)?(?:\/\/)?((?:(([^:@]*)(?::([^:@]*))?)?@)?([^:\/?#]*)(?::(\d*))?)(((\/(?:[^?#](?![^?#\/]*\.[^?#\/.]+(?:[?#]|$)))*\/?)?([^?#\/]*))(?:\?([^#]*))?(?:#(.*))?)/

  @url = -> Router.parseUri(document.URL)

  routesArr = []
  @route = (r) ->
    rx = /:[A-Za-z0-9]+/
    r.paramNames = []
    r.findPath = r.path
    while arr = rx.exec(r.findPath)
      for a in arr
        r.paramNames.push a.substring(1)
        r.findPath = r.findPath.replace(new RegExp(a), '([^\]+)' )
    routesArr.push r
  @routes = (rs) ->
    if rs
      Router.route r for r in rs
    routesArr

  @notFound = ''

  getRoute = ->
    path = Router.url().path
    l = path.length
    path = path.substring(0, l - 1) if l > 1 and path.charAt(l - 1) is '/'
    for r in routesArr
      rx = new RegExp('^' + r.findPath + '$')
      return r if path.match(rx)
    undefined

  currentRoute = undefined
  @initialize = ->
    currentRoute = getRoute()
    if currentRoute
      r = currentRoute
      rx = new RegExp(r.findPath)
      url = Router.url()
      arr = rx.exec url.path
      r.params = {}
      if arr
        i = 0
        for a in arr
          if i > 0
            r.params[r.paramNames[i - 1]] = a
          i++

      r.query = {}
      for key of url.queryKey
        r.query[key] = url.queryKey[key]

  @template = ->
    currentRoute?.template || Router.notFound

  @data = ->
    r = currentRoute
    if r?.data
      r.data()
    else
      r?.params

  @defaultLayout = undefined

  @layout = -> currentRoute?.layout || Router.defaultLayout

