class Api::V1::HistoriesController < Api::V1::BaseApiController
  def user 
    histories = History.where user_id: params[:user_id]
    render :json => histories 
  end
end
