30.times do
  title = FFaker::HipsterIpsum.words
  body = FFaker::Lorem.paragraphs
  Question.create title: title.to_s, body: body.to_s
end


