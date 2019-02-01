class Api::V1::MacsController < Api::V1::BaseController
  def create
    # get_user
    # debugger
    mac_address = Mac.find_or_initialize_by(mac_params)
    visitor = Visitor.where(mac_params[:visitor]).first
    mac_address.visitor = visitor if visitor.present?
    # mac_address.visitor.build
    if mac_address.save
      render json: mac_address
    end
  end

  private

  def get_user
    Visitor.where(params[:visitor]).first
  end

  def mac_params
    debugger
    params.require(:mac).permit(:address, user_attributes: [:first_name, :last_name, :email])
  end
end
