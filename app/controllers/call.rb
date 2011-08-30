Mymemoryreallysucks.controllers :call do
   get :index do
      error 404
   end

   post :index do
      account = Account.where(:number => params[:FromNumber]).first

      if account.nil?
         render :notanumber
      end

      erb :call, :locals => { :params => params }
   end
end
