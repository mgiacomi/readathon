class LoginsController < ApplicationController

  def login
    student = Student.find_by_code params[:code]

    if student.nil?
      redirect_to :login_screen, alert: "Invalid Code"
    else
      if student.email.nil?
        redirect_to register_screen_path(student.code)
      else
        cookies[:code] = student.code
        redirect_to :priprofile_index
      end
    end
  end

  def register_screen
    student = Student.find_by_code params[:code]

    if student.nil?
      redirect_to :login_screen
    else
      @code = student.code
    end
  end

  def register
    student = Student.find_by_code params[:code]

    if student.nil? || params[:email] == nil
      redirect_to :login_screen
    else
      student.update_attribute :email, params[:email]
      cookies[:code] = student.code
      redirect_to :priprofile_index, notice: "Registration Complete"
    end
  end

end