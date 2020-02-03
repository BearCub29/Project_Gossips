class Gossip
  attr_accessor :author , :content , :id
  def initialize(author,content)
    @author = author
    @content = content
  end
  def save
    CSV.open("./db/gossip.csv","ab") do |csv|
        csv << [@author , @content]
    end
  end
  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end
  def self.find(id)
    Gossip.all[id-1]
  end
  def self.edit(index,new_author,new_content)
    gossips = Gossip.all
    gossips[index-1]= Gossip.new(new_author,new_content)
    File.open("./db/gossip.csv","wb") do |g|
      g << ""
    end
    gossips.map {|q| q.save}
  end
end
