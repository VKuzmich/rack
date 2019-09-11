# frozen_string_literal: true

class TableRow
  attr_accessor :name, :difficulty, :attempts_total, :attempts_used, :hints_total, :hints_used, :date

  def initialize(options)
    @name = options[:name]
    @difficulty = options[:difficulty]
    @attempts_total = options[:attempts_total]
    @attempts_used = options[:attempts_used]
    @hints_total = options[:hints_total]
    @hints_used = options[:hints_used]
    @date = options[:date]
  end
end
