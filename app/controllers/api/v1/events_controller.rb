class Api::V1::EventsController < Api::V1::BaseController
  def index
    @events = Event.all
    render json: @events
  end

  def get_events
    visitor = Visitor.joins(:events).where(email: params[:email_visitor]).distinct
    @events = visitor.first.events.where("end_time > ?", Time.current).distinct if visitor.present?
    debugger
    render json: @events, status: 200
  end

  def update_event
    @event = EventVisitor.new(
      event: Event.find(params[:event][:id]),
      visitor: Visitor.where(email: params[:visitor][:email]).first,
      visitor_bssid: params[:visitor_bssid]
    )
    if @event.save
      render json:{ "success" => true }
    else
      render json: { "success" => false }
    end
  end
end
