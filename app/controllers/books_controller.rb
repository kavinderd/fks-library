class BooksController < ApplicationController

  def new

  end

  def import
    bi = BookImport.new(params[:file])
    bi.import
    flash[:notice] = "Books Imported"
    redirect_to "/admin"
  end

  def bulk_update
    bi = BookImport.new(params[:file])
    bi.update
    flash[:notice] = "Books Updated"
    redirect_to "/admin"
  end
end
