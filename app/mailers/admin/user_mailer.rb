module Admin
  class UserMailer < ApplicationMailer
    def bulk_import_done
      @user = params[:user]

      mail to: @user.email, subject: 'SUCCESS! Bulk import of users'
    end

    def bulk_import_fail
      @error = params[:error]
      @user = params[:user]

      mail to: @user.email, subject: 'ERROR! Bulk import of users'
    end
  end
end