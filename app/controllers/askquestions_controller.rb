class AskquestionsController < ApplicationController

  before_filter :require_login, only: [:create]

  def new

    @askquestion = Askquestion.new

    #return render :json => params


  end

  def create

    #return render :json => params
    #return render :json => params
    #return render :json => session



    @askquestion = current_user.askquestions.build(params[:askquestion])

    # will be use in future
    #    @tag=Tag.all
    #    @tag.each do |question|
    #      if @askquestion.tag==question.askquestion_tag
    #        question.counter=question.counter+1
    #
    #        break
    #
    #      else
    #        @tag= Tag.new
    #        @tag.counter=1
    #        @tag.askquestion_tag= @askquestion.tag
    ##        create(@tag)
    #      end
    #    end



    if @askquestion.save
      #return render :json=> params
      flash[:notice] = "Successfully created question."
      redirect_to askquestions_path, :notice => "new question has been created"
    else
      #return render :json=> params
      render :new
    end

  end

  def index
    #return render :json => params
    @askquestions = Askquestion.page(params[:page]).per_page(6)
    #@askquestions = Askquestion.paginate(:page => params[:page], :per_page => 3)

    #@askquestion = Askquestion.find(params[:id])----------------------  gillani before pagination
    @count=Askquestion.count
  end

end
