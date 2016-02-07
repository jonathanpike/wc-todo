class Todo < ActiveRecord::Base
  scope :completed, -> { where(completed: true) }
  scope :uncompleted, -> { where(completed: false) }
end
