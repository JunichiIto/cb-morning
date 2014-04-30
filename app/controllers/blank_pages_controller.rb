class BlankPagesController < ApplicationController
  def index; end

  def basic_auth_required?
    false
  end
end