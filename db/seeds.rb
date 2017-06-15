# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroying old records"


#building related
Survey.destroy_all
Choice.destroy_all
MultiQ.destroy_all
RangeQAndC.destroy_all

#using related
User.destroy_all
MultiAnswer.destroy_all
RangeAnswer.destroy_all


puts "Old records destroyed"


puts "Survey building"
3.times do 
  s = Survey.new
  s[:title] = Faker::Coffee.blend_name
  s[:description] = Faker::Coffee.notes
  s.save
end



puts "Multi Questions building"
Survey.all.each do |sur|
  10.times do
    m = MultiQ.new
    m[:question] = Faker::TwinPeaks.quote + "#{rand(187)}" + " ?"
    m[:survey_id] = sur.id
    m[:required] = [true, false].sample
    m[:multiple] = [true, false].sample
    puts "DBG: m = #{m.inspect}"
    m.save
  end
end

puts "Choice Building"
MultiQ.all.each do |m|
  no_of_choices = rand(2..7)
  no_of_choices.times do
    c = Choice.new
    c[:multi_q_id] = m.id
    c[:name] = Faker::Space.star
    c.save
  end
end

puts "Ignoring Range questions"

puts "Building users and their answers"
Survey.all.each do |sur|
  5.times do
    person = User.create
    MultiQ.all.where(:survey_id => sur.id).each do |mq|
      ma = MultiAnswer.new
      ma[:user_id] = person.id
      ma[:choice_id] = Choice.all.where(:multi_q_id => mq.id).pluck(:id).sample
      ma[:multi_q_id] = mq.id
      puts "DBG: ma = #{ma.inspect}"
      ma.save!
    end
  end
end



puts "DONE!"

