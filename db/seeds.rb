# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
posts_data = [
  { title: "First Post", content: "This is the content of the first post." },
  { title: "Second Post", content: "This is the content of the second post." },
  { title: "Third Post", content: "This is the content of the third post." }
]

posts_data.each do |post_data|
  Post.find_or_create_by!(title: post_data[:title]) do |post|
    post.content = post_data[:content]
  end
end