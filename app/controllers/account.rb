Mymemoryreallysucks.controllers :account do
   get :index do
      if params[:oauth_token] and !session[:dropbox_session].nil? then
         dropbox_session = Dropbox::Session.deserialize(session[:dropbox_session])
         if !dropbox_session.authorized?
            dropbox_session.authorize(params)
         end

         session[:dropbox_session] = dropbox_session.serialize # re-serialize the authenticated session

         if current_account.box.nil?
            current_account.box = Box.new
            if current_account.box.token != dropbox_session.serialize
               current_account.box.box_type = "dropbox"
               current_account.box.token = dropbox_session.serialize
            end
            current_account.box.save
         end

         render "/account/index", :locals => { "account" => current_account }
      else
         dropbox_session = Dropbox::Session.new('xndjpji4o7ynl6l', 't3f0hrbh0a23i27')
         session[:dropbox_session] = dropbox_session.serialize
         redirect dropbox_session.authorize_url( :oauth_callback => request.url )
      end
   end

   put :update do
      if current_account.update_attributes(params[:account])
         flash[:notice] = 'Account was successfully updated.'
         redirect url(:account, :index)
      else
         flash[:error] = 'Account update failed.'
         redirect url(:account, :index)
      end
   end
end
