class Api::V1::BssidsController < Api::V1::BaseController
  def create
    bssid = Bssid.new(bssid_params)

    if bssid.save
      render json: bssid
    end
  end

  private

  def bssid_params
    params.require(:bssid).permit(:name)
  end
end
