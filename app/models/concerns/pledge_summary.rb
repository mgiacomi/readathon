module PledgeSummary
  extend ActiveSupport::Concern

  module ClassMethods
  end

  def pledged_per_hour
    pph = self.pledges.select{ |p| p.ptype == "hourly"}.map{ |p| p.amount}.reduce {|sum, n| sum + n}
    pph.nil? ? 0 : pph
  end

  def pledged_flat
    pf = self.pledges.select{ |p| p.ptype == "flat"}.map{ |p| p.amount}.reduce {|sum, n| sum + n}
    pf.nil? ? 0 : pph
  end


  def money_raised
    total = (pledged_per_hour / 60) * student_minutes_total
    total += pledged_flat
  end

end