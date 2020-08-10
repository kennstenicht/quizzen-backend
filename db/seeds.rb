# frozen_string_literal: true

require 'faker'

# Reset database
Quiz.destroy_all
User.destroy_all
Category.destroy_all
Answer.destroy_all
Question.destroy_all

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
              }
            ])

2.times do |index|
  quizze = Quiz.create({
                       title: 'Mein erstes Quiz',
                       owner: users[index]
                     })

  5.times do
    category = Category.create({
                                 title: Faker::Book.unique.title,
                                 owner: users[index]
                               })
    quizze.categories << category

    5.times do
      question = Question.create({
                                   label: Faker::Quotes::Shakespeare.as_you_like_it_quote,
                                   date: Faker::Date.backward(days: 365),
                                   source: Faker::Internet.url,
                                   owner: users[index]
                                 })

      category.questions << question

      5.times do
        answer = Answer.create({
                                 label: Faker::Movies::HarryPotter.quote,
                                 information: Faker::Quotes::Shakespeare.king_richard_iii_quote,
                                 value: Faker::Number.between(
                                   from: 1,
                                   to:  1000000
                                 )
                               })

        question.answers << answer
      end
    end
  end
end
