class ApiController < ApplicationController
    #same as authenticate_user! on devise, but this one will check the oauth token
    # before_action :authenticate_user!
    before_action :doorkeeper_authorize!
    
    #skip checking CSRF token auth for api requests
    skip_before_action :verify_authenticity_token

    #set response type
    respond_to :json

    # helper to get current user from token
    def current_user
        return unless doorkeeper_token
        @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
    end
end