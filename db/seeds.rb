#30.times do
#  title = FFaker::HipsterIpsum.words
#  body = FFaker::Lorem.paragraphs
#  Question.create title: title.to_s, body: body.to_s
#end

#User.each { |u| u.send(:set_gravatar_hash) ; u.save }

30.times do
  title = FFaker::HipsterIpsum.word
  Tag.create title: title
end


