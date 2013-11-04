class Route < ActiveRecord::Base
  has_many :route_busstops, :dependent => :destroy
  has_many :busstops, through: :route_busstops
  
  has_one :admin
  
  has_many :companies, through: :company_routes
  has_many :company_routes
  
  
  
  validates :routeName, presence: true, uniqueness: true, format: { with: /\A[\sa-z0-9]+\Z/i, message: "only allows alphanumeric" }
  validates :routeSourceName, presence: true, format: { with: /\A^[a-zA-Z\d ]+$\Z/i, message: "only allows letters, numbers and space" }
  validates :routeDestName, presence: true, format: { with: /\A^[a-zA-Z\d ]+$\Z/i, message: "only allows letters numbers and space" }
  validates :routeDistance, numericality: true, :allow_blank => true
  #validates :routeSourceLatLong, numericality: true, :allow_blank => true
  #validates :routeDestLatLong, numericality: true, :allow_blank => true
  
  def self.search(search)
    if search
      Busstop.find(:all, :conditions => ['busStopName LIKE ?', "%#{search}%"])
    else
       Busstop.find(:all)
    end
  end
  
  def validateAddressWithError(latlong)
      if not (latlong.blank?) 
          if (isNumerics?(latlong))
              return true
          else
              self.errors.add(:routeSourceLatLong, 'Use proper latlong')
              return false
          end
      else
          self.errors.add(:routeSourceLatLong, 'Can\'t be blank')
          return false
      end
  end
  
  def isNumerics?(num)
      
     if(num =~ /\d+[.]\d+[,]\d+[.]\d+/)
         return true
      else
          return false
      end
  end
  
  
end
