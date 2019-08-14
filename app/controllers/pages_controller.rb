class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def update
    if current_user.update(user_params)
      UpdateUserJob.perform_later(current_user.id)  # <- The job is queued
      flash[:notice] = "Your profile has been updated"
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    # Some strong params of your choice
  end
end
