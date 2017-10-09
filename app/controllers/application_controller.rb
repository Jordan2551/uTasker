class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:introduction]

  helper_method :time_left_builder
  helper_method :task_row_colorizer

  def introduction
    if user_signed_in?
      redirect_to controller: :tasks, action: :index
    end
  end

  def time_left_builder(due_date, is_completed)

    due_date_time_left = ""

    if is_completed
      due_date_time_left = "Completed"

    elsif due_date <= DateTime.now
      due_date_time_left = "Due"

    else
      due_date_time_left = TimeDifference.between(due_date, DateTime.now).humanize

    end

  end

  def task_row_colorizer(is_completed, is_priority, due_date)

      time_left = TimeDifference.between(due_date, DateTime.now).in_each_component

      #If the task is a priority we give the row a class of danger
      if is_completed
        'success'
      #Otherwise, we will use the time left to complete the task as an indicator of row color
      elsif is_priority
        'danger'

      else

        if time_left[:hours] <= 48
          'danger'
        elsif time_left[:hours] <= 120
          'warning'
        elsif time_left[:hours] > 120
          'info'
      end
    end
  end

end
