class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]

  # GET /news
  # GET /news.json
  def index
    @news = News.all
  end

  # GET /news/1
  # GET /news/1.json
  def show
  end

  # GET /news/new
  def new
    @news = News.new
  end

  # GET /news/1/edit
  def edit
    # You cannot edit other people's post
    if @news.profile != current_account.profile
      redirect_to root_path
    end
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(news_params)

    # Initialise other values for News
    @news.likes = 0
    @news.profile = current_account.profile

    respond_to do |format|
      if @news.save
        format.html { redirect_to root_path, notice: 'News was successfully created.' }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to root_path, notice: 'News was successfully updated.' }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    # You cannot delete other people's post
    if @news.profile != current_account.profile
      redirect_to root_path
    end
    
    @news.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'News was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.require(:news).permit(:message, :photo, :likes, :profile_id)
    end
end