class QuestionsController < ApplicationController
  before_action :set_survey
  before_action :set_question, only: %i[ update destroy ]

  def create
    @question = Question.create!(survey: @survey, body: "Who?")
  end

  def update
    @question.update(question_params)
  end

  def destroy
    @question.destroy!
  end

  private

  def question_params
    params.require(:question).permit(:question_type, :body, :option_layout, options: [])
  end

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_question
    @question = @survey.questions.find(params[:id])
  end
end
