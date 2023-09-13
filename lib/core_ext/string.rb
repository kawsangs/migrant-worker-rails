# frozen_string_literal: true

class String
  def to_latin_number
    chars.map { |c| %w[០ ១ ២ ៣ ៤ ៥ ៦ ៧ ៨ ៩].index(c) || c }.join
  end

  def remove_special_character
    self.gsub(/[^0-9A-Za-z]/, "")
  end
end
