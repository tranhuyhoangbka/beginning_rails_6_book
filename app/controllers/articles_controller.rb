class ArticlesController < ApplicationController
  before_action :authenticate, except: [:index, :show]
  before_action :set_article, only: %i[show notify_friend]

  # GET /articles or /articles.json
  def index
    @articles = Article.includes(:user).with_rich_text_body.with_attached_cover_image.all
  end

  # GET /articles/1 or /articles/1.json
  def show
    @email_a_friend = EmailAFriend.new
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @article = current_user.articles.find(params[:id])
  end

  # POST /articles or /articles.json
  def create
    @article = current_user.articles.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, alert: t('articles.create_success') }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    @article = current_user.articles.find(params[:id])
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: t('articles.update_success') }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: t('articles.destroy_success') }
      format.json { head :no_content }
    end
  end

  def notify_friend
    @email_a_friend = EmailAFriend.new(email_a_friend_params)
    if @email_a_friend.valid?
      NotifierMailer.email_friend(@article, @email_a_friend.name, @email_a_friend.email)
        .deliver_later
      redirect_to @article, notice: t('articles.notify_friend_success')
    else
      render :notify_friend, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :location, :excerpt, :body,
        :published_at, :cover_image, :remove_cover_image, category_ids: [])
    end

    def email_a_friend_params
      params.require(:email_a_friend).permit(:name, :email)
    end
end
