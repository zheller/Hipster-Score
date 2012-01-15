if Rails.env.production?
  
else
  if ENV['USER'] == 'zachary'
    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :facebook, ENV['APP_ID'], ENV['APP_SECRET'], :display => 'popup', :scope => 'email,user_religion_politics,user_about_me,user_likes,user_interests,user_education_history,user_actions:music,offline_access,publish_stream'
    end
  end
end