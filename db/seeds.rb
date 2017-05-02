q1 = Question.create(
    label: 'Bezirke von Berlin',
    date: DateTime.new(2017,4,13),
    source: 'https://de.wikipedia.org/wiki/Berliner_Bezirke'
  )
q2 = Question.create(
    label: 'Die längsten Flüsse in Deutschland',
    date: DateTime.new(2017,4,13),
    source: 'https://de.wikipedia.org/wiki/Liste_von_Fl%C3%BCssen_in_Deutschland'
  )

a1 = q1.answers.create(label: 'Neukölln')
a2 = q2.answers.create(label: 'Donau', value: '2.811')
