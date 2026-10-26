class StartupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_startup, only: [ :show, :edit, :update, :destroy ]

  def index
    authorize Startup
    @startups = policy_scope(Startup).includes(:user)
  end

  def show
    authorize @startup
    @listings = @startup.listings
  end

  def new
    authorize Startup
    @startup = Startup.new
  end

  def create
    authorize Startup
    @startup = current_user.build_startup(startup_params)

    respond_to do |format|
       if @startup.save
         format.html { redirect_to @startup, notice: "Startup was successfully created." }
         format.json { render :show, status: :created, location: @startup }
       else
         format.html { render :new, status: :unprocessable_entity }
         format.json { render json: @startup.errors, status: :unprocessable_entity }
       end
     end
  end

  def edit
    authorize @startup
  end

  def update
    authorize @startup

    respond_to do |format|
       if @startup.update(startup_params)
         format.html { redirect_to @startup, notice: "Startup was successfully updated." }
         format.json { render :show, status: :ok, location: @startup }
       else
         format.html { render :edit, status: :unprocessable_entity }
         format.json { render json: @startup.errors, status: :unprocessable_entity }
       end
     end
  end

  def destroy
    authorize @startup
    @startup.destroy
    respond_to do |format|
       format.html { redirect_to startups_path, status: :see_other, notice: "Startup was successfully destroyed." }
       format.json { head :no_content }
     end
  end

  private

  def set_startup
    @startup = Startup.find(params[:id])
  end

  def startup_params
    params.require(:startup).permit(:name, :description, :industry, :funding_goal, :funding_goal_currency, :equity_offered, :url)
  end
end
