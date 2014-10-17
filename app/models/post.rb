class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  before_create :create_slug

  field :title, type: String
  field :body, type: String
  field :slug, type: String

  validates_presence_of :title

  belongs_to :user

  def create_slug
    self.slug = self.title.downcase.gsub(/\s/, '-').gsub(/[^0-9A-Za-z\-]/, '')
  end
end