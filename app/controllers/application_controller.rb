class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_user

  add_breadcrumb "home", :root_path, :if => :add_home_breadcrumb?

  def add_home_breadcrumb?
    !(self.class.name =~ /^Welcome(::|Controller)/)
  end

  def set_user
    @user = current_user
  end

  def set_s3_client
    Aws.config.update({
      region: ENV["REGION"],
      credentials: Aws::Credentials.new(ENV["AWS_ACCESS_KEY"], ENV["AWS_SECRET_KEY"])
    })
  end
end
