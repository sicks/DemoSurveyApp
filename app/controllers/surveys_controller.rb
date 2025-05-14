class SurveysController < ApplicationController
  before_action :set_survey, only: %i[ show edit update destroy ]

  def index
    @surveys = Survey.all.page(params[:page])
  end

  def new
    @survey = Survey.new
    @survey.questions << Question.new
  end

  def create
    @survey = Survey.create!(survey_params)

    redirect_to survey_path(@survey), notice: "Survey Created"
  end

  def show
  end

  def edit
  end

  def update
    @survey.update!(survey_params)

    redirect_to survey_path(@survey), notice: "Survey Updated"
  end

  def destroy
    @survey.destroy!

    redirect_to surveys_path, notice: "Survey Deleted"
  end

  private

  def survey_params
    params.require(:survey).permit(:name, questions_attributes: [ :id, :body, :question_type, :option_layout, :_destroy, options: [] ])
  end

  def set_survey
    @survey = Survey.find(params[:id])
  end
end
