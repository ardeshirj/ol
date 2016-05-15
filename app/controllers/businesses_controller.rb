# Businesses Controller
class BusinessesController < ApplicationController
  before_action :set_business, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /businesses
  # GET /businesses.json
  def index
    page_number = params[:page]
    page_size = params[:per_page] || 50

    @businesses = Business.all
    @businesses = Business.page(page_number).per(page_size)

    render json: @businesses, meta: pagination_dict(@businesses)
  end

  # GET /businesses/1
  # GET /businesses/1.json
  def show
    render json: @business
  end

  # POST /businesses
  # POST /businesses.json
  def create
    @business = Business.new(business_params)

    if @business.save
      render json: @business, status: :created, location: @business
    else
      render json: @business.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /businesses/1
  # PATCH/PUT /businesses/1.json
  def update
    @business = Business.find(params[:id])

    if @business.update(business_params)
      head :no_content
    else
      render json: @business.errors, status: :unprocessable_entity
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.json
  def destroy
    @business.destroy

    head :no_content
  end

  private

  def set_business
    @business = Business.find(params[:id])
  end

  def business_params
    params.require(:business).permit(
      :uuid, :name, :address, :address2, :city, :state, :zip, :country, :phone,
      :website, :created_at
    )
  end

  def record_not_found(error)
    render json: error.message, status: 404
  end
end
