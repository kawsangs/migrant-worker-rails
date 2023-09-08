# frozen_string_literal: true

class String
  def to_eng_num
    chars.map { |c| %w[០ ១ ២ ៣ ៤ ៥ ៦ ៧ ៨ ៩].index(c) || c }.join
  end
end
