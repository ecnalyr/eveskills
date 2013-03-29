class ApiKeysController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @api_keys = ApiKey.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @api_keys }
    end
  end

  def show
    @api_key = ApiKey.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @api_key }
    end
  end

  def new
    @api_key = ApiKey.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @api_key }
    end
  end

  def edit
    @api_key = ApiKey.find(params[:id])
  end

  def create
    @api_key = ApiKey.new(params[:api_key])
    @api_key.user = current_user

    respond_to do |format|
      if @api_key.save
        format.html { redirect_to @api_key, notice: 'Api key was successfully created.' }
        format.json { render json: @api_key, status: :created, location: @api_key }
      else
        format.html { render action: "new" }
        format.json { render json: @api_key.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @api_key = ApiKey.find(params[:id])

    respond_to do |format|
      if @api_key.update_attributes(params[:api_key])
        format.html { redirect_to @api_key, notice: 'Api key was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @api_key.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @api_key = ApiKey.find(params[:id])
    @api_key.destroy

    respond_to do |format|
      format.html { redirect_to api_keys_url }
      format.json { head :no_content }
    end
  end

  def pull_data
    @api_key = ApiKey.find(params[:id])
    @api_key.populate_char_sheet
    @api_key.populate_skill_sheet
    @api_key.populate_training_queue
    @api_key.skip_callbacks = true #because before_save calls populate_char_sheet
    # I never set the above value back to false because I am of the understanding
    # that this class attribute only persists for this instance, as long as it is
    # not used again this instance, this should not be a problem.

    respond_to do |format|
      if @api_key.update_attributes(params[:api_key])
        format.html { redirect_to @api_key, notice: 'Api key was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @api_key.errors, status: :unprocessable_entity }
      end
    end
  end
end
