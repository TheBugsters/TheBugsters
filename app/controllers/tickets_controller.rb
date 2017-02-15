class TicketsController < ApplicationController
  def create
    @ticket = TicketRecord.new
  end

  def index
    @tickets_out = Array.new
    @tickets = TicketRecord.all
    @tickets.each do |t|
      @assignee = UserRecord.find_by_id(t.assigned_to)
      if @assignee != nil
        @assignee_name = @assignee.name
      else
        @assignee_name = "NA"
      end
      @assignee_name ||= "NA"
      @tickets_out.push({
        :title => t.title,
        :description => t.description,
        :url => ticket_url(t),
        :reporter_name => UserRecord.find(t.added_by).name,
        :assignee_name => @assignee_name
      })
    end
  end

  def add
    @ticket = TicketRecord.create(ticket_params)
    redirect_to '/'
  end

  def show
    @ticket = TicketRecord.find(params[:id])
    @reporter_name = UserRecord.find(@ticket.added_by).name
    @assignee = UserRecord.find_by_id(@ticket.assigned_to)
    if @assignee != nil
      @assignee_name = @assignee.name
    else
      @assignee_name = "NA"
    end
  end

  private
    def ticket_params
      @parms = params[:ticket].permit(:title, :description)
      @parms[:added_by] = session[:user_id]
      @parms[:assigned_to] = UserRecord.find_by_username(params[:ticket][:assigned_to]).id
      @parms
    end
end
