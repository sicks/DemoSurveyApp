class SurveysController < ApplicationController
  before_action :set_survey, only: %i[ show edit update destroy ]
  before_action :ensure_editable, only: %i[ edit update destroy ]

  def index
    @surveys = Survey.all.page(params[:page])
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.create(survey_params)

    if @survey.errors.any?
      render :create, status: :bad_request
    else
      @survey.questions.create!
      redirect_to edit_survey_path(@survey), notice: "Survey Created!"
    end
  end

  def update
    @survey.update(survey_params)

    render :update, status: :bad_request if @survey.errors.any?
  end

  def destroy
    @survey.destroy!

    redirect_to surveys_path, notice: "Survey Deleted"
  end

  def generate
    @survey = Survey.create_example!

    redirect_to surveys_path, notice: "Example Survey Generated"
  end

  private

  def survey_params
    params.require(:survey).permit(:name)
  end

  def set_survey
    @survey = Survey.find(params[:id])
  end

  def ensure_editable
    redirect_to survey_path(@survey), alert: "You cannot edit a survey once it has responses" unless @survey.editable?
  end
end
