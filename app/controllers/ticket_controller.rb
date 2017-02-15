class TicketController < ApplicationController
  def new
  end

  def index
    @tickets = Ticket.all
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.save
    redirect_to @ticket
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  private
    def ticket_params
      params.require(:ticket).permit(:title, :description, :added_by)
    end
end
