class TipsController < ApplicationController
#  has_one :user
#  belongs_to :user

#  before_filter :authenticate_user!
  before_action :set_tip, only: [:show, :edit, :update, :destroy]
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
   @tips = Tip.text_search(params[:query]).order(sort_column + ' ' + sort_direction).page(params[:page])
  end

  def show
    @tip = Tip.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tip }
    end
  end

  # GET /tips/new
  def new
    @tip = Tip.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tip }
    end
  end

  def edit
  end

  def create
    @tip = Tip.new(tip_params)

    respond_to do |format|
      if @tip.save
        format.html { redirect_to @tip, notice: 'Tip was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tip }
      else
        format.html { render action: 'new' }
        format.json { render json: @tip.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tip.update(tip_params)
        format.html { redirect_to @tip, notice: 'Tip was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @tip }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tip.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tip.destroy
    respond_to do |format|
      format.html { redirect_to tips_url }
      format.json { head :no_content }
    end
  end

private
  def require_admin
    unless current_user_admin?
      redirect_to tips_path, alert: "Unauthorized access!"
    end
  end

    # Use callbacks to share common setup or constraints between actions.
  def sort_column
    params[:sort] || "subject"
  end

  def sort_direction
     params[:direction] || "asc"
  end

  def set_tip
    @tip = Tip.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tip_params
    params.require(:tip).permit(:source, :rubytype, :subject, :category, :tip, :applies_to, :email, :posted, :firstname, :lastname, :xmail)
  end
end
