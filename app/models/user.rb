class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
  } # etc.
  attr_accessor :login
  has_one :profile
  after_create :init_profile

  has_many :homeworks
  has_many :unit_evaluations

  def init_profile
    profile = Profile.new
    profile.user = self
    profile.save(:validate => false)
  end

  def display_name
    self.profile.real_name.nil? ? self.username : self.profile.real_name
  end

  def next_question
    current_course_done_questions = Homework.where(question: current_course.questions, user: self).pluck(:question_id)
    (current_course.questions - Question.where(id: current_course_done_questions)).first
  end

  def current_level
    profile.level
  end

  def cal_level
    if self.current_course.kind == 'Test' && self.profile.level == 'None'
      i = 0
      current_course.questions.each do |q|
        if q.correct_choices.collect{|c| c.id.to_s} == self.homeworks.find_by_question_id(q.id).answer
          i += 1
        end
      end
      self.current_course.range_standard.each do |key ,value|
        if key.include?(i)
          self.profile.level = value
          self.profile.save
        end
      end
    end
  end

  def current_course
    if self.profile.level == 'None'
      Course.published.where(kind: 'Test').first

    else
      # byebug
      Course.published.where( kind: 'Normal',
                              level: self.profile.level,
                              duration: Date::MONTHNAMES[Date.today.month]
                            ).to_a.delete_if { |course| course.all_units_submitted?(self) }.first
    end
  end

  def joined_courses
    Course.published.has_submitted_units.where("unit_evaluations.user_id = ?", self.id)
  end

  def current_unit
    (current_course.units - Unit.where(id: self.unit_evaluations.where(submitted: true).collect{ |ue| ue.unit_id })).first
  end

  def finish_current_unit?
    all_done_homeworks = self.homeworks.collect{ |h| h.question_id }
    current_unit_questions = current_unit.questions.collect{ |q| q.id }
    (all_done_homeworks & current_unit_questions) == current_unit_questions
  end

  def course_percentage
    current_course_questions = Question.where unit: current_course.units
    Homework.where(question: current_course_questions, user: self).size / current_course_questions.size.to_f
  end



  def unit_percentage
    current_unit_questions = current_unit.questions
    Homework.where(question: current_unit_questions, user: self).size / current_unit_questions.size.to_f
  end

  def switch_payment_status
    if self.payment_status == 'paid'
      self.payment_status = 'unpaid'
    elsif self.payment_status == 'unpaid'
      self.payment_status = 'paid'
    end
    self.save
  end

  def paid?
    self.payment_status == 'paid'
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end
end
