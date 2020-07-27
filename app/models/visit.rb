class Visit < ActiveRecord::Base
  validates :date, :user_id, :status, presence: true
  validate :date_cannot_be_less_than_date_of_creation
  validate :checkin_at_cannot_be_greater_than_or_equal_to_today
  validate :checkin_at_cannot_be_greater_than_or_equal_to_today, :on => :create
  validate :checkin_at_cannot_be_greater_than_checkout_at, :on => :create
  validate :user_id_exists?

  def user_id_exists?
    if !User.exists?(user_id)
      errors.add(:user_id, "Usuário não existe")
    end
  end

  def date_cannot_be_less_than_date_of_creation
   if date < Time.now.to_s
     errors.add(:date, "Data de visita não pode ser menor que data da criação")
   end
  end

  def checkin_at_cannot_be_greater_than_or_equal_to_today
   if checkin_at >= Time.now.to_s
     errors.add(:checkin_at, "Horário de checkin não pode ser maior ou igual que o horário atual")
   end
  end

  def checkin_at_cannot_be_greater_than_checkout_at
    if checkin_at > checkout_at
      errors.add(:checkin_at, "Horário de checkin não pode ser maior que o horário de checkout")
    end
  end
  belongs_to :user
end
