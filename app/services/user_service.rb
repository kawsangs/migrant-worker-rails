# frozen_string_literal: true

require "spreadsheet"

class UserService
  def initialize(users)
    @users = users
  end

  def export
    Spreadsheet.client_encoding = "UTF-8"
    book = Spreadsheet::Workbook.new
    create_sheet_user(book)
    create_sheet_games(book)

    file_path = [Rails.root, "public", "uploads", "tmp", "users.xls"].join("/")
    book.write(file_path)
    File.read(file_path)
  end

  private
    def create_sheet_user(book)
      sheet = book.create_worksheet name: "Users"
      sheet.row(0).push("User ID", "User Name", "Sex", "Age", "Voice Record", "Registered At")

      @users.each_with_index do |user, index|
        sheet.row(index + 1).push(user.id, user.full_name, user.sex, user.age, user.audio_url)
        sheet.row(index + 1).push(I18n.l(user.registered_at)) if user.registered_at.present?
      end
    end

    def create_sheet_games(book)
      Form.all.each do |form|
        create_sheet_game(book, form)
      end
    end

    def create_sheet_game(book, form)
      sheet = book.create_worksheet name: form.name
      build_quiz_header(sheet, form)
      build_quiz_body(sheet, form)
    end

    def build_quiz_header(sheet, form)
      sheet.row(0).push("User ID", "User Name")
      form.questions.each do |question|
        sheet.row(0).push(question.name)
      end
    end

    def build_quiz_body(sheet, form)
      quizzes = Quiz.where(form_id: form.id).includes(:user, :answers)
      quizzes.find_each(batch_size: ENV["MAXIMUM_DOWNLOAD_RECORDS"].to_i).with_index do |quiz, index|
        row_num = index + 1
        # User info
        sheet.row(row_num).push(quiz.user.id, quiz.user.full_name)

        # Quiz answer info
        form.questions.each do |question|
          answer = quiz.answers.select { |ans| ans.question_id == question.id }.first
          sheet.row(row_num).push(answer.try(:value))
        end
      end
    end
end
