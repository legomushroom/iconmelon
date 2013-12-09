express = require 'express'
http    = require 'http'
fs      = require 'fs'
mongo   = require 'mongoose'
path    = require 'path'
che     = require 'cheerio'
Promise = require('node-promise').Promise
_       = require 'lodash'
zip     = require 'node-native-zip-compression'
md5     = require 'MD5'
mkdirp  = require 'mkdirp'
jade    = require 'jade'
cookies = require 'cookies'
markdown= require('node-markdown').Markdown
pretty  = require('pretty-data').pd

port    = 3000  
app     = express()

# folder = 'dist'
folder = 'frontend' 

mkdirp "#{folder}/generated-icons", ->
mkdirp 'uploads', ->

oneDay = 86400000
app.set 'port', process.env.PORT or port
app.use express.compress()
app.use express.favicon __dirname + "/#{folder}/favicon.ico"
app.use express.static  __dirname + "/#{folder}", maxAge: oneDay

app.use express.bodyParser(uploadDir: 'uploads')
app.use express.methodOverride()

process.env.NODE_ENV = true
mongo.connect if process.env.NODE_ENV then fs.readFileSync("db").toString() else 'mongodb://localhost/iconmelon'

SectionSchema = new mongo.Schema
      name:           String
      author:         String
      license:        String
      email:          String
      website:        String
      isMulticolor:   Boolean
      icons:          Array
      moderated:      Boolean
      createDate:     Date

SectionSchema.virtual('id').get -> @_id.toHexString()
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


BudgetSchema = new mongo.Schema
      budget:         String
      monthly:        String

Budget = mongo.model 'Budget', BudgetSchema

SecretSchema = new mongo.Schema
  hash:         String

Secret = mongo.model 'Secret', SecretSchema

io = require('socket.io').listen(app.listen(process.env.PORT or port), { log: false })

class Main
  SVG_PATH: "#{folder}/css/"
  constructor:(@o={})->
    @licensesLinks = 
      'MIT':       'http://opensource.org/licenses/MIT'
      'GPL-v3':    'http://www.gnu.org/licenses/gpl-3.0.html'
      'GPL-v2':    'http://www.gnu.org/licenses/gpl-2.0.html'
      'GPL-v1':    'http://www.gnu.org/licenses/gpl-1.0.html'
      'CC by 3.0': 'http://creativecommons.org/licenses/by/3.0/'
      'CC by-sa 3.0': 'http://creativecommons.org/licenses/by-sa/3.0/'
      'CC by-nd 3.0': 'http://creativecommons.org/licenses/by-nd/3.0/'
      'BSD':      'http://opensource.org/licenses/BSD-3-Clause'
      'CC0 1.0':  'http://creativecommons.org/publicdomain/zero/1.0/'
  
  generateMainPageSvg:()->
    prm = new Promise()
    @getIconsData({moderated: true}).then (iconsData)=>
      @makeMainSvgFile(iconsData).then (data)=>
        @writeFile("#{@SVG_PATH}icons-main-page.svg", pretty.xmlmin(data) ).then ->
          prm.resolve 'ok'
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
          iconData += doc.filter.replace /\<filter/, "<filter id='#{doc.hash}' "
        prm.resolve iconData

    prm

  generateProductionIcons:(data)->
    @iconNames = []
    prm = new Promise()
    data = @restructData data
    @generateProductionSvgData(data).then (xmlData)=>
     
      @makeProductionHtmlFile(xmlData).then (htmlData)=>
        @makeProductionSvgFile(xmlData.svgData).then (svgData)=>
            @makeZipFireball(
              htmlData: htmlData
              svgData:  svgData
              licenseData: xmlData.licenseData
            ).then (archive)=>
              prm.resolve archive

    prm

  makeZipFireball:(data)->
    prm = new Promise()
    archive = new zip
    archive.add 'icons.svg',  (new Buffer pretty.xml(data.svgData),     'utf8'), 'deflate'
    archive.add 'index.html', (new Buffer pretty.xml(data.htmlData),    'utf8'), 'deflate'
    archive.add 'license.md', (new Buffer data.licenseData,             'utf8'), 'deflate'
    SYSTEM_FILES = 'you-dont-need-this-assets-folder'
    archive.addFiles([
      {name: "#{SYSTEM_FILES}/main.css", path: "#{folder}/download/css/main.css", compression: 'store'}
      {name: "#{SYSTEM_FILES}/favicon.ico", path: "#{folder}/download/css/favicon.ico", compression: 'store'}
      {name: "#{SYSTEM_FILES}/main-logo.svg", path: "#{folder}/download/css/main-logo.svg", compression: 'store'}
      {name: 'icons.css',    path: "#{folder}/download/icons.css", compression: 'store'}
    ], (err)->
      if (err) then return console.log("err while adding files", err)
      fileName = "iconmelon-#{md5(new Date + (new Date).getMilliseconds() + Math.random(9999999999999) + Math.random(9999999999999) + Math.random(9999999999999))}"
      archive.toBuffer (result)->
        fs.writeFile "#{folder}/generated-icons/#{fileName}.zip", result, (err)->
          prm.resolve fileName
    )

    prm

  makeProductionHtmlFile:(xmlData)->
    prm = new Promise()
    fs.readFile "#{folder}/download/kit.html", {encoding: 'utf8'}, (err,data)->
      data = data.replace /\<\!-- svg-icons-place --\>/gi,  xmlData.svgData
      data = data.replace /\<\!-- icons-place --\>/gi,      xmlData.htmlData
      prm.resolve data
    prm

  makeProductionSvgFile:(svgData)->
    prm = new Promise()
    fs.readFile "#{folder}/download/icons-template.svg", {encoding: 'utf8'}, (err,data)->
      data = data.replace /\<\/svg\>/gi, ''
      data =  "#{data}#{svgData}</svg>"
      prm.resolve data
    prm

  addAuthor:(doc)->
    @licenses ?= []
    if _.indexOf(@licenses, doc.license) is -1 then @licenses.push doc.license
    "#{(new Date).getFullYear()} #{doc.author} #{doc.email} #{doc.website or ''} \nlicense: #{doc.license} #{@licensesLinks[doc.license]} \n\n" 


  makeLicense:(data)->
    licenses = ''
    for license, i in @licenses
      if license.length >= 2
        licenses += "\n\n\n\n\n===========================\n#{fs.readFileSync("views/licenses/#{license}.md")?.toString()}"
        # licenses += ""
    
    data += "#{licenses}"

  generateProductionSvgData:(data)->
    prm = new Promise()
    svgData   = ''
    htmlData  = jade.renderFile('views/header.jade', name: 'Icons')
    licenseData = ''
    htmlIcon  = ''
    firstIcon = null
    Section.find { name:  $in: data.sections }, (err, docs)=>
      for doc, i in docs
        icons = data.icons[doc.name]
        iconsDB = doc.icons

        licenseData += @addAuthor doc
        
        for icon, j in icons
          for iconDB, k in iconsDB
            if iconDB.hash is icon
              name = @ensureUniq(@safeCssName(iconDB.name))
              renderData = 
                iconDB: iconDB
                name:   name.toLowerCase()
                doc:    doc
              str = jade.renderFile('views/g.jade', renderData)
              str = if !doc.isMulticolor then str.replace(/fill=\"\s?#[0-9A-Fa-f]{3,6}\s?\"/gi, '') else str
              htmlIcon = jade.renderFile('views/icon.jade', data: name: name.toLowerCase())

              htmlData += htmlIcon
              firstIcon ?= htmlIcon
              svgData += str

      htmlData += '</div>'

      licenseData = @makeLicense licenseData

      if !data.filters
        prm.resolve 
                svgData:      svgData
                htmlData:     htmlData
                licenseData:  licenseData
        return

      Filter.find { hash: $in: data.filters  }, (err, docs)=>
        htmlData  += jade.renderFile('views/header.jade', name: 'Filters')
        for doc, i in docs
          filterName = @safeCssName(doc.name)
          str = doc.filter.replace /\<filter\s?/ , "<filter id='#{filterName}' data-iconmelon='filter:#{doc.hash}' "
          svgData  += str
          data =
            filter: filterName
            name:   name
            viewBox: '0 0 34 34'

          htmlData += jade.renderFile('views/icon.jade', data: data)
      
        prm.resolve 
                svgData:      svgData
                htmlData:     htmlData += '</div>'
                licenseData:  licenseData

    prm


  safeCssName:(name)->
    name.replace /[^|\d|\w|\-]/gi, '-'

  ensureUniq:(name)->
    if _.indexOf(@iconNames, name) is -1
      @iconNames.push(name)
      return name
    else 
      lastDigit = parseInt name.match(/\d$/),10
      name = if !lastDigit then "#{name}1" else name.replace /\d$/, ++lastDigit
      @ensureUniq name

  restructData:(data)->
    icons = {}
    sections = []
    for icon, i in data.icons
      icon = icon.split ':'
      if !icons[icon[0]]?
        icons[icon[0]] = []
        sections.push icon[0]
      icons[icon[0]].push icon[1]

    icons: icons
    sections: sections
    filters: data.filters

  deleteOldGeneratedFiles:->
    dirPath = "#{folder}/generated-icons/"
    fs.readdir dirPath, (err, files) ->
      return console.log(err) if err
      files.forEach (file) ->
        filePath = dirPath + file
        fs.stat filePath, (err, stat) ->
          return console.log(err)  if err
          livesUntil = new Date()
          livesUntil.setHours livesUntil.getHours() - 1
          # console.log "livesUntil: #{livesUntil}"
          # console.log "stat.ctime: #{stat.ctime}"
          if stat.ctime < livesUntil
            fs.unlink filePath, (err) ->
              console.log err  if err

main = new Main

io.sockets.on "connection", (socket) ->

  socket.getCookie = (name)->
    cookies = {}
    for cookie, i in socket.handshake.headers.cookie.split(';')
      cookie = cookie.split '='
      cookies[cookie[0].replace /\s/, ''] = cookie[1]
    cookies[name]

  socket.on "filters:read", (data, callback) ->
    Filter.find {moderated: true}, (err, docs)->
      if err
        callback 500, 'DB error'
        console.error err

      callback null, docs

  socket.on "sections:read", (data, callback) ->
    if data.sectionNames
      Section.find {moderated: true, name: $in:data.sectionNames }, null, options, (err, docs)->
        callback null, data =
                        models: docs
    else 
      options = 
        skip: (data.page-1)*data.perPage
        limit: data.perPage
        sort: createDate: -1
      Section.find {moderated: true}, null, options, (err, docs)->
        Section.find {moderated: true}, (err, docs2)->
          callback null, data =
                          models: docs
                          total: docs2.length


  socket.on "sections-all:read", (data, callback) ->
    Secret.find {}, (err, docs)->
      if docs[0].hash isnt socket.getCookie 'secret' then callback(405, 'no, sorry'); return

      Section.find {}, (err, docs)->
        callback null, docs

  socket.on "section:create", (data, callback) ->
      data.moderated = false
      data.createDate = new Date
      new Section(data).save (err)->
        if err
          callback 500, 'DB error'
          console.error err
        else callback null, 'ok'

  socket.on "section:update", (data, callback) ->
    Secret.find {}, (err, docs)->
      if docs[0].hash isnt socket.getCookie 'secret' then callback(405, 'no, sorry'); return

      id = data.id; delete data._id
      Section.update {'_id':id}, data, {upsert:true}, (err)->
        main.generateMainPageSvg().then =>
          if err
            callback 500, 'DB error'
            console.error err
          else callback null, 'ok'

      # main.generateMainPageSvg()

  socket.on "section:delete", (data, callback) ->
    Secret.find {}, (err, docs)->
      if docs[0].hash isnt socket.getCookie 'secret' then callback(405, 'no, sorry'); return
      
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

app.post '/download-icons', (req,res,next)->
  main.generateProductionIcons(req.body).then (fileName)=>
    res.send fileName

app.post '/file-upload', (req,res,next)->
  fs.readFile req.files.files[0].path, {encoding: 'utf8'}, (err,data)->
    $ = che.load data
    res.send $('svg').html()
    fs.unlink req.files.files[0].path, (err)->
        err and console.error err

app.get '/generate-main-svg-data', (req,res,next)->
  main.generateMainPageSvg().then (msg)->
    res.send msg

app.get '/clean-generated-data', (req,res,next)->
    main.deleteOldGeneratedFiles()
    res.send 'ok'

app.get '/budget-counters', (req,res,next)->
  Budget.find {}, (err, docs)->
    doc = docs[0]
    res.send doc


# new Secret(
#   hash: 'bb0744e372fd5e83cf94dfaaf21c4b45'
# ).save()

# new Budget(
#       budget: '-40'
#       monthly: '20'
#     ).save()

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
