# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(
  name: "test user",
  password: "test password",
  password_confirmation: "test password",
  email: "test@e.mail")

contest = Contest.create(
  name: "test contest",
  is_activated: false
)

question = Question.create(
  problem: "test problem",
  answer: "test answer",
  maximum_score: 1,
  contest_id: contest.id,
  question_number: 1
)
