class HomeController < ApplicationController
    skip_before_action :authenticate_user!

    def show
        redirect_to dashboard_path if user_signed_in?
    end
end
