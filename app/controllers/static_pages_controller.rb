class StaticPagesController < ApplicationController
  before_action :set_static_page, only: %i[ show edit update destroy ]

  # GET /static_pages or /static_pages.json
  def index
    # @static_pages = StaticPage.all
  end
  
  # GET /static_pages/1 or /static_pages/1.json
  def show
  end

  # GET /static_pages/new
  def new
    # binding.pry
    return unless params[:user_id]

    api_key = ENV['FLICKR_API_KEY']
    flickr = Flickr.new api_key, ENV['FLICKR_API_SECRET']
    list = flickr.people.getPublicPhotos user_id: params[:user_id]

    @photo_urls = list.map do |photo|
      info = flickr.photos.getInfo(photo_id: photo.id)
      # binding.pry
      Flickr.url_b(info)
    end

    # @static_page = StaticPage.new
  end

  # GET /static_pages/1/edit
  def edit
  end

  # POST /static_pages or /static_pages.json
  def create
    puts 'CREATE'
    # @static_page = StaticPage.new(static_page_params)

    # respond_to do |format|
    #   if @static_page.save
    #     format.html { redirect_to static_page_url(@static_page), notice: "Static page was successfully created." }
    #     format.json { render :show, status: :created, location: @static_page }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @static_page.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /static_pages/1 or /static_pages/1.json
  def update
    respond_to do |format|
      if @static_page.update(static_page_params)
        format.html { redirect_to static_page_url(@static_page), notice: "Static page was successfully updated." }
        format.json { render :show, status: :ok, location: @static_page }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @static_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /static_pages/1 or /static_pages/1.json
  def destroy
    @static_page.destroy

    respond_to do |format|
      format.html { redirect_to static_pages_url, notice: "Static page was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_static_page
      @static_page = StaticPage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def static_page_params
      params.require(:static_page).permit(:flickr_id)
    end
end
