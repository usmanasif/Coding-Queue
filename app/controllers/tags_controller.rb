class TagsController < ApplicationController
  def new
    @tag = Tag.new
  end

  def create

    @tag = current_user.tags.build(params[:tag])
    @tag.save
  end

  def index
    @tags = Tag.order(:name)
    respond_to do |format|
      format.html
      format.json { render json: @tags.tokens(params[:q]) }
    end
  end

end