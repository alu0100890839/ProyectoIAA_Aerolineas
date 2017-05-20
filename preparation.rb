require 'csv'

def preprocess(text)
   text = text.downcase
   
   text.gsub!(/((?:f|ht)tps?:\/[^\s]+)|(www\.[^\s]+)/, '')
   text.gsub!(/@[^\s]+/, '')
   text.gsub!(/#/, '')
   text.gsub!(/\n/, ' ')
   text.strip!
end


original = CSV.read("files/original.csv", :headers => :true, :encoding => 'iso-8859-1')
puts original.headers

pos_or_neg = CSV.open("files/pos_or_neg.csv", "w", :encoding  => 'iso-8859-1')
reasons = CSV.open("files/reasons.csv", "w", :encoding  => 'iso-8859-1')

original.each do |row|
    tweet = preprocess(row["text"])
    pos_or_neg << [tweet, row["airline_sentiment"]]
    
    if(row["airline_sentiment"] = "negative" && !row["negativereason"].nil?)
        reasons << [tweet, row["negativereason"]]
    end
end

reasons.close
pos_or_neg.close

