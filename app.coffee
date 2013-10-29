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
      creationDate:   String
      icons:          Array
      moderated:      Boolean

SectionSchema.virtual('id').get ->
  @_id.toHexString()
 # Ensure virtual fields are serialised.
SectionSchema.set 'toJSON', virtuals: true

Section = mongo.model 'Section', SectionSchema

io = require('socket.io').listen(app.listen(process.env.PORT or port), { log: false })

class Main
  SVG_PATH: 'frontend/css/'
  constructor:(@o={})->
  
  generateMainPageSvg:()->
    @getIconsData({moderated: true}).then (iconsData)=>
      @makeMainSvgFile(iconsData).then (data)=>
        @writeFile "#{@SVG_PATH}icons-main-page.svg", data

  writeFile:(filename, data)->
    fs.writeFile filename, data, (err)->
      err and (console.error err)

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
          iconData += "<g id='#{icon.hash}'>#{icon.shape}</g>"
      prm.resolve iconData

    prm
    

main = new Main


io.sockets.on "connection", (socket) ->
  
  socket.on "sections:read", (data, callback) ->
    Section.find {moderated: true}, (err, docs)->
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
      if err
        callback 500, 'DB error'
        console.error err
      else callback null, 'ok'

      main.generateMainPageSvg()

  socket.on "section:delete", (data, callback) ->
    Section.findById data.id, (err, doc)->
      if err
        callback 500, 'DB error'
        console.error err
      else callback null, 'ok'
      doc.remove (err)->
        if err
          callback 500, 'DB error'
          console.error err
        else callback null, 'ok'

app.post '/file-upload', (req,res,next)->
  fs.readFile req.files.files[0].path, {encoding: 'utf8'}, (err,data)->
    $ = che.load data
    res.send $('svg').html()
    fs.unlink req.files.files[0].path, (err)->
        err and console.error err
