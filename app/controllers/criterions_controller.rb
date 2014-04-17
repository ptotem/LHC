class CriterionsController < ApplicationController
  before_action :set_criterion, only: [:show, :edit, :update, :destroy]

  # GET /criterions
  # GET /criterions.json
  def index
    @criterions = Criterion.all
  end

  # GET /criterions/1
  # GET /criterions/1.json
  def show
  end

  # GET /criterions/new
  def new
    @criterion = Criterion.new
  end

  def fill_matching_criteria
    @user = current_user
    #@user = User.find(current_user.id)
    #@user_demographic = @user.build_demographic
    #@user_criterion = @user.criterions.build
  end

  def create_matching_criteria
    #TODO: update_attribues, don't create, and use permit params
    #render :json => params
    #return
    @user = current_user

    @user_demographic_date = params[:user][:demographic]["dob(3i)"]
    @user_demographic_month = params[:user][:demographic]["dob(2i)"]
    @user_demographic_year = params[:user][:demographic]["dob(1i)"]
    d = Date.parse( {"(1i)"=>@user_demographic_year, "(2i)"=>@user_demographic_month, "(3i)"=>@user_demographic_date}.to_a.sort.collect{|c| c[1]}.join("-") )
    @user_demographic_dob = d.to_s
    @user_demographic_drinking = params[:user][:demographic][:drinking]
    @user_demographic_smoking = params[:user][:demographic][:smoking]

    #@user_demographic = @user.demographic.create!(params[:user][:demographic])
    @user_demographic = @user.build_demographic(:dob=>@user_demographic_dob, :drinking=>@user_demographic_drinking, :smoking=>@user_demographic_smoking)


    @user_criterion_minage = params[:user][:criterion][:minage]
    @user_criterion_maxage = params[:user][:criterion][:maxage]
    @user_criterion_drinking = params[:user][:criterion][:drinking]
    @user_criterion_smoking = params[:user][:criterion][:smoking]

    #@user_criteria = @user.criterions.create!(params[:user][:criterions])
    #@user_criteria = @user.criterions.create!(:minage => @user_criterion_minage, :maxage => @user_criterion_maxage, :drinking => @user_criterion_drinking, :smoking=> @user_criterion_smoking)
    @user_criteriion = @user.build_criterion(:minage => @user_criterion_minage, :maxage => @user_criterion_maxage, :drinking => @user_criterion_drinking, :smoking=> @user_criterion_smoking)
    @user.save!

    #redirect_to my_dashboard_path
    redirect_to welcome_dashboard_path

  end

  # GET /criterions/1/edit
  def edit
  end

  # POST /criterions
  # POST /criterions.json
  def create

    @user = current_user
    @user_criteria = @user.criterions.create!(criterion_params)

    if @user_criteria.save
      #redirect to dashboard
    else

    end


    #@criterion = Criterion.new(criterion_params)
    #
    #respond_to do |format|
    #  if @criterion.save
    #    format.html { redirect_to @criterion, notice: 'Criterion was successfully created.' }
    #    format.json { render action: 'show', status: :created, location: @criterion }
    #  else
    #    format.html { render action: 'new' }
    #    format.json { render json: @criterion.errors, status: :unprocessable_entity }
    #  end
    #end

  end

  # PATCH/PUT /criterions/1
  # PATCH/PUT /criterions/1.json
  def update
    respond_to do |format|
      if @criterion.update(criterion_params)
        format.html { redirect_to @criterion, notice: 'Criterion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @criterion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /criterions/1
  # DELETE /criterions/1.json
  def destroy
    @criterion.destroy
    respond_to do |format|
      format.html { redirect_to criterions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_criterion
      @criterion = Criterion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def criterion_params
      #params[:criterion]
      params.require(:criterion).permit(:minage, :maxage, :drinking, :smoking)
    end


end
