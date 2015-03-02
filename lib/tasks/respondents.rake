namespace :training_data do
  desc "Import respondent records into Respondents table"
  task :import => :environment do
    STDOUT.puts "Please enter JSON file URL"
    json_file = STDIN.gets.chomp


    def import_records(url)
      json_parsed = retrieve_json_file(url)

      respondents = json_parsed["people"]

      respondents.each do |respondent|
        save_info(respondent)
      end
    end

    def retrieve_json_file(url)
      JSON.parse(HTTParty.get(url))
    end

    def save_info(respondent)
      entry = respondent["person"]

      height = entry['height'] ? entry['height'] : 'null'
      weight = entry['weight'] ? entry['weight'] : 'null'
      gender = entry['gender'] ? entry['gender'].downcase : 'null'

      connection = ActiveRecord::Base.connection()
      connection.execute("INSERT INTO Respondents (Height, Weight, Gender)
      VALUES (#{height}, #{weight}, '#{gender}')")
    end


    import_records(json_file)
  end
end

