User.find_or_create_by!(email_address: "mattruggio@icloud.com") do |user|
  user.password = user.password_confirmation = "Changemeplz123~"
end

User.find_or_create_by!(email_address: "mattruggio@gmail.com") do |user|
  user.password = user.password_confirmation = "Changemeplz123~"
end
