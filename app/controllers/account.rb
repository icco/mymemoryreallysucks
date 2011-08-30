Mymemoryreallysucks.controllers :account do
   get :index do
      if params[:oauth_token] and !session[:dropbox_session].nil? then
         dropbox_session = Dropbox::Session.deserialize(session[:dropbox_session])
         if !dropbox_session.authorized?
            dropbox_session.authorize(params)
         end
         session[:dropbox_session] = dropbox_session.serialize # re-serialize the authenticated session

         p session
         render "/account/index", :locals => { "account" => session, "box_auth_url" => "#" }
      else
         dropbox_session = Dropbox::Session.new('xndjpji4o7ynl6l', 't3f0hrbh0a23i27')
         session[:dropbox_session] = dropbox_session.serialize
         redirect dropbox_session.authorize_url( :oauth_callback => request.url )
      end
   end
end
