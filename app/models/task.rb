class Task < ActiveRecord::Base

  belongs_to :project
  has_many :logs, dependent: :destroy

  default_scope { order(:done, :created_at => :desc) }

  validates :name, presence: { message: 'Please provide a name' }
  validates_presence_of :project

  def work?
    !logs.empty? && !logs.first.stop
  end

  def logged
    logs.map(&:duration).sum
  end

end