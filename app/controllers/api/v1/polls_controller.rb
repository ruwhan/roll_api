class Api::V1::PollsController < Api::V1::BaseApiController
  before_filter :set_poll, except: [:index, :create]

  def index 
    render :json => current_user.polls
  end

  def show 
    render :json => @poll
  end

  def create 
    poll = current_user.polls.build(poll_params)

    if poll.save
      render :json => poll, status: 201, location: [:v1, poll]
    else
      render :json => { errors: poll.errors }, status: 422
    end
  end

  def destroy 
    @poll.destroy

    head 204
  end

private
  def set_poll 
    @poll = current_user.polls.find(params[:id])
  end

  def poll_params
    params.require(:poll).permit(:id, :title, :description, :choices_attributes => [:label, :votes])
  end
end
