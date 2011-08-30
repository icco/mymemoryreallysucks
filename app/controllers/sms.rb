Mymemoryreallysucks.controllers :sms do
   get :index do
      error 404
   end

   post :index do
      account = Account.where(:number => params[:FromNumber]).first

      if account.nil?
         render :notanumber
      else
         account.new_sms params
      end

      erb :sms, :locals => { :params => params }
   end
end
