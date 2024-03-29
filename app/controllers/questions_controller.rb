# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]
  before_action :set_contest
  authorize_resource

  # GET /questions
  # GET /questions.json
  def index
    @questions = @contest.questions
  end

  # GET /questions/1
  # GET /questions/1.json
  def show; end

  # GET /questions/new
  def new
    @question = @contest.questions.new
  end

  # GET /questions/1/edit
  def edit; end

  # POST /questions
  # POST /questions.json
  def create
    @question = @contest.questions.create(question_params)

    respond_to do |format|
      if @question.errors.none?
        format.html do
          redirect_to contest_question_url(@contest, @question), notice: 'Question was successfully created.'
        end
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html do
          redirect_to contest_question_url(@contest, @question), notice: 'Question was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to contest_questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Set the contest, to be done before any actions
  def set_contest
    @contest = Contest.find(params[:contest_id])
  end

  # Only allow a list of trusted parameters through.
  def question_params
    params.require(:question).permit(:question_number, :contest_id, :problem, :answer, :maximum_score)
  end
end
