# frozen_string_literal: true

class SubmissionsController < ApplicationController
  before_action :set_submission, only: %i[show edit update destroy]
  authorize_resource

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.all
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show; end

  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  # GET /submissions/1/edit
  def edit; end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(submission_params)

    respond_to do |format|
      if @submission.save
        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end



  def edit_multiple
    @submissions = Submission.find(params[:submission_ids])
  end

  def update_multiple
    p multiple_submission_params
    hash = multiple_submission_params[:submissions]
    hash.each do |id, submission|
      p id
      p submission
      @submission = Submission.find(id)

      if @submission.present?
        @submission.update(submission)
      else
        @submission = Submission.create(submission)
      end
    end

    redirect_to contests_path
  end


  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_submission
    @submission = Submission.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def submission_params
    hash = params.require(:submission).permit(:question_id, :answer, :marks)
    hash[:user_id] = current_user&.id
    hash
  end

  def multiple_submission_params
    params.permit(submissions: %i[answer user_id question_id id])
  end
end
