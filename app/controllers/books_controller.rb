class BooksController < ApplicationController

  def new

  end

  def import
    bi = BookImport.new(params[:file])
    bi.import
    flash[:notice] = "Books Imported"
    redirect_to "/admin"
  end
end
