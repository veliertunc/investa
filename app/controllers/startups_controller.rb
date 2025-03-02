class StartupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_startup, only: [ :show, :edit, :update, :destroy ]

  def index
    authorize Startup
    @startups = Startup.all.includes(:user)
  end

  def show
    authorize @startup
    @listings = @startup.listings
  end

  def new
    authorize Startup
    @startup = Startup.new
    current_user.startup = @startup
  end

  def create
    authorize Startup
    @startup = Startup.new(startup_params)
    current_user.startup = @startup

    if @startup.save
      redirect_to @startup, notice: "Startup was successfully created."
    else
      render :new
    end
  end

  def edit
    authorize @startup
  end

  def update
    authorize @startup

    if @startup.update(startup_params)
      redirect_to @startup, notice: "Startup was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @startup
    @startup.destroy
    redirect_to startups_url, notice: "Startup was successfully deleted."
  end

  private

  def set_startup
    @startup = Startup.find(params[:id])
  end

  def startup_params
    params.require(:startup).permit(:name, :description, :industry, :funding_goal, :equity_offered, :website_url)
  end
end
