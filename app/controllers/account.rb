Mymemoryreallysucks.controllers :account do
   get :index do
      # Box.net
      account = Box::Account.new(BOX_API_KEY)

      if !account.authorized?
         account.authorize(nil) do |auth_url|
            redirect auth_url
            p auth_url
            render "/account/index", :locals => { "account" => account, "box_auth_url" => auth_url}
         end
      else
         render "/account/index", :locals => { "account" => account, "box_auth_url" => "#" }
      end
   end
end
