User.each { |u| u.send(:set_gravatar_hash) ; u.save }


