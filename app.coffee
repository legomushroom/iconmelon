
express     = require('express');
http        = require('http');
port        = 3000
mongo       = require 'mongoose'
path 		= require 'path'
app         = express()

app.set 'port', process.env.PORT or port
app.use express.favicon	__dirname + '/frontend/favicon.ico'
app.use express.static  __dirname + '/frontend'


app.use express.bodyParser()
app.use express.methodOverride()



mongo.connect 'mongodb://localhost/iconmelon'

SectionSchema = new mongo.Schema
				name: 			String
				author: 		String
				license: 		String
				creationDate: 	String
				icons: 			Array

Section = mongo.model 'Section', SectionSchema


io = require('socket.io').listen(app.listen(process.env.PORT or port))

io.sockets.on "connection", (socket) ->
	console.log 'connected'

	socket.on "sections:read", (data, callback) ->
		Section.find {}, (err, docs)->
			callback null, docs


# app.get '/api/sections', (req,res)->
	

# getRandom = (min, max)->
# 	Math.floor((Math.random() * ((max + 1) - min)) + min)


# generatedIcons = for i in [0..getRandom(10,100)]
# 	{
# 		name: 'generic name'
# 		hash: '9e78a293b56b43a69cf374ae4ad9f495'
# 		shape: 	"""
# 					<path fill-rule="evenodd" clip-rule="evenodd" d="M346.564,64.023c37.117-0.66,56.847,12.978,75.709,30.304
# 					c16.018-1.394,36.827-10.406,49.074-16.688c3.98-2.199,7.959-4.369,11.918-6.568c-6.984,19.085-16.477,34.006-31.066,45.325
# 					c-3.254,2.524-6.467,5.93-10.528,7.5c0,0.087,0,0.167,0,0.248c20.787-0.208,37.925-9.653,54.214-14.796c0,0.087,0,0.167,0,0.248
# 					c-8.538,13.702-20.143,27.604-32.474,37.557c-4.995,3.997-9.968,8.001-14.964,11.978c0.269,22.195-0.311,43.354-4.436,62.007
# 					c-23.937,108.391-87.311,181.964-187.641,213.486c-36.039,11.315-94.256,15.958-135.541,5.636
# 					c-20.452-5.118-38.965-10.9-56.311-18.547c-9.633-4.249-18.566-8.851-27.105-14.095c-2.818-1.719-5.596-3.459-8.414-5.179
# 					c9.326,0.291,20.204,2.88,30.609,1.182c9.434-1.534,18.652-1.141,27.338-3.048c21.678-4.808,40.91-11.128,57.49-20.913
# 					c8.04-4.724,20.224-10.299,25.945-17.137c-10.777,0.186-20.517-2.321-28.518-5.16c-30.982-11.047-49.035-31.315-60.766-61.781
# 					c9.412,1.035,36.439,3.5,42.779-1.866c-11.816-0.663-23.195-7.564-31.314-12.683c-24.935-15.731-45.246-42.111-45.099-82.674
# 					c3.251,1.559,6.528,3.132,9.806,4.71c6.255,2.651,12.637,4.058,20.098,5.636c3.15,0.64,9.452,2.525,13.103,1.159
# 					c-0.165,0-0.332,0-0.479,0c-4.83-5.655-12.684-9.431-17.533-15.5c-15.981-20.019-30.983-50.862-21.49-87.587
# 					c2.405-9.326,6.215-17.553,10.278-25.133c0.166,0.059,0.313,0.14,0.453,0.226c1.865,3.938,6.016,6.815,8.666,10.113
# 					c8.167,10.199,18.24,19.378,28.518,27.479c34.961,27.565,66.464,44.519,117.051,57.055c12.85,3.171,27.668,5.616,43.006,5.638
# 					c-4.31-12.639-2.924-33.096,0.475-45.327c8.52-30.749,27.025-52.925,54.217-64.823c6.467-2.837,13.677-4.89,21.264-6.568
# 					C338.773,64.955,342.67,64.502,346.564,64.023z"/>
# 	        	"""
# 	}


# new Section({
# 	name: 	 'Tracksflow'
# 	author:  'Stepahin Igor'
# 	license: 'MIT'
# 	creationDate: '2013'
# 	icons: generatedIcons
# }).save()

# http.createServer(app).listen(process.env.PORT or port)

    

