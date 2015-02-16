class TransactionsController < ApplicationController
  before_action :set_item
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    if @item
      @transactions = @item.transactions.most_recent_first
    else
      @transactions = Transaction.most_recent_first
    end
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  def delivery
    @transaction = Transaction.new
    if @item
      @transaction.item_id = @item.id
    end
    @transaction.code = 'delivery'
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    if @item
      @balance = @item.transactions.sum(:amount)
      @transaction.item_id = @item.id
    end
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    if @item
      @transaction.item_id = @item.id
    end

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to [@item, @transaction], notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to [@item, @transaction], notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_item
      @item = params[:item_id] ? Item.find(params[:item_id]) : nil
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:item_id, :code, :date, :amount)
    end
end
