module Assignment
  class AssignmentGroup < ActiveRecord::Base
    serialize :user_ids, Array

    belongs_to :user
    belongs_to :assignment_group_template
    has_one :permission_group, through: :assignment_group_template
    has_many :survey_assignments
    delegate :lime_surveys, to: :assignment_group_template
    validates :user, presence: true
    #validates :survey_assignments, presence: true
    validates :assignment_group_template, presence: true
    STATES = {
      1 => :active,
      2 => :inactive,
      3 => :complete
    }

    rails_admin do
      field :user
      field :assignment_group_template
      field :status
      field :title
      field :desc_md
      field :user_ids
      field :survey_assignments
    end
    
    def status_enum
      STATES.invert
    end

    def user_ids
      self[:user_ids].map{|v| v.to_i unless v.empty?}.compact
    end

    def assignment_group_template_enum
      AssignmentGroupTemplate.active
    end

    def users_enum
      @users_enum ||= User.all
    end
    
    def users
      User.where(["id in (?)", user_ids])
    end

    def user_ids_enum
      @user_ids_enum ||= users_enum.map{|u|[u.title, u.id]}
    end

  end
end
