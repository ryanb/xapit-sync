class XapitController < ApplicationController
  def reload
    Xapit::Config.database.reopen
    render :nothing => true
  end
end
