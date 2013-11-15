define 'collections/PaginatedCollection', ['backbone'], (B)=>
  class PaginatedCollection extends B.Collection
    page: 1
    perPage: 4

    initialize: ->
      # _.bindAll @, "parse", "url", "pageInfo", "nextPage", "previousPage"
      @options = 
        page: @page
        perPage: @perPage
        total: 10

    fetch: (options) ->
      Backbone.Collection::fetch.call @, data: $.extend @options, options or {}

    parse: (resp) ->
      @options.total    = resp.total
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
      return false unless @pageInfo().next
      @options.page++; @fetch().then => @afterFetch?()

    prevPage:->
      return false unless @pageInfo().prev
      @options.page--; @fetch().then => @afterFetch?()

    loadPage:(n)->
      return false if n is @options.page
      @options.page = n; @fetch().then => @afterFetch?()

  PaginatedCollection