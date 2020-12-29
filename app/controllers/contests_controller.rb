# frozen_string_literal: true

class ContestsController < ApplicationController
  before_action :set_contest, only: %i[show edit update destroy]
  authorize_resource

  # GET /contests
  # GET /contests.json
  def index
    @contests = Contest.all.order(:id)
  end

  # GET /contests/1
  # GET /contests/1.json
  def show
    @questions = @contest.questions.order(:question_number)
    if @contest.is_activated
      load_questions
      render 'show'
    else
      load_leaderboard
      render 'leaderboard'
    end
  end

  # GET /contests/new
  def new
    @contest = Contest.new
  end

  # GET /contests/1/edit
  def edit; end

  # POST /contests
  # POST /contests.json
  def create
    @contest = Contest.new(contest_params)

    respond_to do |format|
      if @contest.save
        format.html { redirect_to @contest, notice: 'Contest was successfully created.' }
        format.json { render :show, status: :created, location: @contest }
      else
        format.html { render :new }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contests/1
  # PATCH/PUT /contests/1.json
  def update
    respond_to do |format|
      if @contest.update(contest_params)
        format.html { redirect_to @contest, notice: 'Contest was successfully updated.' }
        format.json { render :show, status: :ok, location: @contest }
      else
        format.html { render :edit }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contests/1
  # DELETE /contests/1.json
  def destroy
    @contest.destroy
    respond_to do |format|
      format.html { redirect_to contests_url, notice: 'Contest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contest
    @contest = Contest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def contest_params
    params.require(:contest).permit(:is_activated, :name,
                                    submissions_attributes: %i[answer user_id question_id contest_id id])
  end

  # Load the questions for show
  def load_questions
    @submissions = Submission.where(user_id: current_user.id, contest_id: @contest.id).includes(:question)
    @submission_is_present = @submissions.present?

    return if @submission_is_present

    @contest.questions.all.each do |q|
      @submissions.create(question_id: q.id)
    end
    # refresh list
    @submissions = Submission.where(user_id: current_user.id, contest_id: @contest.id).includes(:question)
  end

  # Load leaderboard for show method
  def load_leaderboard
    @submissions = Submission.where(contest_id: @contest.id)
    @users = @submissions.pluck(:user_id).uniq # Get unique users
    @leaderboard_array = []
    @users.each do |id|
      user_with_score = {}
      user_with_score[:score] = @submissions.where(user_id: id).sum(:marks)
      user_with_score[:name] = User.find(id).name
      @leaderboard_array.push(user_with_score)
    end
    @leaderboard_array.sort_by { |key| key['score'] }.reverse!
  end
end
