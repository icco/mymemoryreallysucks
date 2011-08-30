class Mymemoryreallysucks < Padrino::Application
   register LessInitializer
   register Padrino::Rendering
   register Padrino::Mailer
   register Padrino::Helpers
   register Padrino::Admin::AccessControl

   enable :sessions
   get '/' do
      erb :index
   end

   post '/sms' do
      p params
   end
end
