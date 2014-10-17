class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  before_create :create_slug, :assign_creator
  before_update :assign_updator

  field :title, type: String
  field :body, type: String
  field :slug, type: String
  field :created_by, type: String
  field :updated_by, type: String

  validates_presence_of :title

  belongs_to :user

  def create_slug
    self.slug = self.title.downcase.gsub(/\s/, '-').gsub(/[^0-9A-Za-z\-]/, '')
  end

  def assign_creator
    self.created_by = self.user_id
  end

  def assign_updator
    self.updated_by = self.user_id
  end

end