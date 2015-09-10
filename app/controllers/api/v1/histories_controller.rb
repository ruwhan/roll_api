class Api::V1::HistoriesController < Api::V1::BaseApiController
  def users
    histories = History.where user_id: params[:user_id]
    render :json => histories 
  end

  def create 
    @history = History.new history_params 

    if @history.save
      render :json => @history, status: 201, location: nil
    else
      render :json => { errors: @history.errors }, status: 422
    end
  end

private 
  def history_params 
    params.require(:history).permit(:user_id, :poll_id, :choice_id)
  end
end
