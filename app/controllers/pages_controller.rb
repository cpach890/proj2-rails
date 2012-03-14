class PagesController < ApplicationController
  def login
    if params[:student] == nil
        username = password = ""
    else 
        username = params[:student][:username]
        password = params[:student][:password]
    end
    conn = ActiveRecord::Base.connection
    user_id = conn.select_value("select getID('" + username + "','" + password + "')").to_i
    if user_id > 1
        cookies.signed[:uid] = user_id
        redirect_to :public => "MyProject.html"
    elsif user_id == 1
        redirect_to :controller => "pages", :action => "login"
    end
  end
end
