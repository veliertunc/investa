class InvestorProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_investor_profile, only: [ :show, :edit, :update ]
  before_action :authorize_investor, only: [ :edit, :update ]
  before_action :check_existing_profile, only: [ :new, :create ]
  # GET /investor_profiles or /investor_profiles.json
  def index
    @investor_profiles = InvestorProfile.all
  end

  # GET /investor_profiles/1 or /investor_profiles/1.json
  def show
  end

  # GET /investor_profiles/new
  def new
    @investor_profile = current_user.build_investor_profile
  end

  # GET /investor_profiles/1/edit
  def edit
  end

  # POST /investor_profiles or /investor_profiles.json
  def create
    @investor_profile = current_user.build_investor_profile(investor_profile_params)

    respond_to do |format|
      if @investor_profile.save
        format.html { redirect_to @investor_profile, notice: "Investor profile was successfully created." }
        format.json { render :show, status: :created, location: @investor_profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @investor_profile.edit_investor_profileerrors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /investor_profiles/1 or /investor_profiles/1.json
  def update
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
      params.expect(investor_profile: [ :name, :bio, :investment_preferences ])
    end

    def authorize_investor
      redirect_to dashboard_path, alert: "Only profile owner can perform this action." unless current_user.investor? and current_user.investor_profile == @investor_profile
    end

    def check_existing_profile
      redirect_to edit_investor_profile_path(current_user.investor_profile), notice: "You already have a investor profile" if current_user.investor_profile.present?
    end
end
