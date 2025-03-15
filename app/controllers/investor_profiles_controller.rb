class InvestorProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_investor_profile, only: [ :show, :edit, :update ]
  # GET /investor_profiles or /investor_profiles.json
  def index
    authorize InvestorProfile
    @investor_profiles = InvestorProfile.all
  end

  # GET /investor_profiles/1 or /investor_profiles/1.json
  def show
    authorize @investor_profile
  end

  # GET /investor_profiles/new
  def new
    authorize InvestorProfile
    @investor_profile = current_user.build_investor_profile
  end

  # POST /investor_profiles or /investor_profiles.json
  def create
    authorize InvestorProfile
    @investor_profile = current_user.build_investor_profile(investor_profile_params)

    respond_to do |format|
      if @investor_profile.save
        format.html { redirect_to @investor_profile, notice: "Investor profile was successfully created." }
        format.json { render :show, status: :created, location: @investor_profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @investor_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /investor_profiles/1/edit
  def edit
    authorize @investor_profile
  end

  # PATCH/PUT /investor_profiles/1 or /investor_profiles/1.json
  def update
    authorize @investor_profile

    respond_to do |format|
      if @investor_profile.update(investor_profile_params)
        format.html { redirect_to @investor_profile, notice: "Investor profile was successfully updated." }
        format.json { render :show, status: :ok, location: @investor_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @investor_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_investor_profile
      @investor_profile = InvestorProfile.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def investor_profile_params
      params.require(:investor_profile).permit(:user_id, :name, :bio, :investment_preferences)
    end
end
