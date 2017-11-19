class RegisteredApplicationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @registered_applications = RegisteredApplication.all
  end

  def show
    @registered_application = RegisteredApplication.find(params[:id])
  end

  def new
    @registered_application = RegisteredApplication.new
  end

  def create
    @registered_application = RegisteredApplication.new
    @registered_application.user = current_user
    @registered_application.assign_attributes(registered_application_params)

    if @registered_application.save
      flash[:notice] = "#{@registered_application.name} was saved! Thanks!"
      redirect_to registered_applications_path
    else
      flash[:alert] = "Alert: failed to save!"
      render :new
    end
  end

  def edit
    @registered_application = RegisteredApplication.find(params[:id])
  end

  def update
    @registered_application = RegisteredApplication.find(params[:id])
    @registered_application.assign_attributes(registered_application_params)

    if @registered_application.save
      flash[:notice] = "#{@registered_application.name} was saved! Thanks!"
      redirect_to @registered_application
    else
      flash[:alert] = "Error! Failed to save the changes!"
      render :edit
    end
  end

  def destroy
    @registered_application = RegisteredApplication.find(params[:id])

    if @registered_application.destroy
      flash[:notice] = "#{@registered_application.name} was deleted!"
      redirect_to registered_applications_path
    else
      flash[:alert] = "Error! Failed to delete the app!"
      render :show
    end
  end

  private

  def registered_application_params
    params.require(:registered_application).permit(:name, :url)
  end
end
