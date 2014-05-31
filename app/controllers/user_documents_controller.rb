class UserDocumentsController < ApplicationController
  before_action :set_user_document, only: [:show, :edit, :update, :destroy]

  # GET /user_documents
  # GET /user_documents.json
  def index
    @user_documents = UserDocument.all
  end

  # GET /user_documents/1
  # GET /user_documents/1.json
  def show
  end

  # GET /user_documents/new
  def new
    @user_document = UserDocument.new
  end

  # GET /user_documents/1/edit
  def edit
  end

  # POST /user_documents
  # POST /user_documents.json
  def create
    #render :json => params
    #return

    @user_document = UserDocument.new(user_document_params)
    @user = current_user
    @user.verification_request_sent = true
    @user.verification_request_sent_at = Time.now.to_i
    @user.save!

    respond_to do |format|
      if @user_document.save!
        format.html { redirect_to my_dashboard_path, notice: 'User document was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @user_document }
      else
        format.html { redirect_to my_dashboard_path }
        format.json { render json: @user_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_documents/1
  # PATCH/PUT /user_documents/1.json
  def update
    respond_to do |format|
      if @user_document.update(user_document_params)
        format.html { redirect_to @user_document, notice: 'User document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_documents/1
  # DELETE /user_documents/1.json
  def destroy
    @user_document.destroy
    respond_to do |format|
      format.html { redirect_to user_documents_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_document
      @user_document = UserDocument.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_document_params
      params.require(:user_document).permit(:avatar, :user_id)
    end
end
