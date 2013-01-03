class CommentsController < ApplicationController
 respond_to :html , :json
 before_filter :require_login, :except => [:index, :show,:new]
 skip_before_filter :verify_authenticity_token

  def new
    @comment = Comment.new


    #respond_to do |format|
    #  format.html  # new.html.erb
    #  format.json  { render :json => @comment }
    #end
  end

  def create
    #return render :json => params

    if params[:answer_id].present?
      #@answer = Answer.find(params[:answer_id])
      @comment_on_answer = Answer.find(params[:answer_id])
      @comment = @comment_on_answer.comments.build(params[:comment])
    elsif params[:askquestion_id].present?
      @question = Askquestion.find(params[:askquestion_id])
      @comment = @question.comments.build(params[:comment])
    end

    #@question = Askquestion.find(params[:askquestion_id])
    #@comment_on_answer = Answer.find(params[:answer_id]) if params[:answer_id].present?
    #if @comment_on_answer.blank?
    #  @comment = @question.comments.build(params[:comment])
    #else
    #    @comment = @comment_on_answer.comments.build(params[:comment])
    #end

     @comment.user = current_user


      if @comment.save
        @user_email = User.find(@comment.user_id)
        #redirect_to :back
        return render :json =>  [@comment, :email => @user_email.email]
        #redirect_to :back  , :notice => 'Comment was successfully created.'

      end
  end


  def index
    @comments = Comment.all

    respond_with @comments
    #respond_to do |format|
    #  format.html  # index.html.erb
    #  format.json  { render :json => @comments }
    #end
  end




  def edit
    #return render :json => params
    @comment = Comment.find(params[:id])
    #@comment = Comment.all
    @ques =  Askquestion.find(params[:askquestion_id])
    #return render :json => params
    #return render :json =>  @comment
    #redirect_to :back
  end

  def update
    #return render  :json => params
    @comment = Comment.find(params[:id])

    @comment.update_attributes(params[:comment])

    respond_with @comment

    end
 def update_test
   @comment = Comment.find(params[:id])


   if @comment.update_attributes(params[:comment])
     redirect_to :back
     #respond_with @comment
     #return render  :json => params

     #else
     #  format.html  { render :action => "edit" }
     #  format.json  { render :json => @comment.errors,
     #                        :status => :unprocessable_entity }
     #end
   end
 end
 def show
   @comment = Comment.find(params[:id])

   #respond_to do |format|
   #  format.html  # show.html.erb
   #  format.json  { render :json => @comment }
   #end
 end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end

end