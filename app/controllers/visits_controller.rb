class VisitsController < ApplicationController
  def index
  end

  def new
  end

  def create
    v = Visit.new(property_id: params[:property_id], tenant_id: current_tenant.id, status_id: 1)
  end

  def show
  end

end
