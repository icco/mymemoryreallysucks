Mymemoryreallysucks.controllers :sessions do
   get :new do
      render "/sessions/new", nil, :layout => false
   end

   post :create do
      if account = Account.authenticate(params[:email], params[:password])
         set_current_account(account)
         redirect url(:account, :index)
      else
         flash[:warning] = "Login or password wrong."
         redirect url(:sessions, :new)
      end
   end

   delete :destroy do
      set_current_account(nil)
      flash[:info] = "Logged out."
      redirect url(:sessions, :new)
   end
end
