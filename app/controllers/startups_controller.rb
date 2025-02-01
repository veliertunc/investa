class StartupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_startup, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_founder, except: [ :index, :show ]


  def index
    @startups = Startup.all.includes(:user)
  end

  def show
    @listings = @startup.listings
  end

  def new
    @startup = Startup.new
    @startup.user = current_user unless @startup.user
  end

  def create
    @startup = Startup.new(startup_params)
    @startup.user = current_user unless @startup.user
    if @startup.save
      redirect_to @startup, notice: "Startup was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @startup.update(startup_params)
      redirect_to @startup, notice: "Startup was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @startup.destroy
    redirect_to startups_url, notice: "Startup was successfully deleted."
  end

  private

  def set_startup
    @startup = Startup.find(params[:id])
  end

  def startup_params
    params.require(:startup).permit(:name, :description, :industry, :funding_goal, :equity_offered)
  end

  def authorize_founder
    redirect_to startups_path, alert: "Only startup owner can perform this action." unless current_user.founder? and @startup.user == current_user
  end
end
