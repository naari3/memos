class MemosController < ApplicationController
  helper_method :is_correct_user?

  before_action :set_memo, only: [:show, :edit, :update, :destroy]
  before_action :login_required, only: [:new, :edit, :create, :update, :destroy]
  before_action :correct_user_required, only: [:edit, :update, :destroy]

  # GET /memos
  # GET /memos.json
  def index
    if logged_in?
      @memos = current_user.memos
    else
      @memos = Memo.all
    end
  end

  # GET /memos/1
  # GET /memos/1.json
  def show
  end

  # GET /memos/new
  def new
    @memo = current_user.memos.create!
  end

  # GET /memos/1/edit
  def edit
  end

  # POST /memos
  # POST /memos.json
  def create
    @memo = current_user.memos.create!(memo_params)

    respond_to do |format|
      if @memo.save
        format.html { redirect_to @memo, notice: 'Memo was successfully created.' }
        format.json { render :show, status: :created, location: @memo }
      else
        format.html { render :new }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memos/1
  # PATCH/PUT /memos/1.json
  def update
    respond_to do |format|
      if @memo.update(memo_params)
        format.html { redirect_to @memo, notice: 'Memo was successfully updated.' }
        format.json { render :show, status: :ok, location: @memo }
      else
        format.html { render :edit }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memos/1
  # DELETE /memos/1.json
  def destroy
    @memo.destroy
    respond_to do |format|
      format.html { redirect_to memos_url, notice: 'Memo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memo
      @memo = Memo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def memo_params
      params.require(:memo).permit(:title, :body)
    end

    def login_required
      if not logged_in?
        redirect_to root_path, alert: 'Login required'
      end
    end

    def correct_user_required
      if not is_correct_user?
        redirect_to root_path, alert: 'incorrect user'
      end
    end

    def is_correct_user?
      if logged_in?
        @memo.user_id == current_user.id
      else
        return false
      end
    end
end
