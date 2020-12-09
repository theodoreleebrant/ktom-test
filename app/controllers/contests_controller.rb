class ContestsController < ApplicationController
  before_action :set_contest, only: [:show, :edit, :update, :destroy]

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
      render "show"
    else
      @submissions = Submission.where(contest_id: @contest.id)
      @users = @submissions.distinct.pluck(:user_id) #Get unique users
      @leaderboard_array = []
      for id in @users do
        user_with_score = {}
        user_score = @submissions.where(user_id: id).sum(:marks)
        user_name = User.find(id).name
        user_with_score[:score] = user_score
        user_with_score[:name] = user_name
        @leaderboard_array.push(user_with_score)
      end
      @leaderboard_array.sort_by! { |key| key["score"]}
      render "leaderboard"
    end
  end

  # GET /contests/new
  def new
    @contest = Contest.new
  end

  # GET /contests/1/edit
  def edit
  end

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
      params.require(:contest).permit(:is_activated, :name)
    end
end
