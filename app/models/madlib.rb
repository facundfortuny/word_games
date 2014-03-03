class Madlib < ActiveRecord::Base
  attr_accessible :text, :fields

  serialize :fields, Hash

  has_many :solutions, :dependent => :destroy

  before_save :build_fields, :if => lambda { |madlib| madlib.changed.include?('text') }

  def has_field?(string)
    key, number = FieldParsing.parse_field_string(string)
    return false unless self.fields[key] >= number
    return true
  end

  protected

  def build_fields

    self.fields = {}

    arr = text.scan(/\{[\w,\s-]+\}/).collect { |i| i.gsub(/[\{\}]/,'') }

    arr.each do |field|
      key = field.downcase
      self.fields[key] = (self.fields[key].nil? ? 1 : self.fields[key] + 1)
    end
  end

end

