class LoginsController < ApplicationController

  def logout
    cookies.permanent[:code] = nil
    redirect_to :login_screen, alert: "Signed Off"
  end

  def register_screen
    student = Student.find_by_code params[:code]

    if student.nil?
      redirect_to :login_screen
    else
      @student = student
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

  def autologin
    student = Student.find_by_code params[:id]
    if student.nil? || student.email.length == 0
      redirect_to :login_screen
    else
      cookies[:code] = student.code
      redirect_to :priprofile_index, notice: "Login Success"
    end
  end

end
