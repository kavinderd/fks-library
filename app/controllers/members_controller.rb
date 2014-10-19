class MembersController < ApplicationController

  def new
    @member = Member.new
  end 

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to @member
    else
      render :new
    end
  end

  def show
  end

  private

  def member_params
    params.require(:member).permit(:name, :email)
  end

end
