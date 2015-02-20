class MembersController < ApplicationController

  def new
    @member = Member.new
  end 

  def create
    @member = Member.new(member_params)
    if @member.save
      flash[:notice] = "Member Created"
      redirect_to @member
    else
      render :new
    end
  end

  def show
    @member = Member.find(params[:id])
  end

  private

  def member_params
    params.require(:member).permit(:name, :email)
  end

end
