class ResponsesController < ApplicationController
  before_action :set_response, only: %i[ show edit complete ]

  def index
    @responses = Current.user.responses.all.order(created_at: :desc).page(params[:page])
  end

  def create
    @survey = Survey.find(params[:survey_id])
    @response = Response.create!(survey: @survey, user: Current.user)

    redirect_to edit_response_path(@response), notice: "Response Created"
  end

  def show
    redirect_to edit_response_path(@response), alert: "Response not yet marked complete" unless @response.completed?
  end

  def edit
    redirect_to response_path(@response), alert: "Response already marked complete" if @response.completed?
  end

  def complete
    @response.update!(completed_at: Time.current) unless @response.completed?

    redirect_to response_path(@response), notice: "Response complete"
  end

  private

  def set_response
    @response = Response.find(params[:id])
  end
end
