class ItemsController < ApplicationController
  before_action :set_category
  before_action :set_item, only: [:show, :edit, :update, :destroy, :delivery]

  # GET /items
  # GET /items.json
  def index
    if @category
      @items = @category.items
    else
      @items = Item.all.order('items.discontinued ASC').order('items.category_id ASC').order('items.name ASC')
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @transactions = @item.transactions.most_recent_first
    @balance = @item.transactions.sum(:amount)
  end

  # GET /items/new
  def new
    @item = Item.new
    if @category
      @item.category_id = @category.id
    end
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    if @category
      @item.category_id = @category.id
    end

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    def set_category
      @category = params[:category_id] ? Category.find(params[:category_id]) : nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:category_id, :name, :description, :discontinued)
    end
end
