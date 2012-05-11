class TipsController < ApplicationController
  # GET /tips
  # GET /tips.json
  def index
#    @tips = Tip.order(sort_column + ' ' + sort_direction).page params[:page]

    @tips = Tip.text_search(params[:query]).order(sort_column + ' ' + sort_direction).page(params[:page])
=begin
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tips }
    end
=end
  end

  # GET /tips/1
  # GET /tips/1.json
  def show
    @tip = Tip.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tip }
    end
  end

  # GET /tips/new
  # GET /tips/new.json
  def new
    @tip = Tip.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tip }
    end
  end

  # GET /tips/1/edit
  def edit
    @tip = Tip.find(params[:id])
  end

  # POST /tips
  # POST /tips.json
  def create
    @tip = Tip.new(params[:tip])

    respond_to do |format|
      if @tip.save
        format.html { redirect_to @tip, notice: 'Tip was successfully created.' }
        format.json { render json: @tip, status: :created, location: @tip }
      else
        format.html { render action: "new" }
        format.json { render json: @tip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tips/1
  # PUT /tips/1.json
  def update
    @tip = Tip.find(params[:id])

    respond_to do |format|
      if @tip.update_attributes(params[:tip])
        format.html { redirect_to @tip, notice: 'Tip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tips/1
  # DELETE /tips/1.json
  def destroy
    @tip = Tip.find(params[:id])
    @tip.destroy

    respond_to do |format|
      format.html { redirect_to tips_url }
      format.json { head :no_content }
    end
  end
  
  private
  
  def sort_column
    params[:sort] || "subject"
  end
  
  def sort_direction
    params[:direction] || "asc"
  end
  
end
