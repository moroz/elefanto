module PostNumber
  extend ActiveSupport::Concern

  def post_number(number)
    if number == number.to_i
      return "%d. " % number
    elsif number != number.to_i
      return (("%.1f" % number).gsub('.', ',')) + ". "
    elsif number == 0
      return ""
    end
  end
end
