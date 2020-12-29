# frozen_string_literal: true

require 'csv'

# Reset database
Game.destroy_all
Answer.destroy_all
Question.destroy_all
Category.destroy_all
Quiz.destroy_all
User.destroy_all

# Users
users = User.create([
  {
    email: 'christoph@ag-prop.com',
    firstname: 'Christoph',
    lastname: 'Wiedenmann',
    nickname: 'christoph',
    password: '1'
  },
  {
    email: 'fabian@ag-prop.com',
    firstname: 'Fabian',
    lastname: 'Wirths',
    nickname: 'fabian',
    password: '1'
  },
  {
    email: 'sevisa@web.de',
    firstname: 'Severine',
    lastname: 'Sarközi',
    nickname: 'sevi',
    password: '1'
  },
  {
    email: 'felix@ag-prop.com',
    firstname: 'Felix',
    lastname: 'Schramm',
    nickname: 'felix',
    password: '1'
  },
])

quizzen_path = Rails.root.join('db', 'seeds', 'quizzes.csv')
if File.exist?(quizzen_path)
  quizzes_csv = CSV.parse(File.read(quizzen_path), headers: true, encoding: 'UTF-8', col_sep: ';')

  quizzes_csv.each_with_index do |quiz_row, quiz_index|
    owner = users[quiz_index]

    quiz = Quiz.create({
      title: quiz_row['title'],
      owner: owner
    })


    categories_path = Rails.root.join('db', 'seeds', 'quizzes', "#{quiz_index}", 'categories.csv')

    if File.exist?(categories_path)
      categroies_csv = CSV.parse(File.read(categories_path), headers: true, encoding: 'UTF-8', col_sep: ';')

      categroies_csv.each_with_index do |category_row, category_index|
        category = Category.create({
          title: category_row['title'],
          owner: owner
        })
        quiz.categories << category


        questions_path = Rails.root.join('db', 'seeds', 'quizzes', "#{quiz_index}", 'categories', "#{category_index}", 'questions.csv')

        if File.exist?(questions_path)
          questions_csv = CSV.parse(File.read(questions_path), headers: true, encoding: 'UTF-8', col_sep: ';')

          questions_csv.each_with_index do |question_row, question_index|
            question = Question.create({
              label: question_row['label'],
              date: Date.parse("2020-02-02"),
              source: question_row['source'],
              owner: owner
            })
            category.questions << question

            answers_path = Rails.root.join('db', 'seeds', 'quizzes', "#{quiz_index}", 'categories', "#{category_index}", 'questions', "#{question_index}", 'answers.csv')

            if File.exist?(answers_path)
              answers_csv = CSV.parse(File.read(answers_path), headers: true, encoding: 'UTF-8', col_sep: ';')

              answers_csv.each_with_index do |answer_row, qanswer_index|
                answer = Answer.create({
                  label: answer_row['label'],
                  information: answer_row['information'],
                  value: answer_row['value']
                })

                question.answers << answer
              end
            end
          end
        end
      end
    end
  end
end
