class SecretCodesController < ApplicationController

  load_and_authorize_resource

  def index
    @secret_codes = SecretCode.order("user_id DESC").page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @secret_codes }
    end
  end

  def show
    @secret_code = SecretCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @secret_code }
    end
  end

  def new
    @secret_code = SecretCode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @secret_code }
    end
  end


  def create
    @secret_code = SecretCode.generate_code(params[:generate_coupons][:nos].to_i)
    respond_to do |format|
      if @secret_code.save
        format.html { redirect_to @secret_code, notice: 'Secret code was successfully created.' }
        format.json { render json: @secret_code, status: :created, location: @secret_code }
      else
        format.html { render action: "new" }
        format.json { render json: @secret_code.errors, status: :unprocessable_entity }
      end
    end
  end

  def generate_code
    @codes = SecretCode.generate_code(params[:nos].to_i)
    respond_to do |format|
      if @codes
        format.html { redirect_to :action => 'index', notice: 'Secret code was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @codes.errors, status: :unprocessable_entity }
      end
    end

  end


end
