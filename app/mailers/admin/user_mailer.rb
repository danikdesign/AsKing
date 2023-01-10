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

    def bulk_export_done
      @user = params[:user]
      zipped_blob = params[:zipped_blob]

      attachments[zipped_blob.attachable_filename] = zipped_blob.download
      mail to: @user.email, subject: 'You are export all users successfully'
    end

  end
end