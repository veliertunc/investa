class InvestorProfilesController < ApplicationController
  before_action :set_investor_profile, only: %i[ show edit update destroy ]

  # GET /investor_profiles or /investor_profiles.json
  def index
    @investor_profiles = InvestorProfile.all
  end

  # GET /investor_profiles/1 or /investor_profiles/1.json
  def show
  end

  # GET /investor_profiles/new
  def new
    @investor_profile = InvestorProfile.new
  end

  # GET /investor_profiles/1/edit
  def edit
  end

  # POST /investor_profiles or /investor_profiles.json
  def create
    @investor_profile = InvestorProfile.new(investor_profile_params)

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

  # DELETE /investor_profiles/1 or /investor_profiles/1.json
  def destroy
    @investor_profile.destroy!

    respond_to do |format|
      format.html { redirect_to investor_profiles_path, status: :see_other, notice: "Investor profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_investor_profile
      @investor_profile = InvestorProfile.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def investor_profile_params
      params.expect(investor_profile: [ :user_id, :name, :bio, :investment_preferences ])
    end
end
