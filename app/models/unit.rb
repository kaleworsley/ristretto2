class Unit < ActiveRecord::Base

  belongs_to :customer
  
  serialize :phone
  
  before_save :remove_blank_phone_numbers

  # Override the value of 'phone'
  def phone
    if attributes['phone'] == {} || attributes['phone'].blank?
      {'type' => ['', ''], 'number' => ['','']}
    else
      a = attributes['phone']
      a['type'] = a['type']+[''] unless a['number'].last == ''
      a['number'] = a['number']+[''] unless a['number'].last == ''
      a
    end
  end

  protected

  # Remove row if number or type is blank
  def remove_blank_phone_numbers
    types = []
    numbers = []
    
    phone['number'].each_with_index do |value, index| 
      unless value.blank? || phone['type'][index].blank?
        numbers << value
        types << phone['type'][index]
      end
    end

    phone['type'] = types
    phone['number'] = numbers
  end

end
