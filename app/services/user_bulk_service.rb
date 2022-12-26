class UserBulkService < ApplicationService
  attr_reader :archive

  def initialize(archive_param)
    @archive = archive_param.tempfile
  end

  def call
  end
end