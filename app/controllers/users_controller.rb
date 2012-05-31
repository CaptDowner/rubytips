class UsersController < ApplicationController
  before_filter :check_if_owner, :only => [:edit, :update, :show, :destroy]
  
  def check_if_owner
    unless current_user.admin? # check whether the user is admin, preferably by a method in the model
      unless # check whether the current user is the owner of the item (or whether it is his account) like 'current_user.id == params[:id].to_i'
        flash[:notice] = "You dont have permission to modify this item"
# TODO: add a redirect path here        
#        redirect_to # some path
        return
      end
    end
  end

  def admin?
    true
  end  

end
