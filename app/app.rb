class Mymemoryreallysucks < Padrino::Application
   register LessInitializer
   register Padrino::Rendering
   register Padrino::Mailer
   register Padrino::Helpers

   enable :sessions
   get '/' do
      erb :index
   end

   post '/call' do
      p params
      erb :call, :locals => { :params => params }
   end

   post '/add-note' do
      p params

      folder = "/notes/"
      authtoken = "1234asd"

      f = File.new(filename, File::RDWR)
      reply = RestClient.post(
         "http://upload.box.net/api/1.0/upload/#{authtoken}/#{folder}",
         :file => IO.open(RestClient.get(params["RecordingUrl"]), 'rb'),
         :share = 0,
      )

      f.close

      erb :success
   end
end
