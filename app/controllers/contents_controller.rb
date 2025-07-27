class ContentsController < ApplicationController
  before_action :set_content, only: %i[ show edit update destroy ]
  before_action :verify_update, only: %i[ edit update destroy ]

  # GET /contents or /contents.json
  def index
    @contents = Content

    if params[:q].present?
      @contents = @contents.where(
      "contents.title LIKE :search OR contents.description LIKE :search",
        search: "%#{Content.sanitize_sql_like(params[:q])}%"
      )
    end

    if params[:c].present? && params[:c].strip != ""
      slugs = params[:c].split(' ')
      category_ids = Category.where(slug: slugs).pluck(:id)
      if category_ids.any?
        @contents = @contents
          .joins(:categories)
          .where(categories: { id: category_ids })
          .group('contents.id')
          .having('COUNT(DISTINCT categories.id) = ?', category_ids.size)
    end
  end

  # Add explicit select for grouped results:
  @contents = @contents.select('contents.*').order(updated_at: :desc)
  # Convert data to integer
  @contents_count = (@contents.size.is_a?(Hash)) ? @contents.size.size.to_i : @contents.size.to_i
  end

  # GET /contents/1 or /contents/1.json
  def show
    @categories = Category.where.not(id: @content.category_ids)
  end

  # GET /contents/new
  def new
    @content = Content.new
  end

  # GET /contents/1/edit
  def edit
  end

  # POST /contents or /contents.json
  def create
    @content = Content.new(content_params)
    @content.user = Current.user

    respond_to do |format|
      if @content.save
        format.html { redirect_to @content, notice: "Content was successfully created." }
        format.json { render :show, status: :created, location: @content }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contents/1 or /contents/1.json
  def update
    respond_to do |format|
      if @content.update(content_params)
        format.html { redirect_to @content, notice: "Content was successfully updated." }
        format.json { render :show, status: :ok, location: @content }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1 or /contents/1.json
  def destroy
    @content.destroy!

    respond_to do |format|
      format.html { redirect_to contents_path, status: :see_other, notice: "Content was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_category
    @content = Content.find_by(slug: params.expect(:content_slug))

    verify_update

    @category = Category.find_by(slug: params.expect(:category_slug))
    @content.categories << @category

    redirect_to @content, notice: "The category was successfully added."
  end

  def remove_category
    @content = Content.find_by(slug: params.expect(:content_slug))

    verify_update

    @category = Category.find_by(slug: params.expect(:category_slug))
    @content.categories.delete(@category)

    redirect_to @content, notice: "The category was successfully deleted."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = Content.find_by(slug: params.expect(:slug))
    end

    # Only allow a list of trusted parameters through.
    def content_params
      params.expect(content: [ :slug, :content_type_id, :title, :description, :body, :attachements ])
    end

    def verify_update
      if !@content.can_update?
        # render :show, status: :unauthorized
        redirect_to @content
      end
    end
end
