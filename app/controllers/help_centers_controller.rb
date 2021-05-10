class HelpCentersController < ApplicationController
  before_action :set_help_center, only: [:edit, :update, :destroy]

  def index
    @help_centers = HelpCenter.all
  end

  def new
    @help_center = HelpCenter.new
  end

  def create
    @help_center = HelpCenter.new(help_center_params)
    if @help_center.save
      redirect_to help_centers_path, status: :moved_permanently, notice: 'success'
    else
      render :new, status: :unprocessable_entity, alert: 'fail'
    end
  end

  def edit
  end

  def update
    if @help_center.update(help_center_params)
      redirect_to help_centers_path, status: :moved_permanently, notice: 'success'
    else
      render :new, status: :unprocessable_entity, alert: 'fail'
    end
  end

  def destroy
    @help_center.destroy
    redirect_to help_centers_path, status: :moved_permanently, notice: 'success'
  end

  private

  def help_center_params
    params.require(:help_center).permit(:name)
  end

  def set_help_center
    @help_center = HelpCenter.find(params[:id])
  end
end
