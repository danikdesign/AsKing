class PasswordResetMailer < ApplicationMailer
  def reset_email
    @user = params[:user]

    mail to: @user.email, subject: 'Password reset | AsKing'
  end
end