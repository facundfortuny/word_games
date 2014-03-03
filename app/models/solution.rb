class Solution < ActiveRecord::Base
  attr_accessible :fields, :madlib_id
  serialize :fields, Hash

  belongs_to :madlib

  # Insert an answer.  'string' is an unparsed string, value is the answer hash.
  def fill_field(string, value)
    return false unless madlib.has_field?(string)
    key, count = FieldParsing.parse_field_string(string)
    self.fields ||= {}
    self.fields[key] ||= []
    self.fields[key][count - 1] = value[:with]
    self.save
  end

  # Build the MadLib text with the solution answers filled in.
  def resolve
    resolution = ""
    my_fields = self.fields.clone # Keep the original answer hash intact
    my_fields.each_value { |i| i.reverse! }

    madlib.text.scan(/\{[\w,\s-]+\}|\w+|\W/) do |i|
      if (i =~ /\{[\w,\s-]+\}/)
        type = i.gsub(/[\{\}]/,'').downcase
        resolution += my_fields[type].pop
      else
        resolution += i
      end
    end

    return resolution
  end

end