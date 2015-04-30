class RestDayRange
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :from, :to, :from_string, :to_string
  
  #validates_presence_of :from, :to
  validate :check_inversion
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      begin
        send("#{name}_string=", value)
        send("#{name}=", Date.parse(value))
      rescue => e
        Rails.logger.warn(e)
      end
    end
  end
  
  def persisted?
    false
  end
  
  private
  def check_inversion
    # format check
    errors.add(:from, :invalid) unless /\A\d{1,4}\-\d{1,2}\-\d{1,2}\Z/ =~ self.from_string
    errors.add(:to, :invalid) unless /\A\d{1,4}\-\d{1,2}\-\d{1,2}\Z/ =~ self.to_string

    if errors.blank?
      errors.add(:from, :greater_than, :to => RestDayRange.human_attribute_name(:to)) if self.from > self.to
    end
  end
end