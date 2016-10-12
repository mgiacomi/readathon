module ReadlogMgr
  extend ActiveSupport::Concern

  module ClassMethods
  end

  def total_minutes_read
    Readlog.where("student_id=?", self.id).sum(:minutes)
  end

  ########################################
  #  Student Section
  ########################################
  def student_readlog_today
    Readlog.where("teacher_id is null and student_id=? and day=?", self.id, Time.zone.now.to_date).first
  end

  def student_minutes_today
    readlog_today = student_readlog_today
    readlog_today.nil? ? 0 : readlog_today.minutes
  end

  def student_minutes_total
    Readlog.where("teacher_id is null and student_id=?", self.id).sum(:minutes)
  end

  def student_minutes_update minutes
    readlog_today = student_readlog_today

    if readlog_today.nil?
      readlog_today = Readlog.create(student_id: self.id, minutes: 0, day: Time.zone.now.to_date)
    end

    # Don't allow minutes to go negative.
    if (readlog_today.minutes + minutes) < 0
      return
    end

    total_minutes = minutes + readlog_today.minutes
    readlog_today.update_attribute :minutes, total_minutes
  end

  ########################################
  #  Teacher Section
  ########################################
  def teacher_readlog_today  teacher_id
    Readlog.where("teacher_id=? and student_id=? and day=?", teacher_id, self.id, Time.zone.now.to_date).first
  end

  def teacher_minutes_today  teacher_id
    readlog_today = teacher_readlog_today teacher_id
    readlog_today.nil? ? 0 : readlog_today.minutes
  end

  def teacher_minutes_total teacher_id
    Readlog.where("teacher_id=? and student_id=?", teacher_id, self.id).sum(:minutes)
  end

  def teacher_minutes_update teacher_id, minutes
    readlog_today = teacher_readlog_today teacher_id

    if readlog_today.nil?
      readlog_today = Readlog.create(teacher_id: teacher_id, student_id: self.id, minutes: 0, day: Time.zone.now.to_date)
    end

    # Don't allow minutes to go negative.
    if (readlog_today.minutes + minutes) < 0
      return
    end

    readlog_today.update_attribute :minutes, minutes
  end

end