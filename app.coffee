express = require 'express'
http    = require 'http'
fs      = require 'fs'
mongo   = require 'mongoose'
path    = require 'path'
che     = require 'cheerio'
Promise = require('node-promise').Promise


port    = 3000
app     = express()

app.set 'port', process.env.PORT or port
app.use express.favicon __dirname + '/frontend/favicon.ico'
app.use express.static  __dirname + '/frontend'



app.use express.bodyParser(uploadDir: 'uploads')
app.use express.methodOverride()


mongo.connect 'mongodb://localhost/iconmelon'

SectionSchema = new mongo.Schema
      name:           String
      author:         String
      email:          String
      website:        String
      creationDate:   String
      isMulticolor:   Boolean
      icons:          Array
      moderated:      Boolean

SectionSchema.virtual('id').get ->
  @_id.toHexString()
 # Ensure virtual fields are serialised.
SectionSchema.set 'toJSON', virtuals: true

Section = mongo.model 'Section', SectionSchema

FilterSchema = new mongo.Schema
      name:           String
      author:         String
      email:          String
      hash:           String
      filter:         String
      moderated:      Boolean

Filter = mongo.model 'Filter', FilterSchema

io = require('socket.io').listen(app.listen(process.env.PORT or port), { log: false })

class Main
  SVG_PATH: 'frontend/css/'
  constructor:(@o={})->
  
  generateMainPageSvg:()->
    prm = new Promise()
    @getIconsData({moderated: true}).then (iconsData)=>
      @makeMainSvgFile(iconsData).then (data)=>
        @writeFile("#{@SVG_PATH}icons-main-page.svg", data).then ->
          prm.resolve()
    prm



  writeFile:(filename, data)->
    prm = new Promise()
    fs.writeFile filename, data, (err)->
      err and (console.error err)
      prm.resolve()
    prm

  makeMainSvgFile:(iconsData, filename)->
    prm = new Promise()
    fs.readFile "#{@SVG_PATH}icons.svg", {encoding: 'utf8'}, (err,data)->
      data = data.replace /\<\/svg\>/gi, ''
      data =  "#{data}#{iconsData}</svg>"
      prm.resolve data

    prm

  getIconsData:(search)->
    prm = new Promise()
    Section.find search, (err, docs)->
      iconData = ''
      for doc, i in docs
        for icon, j in doc.icons
          str = "<g id='#{icon.hash}'>#{icon.shape}</g>"
          str = if !doc.isMulticolor then str.replace(/fill=\"\s?#[0-9A-Fa-f]{3,6}\s?\"/gi, '') else str
          iconData += str

      Filter.find search, (err, docs)->
        for doc, i in docs
          iconData += doc.filter.replace /\<filter/, "<filter id='#{doc.hash}'"
        prm.resolve iconData

    prm

main = new Main


io.sockets.on "connection", (socket) ->
  
  socket.on "sections:read", (data, callback) ->
    Section.find {moderated: true}, (err, docs)->
      callback null, docs

  socket.on "filters:read", (data, callback) ->
    Filter.find {moderated: true}, (err, docs)->
      if err
        callback 500, 'DB error'
        console.error err

      callback null, docs

  socket.on "sections-all:read", (data, callback) ->
    Section.find {}, (err, docs)->
      callback null, docs

  socket.on "section:create", (data, callback) ->
    data.moderated = false
    new Section(data).save (err)->
      if err
        callback 500, 'DB error'
        console.error err
      else callback null, 'ok'

  socket.on "section:update", (data, callback) ->
    id = data.id; delete data._id
    Section.update {'_id':id}, data, {upsert:true}, (err)->
      main.generateMainPageSvg().then =>
        if err
          callback 500, 'DB error'
          console.error err
        else callback null, 'ok'

      # main.generateMainPageSvg()

  socket.on "section:delete", (data, callback) ->
    Section.findById data.id, (err, doc)->
      if err
        callback 500, 'DB error'
        console.error err
      else callback null, 'ok'
      doc.remove (err)->
        if err
          callback 500, 'fs error'
          console.error err
        else callback null, 'ok'

app.post '/file-upload', (req,res,next)->
  fs.readFile req.files.files[0].path, {encoding: 'utf8'}, (err,data)->
    $ = che.load data
    res.send $('svg').html()
    fs.unlink req.files.files[0].path, (err)->
        err and console.error err

app.get '/generate-main-svg-data', (req,res,next)->
  main.generateMainPageSvg().then ->
    res.send 'ok'


# new Filter({
#   name: 'outline color'
#   hash: 'b6e728fa74b3a7f7b053d94f53db3cba'
#   moderated: true
#   filter: """
            
#   <filter>
#    <feFlood flood-color="#FF3D7F" result="base" />
#    <feMorphology result="bigger" in="SourceGraphic" operator="dilate" radius="1"/>
#    <feColorMatrix result="mask" in="bigger" type="matrix"
#       values="0 0 0 0 0
#               0 0 0 0 0
#               0 0 0 0 0
#               0 0 0 1 0" />
#    <feComposite result="drop" in="base" in2="mask" operator="in" />
#    <feGaussianBlur result="blur" in="drop" stdDeviation="0" />
#    <feBlend in="SourceGraphic" in2="blur" mode="normal" />
# </filter>
#           """
# }).save()
