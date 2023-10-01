# frozen_string_literal: true

class AddressesController < ApplicationController
  before_action :set_address, only: %i[show edit update destroy]

  def index
    if current_user.address.nil?
      redirect_to new_address_path, notice: "You don't have an address. Please add one."
      return
    end

    @address = current_user.address
    render :show
  end

  # GET /addresses/1 or /addresses/1.json
  def show; end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit; end

  # POST /addresses or /addresses.json
  def create
    @address = Address.new(address_params).tap do |addr|
      addr.addressable = current_user
    end

    respond_to do |format|
      if @address.save
        format.html { redirect_to address_url(@address), notice: 'Address was successfully created.' }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1 or /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to address_url(@address), notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1 or /addresses/1.json
  def destroy
    @address.destroy

    respond_to do |format|
      format.html { redirect_to addresses_url, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_address
    @address = Address.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def address_params
    params.require(:address).permit(:house_no, :first_line, :second_line, :county, :post_code)
  end

  def current_ability
    @current_ability ||= AddressAbility.new(current_user)
  end
end
