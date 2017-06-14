require("bundler")
Bundler.require

class PhoneNumberValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    lookups_client = Twilio::REST::LookupsClient.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
    begin
      response = lookups_client.phone_numbers.get(value)
      response.phone_number
    rescue Twilio::REST::RequestError => error
      if error.code == 20404
        record.errors[attribute] << (options[:message] || 'is not a valid phone number')
      else
        raise error
      end
    end
  end
end

class UserDetails
  include ActiveModel::Validations

  attr_reader :name, :email, :phone_number

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, allow_blank: true }
  validates :phone_number, phone_number: { allow_blank: true }

  def initialize(name=nil, email=nil, phone_number=nil)
    @name = name
    @email = email
    @phone_number = phone_number
  end

  def to_row
    [name, email, phone_number]
  end
end

get "/" do
  erb :index, locals: { user_details: UserDetails.new }
end

post "/" do
  user_details = UserDetails.new(params["name"], params["email"], params["phone_number"])
  if user_details.valid?
    begin
      worksheet.insert_rows(worksheet.num_rows+1, [user_details.to_row])
      worksheet.save
      erb :thanks
    rescue
      erb :index, locals: {
        error_message: "Your details could not be saved, please try again."
      }
    end
  else
    erb :index, locals: { user_details: user_details }
  end
end

def worksheet
  @session ||= GoogleDrive::Session.from_service_account_key("client_secret.json")
  @spreadsheet ||= @session.spreadsheet_by_title("Fancy new app spreadsheet")
  @worksheet ||= @spreadsheet.worksheets.first
end
