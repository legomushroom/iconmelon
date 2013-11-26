define 'collections/PaginatedCollection', ['backbone'], (B)=>
  class PaginatedCollection extends B.Collection
    page: 1
    perPage: 2

    initialize: ->
     
      # _.bindAll @, "parse", "url", "pageInfo", "nextPage", "previousPage"
      @options = 
        page: @page
        perPage: @perPage
        total: 10

      @o.isPaginated and @fetch = @fetchFun
      @o.isPaginated and @parse = @parseFun
      super
      @

    fetchFun:(options)->
        @loadFromFile = if options?.sectionNames then true else false
        Backbone.Collection::fetch.call(@, data: $.extend @options, options or {})

    parseFun: (resp) ->
      @options.total = resp.total if resp.total
      resp.models

    pageInfo: ->
      info =
        total:    @options.total
        page:     @options.page
        perPage:  @options.perPage
        pages:    Math.ceil(@options.total / @options.perPage)
        prev:     false
        next:     false

      max = Math.min(@options.total, @options.page * @options.perPage)
      max = @options.total  if @options.total is @options.pages * @options.perPage
      info.range = [(@options.page - 1) * @options.perPage + 1, max]
      info.prev = @options.page - 1  if @options.page > 1
      info.next = @options.page + 1  if @options.page < info.pages
      info

    nextPage:->
      @loadFromFile and @clearSelectedIcons()
      return false unless @pageInfo().next
      @options.page++; @fetch().then => !@isClosed and @trigger 'afterFetch'

    prevPage:->
      return false unless @pageInfo().prev
      @options.page--; @fetch().then => !@isClosed and @trigger 'afterFetch'

    loadPage:(n)->
      return false if n is @options.page
      @options.page = n; @fetch().then => !@isClosed and @trigger 'afterFetch'

    clearSelectedIcons:->
      App.vent.trigger 'icon:deselect'

  PaginatedCollection