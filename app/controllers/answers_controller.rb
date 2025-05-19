class AnswersController < ApplicationController
  before_action :set_response

  def create
    @answer = @response.answers.create(answer_params)

    render :create, status: :bad_request if @answer.errors.any?
  end

  def update
    @answer = @response.answers.find(params[:id])
    @answer.update(answer_params)

    render :update, status: :bad_request if @answer.errors.any?
  end

  private

  def answer_params
    params.require(:answer).permit(:question_id, :body, picks: [])
  end

  def set_response
    @response = Response.find(params[:response_id])
  end
end
