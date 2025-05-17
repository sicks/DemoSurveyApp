class SurveysController < ApplicationController
  before_action :set_survey, only: %i[ show edit update destroy ]

  def index
    @surveys = Survey.all.page(params[:page])
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.create!(survey_params)
    @survey.questions.create(body: "Who?")

    redirect_to edit_survey_path(@survey), notice: "Survey Created!"
  end

  def update
    @survey.update!(survey_params)
  end

  def destroy
    @survey.destroy!

    redirect_to surveys_path, notice: "Survey Deleted"
  end

  def generate
    ActiveRecord::Base.transaction do
      @survey = Survey.create!(name: "Example Survey")
      @survey.questions.create!(body: "How are you feeling today?")
      @survey.questions.create!(body: "Rate your stress level from 1-5",
                                question_type: :pick_one, options: [ "1", "2", "3", "4", "5" ])
      @survey.questions.create!(body: "Any additional coments?")
    end

    redirect_to surveys_path, notice: "Example Survey Generated"
  end

  private

  def survey_params
    params.require(:survey).permit(:name)
  end

  def set_survey
    @survey = Survey.find(params[:id])
  end
end
